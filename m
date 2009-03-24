From: David Howells <dhowells@redhat.com>
Subject: GIT BUG?  GIT occasionally redownloads its entire data set
Date: Tue, 24 Mar 2009 00:45:43 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <28707.1237855543@redhat.com>
Cc: dhowells@redhat.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 01:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lluna-0000yn-Fo
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 01:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbZCXApu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 20:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbZCXApu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 20:45:50 -0400
Received: from mx2.redhat.com ([66.187.237.31]:47144 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbZCXApt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 20:45:49 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2O0jkqk026716
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 20:45:46 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2O0je2b007890;
	Mon, 23 Mar 2009 20:45:41 -0400
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2O0jiIE014389;
	Mon, 23 Mar 2009 20:45:45 -0400
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Llulz-0007T2-KA; Tue, 24 Mar 2009 00:45:43 +0000
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114372>


Hi,

I'm seeing a possible bug in which GIT, in which I issue a git-pull command on
a tree that was okay the day before, GIT reports that there are "no common
commits" and then redownloads the entire tree (as far as I can tell).

This happened just now when I did I git-pull on a GIT repository that I think
went from Monday morning's head:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=59fcbddaff6f862cc1584b488866d9c4a5579085

to v2.6.29.  I've attached the command output for reference.

I've seen this a number of times.  It has been suggested this usually happens
when a new version tag is committed, but I wouldn't normally see that as the
git-pull to my base repository is normally run by crond.

This bug is annoying as it can eat a big chunk out of the download quota set by
my ISP.

David
---
warthog>git-pull
remote: Counting objects: 447, done.
remote: Compressing objects: 100% (57/57), done.
remote: Total 266 (delta 216), reused 254 (delta 207)
Receiving objects: 100% (266/266), 37.94 KiB, done.
Resolving deltas: 100% (216/216), completed with 105 local objects.
warning: no common commits
remote: Counting objects: 1075436, done.
remote: Compressing objects: 100% (176743/176743), done.
remote: Total 1075436 (delta 896164), reused 1072243 (delta 893708)
Receiving objects: 100% (1075436/1075436), 260.71 MiB | 307 KiB/s, done.
Resolving deltas: 100% (896164/896164), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new tag]         v2.6.29    -> v2.6.29
Updating 59fcbdd..8e0ee43
Fast forward
 Documentation/filesystems/ext2.txt        |    5 +-
 Documentation/filesystems/proc.txt        |    7 +++
 Makefile                                  |    7 ++-
 arch/powerpc/kernel/head_32.S             |    9 ++++
 arch/sparc/include/asm/pil.h              |    1 +
 arch/sparc/kernel/kgdb_64.c               |    2 +-
 arch/sparc/kernel/pci_common.c            |    2 +-
 arch/sparc/kernel/ttable.S                |    7 +++-
 arch/sparc/mm/ultra.S                     |   24 +----------
 drivers/dca/dca-sysfs.c                   |   21 ++++++++++
 drivers/isdn/gigaset/bas-gigaset.c        |   16 ++++++-
 drivers/net/Kconfig                       |    2 +-
 drivers/net/benet/be.h                    |    1 +
 drivers/net/benet/be_main.c               |   60 ++++++++++++++++------------
 drivers/net/bnx2.c                        |   12 +++---
 drivers/net/bonding/bond_main.c           |   25 ++++++++++--
 drivers/net/dm9000.c                      |    6 ++-
 drivers/net/dnet.c                        |    6 +-
 drivers/net/sh_eth.c                      |   20 ++++++++-
 drivers/net/sh_eth.h                      |    4 +-
 drivers/net/smsc911x.c                    |    4 ++
 drivers/net/sungem.c                      |    9 ++--
 drivers/net/tulip/tulip_core.c            |   45 ++++++++++++++--------
 drivers/net/ucc_geth.c                    |   34 +++++-----------
 drivers/net/ucc_geth.h                    |    3 +-
 drivers/net/virtio_net.c                  |    3 +
 drivers/net/wireless/ath9k/ath9k.h        |    4 +-
 drivers/net/wireless/ath9k/core.h         |   33 ++++++++++++++++
 drivers/net/wireless/ath9k/hw.c           |   22 ++++++++++-
 drivers/net/wireless/ath9k/main.c         |    1 +
 drivers/net/wireless/zd1211rw/zd_mac.c    |    8 +++-
 drivers/sbus/char/openprom.c              |    1 +
 include/linux/dca.h                       |   20 ++++++++++
 include/net/netfilter/nf_conntrack_core.h |    3 +-
 kernel/signal.c                           |    8 ++++
 net/core/dev.c                            |    7 ++-
 net/ipv4/ip_fragment.c                    |    3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c   |    8 ++--
 net/ipv6/reassembly.c                     |    7 +--
 net/ipv6/sit.c                            |    2 +-
 net/mac80211/tx.c                         |    2 +
 net/netfilter/nf_conntrack_core.c         |    2 +-
 net/netfilter/nf_conntrack_netlink.c      |    1 +
 net/netfilter/nf_conntrack_proto_tcp.c    |    4 +-
 net/sctp/endpointola.c                    |    3 +-
 net/wireless/Kconfig                      |   10 +++++
 net/wireless/lib80211_crypt_ccmp.c        |    2 +
 net/wireless/lib80211_crypt_tkip.c        |    4 ++
 net/wireless/nl80211.c                    |   11 +++++
 49 files changed, 351 insertions(+), 150 deletions(-)
warthog>
