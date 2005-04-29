From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] leftover bits for git rename
Date: Fri, 29 Apr 2005 15:42:09 -0700
Message-ID: <7voebx2oji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:37:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRe6e-0004A8-8N
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbVD2Wmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVD2Wmi
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:42:38 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:439 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263042AbVD2WmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 18:42:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429224210.YIIN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 18:42:10 -0400
To: Linus Torvalds <torvalds@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  commit 2d280e1c5e6fdcf5428e60219eae14a2c6629c51
  parent aed7a5a9dab96d1a17be4fadf7685086047178cc
  author Linus Torvalds <torvalds@ppc970.osdl.org> Fri Apr 29 15:02:43 2005
  committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri Apr 29 15:02:43 2005

    Update the merge scripts for the big git rename.

    Let's see what else I forgot..

Not that many, but here they are.

Signed-off-by: Junio C Hamano <junkio@cox.net>
----

git-merge-one-file-script |    6 +++---
git-prune-script          |    2 +-
git-tag-script            |    2 +-

cd /opt/packrat/playpen/public/in-place/git/git.linus/
jit-snap -v 0
# - [PATCH] Makefile: The big git command renaming fallout fix.
# + working tree
--- k/git-merge-one-file-script  (mode:100755)
+++ l/git-merge-one-file-script  (mode:100755)
@@ -9,7 +9,7 @@
 #
 #
 # Handle some trivial cases.. The _really_ trivial cases have
-# been handled already by read-tree, but that one doesn't
+# been handled already by git-read-tree, but that one doesn't
 # do any merges that migth change the tree layout
 #
 
@@ -41,7 +41,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 ".$2." | "..$3" )
 	echo "Adding $4 with perm $6$7"
-	mv $(unpack-file "$2$3") $4
+	mv $(git-unpack-file "$2$3") $4
 	chmod "$6$7" $4
 	git-update-cache --add -- $4
 	exit 0
@@ -55,7 +55,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		exit 1
 	fi
 	echo "Adding $4 with perm $6"
-	mv $(unpack-file "$2") $4
+	mv $(git-unpack-file "$2") $4
 	chmod "$6" $4
 	git-update-cache --add -- $4
 	exit 0;;
--- k/git-prune-script  (mode:100755)
+++ l/git-prune-script  (mode:100755)
@@ -1,2 +1,2 @@
 #!/bin/sh
-fsck-cache --unreachable $(cat .git/HEAD ) | grep unreachable | cut -d' ' -f3 | sed 's:^\(..\):.git/objects/\1/:' | xargs rm
+git-fsck-cache --unreachable $(cat .git/HEAD ) | grep unreachable | cut -d' ' -f3 | sed 's:^\(..\):.git/objects/\1/:' | xargs rm
--- k/git-tag-script  (mode:100755)
+++ l/git-tag-script  (mode:100755)
@@ -1,6 +1,6 @@
 #!/bin/sh
 object=${2:-$(cat .git/HEAD)}
-type=$(cat-file -t $object) || exit 1
+type=$(git-cat-file -t $object) || exit 1
 ( echo -e "object $object\ntype $type\ntag $1\n"; cat ) > .tmp-tag
 rm -f .tmp-tag.asc
 gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag


