From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Audit rev-parse users.
Date: Mon, 15 Aug 2005 02:55:23 -0700
Message-ID: <7vacjj1q44.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 15 11:55:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4bgm-0000Tk-4F
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVHOJzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVHOJzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:55:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31651 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932536AbVHOJzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:55:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815095524.VEZO8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 05:55:24 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make sure that we say --verify when we want to get a single SHA1
name.  Also when we say --verify, --revs-only is redundant.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-rebase-script |    2 +-
 git-reset-script  |    4 ++--
 git-tag-script    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

fb1dea6f0298f4b47ae6a3dc08a1bc2398ef8053
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -28,7 +28,7 @@ case "$#" in
 esac
 
 git-read-tree -m -u $ours $upstream &&
-echo "$upstream" >"$GIT_DIR/HEAD" || exit
+git-rev-parse --verify "$upstream^0" >"$GIT_DIR/HEAD" || exit
 
 tmp=.rebase-tmp$$
 fail=$tmp-fail
diff --git a/git-reset-script b/git-reset-script
--- a/git-reset-script
+++ b/git-reset-script
@@ -1,7 +1,7 @@
 #!/bin/sh
 . git-sh-setup-script || die "Not a git archive"
-rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
-rev=$(git-rev-parse --revs-only --verify $rev^0) || exit
+rev=$(git-rev-parse --verify --default HEAD "$@") || exit
+rev=$(git-rev-parse --verify $rev^0) || exit
 git-read-tree --reset "$rev" && {
 	if orig=$(git-rev-parse --verify HEAD 2>/dev/null)
 	then
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -47,7 +47,7 @@ if [ -e "$GIT_DIR/refs/tags/$name" -a -z
 fi
 shift
 
-object=$(git-rev-parse --verify --revs-only --default HEAD "$@") || exit 1
+object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
 
