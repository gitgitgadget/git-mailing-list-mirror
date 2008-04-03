From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Update setup-git-server-over-http.txt based on my experience.
Date: Thu,  3 Apr 2008 18:58:22 +0200
Message-ID: <1207241902-4667-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 03 19:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhSnQ-0005Sh-Sh
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 19:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYDCQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYDCQ7W
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 12:59:22 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:60230 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbYDCQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 12:59:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m33GwMjg024678;
	Thu, 3 Apr 2008 18:58:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JhSla-0007Fc-Dq; Thu, 03 Apr 2008 18:58:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JhSla-0001De-Bc; Thu, 03 Apr 2008 18:58:22 +0200
X-Mailer: git-send-email 1.5.5.rc0.25.g9d90.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 03 Apr 2008 18:58:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78763>

I managed to set up a Git repository on a preconfigured WebDAV server,
without installing Git on it or changing the configuration. This patch
reflects this (it previously stated that Git was _necessary_ on the
server, which isn't true). Also give a few hints to troubleshoting.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/howto/setup-git-server-over-http.txt |   36 +++++++++++++++----
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index 8eadc20..34d377a 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -40,9 +40,10 @@ What's needed:
 
 - have permissions to chown a directory
 
-- have git installed at the server _and_ client
+- have git installed on the client, and preferably on the server
 
-In effect, this probably means you're going to be root.
+In effect, this probably means you're going to be root, or that you're
+using a preconfigured WebDAV server.
 
 
 Step 1: setup a bare GIT repository
@@ -50,9 +51,9 @@ Step 1: setup a bare GIT repository
 
 At the time of writing, git-http-push cannot remotely create a GIT
 repository. So we have to do that at the server side with git. Another
-option would be to generate an empty repository at the client and copy
-it to the server with WebDAV. But then you're probably the first to
-try that out :)
+option is to generate an empty repository at the client and copy it to
+the server with a WebDAV client (which is the only option if Git is
+not installed on the server).
 
 Create the directory under the DocumentRoot of the directories served
 by Apache. As an example we take /usr/local/apache2, but try "grep
@@ -169,7 +170,8 @@ On Debian:
 
    Most tests should pass.
 
-A command line tool to test WebDAV is cadaver.
+A command line tool to test WebDAV is cadaver. If you prefer GUIs,
+konqueror can open WebDAV URLs as "webdav://..." or "webdavs://...".
 
 If you're into Windows, from XP onwards Internet Explorer supports
 WebDAV. For this, do Internet Explorer -> Open Location ->
@@ -179,8 +181,10 @@ http://<servername>/my-new-repo.git [x] Open as webfolder -> login .
 Step 3: setup the client
 ------------------------
 
-Make sure that you have HTTP support, i.e. your git was built with curl.
-The easiest way to check is to look for the executable 'git-http-push'.
+Make sure that you have HTTP support, i.e. your git was built with
+curl (and a recent enough version). The easiest way to check is to
+look for the executable 'git-http-push'. The command "git http-push"
+with no argument should display a usage message.
 
 Then, add the following to your $HOME/.netrc (you can do without, but will be
 asked to input your password a _lot_ of times):
@@ -212,6 +216,10 @@ It is important to put the last '/'; Without it, the server will send
 a redirect which git-http-push does not (yet) understand, and git-http-push
 will repeat the request infinitely.
 
+Also note that the URL should point to the git repository itself, that
+is, to the '.git/' directory and not the working tree in case the
+repository is non-bare.
+
 
 Step 4: make the initial push
 -----------------------------
@@ -224,6 +232,13 @@ This pushes branch 'master' (which is assumed to be the branch you
 want to export) to repository called 'upload', which we previously
 defined with git-config.
 
+Using a proxy:
+--------------
+
+If you have to access the WebDAV server from behind an HTTP(S) proxy,
+set the variable 'all_proxy' to 'http://proxy-host.com:port', or
+'http://login-on-proxy:passwd-on-proxy@proxy-host.com:port'. See 'man
+curl' for details.
 
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
