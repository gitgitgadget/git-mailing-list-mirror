From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 09/10] Revert "adapt git-cvsserver manpage to dash-free syntax"
Date: Sat, 24 Jan 2009 16:43:20 -0700
Message-ID: <1232840601-24696-10-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBe-0006Ei-54
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbZAXXnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbZAXXns
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:48 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:54901 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753450AbZAXXnc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:32 -0500
Received: from OMTA03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id 7SZs1b0080b6N64A9bjYjh; Sat, 24 Jan 2009 23:43:32 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA03.emeryville.ca.mail.comcast.net with comcast
	id 7bjW1b00M1TYyYj8PbjYTK; Sat, 24 Jan 2009 23:43:32 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id C7EB08911D;
	Sat, 24 Jan 2009 16:43:25 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107025>

This reverts commit da9973c6f9600d90e64aac647f3ed22dfd692f70,
and a couple of other remaining references to "git cvsserver".

When da9973c6f9600 was committed, we did not install git-cvsserver
in $(bindir) by default, but that situation did not last long (see
1df2a1ce806 "Install git-cvsserver in $(bindir)").  Also, a recent
commit (cvsserver: use dashless "git command"s to access plumbing)
fixed an issue with git-cvsserver trying to run dashed forms
without setting up the PATH for it.

The dashed form is arguably better in this case, since it is
required for cvs's ":fork:" connection method (although ":ext:"
usually doesn't need dashes), and it can minimize the need to escape
characters when setting up CVS_SERVER and/or CVSROOT.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

Note: It might conceivably be worth holding off on this patch for a
release, in case someone tries to use a newer man page from the web with
an older install of git, where git-cvsserver still has the PATH bug
mentioned in the commit message above.  But I doubt this is really
common enough to worry about.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 Documentation/git-cvsserver.txt |   10 +++++-----
 git-cvsserver.perl              |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index e32ad7b..6f8cd88 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 SSH:
 
 [verse]
-export CVS_SERVER="git cvsserver"
+export CVS_SERVER=git-cvsserver
 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
 
 pserver (/etc/inetd.conf):
@@ -22,7 +22,7 @@ cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserver pserver
 Usage:
 
 [verse]
-'git cvsserver' [options] [pserver|server] [<directory> ...]
+'git-cvsserver' [options] [pserver|server] [<directory> ...]
 
 OPTIONS
 -------
@@ -109,7 +109,7 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
 
 ------
-cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
+cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
@@ -161,7 +161,7 @@ allowing access over SSH.
 --
 ------
      export CVSROOT=:ext:user@server:/var/git/project.git
-     export CVS_SERVER="git cvsserver"
+     export CVS_SERVER=git-cvsserver
 ------
 --
 4. For SSH clients that will make commits, make sure their server-side
@@ -286,7 +286,7 @@ To get a checkout with the Eclipse CVS client:
 Protocol notes: If you are using anonymous access via pserver, just select that.
 Those using SSH access should choose the 'ext' protocol, and configure 'ext'
 access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
-"'git cvsserver'". Note that password support is not good when using 'ext',
+'git-cvsserver'. Note that password support is not good when using 'ext',
 you will definitely want to have SSH keys setup.
 
 Alternatively, you can just use the non-standard extssh protocol that Eclipse
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 8e9e659..4b817ce 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -100,7 +100,7 @@ my $work =
 $log->info("--------------- STARTING -----------------");
 
 my $usage =
-    "Usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
+    "Usage: git-cvsserver [options] [pserver|server] [<directory> ...]\n".
     "    --base-path <path>  : Prepend to requested CVSROOT\n".
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
     "    --export-all        : Don't check for gitcvs.enabled in config\n".
-- 
1.6.1.81.g9833d.dirty
