From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add SVN->Git conversion example to documentation, and cleanup the doc
Date: Fri, 20 Jun 2008 16:23:48 +0300
Message-ID: <20080620132348.GA21193@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Karl Hasselstrom <kha@treskal.com>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 15:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gbi-0002bT-SX
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYFTNXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jun 2008 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYFTNXv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:23:51 -0400
Received: from zakalwe.fi ([80.83.5.154]:34114 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbYFTNXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:23:50 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 8EAE62BBF3; Fri, 20 Jun 2008 16:23:48 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85643>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
This is the fourth round of the patch. Changes to earlier attempts:

* Explain git<>svn process better (Junio C Hamano)

* Don't mention git-svnimport unnecessarily. And where mentioned,=20
  mark it as deprecated. (Karl Hasselstr=F6m, Junio C Hamano)

* Remove unnecessary words from description

* Rename foo.git -> foo (Miklos Vajna)

* Remove refs/remotes/git-svn (Miklos Vajna)

* Don't set unnecessary fetch sources

* Use proper syntax for marking command line options in the text.
  Use "`--no-metadata`" instead of "--no-metadata". (Junio C Hamano)

* Improve explanation of "`--no-metadata`"

* This patch explains how to do one step transition to Git repository.
  Further updates from the SVN repo are not possible. A later patch may
  explain the process of incremental updates, but it doesn't really
  address the issue of moving from SVN to Git as Git should be
  self-sufficient. (Miklos Vajna)

 Documentation/git-svn.txt |   56 +++++++++++++++++++++++++++++++++++++=
--------
 1 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 97bed54..551f1df 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -11,15 +11,15 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-git-svn is a simple conduit for changesets between Subversion and git.
-It is not to be confused with linkgit:git-svnimport[1], which is
-read-only.
+git-svn is a simple bidirectional conduit for changesets between
+Subversion and git. It is used to develop SVN hosted projects with Git=
 tools.
+Changes are committed to a Git repository as would be normally done wi=
th
+Git, but the tool converts these commits later to SVN commits.
+It can also be used to convert a Subversion repository to a Git reposi=
tory.
=20
-git-svn was originally designed for an individual developer who wants =
a
-bidirectional flow of changesets between a single branch in Subversion
-and an arbitrary number of branches in git.  Since its inception,
-git-svn has gained the ability to track multiple branches in a manner
-similar to git-svnimport.
+git-svn was designed for developers who want
+bidirectional flow of changesets between multiple branches in Subversi=
on
+and an arbitrary number of branches in git.=20
=20
 git-svn is especially useful when it comes to tracking repositories
 not organized in the way Subversion developers recommend (trunk,
@@ -219,7 +219,7 @@ Any other arguments are passed directly to `git log=
'
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
 	command-line.  This command is intended for interoperability with
-	git-svnimport and does not rely on being inside an git-svn
+	git-svnimport (deprecated) and does not rely on being inside an git-s=
vn
 	init-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
 	URL of the target Subversion repository.  The final argument
@@ -317,7 +317,7 @@ config key: svn.findcopiesharder
 -A<filename>::
 --authors-file=3D<filename>::
=20
-Syntax is compatible with the files used by git-svnimport and
+Syntax is compatible with the files used by git-svnimport (deprecated)=
 and
 git-cvsimport:
=20
 ----------------------------------------------------------------------=
--
@@ -521,6 +521,42 @@ have each person clone that repository with 'git c=
lone':
 	git-svn rebase
 ----------------------------------------------------------------------=
--
=20
+CONVERTING A SUBVERSION REPOSITORY TO A GIT REPOSITORY
+------------------------------------------------------
+
+When converting a Subversion repository to a Git repository
+"`--no-metadata`" prevents git-svn from adding "git-svn-id:" comments =
to
+the log. "`-A`" option is used to convert SVN pseudonyms to real names
+and email addresses. The whole repository, or a part of it can be
+converted. Two examples below show how to convert the whole repo
+with all branches, or only the SVN trunk. Note, this way it is
+impossible to update Git repository incrementally from the SVN reposit=
ory.
+This is a one-step, one-way conversion.
+
+----------------------------------------------------------------------=
--
+# Convert all branches of an SVN repository to a Git repository:
+
+	git svn clone --no-metadata -A authors.txt SVN_URL foo
+
+# Convert only the trunk of an SVN repository to a Git repository:
+
+	git svn clone --no-metadata -A authors.txt SVN_URL/trunk foo
+----------------------------------------------------------------------=
--
+Next, the new repository should be verified to match what was
+expected. Go through the repository and logs to do that.
+Also, there may have been typos in the author file. It is crucial to
+get authors correctly in the conversion step, because it is very
+awkward and inconvenient to do it later (with rewrite).
+The last step is to remove the svn data from the repository,
+and repack the repository.
+----------------------------------------------------------------------=
--
+	cd foo/.git
+	rm -rf svn
+	rm -f refs/remotes/git-svn
+	git config --remove-section svn-remote.svn
+	git gc
+----------------------------------------------------------------------=
--
+
 REBASE VS. PULL/MERGE
 ---------------------
=20
--=20
1.5.5.1.1.ga5e5c
