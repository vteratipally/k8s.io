#! /bin/sh

# List of repos under https://console.cloud.google.com/gcr/images/k8s-staging-csi/GLOBAL
repos="
csi-attacher
csi-node-driver-registrar
csi-provisioner
csi-resizer
csi-snapshotter
hostpathplugin
livenessprobe
mock-driver
snapshot-controller
"

for repo in $repos; do
    echo "- name: $repo"
    echo "  dmap:"
    gcloud container images list-tags gcr.io/k8s-staging-csi/$repo --format='get(digest, tags)' --filter='tags~v.* AND NOT tags~v2020.* AND NOT tags~.*rc.*' |
        sed -e 's/\([^ ]*\)\t\(.*\)/    "\1": [ "\2" ]/'
done
