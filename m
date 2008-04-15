From: Scott Collins <scc@ScottCollins.net>
Subject: [PATCH] Clarify documentation of git-cvsserver, particularly in relation to git-shell
Date: Tue, 15 Apr 2008 11:30:02 -0400
Message-ID: <1208273402-2152-1-git-send-email-scc@ScottCollins.net>
Cc: Scott Collins <scc@ScottCollins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 18:17:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlnmM-0006Is-I3
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 18:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYDOQMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 12:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYDOQMT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 12:12:19 -0400
Received: from mx-1.vasoftware.com ([208.48.95.23]:50419 "EHLO
	mx-1.vasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbYDOQMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 12:12:18 -0400
X-Greylist: delayed 2526 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 12:12:18 EDT
Received: from ip199-194.digitalrealm.net ([216.144.199.194] helo=localhost.localdomain)
	by mx-1.vasoftware.com with esmtpa 
	(Exim 4.64)
	id 1Jln6p-0005AD-1W by VAAuthID scollins with plain; Tue, 15 Apr 2008 08:30:11 -0700
X-Mailer: git-send-email 1.5.5.49.gf43e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79605>

Currently, git-cvsserver requires CVS_SERVER to be set to 'cvs' if you are
restricted to git-shell, so we need to mention that here.  Previous wording
mentioning GIT_AUTHOR, GIT_COMMITTER variables may not have made clear we
really meant GIT_AUTHOR_(NAME|COMMITTER), etc.  Add a bit of text to
differentiate cvs -d (setting CVSROOT) from cvs co -d (setting the name of
the newly checked out directory).

Signed-off-by: Scott Collins <scc@ScottCollins.net>
---
 Documentation/git-cvsserver.txt |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 9cec802..5e67a89 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -106,7 +106,10 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
 
 ------
-cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
+cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name> -d <dir_name>
+
+# or for git-shell users:
+cvs -d ":ext;CVS_SERVER=cvs:user@server/path/repo.git" co <HEAD_name> -d <dir_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
@@ -146,7 +149,8 @@ allowing access over SSH.
    appropriate git repo. For example:
 +
 --
-For SSH access, CVS_SERVER should be set to git-cvsserver
+For normal SSH access, CVS_SERVER should be set to git-cvsserver.  For those
+whose access is restricted to git-shell, CVS_SERVER should be set to cvs.
 
 Example:
 
@@ -155,14 +159,17 @@ Example:
      export CVS_SERVER=git-cvsserver
 ------
 --
-4. For SSH clients that will make commits, make sure their .bashrc file
-   sets the GIT_AUTHOR and GIT_COMMITTER variables.
+4. For SSH clients that will make commits, make sure their (server-side) .bashrc
+   files export GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and
+   GIT_COMMITTER_EMAIL.
 
 5. Clients should now be able to check out the project. Use the CVS 'module'
-   name to indicate what GIT 'head' you want to check out. Example:
+   name to indicate what GIT 'head' you want to check out.  This also sets the
+   name of your newly checked-out directory, unless you tell it otherwise with
+   `-d <dir_name>` Example:
 +
 ------
-     cvs co -d project-master master
+     cvs co master -d project-master
 ------
 
 [[dbbackend]]
-- 
1.5.5.49.gf43e2
