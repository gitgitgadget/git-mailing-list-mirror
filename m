From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/6] show-diff.c: adjust default format for the Linux
 kernel.
Date: Mon, 18 Apr 2005 13:35:42 -0700
Message-ID: <7vis2ju8kh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:33:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcuR-0002yL-Vc
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDRUfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVDRUfx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:35:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35323 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261152AbVDRUfo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:35:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418203543.YLYU1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 16:35:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH 4/6] show-diff.c: adjust default format for the Linux kernel.

This patch adjusts the default output format of show-diff to match
the Linux kernel style, recommended in Documentation/SubmittingPatches.

To be applied on top of:

    [PATCH 1/6] show-diff.c: clean up private buffer use.
    [PATCH 2/6] show-diff.c: check unreadbale blob.
    [PATCH 3/6] show-diff.c: simplify show_diff_empty.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- a/show-diff.c
+++ b/show-diff.c
@@ -5,7 +5,7 @@
  */
 #include "cache.h"
 
-static char *diff_cmd = "diff -L '%s' -u -N  - '%s'";
+static char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' -p -u - '%s'";
 
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', and the caller is
@@ -52,11 +52,12 @@ static void show_differences(char *name,
 	FILE *f;
 	char *name_sq = sq_expand(name);
 	char *label_sq = (name != label) ? sq_expand(label) : name_sq;
-	int cmd_size = strlen(name_sq) + strlen(label_sq) + strlen(diff_cmd);
+	int cmd_size = strlen(name_sq) +
+		strlen(label_sq) * 2 + strlen(diff_cmd);
 	char *cmd = malloc(cmd_size);
 
 	fflush(stdout);
-	snprintf(cmd, cmd_size, diff_cmd, label_sq, name_sq);
+	snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq, name_sq);
 	f = popen(cmd, "w");
 	if (old_size)
 		fwrite(old_contents, old_size, 1, f);

