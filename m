From: Steven Grimm <sgrimm@sgrimm-mbp.local>
Subject: [PATCH] Update git-svn manpage to remove the implication that SVN::* is optional.
Date: Tue, 9 Jan 2007 16:20:17 -0800
Message-ID: <20070110002017.GA11564@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 10 01:20:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RCZ-0006q0-8E
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbXAJAUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXAJAUT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:20:19 -0500
Received: from tater.midwinter.com ([216.32.86.90]:59403 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932580AbXAJAUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:20:18 -0500
Received: (qmail 11696 invoked by uid 1001); 10 Jan 2007 00:20:17 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36437>

Now that git-svn requires the SVN::* Perl library, the manpage doesn't need
to describe what happens when you don't have it.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git-svn.txt |   65 ++++----------------------------------------
 1 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 8df43cb..1b01313 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -249,8 +249,7 @@ repo-config key: svn.authorsfile
 
 -q::
 --quiet::
-	Make git-svn less verbose.  This only affects git-svn if you
-	have the SVN::* libraries installed and are using them.
+	Make git-svn less verbose.
 
 --repack[=<n>]::
 --repack-flags=<flags>
@@ -321,8 +320,6 @@ for more information on using GIT_SVN_ID.
 	started tracking a branch and never tracked the trunk it was
 	descended from.
 
-	This relies on the SVN::* libraries to work.
-
 repo-config key: svn.followparent
 
 --no-metadata::
@@ -350,25 +347,6 @@ Run this if you used an old version of git-svn that used
 "git-svn-HEAD" instead of "remotes/git-svn" as the branch
 for tracking the remote.
 
---no-ignore-externals::
-Only used with the 'fetch' and 'rebuild' command.
-
-This command has no effect when you are using the SVN::*
-libraries with git, svn:externals are always avoided.
-
-By default, git-svn passes --ignore-externals to svn to avoid
-fetching svn:external trees into git.  Pass this flag to enable
-externals tracking directly via git.
-
-Versions of svn that do not support --ignore-externals are
-automatically detected and this flag will be automatically
-enabled for them.
-
-Otherwise, do not enable this flag unless you know what you're
-doing.
-
-repo-config key: svn.noignoreexternals
-
 --ignore-nodate::
 Only used with the 'fetch' command.
 
@@ -486,49 +464,18 @@ This allows you to tie unfetched SVN revision 375 to your current HEAD:
 	git-svn fetch 375=$(git-rev-parse HEAD)
 ------------------------------------------------
 
-Advanced Example: Tracking a Reorganized Repository
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Note: this example is now obsolete if you have SVN::* libraries
-installed.  Simply use --follow-parent when fetching.
-
 If you're tracking a directory that has moved, or otherwise been
 branched or tagged off of another directory in the repository and you
-care about the full history of the project, then you can read this
-section.
-
-This is how Yann Dirson tracked the trunk of the ufoai directory when
-the /trunk directory of his repository was moved to /ufoai/trunk and
-he needed to continue tracking /ufoai/trunk where /trunk left off.
+care about the full history of the project, then you can use
+the --follow-parent option.
 
-------------------------------------------------------------------------
-	# This log message shows when the repository was reorganized:
-	r166 | ydirson | 2006-03-02 01:36:55 +0100 (Thu, 02 Mar 2006) | 1 line
-	Changed paths:
-	   D /trunk
-	   A /ufoai/trunk (from /trunk:165)
-
-	# First we start tracking the old revisions:
-	GIT_SVN_ID=git-oldsvn git-svn init \
-			https://svn.sourceforge.net/svnroot/ufoai/trunk
-	GIT_SVN_ID=git-oldsvn git-svn fetch -r1:165
-
-	# And now, we continue tracking the new revisions:
-	GIT_SVN_ID=git-newsvn git-svn init \
-	      https://svn.sourceforge.net/svnroot/ufoai/ufoai/trunk
-	GIT_SVN_ID=git-newsvn git-svn fetch \
-	      166=`git-rev-parse refs/remotes/git-oldsvn`
-------------------------------------------------------------------------
+------------------------------------------------
+	git-svn fetch --follow-parent
+------------------------------------------------
 
 BUGS
 ----
 
-If you are not using the SVN::* Perl libraries and somebody commits a
-conflicting changeset to SVN at a bad moment (right before you commit)
-causing a conflict and your commit to fail, your svn working tree
-($GIT_DIR/git-svn/tree) may be dirtied.  The easiest thing to do is
-probably just to rm -rf $GIT_DIR/git-svn/tree and run 'rebuild'.   You
-can avoid this problem entirely by using 'dcommit'.
-
 We ignore all SVN properties except svn:executable.  Too difficult to
 map them since we rely heavily on git write-tree being _exactly_ the
 same on both the SVN and git working trees and I prefer not to clutter
-- 
1.5.0.rc0.g244a7
