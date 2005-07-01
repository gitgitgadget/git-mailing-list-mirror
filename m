From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Make O(n) algorithm the default implementation of --bisect
Date: Fri, 01 Jul 2005 16:31:16 +1000
Message-ID: <20050701063116.1156.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 01 08:25:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoEwn-0002Py-Ri
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbVGAGbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 02:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVGAGbt
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 02:31:49 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:56195 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S263239AbVGAGbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 02:31:19 -0400
Received: (qmail 1169 invoked by uid 500); 1 Jul 2005 06:31:16 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch makes the O(n) the default implementation of the git-rev-list
--bisect switch.

The original O(n^2) algorithm is still available as --bisect-orig.

It is left around to provide a quick and simple way to verify the
accuracy of the O(n) algorithm.

A subsequent patch is supplied to remove support for --bisect-orig
completely.

Signed-off: Jon Seymour <jon.seymour@gmail.com>
---
Linus: you may choose to defer application of this patch if you are
not confident that the O(n) algorithm is good.
---

 rev-list.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

342b91442a303b222f1601ef34ef37fffe5a9d57
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -16,6 +16,7 @@ static const char rev_list_usage[] =
 		      "  --min-age=epoch\n"
 		      "  --header\n"
 		      "  --pretty\n"
+                      "  --bisect\n"
 		      "  --merge-order [ --show-breaks ]";
 
 static int bisect_list = 0;
@@ -365,11 +366,11 @@ int main(int argc, char **argv)
 			show_parents = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--bisect-by-cut")) {
+		if (!strcmp(arg, "--bisect")) {
 			bisect_by_cut_option = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--bisect")) {
+		if (!strcmp(arg, "--bisect-orig")) {
 			bisect_list = 1;
 			continue;
 		}
------------
