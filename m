From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: updated documentation
Date: Sun, 5 Mar 2006 23:11:00 +1300
Message-ID: <114155346045-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Mar 05 11:11:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFqDD-0006h5-Dq
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 11:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbWCEKLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 05:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbWCEKLK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 05:11:10 -0500
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:49060 "HELO
	mx.nzl.com.ar") by vger.kernel.org with SMTP id S1752239AbWCEKLJ
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 05:11:09 -0500
Received: (qmail 2133 invoked from network); 5 Mar 2006 10:10:58 -0000
Received: from unknown (HELO aporo.local) (192.168.0.35)
  by 192.168.0.1 with SMTP; 5 Mar 2006 10:10:58 -0000
X-Mailer: git-send-email
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17217>

... and stripped trailing whitespace to appease the Gods...

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Documentation/git-cvsserver.txt |   87 +++++++++++++++++++++++++++------------
 1 files changed, 61 insertions(+), 26 deletions(-)

a67387be3b0dd572f78da9befe27303b20e9cbf1
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 19c9c51..4dc13c3 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -5,14 +5,12 @@ NAME
 ----
 git-cvsserver - A CVS server emulator for git
 
-
 SYNOPSIS
 --------
 [verse]
 export CVS_SERVER=git-cvsserver
 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
 
-
 DESCRIPTION
 -----------
 
@@ -27,48 +25,85 @@ plugin. Most functionality works fine wi
 
 LIMITATIONS
 -----------
-Currently gitcvs only works over ssh connections.
 
+Currently cvsserver works over SSH connections for read/write clients, and
+over pserver for anonymous CVS access.
+
+CVS clients cannot tag, branch or perform GIT merges.
 
 INSTALLATION
 ------------
-1. Put server.pl somewhere useful on the same machine that is hosting your git repos
+
+1. If you are going to offer anonymous CVS access via pserver, add a line in
+   /etc/inetd.conf like
+
+   cvspserver stream tcp nowait nobody git-cvsserver pserver
+
+   Note: In some cases, you need to pass the 'pserver' argument twice for
+   git-cvsserver to see it. So the line would look like
+
+   cvspserver stream tcp nowait nobody git-cvsserver pserver pserver
+
+   No special setup is needed for SSH access, other than having GIT tools
+   in the PATH. If you have clients that do not accept the CVS_SERVER
+   env variable, you can rename git-cvsserver to cvs.
 
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
 
    [gitcvs]
         enabled=1
+        # optional for debugging
         logfile=/path/to/logfile
 
-   n.b. you need to ensure each user that is going to invoke server.pl has
-   write access to the log file.
+   Note: you need to ensure each user that is going to invoke git-cvsserver has
+   write access to the log file and to the git repository. When offering anon
+   access via pserver, this means that the nobody user should have write access
+   to at least the sqlite database at the root of the repository.
+
+3. On the client machine you need to set the following variables.
+   CVSROOT should be set as per normal, but the directory should point at the
+   appropriate git repo. For example:
+
+   For SSH access, CVS_SERVER should be set to git-cvsserver
+
+   Example:
+
+     export CVSROOT=:ext:user@server:/var/git/project.git
+     export CVS_SERVER=git-cvsserver
+
+4. For SSH clients that will make commits, make sure their .bashrc file
+   sets the GIT_AUTHOR and GIT_COMMITTER variables.
+
+5. Clients should now be able to check out the project. Use the CVS 'module'
+   name to indicate what GIT 'head' you want to check out. Example:
 
-5. On each client machine you need to set the following variables.
-     CVSROOT should be set as per normal, but the directory should point at the
-             appropriate git repo.
-     CVS_SERVER should be set to the server.pl script that has been put on the
-                remote machine.
-
-6. Clients should now be able to check out modules (where modules are the names
-   of branches in git).
-     $ cvs co -d mylocaldir master
+     cvs co -d project-master master
 
 Eclipse CVS Client Notes
 ------------------------
 
 To get a checkout with the Eclipse CVS client:
 
-1. Create a new project from CVS checkout, giving it repository and module
-2. Context Menu->Team->Share Project...
-3. Enter the repository and module information again and click Finish
-4. The Synchronize view appears. Untick  "launch commit wizard" to avoid
-committing the .project file, and select HEAD as the tag to synchronize to.
-Update all incoming changes.
-
-Note that most versions of Eclipse ignore CVS_SERVER (which you can set in
-the Preferences->Team->CVS->ExtConnection pane), so you may have to
-rename, alias or symlink git-cvsserver to 'cvs' on the server.
+1. Select "Create a new project -> From CVS checkout"
+2. Create a new location. See the notes below for details on how to choose the
+   right protocol.
+3. Browse the 'modules' available. It will give you a list of the heads in
+   the repository. You will not be able to browse the tree from there. Only
+   the heads.
+4. Pick 'HEAD' when it asks what branch/tag to check out. Untick the
+   "launch commit wizard" to avoid committing the .project file.
+
+Protocol notes: If you are using anonymous acces via pserver, just select that.
+Those using SSH access should choose the 'ext' protocol, and configure 'ext'
+access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
+'git-cvsserver'. Not that password support is not good when using 'ext',
+you will definitely want to have SSH keys setup.
+
+Alternatively, you can just use the non-standard extssh protocol that Eclipse
+offer. In that case CVS_SERVER is ignored, and you will have to replace
+the cvs utility on the server with git-cvsserver or manipulate your .bashrc
+so that calling 'cvs' effectively calls git-cvsserver.
 
 Clients known to work
 ---------------------
@@ -106,7 +141,7 @@ Authors: Martyn Smith    <martyn@catalys
 
 Documentation
 --------------
-Documentation by Martyn Smith <martyn@catalyst.net.nz> and Martin Langhoff <martin@catalyst.net.nz>Matthias Urlichs <smurf@smurf.noris.de>.
+Documentation by Martyn Smith <martyn@catalyst.net.nz> and Martin Langhoff <martin@catalyst.net.nz> Matthias Urlichs <smurf@smurf.noris.de>.
 
 GIT
 ---
-- 
1.2.4.g0a60
