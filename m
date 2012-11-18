From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH 1/4] git-svn: Document branches with at-sign(@).
Date: Sun, 18 Nov 2012 18:08:27 +0100
Message-ID: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Cc: "Eric Wong" <normalperson@yhbt.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Nov 25 11:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZZ2-00075K-BJ
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2KYKfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:35:39 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:37798 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2KYKfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:35:38 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 624F11F54504;
	Sun, 25 Nov 2012 11:35:07 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1TcZYb-0005uw-JL; Sun, 25 Nov 2012 11:35:25 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210350>

git svn will sometimes create branches with an at-sign in the name
(branchname@revision). These branches confuse many users and it is a FAQ
why they are created. Document when git svn will create them.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---

I found various important features of git-svn that are not documented.
Thus I created a series of patches to add and update documentation for
git-svn. I am sending this as four patches (of which this mail is the
first). I have tried my best to make the patches ready for inclusion
into git, but if there's any feedback, I'll gladly incorporate it.


 Documentation/git-svn.txt |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 8b0d3ad..482d60d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -881,6 +881,32 @@ different name spaces.  For example:
 	branches = stable/*:refs/remotes/svn/stable/*
 	branches = debug/*:refs/remotes/svn/debug/*
 
+If 'git svn' is configured to fetch branches (and --follow-branches
+is in effect), it will sometimes create multiple branches for one SVN
+branch, where the addtional branches have names of the form
+'branchname@nnn' (with nnn an SVN revision number).  These additional
+branches are created if 'git svn' cannot find a parent commit for the
+first commit in the branch, to connect the branch to the history of the
+other branches. Normally, 'git svn' will find the git commit that
+corresponds to the SVN revision a branch was created (copied) from and
+use that as the parent. However, it is possible that there is no
+suitable git commit to serve as parent.  This will happen, among other
+reasons, if the SVN branch is a copy of a revision that was not fetched
+by 'git svn' (e.g. because it is an old revision that was skipped with
+'--revision'), or if in SVN a directory was copied that is not tracked
+by 'git svn' (a branch that is not tracked at all, or a subdirectory of
+a tracked branch). In these cases, 'git svn' will still create a git
+branch, but the branch will not be connected to the history of the other
+branches.  'git svn' will also create a commit from the SVN revision the
+branch was copied from, and use that as the parent commit of the branch
+(this is indicated by the message "Initializing parent: <branchname>").
+Additionally, it will create a special branch named
+'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
+number the branch was copied from.  This branch will point to the
+specially created parent commit.
+If in SVN the branch was deleted and later recreated from a different
+version, there will be multiple such branches with an '@'.
+
 BUGS
 ----
 
-- 
1.7.10.4
