From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add -v option to git-branch.sh
Date: Sat, 21 Oct 2006 13:32:36 +0200
Message-ID: <11614303561903-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 13:32:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbF5p-0008WU-UL
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 13:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161468AbWJULcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 07:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161469AbWJULcj
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 07:32:39 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:12948 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S1161468AbWJULcj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 07:32:39 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id k9LBWaRv009048;
	Sat, 21 Oct 2006 13:32:36 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.ge193
Date: Sat, 21 Oct 2006 13:09:09 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29604>

Teach git-branch to show sha1 and subject for each branch tip. 

This requires branch names to be max 20 chars for the output to be 
properly aligned. Not optimal, but doing an extra pass just to find 
the longest name didn't seem reasonable either.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-branch.sh |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index 4379a07..6a425e0 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r'
+USAGE='[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r | -v'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
@@ -56,6 +56,7 @@ ls_remote_branches () {
 
 force=
 create_log=
+verbose=
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -73,6 +74,9 @@ do
 	-l)
 		create_log="yes"
 		;;
+	-v)
+		verbose="yes"
+		;;
 	--)
 		shift
 		break
@@ -96,7 +100,13 @@ case "$#" in
 		else
 			pfx=' '
 		fi
-		echo "$pfx $ref"
+		if test "$verbose" = "yes"
+		then
+			log=$(git-log --max-count=1 --pretty=oneline $ref)
+			printf "%s %-20s %s\n" "$pfx" "$ref" "$log"
+		else
+			echo "$pfx $ref"
+		fi
 	done
 	exit 0 ;;
 1)
-- 
1.4.3.ge193
