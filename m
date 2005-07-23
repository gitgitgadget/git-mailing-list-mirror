From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Audit rev-parse users.
Date: Fri, 22 Jul 2005 19:09:05 -0700
Message-ID: <7vsly66zpa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:11:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9Tl-0008Nc-TE
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVGWCKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVGWCKd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:10:33 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21235 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262278AbVGWCJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:09:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723020904.PQYN16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:09:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes rev-parse users that pass a single argument
that is supposed to be a rev parameter to use "--verify".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-checkout-script |    2 +-
 git-cherry          |    8 ++++----
 git-commit-script   |    2 +-
 git-rebase-script   |    8 ++++----
 git-resolve-script  |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

f3818c97f985fe20d24fe3d12cca5ce1cfbf8d74
diff --git a/git-checkout-script b/git-checkout-script
--- a/git-checkout-script
+++ b/git-checkout-script
@@ -22,7 +22,7 @@ while [ "$#" != "0" ]; do
 		force=1
 		;;
 	*)
-		rev=$(git-rev-parse --verify --revs-only "$arg^0") || exit
+		rev=$(git-rev-parse --verify "$arg^0") || exit
 		if [ -z "$rev" ]; then
 			echo "unknown flag $arg"
 			exit 1
diff --git a/git-cherry b/git-cherry
--- a/git-cherry
+++ b/git-cherry
@@ -28,11 +28,11 @@ The output is intended to be used as:
 '
 
 case "$#" in
-1) linus=`git-rev-parse "$1"` &&
-   junio=`git-rev-parse HEAD` || exit
+1) linus=`git-rev-parse --verify "$1"` &&
+   junio=`git-rev-parse --verify HEAD` || exit
    ;;
-2) linus=`git-rev-parse "$1"` &&
-   junio=`git-rev-parse "$2"` || exit
+2) linus=`git-rev-parse --verify "$1"` &&
+   junio=`git-rev-parse --verify "$2"` || exit
    ;;
 *) echo >&2 "$usage"; exit 1 ;;
 esac
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -16,7 +16,7 @@ do
     -m) shift
         case "$#" in
 	0) usage ;;
-	*) use_commit=`git-rev-parse "$1"` ||
+	*) use_commit=`git-rev-parse --verify "$1"` ||
 	   exit ;;
 	esac
 	;;
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -11,11 +11,11 @@ upstream tree.'
 : ${GIT_DIR=.git}
 
 case "$#" in
-1) linus=`git-rev-parse "$1"` &&
-   junio=`git-rev-parse HEAD` || exit
+1) linus=`git-rev-parse --verify "$1"` &&
+   junio=`git-rev-parse --verify HEAD` || exit
    ;;
-2) linus=`git-rev-parse "$1"` &&
-   junio=`git-rev-parse "$2"` || exit
+2) linus=`git-rev-parse --verify "$1"` &&
+   junio=`git-rev-parse --verify "$2"` || exit
    ;;
 *) echo >&2 "$usage"; exit 1 ;;
 esac
diff --git a/git-resolve-script b/git-resolve-script
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -6,8 +6,8 @@
 #
 . git-sh-setup-script || die "Not a git archive"
 
-head=$(git-rev-parse --revs-only "$1")
-merge=$(git-rev-parse --revs-only "$2")
+head=$(git-rev-parse --verify "$1")
+merge=$(git-rev-parse --verify "$2")
 merge_msg="$3"
 
 dropheads() {
