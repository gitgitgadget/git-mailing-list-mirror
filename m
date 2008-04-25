From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] documentation: help: add info about "man.<tool>.cmd"
 config var
Date: Fri, 25 Apr 2008 08:25:35 +0200
Message-ID: <20080425082535.17288c31.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Apr 25 08:21:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpHJ4-0001Ja-Jj
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 08:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbYDYGU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 02:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYDYGU2
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 02:20:28 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51547 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755386AbYDYGU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 02:20:27 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 704931AB2E6;
	Fri, 25 Apr 2008 08:20:26 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 1D53D1AB2C1;
	Fri, 25 Apr 2008 08:20:26 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80325>

This patch also describes the current behavior for "konqueror" and
how to modify it using "man.<tool>.cmd" if needed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt   |    5 ++++
 Documentation/git-help.txt |   48 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c1c72e7..411e367 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -773,6 +773,11 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
 
+man.<tool>.cmd::
+	Specify the command to invoke the specified man viewer. The
+	specified command is evaluated in shell with the man page
+	passed as argument. (See linkgit:git-help[1].)
+
 man.<tool>.path::
 	Override the path for the given tool that may be used to
 	display help in the 'man' format. See linkgit:git-help[1].
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 4c6cb21..bfbba9e 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -82,22 +82,28 @@ man.viewer
 ~~~~~~~~~~
 
 The 'man.viewer' config variable will be checked if the 'man' format
-is chosen. Only the following values are currently supported:
+is chosen. The following values are currently supported:
 
 * "man": use the 'man' program as usual,
 * "woman": use 'emacsclient' to launch the "woman" mode in emacs
 (this only works starting with emacsclient versions 22),
-* "konqueror": use a man KIO slave in konqueror.
+* "konqueror": use 'kfmclient' to open the man page in a new konqueror
+tab (see 'Note about konqueror' below).
 
-Multiple values may be given to this configuration variable. Their
-corresponding programs will be tried in the order listed in the
-configuration file.
+Values for other tools can be used if there is a corresponding
+'man.<tool>.cmd' configuration entry (see below).
+
+Multiple values may be given to the 'man.viewer' configuration
+variable. Their corresponding programs will be tried in the order
+listed in the configuration file.
 
 For example, this configuration:
 
+------------------------------------------------
 	[man]
 		viewer = konqueror
 		viewer = woman
+------------------------------------------------
 
 will try to use konqueror first. But this may fail (for example if
 DISPLAY is not set) and in that case emacs' woman mode will be tried.
@@ -113,6 +119,38 @@ can configure the absolute path to konqueror by setting
 'man.konqueror.path'. Otherwise, 'git help' assumes the tool is
 available in PATH.
 
+man.<tool>.cmd
+~~~~~~~~~~~~~~
+
+When the man viewer, specified by the 'man.viewer' configuration
+variables, is not among the supported ones, then the corresponding
+'man.<tool>.cmd' configuration variable will be looked up. If this
+variable exists then the specified tool will be treated as a custom
+command and a shell eval will be used to run the command with the man
+page passed as arguments.
+
+Note about konqueror
+~~~~~~~~~~~~~~~~~~~~
+
+When 'konqueror' is specified in the 'man.viewer' configuration
+variable, we launch 'kfmclient' to try to open the man page on an
+already opened konqueror in a new tab if possible.
+
+For consistency, we also try such a trick if 'man.konqueror.path' is
+set to something like 'A_PATH_TO/konqueror'. That means we will try to
+launch 'A_PATH_TO/kfmclient' instead.
+
+If you really want to use 'konqueror', then you can use something like
+the following:
+
+------------------------------------------------
+	[man]
+		viewer = konq
+
+	[man "konq"]
+		cmd = A_PATH_TO/konqueror
+------------------------------------------------
+
 Note about git config --global
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.5.5.130.g3ab1e.dirty
