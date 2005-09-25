From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] More descriptive messages for conflict cases in merges
Date: Sun, 25 Sep 2005 16:49:02 +0200
Message-ID: <20050925144902.GC20527@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 16:49:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJXoT-0008BS-4q
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 16:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVIYOtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 10:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVIYOtE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 10:49:04 -0400
Received: from [85.8.31.11] ([85.8.31.11]:44714 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751472AbVIYOtE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 10:49:04 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 4EE144100; Sun, 25 Sep 2005 16:54:49 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EJXoN-0007HZ-00; Sun, 25 Sep 2005 16:49:03 +0200
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9264>

The merge strategies can give more descriptive error messages for
conflict cases if they are given the actual branch names instead of
the SHA1s.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

c5a902b12ca631d0ca28f914c1b227481d300295
diff --git a/git-merge.sh b/git-merge.sh
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -71,6 +71,7 @@ test "$#" -le 2 && usage ;# we need at l
 
 merge_msg="$1"
 shift
+head_arg="$1"
 head=$(git-rev-parse --verify "$1"^0) || usage
 shift
 
@@ -86,7 +87,7 @@ echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
 case "$#,$common" in
 *,'')
-	die "Unable to find common commit between $head and $*"
+	die "Unable to find common commit between $head_arg and $*"
 	;;
 1,"$1")
 	# If head can reach all the merge then we are up to date.
@@ -147,7 +148,7 @@ do
     }
     echo "Trying merge strategy $strategy..."
     wt_strategy=$strategy
-    git-merge-$strategy $common -- $head "$@" || {
+    git-merge-$strategy $common -- $head_arg "$@" || {
 
 	# The backend exits with 1 when conflicts are left to be resolved,
 	# with 2 when it does not handle the given merge at all.
@@ -202,7 +203,7 @@ case "$best_strategy" in
 	echo "Rewinding the tree to pristine..."
 	git reset --hard $head
 	echo "Using the $best_strategy to prepare resolving by hand."
-	git-merge-$best_strategy $common -- $head "$@"
+	git-merge-$best_strategy $common -- $head_arg "$@"
 	;;
 esac
 for remote
