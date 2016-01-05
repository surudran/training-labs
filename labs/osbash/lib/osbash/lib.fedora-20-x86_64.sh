# Fedora 20 x86_64

# Default scripts for all Fedora base disks
: ${BASE_INSTALL_SCRIPTS:=scripts.fedora_base}

# Give Fedora 20 installer sufficient RAM
VM_BASE_MEM=1024

#-------------------------------------------------------------------------------
# Booting the operating system installer
#-------------------------------------------------------------------------------

readonly ISO_URL=http://mirror.switch.ch/ftp/mirror/fedora/linux/releases/20/Fedora/x86_64/iso/Fedora-20-x86_64-DVD.iso
readonly ISO_MD5=9a190c8b2bd382c2d046dbc855cd2f2b

readonly _KS_ssh=http://git.openstack.org/cgit/openstack/training-labs/plain/labs/osbash/lib/osbash/netboot/ks-ssh-v2.cfg
readonly _KS_vbadd=http://git.openstack.org/cgit/openstack/training-labs/plain/labs/osbash/lib/osbash/netboot/ks-vbadd.cfg
readonly _KS_all=http://git.openstack.org/cgit/openstack/training-labs/plain/labs/osbash/lib/osbash/netboot/ks-all-v2.cfg

readonly _BOOT_ARGS="linux ks=%s"

# ostype used by VirtualBox to choose icon and flags (64-bit, IOAPIC)
VBOX_OSTYPE=Fedora_64

function vbox_distro_start_installer {
    local vm_name=$1

    # pick a _KS_* file
    local kickstart=_KS_$VM_ACCESS

    echo "Using $kickstart ${!kickstart}"

    local boot_args=$(printf "$_BOOT_ARGS" "${!kickstart}")

    vbox_kbd_escape_key "$vm_name"

    vbox_sleep 1

    echo -e "${CStatus:-}Pushing boot command line${CReset:-}"
    vbox_kbd_string_input "$vm_name" "$boot_args"

    echo "Initiating boot sequence"
    vbox_kbd_enter_key "$vm_name"
}

# vim: set ai ts=4 sw=4 et ft=sh:
