From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 7/8] Documentation/cherry-pick: describe passing more than
	one commit
Date: Wed, 02 Jun 2010 07:58:40 +0200
Message-ID: <20100602055842.21504.3914.chriscool@tuxfamily.org>
References: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:59:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgzX-00071Z-6h
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab0FBF7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:59:46 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48229 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab0FBF7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:59:45 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2F4B98180E0;
	Wed,  2 Jun 2010 07:59:36 +0200 (CEST)
X-git-sha1: c6fcec4a95045148e6869365e9512c0407975fb7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148215>

And while at it, add an "EXAMPLES" section.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-cherry-pick.txt |   64 ++++++++++++++++++++++++++++++------
 1 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d71607a..bcb4c75 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -3,24 +3,28 @@ git-cherry-pick(1)
 
 NAME
 ----
-git-cherry-pick - Apply the change introduced by an existing commit
+git-cherry-pick - Apply the changes introduced by some existing commits
 
 SYNOPSIS
 --------
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 
 DESCRIPTION
 -----------
-Given one existing commit, apply the change the patch introduces, and record a
-new commit that records it.  This requires your working tree to be clean (no
-modifications from the HEAD commit).
+
+Given one or more existing commits, apply the change each one
+introduces, recording a new commit for each.  This requires your
+working tree to be clean (no modifications from the HEAD commit).
 
 OPTIONS
 -------
-<commit>::
-	Commit to cherry-pick.
+<commit>...::
+	Commits to cherry-pick.
 	For a more complete list of ways to spell commits, see the
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	Sets of commits can be passed but no traversal is done by
+	default, as if the '--no-walk' option was specified, see
+	linkgit:git-rev-list[1].
 
 -e::
 --edit::
@@ -55,10 +59,10 @@ OPTIONS
 
 -n::
 --no-commit::
-	Usually the command automatically creates a commit.
-	This flag applies the change necessary to cherry-pick
-	the named commit to your working tree and the index,
-	but does not make the commit.  In addition, when this
+	Usually the command automatically creates a sequence of commits.
+	This flag applies the changes necessary to cherry-pick
+	each named commit to your working tree and the index,
+	without making any commit.  In addition, when this
 	option is used, your index does not have to match the
 	HEAD commit.  The cherry-pick is done against the
 	beginning state of your index.
@@ -75,6 +79,40 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
+EXAMPLES
+--------
+git cherry-pick master::
+
+	Apply the change introduced by the commit at the tip of the
+	master branch and create a new commit with this change.
+
+git cherry-pick ..master::
+git cherry-pick ^HEAD master::
+
+	Apply the changes introduced by all commits that are ancestors
+	of master but not of HEAD to produce new commits.
+
+git cherry-pick master\~4 master~2::
+
+	Apply the changes introduced by the fifth and third last
+	commits pointed to by master and create 2 new commits with
+	these changes.
+
+git cherry-pick -n master~1 next::
+
+	Apply to the working tree and the index the changes introduced
+	by the second last commit pointed to by master and by the last
+	commit pointed to by next, but do not create any commit with
+	these changes.
+
+git cherry-pick --ff ..next::
+
+	If history is linear and HEAD is an ancestor of next, update
+	the working tree and advance the HEAD pointer to match next.
+	Otherwise, apply the changes introduced by those commits that
+	are in next but not HEAD to the current branch, creating a new
+	commit for each new change.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
@@ -83,6 +121,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+SEE ALSO
+--------
+linkgit:git-revert[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.1.362.g8d752
