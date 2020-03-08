docker build -t rsuriset/multi-client:latest -t rsuriset/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rsuriset/multi-server:latest -t rsuriset/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rsuriset/multi-worker:latest -t rsuriset/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rsuriset/multi-client:latest
docker push rsuriset/multi-server:latest
docker push rsuriset/multi-worker:latest

docker push rsuriset/multi-client:$SHA
docker push rsuriset/multi-server:$SHA
docker push rsuriset/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rsuriset/multi-server:$SHA
kubectl set image deployments/client-deployment server=rsuriset/multi-client:$SHA
kubectl set image deployments/worker-deployment server=rsuriset/multi-worker:$SHA



