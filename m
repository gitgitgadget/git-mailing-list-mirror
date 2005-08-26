From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix the status output when there is nothing to commit.
Date: Fri, 26 Aug 2005 01:04:06 -0700
Message-ID: <7vek8hgm4p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 26 10:39:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8ZC8-0002ho-C5
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 10:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVHZIEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 04:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVHZIEI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 04:04:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33741 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964963AbVHZIEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 04:04:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826080406.URQN15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 04:04:06 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7785>

It had an extra empty '#' line.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-commit-script |    4 ++--
 git-status-script |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

22758793f9cde4379bacb067e2a4551373eaf073
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -195,8 +195,8 @@ else
 fi
 if [ "$?" != "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
 then
-	sed -ne '/^#/p' .editmsg
-	rm .editmsg
+	rm -f .editmsg
+	git-status-script
 	exit 1
 fi
 case "$no_edit" in
diff --git a/git-status-script b/git-status-script
--- a/git-status-script
+++ b/git-status-script
@@ -31,8 +31,7 @@ report () {
 branch=`readlink "$GIT_DIR/HEAD"`
 case "$branch" in
 refs/heads/master) ;;
-*)	echo "#
-# On branch $branch" ;;
+*)	echo "# On branch $branch" ;;
 esac
 git-update-cache --refresh >/dev/null 2>&1
 git-diff-cache -M --cached HEAD | sed 's/^://' | report "Updated but not checked in" "will commit"
