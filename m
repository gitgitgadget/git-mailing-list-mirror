From: c.shoemaker@cox.net
Subject: [PATCH] git-push.sh: Factor out usage statement to function; explain why rsync can't push
Date: Sat, 29 Oct 2005 00:17:03 -0400
Message-ID: <E1EVi9P-0002Tw-BD@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:21:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi9r-0003wp-Bf
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVJ2ERG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVJ2ERG
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:17:06 -0400
Received: from eastrmmtao04.cox.net ([68.230.240.35]:5260 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751066AbVJ2ERE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:17:04 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041603.BMST23022.eastrmmtao04.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:16:03 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi9P-0002Tw-BD
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:17:03 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10790>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 git-push.sh |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

cc2f6f361691771cf461df04255a2b842b264371
diff --git a/git-push.sh b/git-push.sh
--- a/git-push.sh
+++ b/git-push.sh
@@ -1,6 +1,11 @@
 #!/bin/sh
 . git-sh-setup || die "Not a git archive"
 
+usage () {
+    die "Usage: git push [--all] [--force] <repository> [<refspec>]"
+}
+
+
 # Parse out parameters and then stop at remote, so that we can
 # translate it using .git/branches information
 has_all=
@@ -18,8 +23,7 @@ do
 	--exec=*)
 		has_exec="$1" ;;
 	-*)
-		die "Usage: git push [--all] [--force] <repository> <refspec>"
-                ;;
+                usage ;;
         *)
 		set x "$@"
 		shift
@@ -41,8 +45,10 @@ esac
 shift
 
 case "$remote" in
-http://* | https://* | git://* | rsync://* )
+http://* | https://* | git://*)
 	die "Cannot use READ-ONLY transport to push to $remote" ;;
+rsync://*)
+        die "Pushing with rsync transport is deprecated" ;;
 esac
 
 set x "$remote" "$@"; shift
