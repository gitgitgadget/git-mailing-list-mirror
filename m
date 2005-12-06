From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Use printf rather than echo -n.
Date: Tue, 06 Dec 2005 14:21:52 -0800
Message-ID: <20512.1133907712@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:25:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjlCj-0003ga-Qq
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 23:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVLFWVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 17:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVLFWVy
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 17:21:54 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:54425 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1030283AbVLFWVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 17:21:53 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB6MLq6d020514
	for <git@vger.kernel.org>; Tue, 6 Dec 2005 14:21:52 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB6MLqog020513
	for <git@vger.kernel.org>; Tue, 6 Dec 2005 14:21:52 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13300>


On AIX, there is no -n option to the system's echo.  Instead,
it needs the '\c' control character.  We could replace
  echo -n "foo"
with
  echo -e "foo\c"
but printf is recommended by most man pages.  Tested on AIX
5.3, Solaris 8, and Debian.

Signed-off-by: E. Jason Riedy <ejr@cs.berkeley.edu>

---

 git-am.sh         |    2 +-
 git-applypatch.sh |    2 +-
 git-bisect.sh     |    2 +-
 git-status.sh     |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

58ad3dda17daa0577fda5204f75bbc846cf7d7ea
diff --git a/git-am.sh b/git-am.sh
index 660b3a4..6ed527c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -312,7 +312,7 @@ do
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
-		echo -n "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
 		read reply
 		case "$reply" in
 		[yY]*) action=yes ;;
diff --git a/git-applypatch.sh b/git-applypatch.sh
index 4c577eb..a112e1a 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -83,7 +83,7 @@ while [ "$interactive" = yes ]; do
 	echo "--------------------------"
 	cat "$final"
 	echo "--------------------------"
-	echo -n "Apply? [y]es/[n]o/[e]dit/[a]ccept all "
+	printf "Apply? [y]es/[n]o/[e]dit/[a]ccept all "
 	read reply
 	case "$reply" in
 		y|Y) interactive=no;;
diff --git a/git-bisect.sh b/git-bisect.sh
index 68838f3..05dae8a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -67,7 +67,7 @@ bisect_start() {
 	rm -rf "$GIT_DIR/refs/bisect/"
 	mkdir "$GIT_DIR/refs/bisect"
 	{
-	    echo -n "git-bisect start"
+	    printf "git-bisect start"
 	    sq "$@"
 	} >"$GIT_DIR/BISECT_LOG"
 	sq "$@" >"$GIT_DIR/BISECT_NAMES"
diff --git a/git-status.sh b/git-status.sh
index b90ffc1..bf0e66c 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -13,7 +13,7 @@ report () {
   trailer=""
   while read status name newname
   do
-    echo -n "$header"
+    printf "$header"
     header=""
     trailer="#
 "
@@ -27,7 +27,7 @@ report () {
     U ) echo "#	unmerged: $name";;
     esac
   done
-  echo -n "$trailer"
+  printf "$trailer"
   [ "$header" ]
 }
 
-- 
0.99.9.GIT
