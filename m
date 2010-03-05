From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: reset: describe new "--keep" option
Date: Fri, 05 Mar 2010 21:25:36 +0100
Message-ID: <20100305202537.25469.73470.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 22:09:17 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnelp-0001G8-89
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 22:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab0CEVJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 16:09:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52470 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab0CEVJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 16:09:06 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 34E588180EA;
	Fri,  5 Mar 2010 22:08:57 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9AC9A818076;
	Fri,  5 Mar 2010 22:08:54 +0100 (CET)
X-git-sha1: ce28108082d38fcf6f4296226e34456dd9601fdd 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141597>

and give an example to show how it can be used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-reset.txt |   49 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 1 deletions(-)

This patch replaces the patch with the same name currently in pu.
The example given at then end is much improved, thanks to Junio.

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 168db08..1e9ae0a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,7 +8,7 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [--mixed | --soft | --hard | --merge] [-q] [<commit>]
+'git reset' [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]
 'git reset' [-q] [<commit>] [--] <paths>...
 'git reset' --patch [<commit>] [--] [<paths>...]
 
@@ -52,6 +52,11 @@ OPTIONS
 	and updates the files that are different between the named commit
 	and the current commit in the working tree.
 
+--keep::
+	Resets the index to match the tree recorded by the named commit,
+	but keep changes in the working tree. Aborts if the reset would
+	change files that are already modified in the working tree.
+
 -p::
 --patch::
 	Interactively select hunks in the difference between the index
@@ -93,6 +98,7 @@ in the index and in state D in HEAD.
 				--mixed  A       D     D
 				--hard   D       D     D
 				--merge (disallowed)
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -100,6 +106,7 @@ in the index and in state D in HEAD.
 				--mixed  A       C     C
 				--hard   C       C     C
 				--merge (disallowed)
+				--keep   A       C     C
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -107,6 +114,7 @@ in the index and in state D in HEAD.
 				--mixed  B       D     D
 				--hard   D       D     D
 				--merge  D       D     D
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -114,6 +122,7 @@ in the index and in state D in HEAD.
 				--mixed  B       C     C
 				--hard   C       C     C
 				--merge  C       C     C
+				--keep   B       C     C
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -121,6 +130,7 @@ in the index and in state D in HEAD.
 				--mixed  B       D     D
 				--hard   D       D     D
 				--merge (disallowed)
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -128,6 +138,7 @@ in the index and in state D in HEAD.
 				--mixed  B       C     C
 				--hard   C       C     C
 				--merge  B       C     C
+				--keep   B       C     C
 
 "reset --merge" is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the work tree file that is
@@ -138,6 +149,14 @@ between the index and the work tree, then it means that we are not
 resetting out from a state that a mergy operation left after failing
 with a conflict. That is why we disallow --merge option in this case.
 
+"reset --keep" is meant to be used when removing some of the last
+commits in the current branch while keeping changes in the working
+tree. If there could be conflicts between the changes in the commit we
+want to remove and the changes in the working tree we want to keep,
+the reset is disallowed. That's why it is disallowed if there are both
+changes between the working tree and HEAD, and between HEAD and the
+target.
+
 The following tables show what happens when there are unmerged
 entries:
 
@@ -147,6 +166,7 @@ entries:
 				--mixed  X       B     B
 				--hard   B       B     B
 				--merge  B       B     B
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -154,6 +174,7 @@ entries:
 				--mixed  X       A     A
 				--hard   A       A     A
 				--merge  A       A     A
+				--keep   X       A     A
 
 X means any state and U means an unmerged index.
 
@@ -325,6 +346,32 @@ $ git add frotz.c                           <3>
 <2> This commits all other changes in the index.
 <3> Adds the file to the index again.
 
+Keep changes in working tree while discarding some previous commits::
++
+Suppose you are working on something and you commit it, and then you
+continue working a bit more, but now you think that what you have in
+your working tree should be in another branch that has nothing to do
+with what you commited previously. You can start a new branch and
+reset it while keeping the changes in your work tree.
++
+------------
+$ git tag start
+$ git checkout -b branch1
+$ edit
+$ git commit ...                            <1>
+$ edit
+$ git checkout -b branch2                   <2>
+$ git reset --keep start                    <3>
+------------
++
+<1> This commits your first edits in branch1.
+<2> In the ideal world, you could have realized that the earlier
+    commit did not belong to the new topic when you created and switched
+    to branch2 (i.e. "git checkout -b branch2 start"), but nobody is
+    perfect.
+<3> But you can use "reset --keep" to remove the unwanted commit after
+    you switched to "branch2".
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com> and Linus Torvalds <torvalds@osdl.org>
-- 
1.7.0.1.335.g17865
