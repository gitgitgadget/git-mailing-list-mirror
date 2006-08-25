From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: recommend rebase for syncing against an SVN repo
Date: Fri, 25 Aug 2006 12:48:23 -0700
Message-ID: <20060825194823.GC8957@localdomain>
References: <m2u040n5e2.fsf@ziti.local> <20060825191516.GA8957@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 21:48:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGhfK-0008UE-PK
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422871AbWHYTs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWHYTs1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:48:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8596 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422830AbWHYTsZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 15:48:25 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D58817DC02E;
	Fri, 25 Aug 2006 12:48:23 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 25 Aug 2006 12:48:23 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060825191516.GA8957@localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26014>

Does this make sense to other git-svn users out there?

pull can give funky history unless you understand how git-svn works
internally, which users should not be expected to do.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 7d86809..9fce4d3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -212,12 +212,26 @@ # Commit only the git commits you want t
 	git-svn commit <tree-ish> [<tree-ish_2> ...]
 # Commit all the git commits from my-branch that don't exist in SVN:
 	git-svn commit remotes/git-svn..my-branch
-# Something is committed to SVN, pull the latest into your branch:
-	git-svn fetch && git pull . remotes/git-svn
+# Something is committed to SVN, rebase the latest into your branch:
+	git-svn fetch && git rebase remotes/git-svn
 # Append svn:ignore settings to the default git exclude file:
 	git-svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
+REBASE VS. PULL
+---------------
+
+Originally, git-svn recommended that the remotes/git-svn branch be
+pulled from.  This is because the author favored 'git-svn commit B'
+to commit a single head rather than the 'git-svn commit A..B' notation
+to commit multiple commits.
+
+If you use 'git-svn commit A..B' to commit several diffs and you do not
+have the latest remotes/git-svn merged into my-branch, you should use
+'git rebase' to update your work branch instead of 'git pull'.  'pull'
+can cause non-linear history to be flattened when committing into SVN,
+which can lead to merge commits reversing previous commits in SVN.
+
 DESIGN PHILOSOPHY
 -----------------
 Merge tracking in Subversion is lacking and doing branched development
@@ -310,6 +324,10 @@ the possible corner cases (git doesn't d
 copied files are fully supported if they're similar enough for git to
 detect them.
 
+SEE ALSO
+--------
+gitlink:git-rebase[1]
+
 Author
 ------
 Written by Eric Wong <normalperson@yhbt.net>.
-- 
1.4.2.g7c9b
