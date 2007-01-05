From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: update documentation for multi-{init|fetch}
Date: Thu, 4 Jan 2007 18:04:06 -0800
Message-ID: <20070105020405.GA17716@localdomain>
References: <87fyaqvgoz.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Jan 05 03:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2eRJ-0007SF-Px
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 03:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbXAECEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 21:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbXAECEJ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 21:04:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60677 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030273AbXAECEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 21:04:08 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CA2C67DC099;
	Thu,  4 Jan 2007 18:04:06 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 04 Jan 2007 18:04:06 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <87fyaqvgoz.fsf@morpheus.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35968>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   54 ++++++++++++++++++++++++++++++--------------
 1 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f5f57e8..f754d2f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -3,7 +3,7 @@ git-svn(1)
 
 NAME
 ----
-git-svn - bidirectional operation between a single Subversion branch and git
+git-svn - bidirectional operation between Subversion and git
 
 SYNOPSIS
 --------
@@ -11,24 +11,20 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-git-svn is a simple conduit for changesets between a single Subversion
-branch and git. It is not to be confused with gitlink:git-svnimport[1].
-They were designed with very different goals in mind.
+git-svn is a simple conduit for changesets between Subversion and git.
+It is not to be confused with gitlink:git-svnimport[1], which is
+read-only and geared towards tracking multiple branches.
 
-git-svn is designed for an individual developer who wants a
+git-svn was originally designed for an individual developer who wants a
 bidirectional flow of changesets between a single branch in Subversion
-and an arbitrary number of branches in git.  git-svnimport is designed
-for read-only operation on repositories that match a particular layout
-(albeit the recommended one by SVN developers).
+and an arbitrary number of branches in git.  Since its inception,
+git-svn has gained the ability to track multiple branches in a manner
+similar to git-svnimport; but it cannot (yet) automatically detect new
+branches and tags like git-svnimport does.
 
-For importing svn, git-svnimport is potentially more powerful when
-operating on repositories organized under the recommended
-trunk/branch/tags structure, and should be faster, too.
-
-git-svn mostly ignores the very limited view of branching that
-Subversion has.  This allows git-svn to be much easier to use,
-especially on repositories that are not organized in a manner that
-git-svnimport is designed for.
+git-svn is especially useful when it comes to tracking repositories
+not organized in the way Subversion developers recommend (trunk,
+branches, tags directories).
 
 COMMANDS
 --------
@@ -370,7 +366,7 @@ SVN was very wrong.
 Basic Examples
 ~~~~~~~~~~~~~~
 
-Tracking and contributing to a Subversion-managed project:
+Tracking and contributing to a the trunk of a Subversion-managed project:
 
 ------------------------------------------------------------------------
 # Initialize a repo (like git init-db):
@@ -388,6 +384,30 @@ Tracking and contributing to a Subversion-managed project:
 	git-svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
+Tracking and contributing to an entire Subversion-managed project
+(complete with a trunk, tags and branches):
+See also:
+'<<tracking-multiple-repos,Tracking Multiple Repositories or Branches>>'
+
+------------------------------------------------------------------------
+# Initialize a repo (like git init-db):
+	git-svn multi-init http://svn.foo.org/project \
+		-T trunk -b branches -t tags
+# Fetch remote revisions:
+	git-svn multi-fetch
+# Create your own branch of trunk to hack on:
+	git checkout -b my-trunk remotes/trunk
+# Do some work, and then commit your new changes to SVN, as well as
+# automatically updating your working HEAD:
+	git-svn dcommit -i trunk
+# Something has been committed to trunk, rebase the latest into your branch:
+	git-svn multi-fetch && git rebase remotes/trunk
+# Append svn:ignore settings of trunk to the default git exclude file:
+	git-svn show-ignore -i trunk >> .git/info/exclude
+# Check for new branches and tags (no arguments are needed):
+	git-svn multi-init
+------------------------------------------------------------------------
+
 REBASE VS. PULL
 ---------------
 
-- 
1.5.0.rc0.g0d67
