# ======================================
# Discovers the name of master node's
# container
# ======================================
DIND_CLUSTER_MASTER_CONTAINER=`docker ps | grep master | awk '{print $1}'`


# ======================================
# Copies filebeat config to master
# container
# ======================================
docker exec $DIND_CLUSTER_MASTER_CONTAINER mkdir /usr/share/filebeat
docker cp ./filebeat/filebeat.yml $DIND_CLUSTER_MASTER_CONTAINER:/usr/share/filebeat/filebeat.yml


# ======================================
# Creates a config map for filebeat
# ======================================
kubectl create configmap filebeat-config --from-file ./filebeat/filebeat.yml -o yaml --dry-run | kubectl apply -f -


# ======================================
# Deploys Filebeat
# ======================================
kubectl apply -f ./filebeat/filebeat-daemonset.yml



