From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] Documentation cvs: Clarify when a bare repository is needed
Date: Fri, 20 Jun 2008 22:52:05 -0600
Message-ID: <1214023925-12418-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: le_wen@distributel.ca, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 06:53:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9v6E-0008Bm-Rs
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 06:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYFUEwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 00:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbYFUEwL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 00:52:11 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:56678 "EHLO
	QMTA06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbYFUEwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jun 2008 00:52:09 -0400
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA06.emeryville.ca.mail.comcast.net with comcast
	id gUXa1Z00B17UAYkA601o00; Sat, 21 Jun 2008 04:52:08 +0000
Received: from mmogilvi.homeip.net ([75.70.160.185])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id gUs71Z00640J0Bv8ZUs8sf; Sat, 21 Jun 2008 04:52:08 +0000
X-Authority-Analysis: v=1.0 c=1 a=quxUde1k0KYA:10 a=O4TuiOBVbCkA:10
 a=w-HtJ5sARNHSwOu689UA:9 a=6FiSdVk8PvGl8_cI6zkA:7
 a=xnl81J4BaAt8tVwsyrei7TsIh5IA:4 a=3cjVDzgxsZYA:10 a=R6fQ0Q4ov3oA:10
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 479D389114;
	Fri, 20 Jun 2008 22:52:07 -0600 (MDT)
X-Mailer: git-send-email 1.5.5.1.385.g2f071
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85692>


Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

This was inspired because periodically someone asks about the
"Index already exists in git repo" error message from git-cvsserver,
and I noticed that two relevant and common starting points in the
documentation (git-cvsserver and get-cvsimport) do not mention
that a shared repository should be bare.

Maybe someone should write up something similar for things like
git-push, git-svn, various other import scripts, etc.  I don't really
know enough about any of them and how they interact with non-bare
repositories to write reliable documentation.

While in gitcvs-migration, I also noticed that it doesn't mention
git-cvsexportcommit at all, but I'm not sure if it should just
have a link in the "SEE ALSO" section, a sentence or two near where
it talks about incremental imports (since if you need incrementatl
import, you likely also need incremental export), or a whole new section.
Since I've never used cvsexportcommit at all, I'm not real
confident on what to say about how to use it with incremental import.

          - Matthew Ogilvie

 Documentation/git-cvsimport.txt    |    6 ++++++
 Documentation/git-cvsserver.txt    |    3 +++
 Documentation/gitcvs-migration.txt |    5 +++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 2f9b35f..c90de06 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -31,6 +31,12 @@ to work with; after that, you need to 'git merge' incremental imports, or
 any CVS branches, yourself.  It is advisable to specify a named remote via
 -r to separate and protect the incoming branches.
 
+If you intend to set up a shared public repository that all developers can
+read/write, or if you want to use linkgit:git-cvsserver[1], then you
+probably want to make a bare clone of the imported repository,
+and use the clone as the shared repository.
+See linkgit:gitcvs-migration[7][CVS migration].
+
 
 OPTIONS
 -------
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 3310ae2..e22e107 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -133,6 +133,9 @@ write access to the log file and to the database (see
 <<dbbackend,Database Backend>>. If you want to offer write access over
 SSH, the users of course also need write access to the git repository itself.
 
+You also need to ensure that each repository is "bare" (without a git index
+file) for `cvs commit` to work. See linkgit:gitcvs-migration[7][CVS migration].
+
 [[configaccessmethod]]
 All configuration variables can also be overridden for a specific method of
 access. Valid method names are "ext" (for SSH access) and "pserver". The
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 1db3f52..64c7550 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -143,6 +143,11 @@ work, you must not modify the imported branches; instead, create new
 branches for your own changes, and merge in the imported branches as
 necessary.
 
+If you want a shared repository, you will need to make a bare clone
+of the imported directory, as described above. Merging incremental
+imports could then be handled much like any other development clone of
+the shared repository.
+
 Advanced Shared Repository Management
 -------------------------------------
 
-- 
1.5.5.1.385.g2f071
