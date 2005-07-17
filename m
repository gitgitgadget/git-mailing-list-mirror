From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Audit rev-parse users.
Date: Sun, 17 Jul 2005 01:45:15 -0700
Message-ID: <7v8y053jok.fsf@assigned-by-dhcp.cox.net>
References: <7vmzol29zm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 10:45:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du4mA-0005Jt-BN
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 10:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVGQIpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 04:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGQIpU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 04:45:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:2460 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261217AbVGQIpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 04:45:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717084517.BGBX7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Jul 2005 04:45:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzol29zm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 16 Jul 2005 23:59:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes rev-parse users that pass a single argument
that is supposed to be a rev parameter to use "--verify".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This does not have anything to do with the --sq flag.

 git-checkout-script |    2 +-
 git-cherry          |    8 ++++----
 git-commit-script   |    2 +-
 git-rebase-script   |    8 ++++----
 git-resolve-script  |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

eee0f165b4762203c0d827bae7480daf41514f17
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
@@ -15,7 +15,7 @@ do
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
