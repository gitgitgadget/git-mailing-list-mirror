From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Change to gitk to make it use --topo-order rather than --merge-order
Date: Sat, 02 Jul 2005 16:09:38 +1000
Message-ID: <20050702060938.13030.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 02 08:02:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dob4s-0001dQ-Hx
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 08:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVGBGJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 02:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGBGJs
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 02:09:48 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:48770 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261825AbVGBGJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 02:09:41 -0400
Received: (qmail 13040 invoked by uid 500); 2 Jul 2005 06:09:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch make gitk use --topo-order rather than --merge-order.

There is no actual advantage in doing this as the git-rev-list 
execution times are dwarfed by tcl/tk overheads so the 3-4 time
git-rev-list speedup is effectively invisible. Still, it
does demonstrate the use of the --topo-order flag.

One advantage of this patch would be to allow gitk to be used
in environments that don't have the ssl bignum library available
for some reason.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
This patch assumes that git has been patched to include support
for --topo-order.

Here's a chance to test merging a gitk patch from git back into
gitk :-)
---

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

4deb99b73fd6fc8e4995b55e9e23988c8766f509
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -37,7 +37,7 @@ proc getcommits {rargs} {
 	set parsed_args $rargs
     }
     if [catch {
-	set commfd [open "|git-rev-list --header --merge-order $parsed_args" r]
+	set commfd [open "|git-rev-list --header --topo-order $parsed_args" r]
     } err] {
 	puts stderr "Error executing git-rev-list: $err"
 	exit 1
------------
