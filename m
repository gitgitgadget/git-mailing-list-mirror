From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 4/5] Documentation: reset: describe new "--keep" option
Date: Sat, 02 Jan 2010 06:39:32 +0100
Message-ID: <20100102053934.30066.76552.chriscool@tuxfamily.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 06:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwin-00023x-39
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab0ABFj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106Ab0ABFj4
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:39:56 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53999 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab0ABFjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:39:52 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EF1B4818078;
	Sat,  2 Jan 2010 06:39:42 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9BCB1818064;
	Sat,  2 Jan 2010 06:39:39 +0100 (CET)
X-git-sha1: f9a9c1f915a014483c1b04fb8babdf1addcf4b6b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136017>

and give an example to show how it can be used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |   41 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b78e2e1..3d7c206 100644
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
+	change files that are already changes in the working tree.
+
 -p::
 --patch::
 	Interactively select hunks in the difference between the index
@@ -86,6 +91,7 @@ reset options depending on the state of the files.
 				--mixed  A       D     D
 				--hard   D       D     D
 				--merge (disallowed)
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -93,6 +99,7 @@ reset options depending on the state of the files.
 				--mixed  A       C     C
 				--hard   C       C     C
 				--merge (disallowed)
+				--keep   A       C     C
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -100,6 +107,7 @@ reset options depending on the state of the files.
 				--mixed  B       D     D
 				--hard   D       D     D
 				--merge  D       D     D
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -107,13 +115,14 @@ reset options depending on the state of the files.
 				--mixed  B       C     C
 				--hard   C       C     C
 				--merge  C       C     C
+				--keep   B       C     C
 
 In these tables, A, B, C and D are some different states of a
 file. For example, the last line of the last table means that if a
 file is in state B in the working tree and the index, and in a
 different state C in HEAD and in the target, then "git reset
---merge target" will put the file in state C in the working tree,
-in the index and in HEAD.
+--keep target" will put the file in state B in the working tree,
+and in state C in the index and in HEAD.
 
 The following tables show what happens when there are unmerged
 entries:
@@ -124,6 +133,7 @@ entries:
 				--mixed  X       B     B
 				--hard   B       B     B
 				--merge  B       B     B
+				--keep  (disallowed)
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
@@ -131,6 +141,7 @@ entries:
 				--mixed  X       A     A
 				--hard   A       A     A
 				--merge  A       A     A
+				--keep   X       A     A
 
 X means any state and U means an unmerged index.
 
@@ -302,6 +313,30 @@ $ git add frotz.c                           <3>
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
+$ git branch branch1
+$ edit
+$ git commit ...                            <1>
+$ edit
+$ git branch branch2                        <2>
+$ git reset --keep start                    <3>
+------------
++
+<1> This commits your first edits in branch1.
+<2> This creates branch2, but unfortunately it contains the previous
+commit that you don't want in this branch.
+<3> This removes the unwanted previous commit, but this keeps the
+changes in your working tree.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com> and Linus Torvalds <torvalds@osdl.org>
-- 
1.6.6.rc2.5.g49666
