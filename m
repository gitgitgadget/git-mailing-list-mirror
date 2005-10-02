From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Use git-update-ref for updating the HEAD
Date: Sun, 2 Oct 2005 12:12:24 +0200
Message-ID: <20051002101224.GA9219@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 12:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM0pf-0004bC-FT
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 12:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVJBKM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 06:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVJBKM0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 06:12:26 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:2273 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751055AbVJBKMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 06:12:25 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0ED4E6E0E7D; Sun,  2 Oct 2005 12:12:21 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C6A866E010A; Sun,  2 Oct 2005 12:12:20 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3AE5260EF6; Sun,  2 Oct 2005 12:12:24 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9610>

Conditionally make git-update-ref check the old head. For this to succeed
for the initial commit, cg-init should not touch .git/refs/heads/master,
and the touching seems to be redundant anyway, so remove it.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit b41f8cafc556233613412ff3545e3507202b666a
tree 9e2c5d8d467acc27d7c866c908990d7de44478f9
parent b06f2a707963c8712f7a6bbd4b89bae758bcf92a
author Jonas Fonseca <fonseca@diku.dk> Thu, 29 Sep 2005 15:09:06 +0200
committer Jonas Fonseca <fonseca@stud1-9.itu.dk> Thu, 29 Sep 2005 15:09:06 +0200

 cg-Xlib   |    2 +-
 cg-commit |    2 +-
 cg-init   |    1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -246,7 +246,7 @@ tree_timewarp()
 	fi
 
 	git-read-tree -m "$branch" || die "$branch: bad commit"
-	[ "$no_head_update" ] || echo "$branch" > $_git/HEAD
+	[ "$no_head_update" ] || git-update-ref HEAD "$branch"
 
 	# Kill gone files
 	git-diff-tree -z -r $base $branch | xargs -0 bash -c '
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -420,7 +420,7 @@ fi
 
 if [ "$newhead" ]; then
 	echo "Committed as $newhead."
-	echo $newhead >$_git/HEAD
+	git-update-ref HEAD $newhead $oldhead
 	[ "$merging" ] && rm $_git/merging $_git/merging-sym $_git/merge-base
 	rm -f "$_git/commit-ignore"
 
diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -48,7 +48,6 @@ done
 cleanup_trap "rm -rf $_git"
 
 git-init-db
-touch $_git/refs/heads/master
 
 git-read-tree # Seed the dircache
 if ! [ "$no_initial_commit" ]; then

-- 
Jonas Fonseca
