From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 2/3] add -N option to cg-commit (resent again)
Date: Sat, 9 Jul 2005 06:43:30 -0400
Message-ID: <20050709104316.26765.86980.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 12:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrCo6-0005ov-CG
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 12:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGIKnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 06:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVGIKnb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 06:43:31 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:9307 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261606AbVGIKna (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 06:43:30 -0400
Received: (qmail 33557 invoked from network); 9 Jul 2005 10:43:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=xH95VWNLW5LkIkq9R18dHdPJLIveczwywP1uYUDVdqOB5PDCeMSWI8fcQHPfsgoq2digKVwD+SgZ94lvu/yeOgWosXnJV7Tk+2ziCtI3sarpNebM9GEaR5Z6CtawLyA/fnyk69GeE1KILWYjyC5WarIienVi/UvPc4ZZk87pUVE=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp108.mail.sc5.yahoo.com with SMTP; 9 Jul 2005 10:43:25 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(resending cogito patches)

Add the -N option to cg-commit.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-commit |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -39,6 +39,10 @@
 #	the tree is the same as the last time you committed, no changes
 #	happenned.
 #
+# -N::
+#   Don't add the files to the object database, just update the caches
+#   and the commit information.
+#
 # FILES
 # -----
 # $GIT_DIR/author::
@@ -103,11 +107,16 @@ fi
 force=
 forceeditor=
 ignorecache=
+infoonly=
 commitalways=
+nocheck=
 msgs=()
 while optparse; do
 	if optparse -C; then
 		ignorecache=1
+	elif optparse -N; then
+		nocheck=--no-check
+		infoonly=--info-only
 	elif optparse -e; then
 		forceeditor=1
 	elif optparse -E; then
@@ -278,9 +287,9 @@ precommit_update () {
 		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
 	done
 	# XXX: Do we even need to do the --add and --remove update-caches?
-	[ "$queueN" ] && { git-update-cache --add -- "${queueN[@]}" || return 1; }
+	[ "$queueN" ] && { git-update-cache --add ${infoonly} -- "${queueN[@]}" || return 1; }
 	[ "$queueD" ] && { git-update-cache --force-remove -- "${queueD[@]}" || return 1; }
-	[ "$queueM" ] && { git-update-cache -- "${queueM[@]}" || return 1; }
+	[ "$queueM" ] && { git-update-cache ${infoonly} -- "${queueM[@]}" || return 1; }
 	return 0
 }
 
@@ -300,7 +309,7 @@ if [ -s "$_git/HEAD" ]; then
 	oldheadstr="-p $oldhead"
 fi
 
-treeid=$(git-write-tree)
+treeid=$(git-write-tree ${nocheck})
 [ "$treeid" ] || die "git-write-tree failed"
 if [ ! "$force" ] && [ ! "$merging" ] && [ "$oldhead" ] &&
    [ "$treeid" = "$(tree-id)" ]; then



