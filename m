From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document that WebDAV doesn't need git on the server, and works over SSL
Date: Sun, 13 Apr 2008 15:38:21 +0200
Message-ID: <1208093901-19949-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 13 15:41:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl2SR-0006J6-O5
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 15:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905AbYDMNki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756880AbYDMNki
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 09:40:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:63871 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756835AbYDMNki (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 09:40:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m3DDdwFQ026557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 13 Apr 2008 15:39:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Jl2PV-0004KP-Dv; Sun, 13 Apr 2008 15:38:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Jl2PV-0005C5-BV; Sun, 13 Apr 2008 15:38:21 +0200
X-Mailer: git-send-email 1.5.5.rc0.25.g9d90.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 13 Apr 2008 15:40:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79407>

I managed to set up a Git repository on a preconfigured WebDAV server,
and using HTTPS, without installing Git on it or changing the server
configuration. This works through a proxy too. This patch reflects
this (it previously stated that Git was _necessary_ on the server,
which isn't true). Also give a few hints to troubleshoting.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/howto/setup-git-server-over-http.txt |   46 ++++++++++++++------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 8eadc20..a8da347 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -1,5 +1,5 @@
 From: Rutger Nijlunsing <rutger@nospam.com>
-Subject: Setting up a git repository which can be pushed into and pulled from over HTTP.
+Subject: Setting up a git repository which can be pushed into and pulled from over HTTP(S).
 Date: Thu, 10 Aug 2006 22:00:26 +0200
 
 Since Apache is one of those packages people like to compile
@@ -40,9 +40,13 @@ What's needed:
 
 - have permissions to chown a directory
 
-- have git installed at the server _and_ client
+- have git installed on the client, and
 
-In effect, this probably means you're going to be root.
+- either have git installed on the server or have a webdav client on
+  the client.
+
+In effect, this means you're going to be root, or that you're using a
+preconfigured WebDAV server.
 
 
 Step 1: setup a bare GIT repository
@@ -50,9 +54,9 @@ Step 1: setup a bare GIT repository
 
 At the time of writing, git-http-push cannot remotely create a GIT
 repository. So we have to do that at the server side with git. Another
-option would be to generate an empty repository at the client and copy
-it to the server with WebDAV. But then you're probably the first to
-try that out :)
+option is to generate an empty bare repository at the client and copy
+it to the server with a WebDAV client (which is the only option if Git
+is not installed on the server).
 
 Create the directory under the DocumentRoot of the directories served
 by Apache. As an example we take /usr/local/apache2, but try "grep
@@ -169,7 +173,9 @@ On Debian:
 
    Most tests should pass.
 
-A command line tool to test WebDAV is cadaver.
+A command line tool to test WebDAV is cadaver. If you prefer GUIs, for
+example, konqueror can open WebDAV URLs as "webdav://..." or
+"webdavs://...".
 
 If you're into Windows, from XP onwards Internet Explorer supports
 WebDAV. For this, do Internet Explorer -> Open Location ->
@@ -179,8 +185,9 @@ http://<servername>/my-new-repo.git [x] Open as webfolder -> login .
 Step 3: setup the client
 ------------------------
 
-Make sure that you have HTTP support, i.e. your git was built with curl.
-The easiest way to check is to look for the executable 'git-http-push'.
+Make sure that you have HTTP support, i.e. your git was built with
+curl (version more recent than 7.10). The command 'git http-push' with
+no argument should display a usage message.
 
 Then, add the following to your $HOME/.netrc (you can do without, but will be
 asked to input your password a _lot_ of times):
@@ -197,10 +204,10 @@ instead of the server name.
 
 To check whether all is OK, do:
 
-   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/
-
-...this should give a directory listing in HTML of /var/www/my-new-repo.git .
+   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/HEAD
 
+...this should give something like 'ref: refs/heads/master', which is
+the content of the file HEAD on the server.
 
 Now, add the remote in your existing repository which contains the project
 you want to export:
@@ -212,7 +219,6 @@ It is important to put the last '/'; Without it, the server will send
 a redirect which git-http-push does not (yet) understand, and git-http-push
 will repeat the request infinitely.
 
-
 Step 4: make the initial push
 -----------------------------
 
@@ -225,6 +231,15 @@ want to export) to repository called 'upload', which we previously
 defined with git-config.
 
 
+Using a proxy:
+--------------
+
+If you have to access the WebDAV server from behind an HTTP(S) proxy,
+set the variable 'all_proxy' to 'http://proxy-host.com:port', or
+'http://login-on-proxy:passwd-on-proxy@proxy-host.com:port'. See 'man
+curl' for details.
+
+
 Troubleshooting:
 ----------------
 
@@ -248,9 +263,14 @@ Reading /usr/local/apache2/logs/error_log is often helpful.
 
   On Debian: Read /var/log/apache2/error.log instead.
 
+If you access HTTPS locations, git may fail verifying the SSL
+certificate (this is return code 60). Setting http.sslVerify=false can
+help diagnosing the problem, but removes security checks.
+
 
 Debian References: http://www.debian-administration.org/articles/285
 
 Authors
   Johannes Schindelin <Johannes.Schindelin@gmx.de>
   Rutger Nijlunsing <git@wingding.demon.nl>
+  Matthieu Moy <Matthieu.Moy@imag.fr>
-- 
1.5.5.rc0.25.g9d90.dirty
