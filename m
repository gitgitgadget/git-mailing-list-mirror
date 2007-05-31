From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] git-config: Improve documentation of git-config file handling
Date: Thu, 31 May 2007 02:35:37 +0200
Message-ID: <11805717372750-git-send-email-frank@lichtenheld.de>
References: <11805717372779-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 02:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtYdn-00058Q-2f
	for gcvg-git@gmane.org; Thu, 31 May 2007 02:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbXEaAfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 20:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbXEaAfj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 20:35:39 -0400
Received: from v32413.1blu.de ([88.84.155.73]:50437 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbXEaAfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 20:35:37 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HtYdb-0006kl-Ph; Thu, 31 May 2007 02:35:36 +0200
Received: from p54b0d6da.dip.t-dialin.net ([84.176.214.218] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HtYdY-0002mf-0u; Thu, 31 May 2007 02:35:32 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HtYdd-0006II-OC; Thu, 31 May 2007 02:35:37 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <11805717372779-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48794>

The description which files git-config uses and how the various
command line options and environment variables affect its
behaviour was incomplete, outdated and confusing. Try to fix that.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-config.txt |   66 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 8f4149f..bd2fff7 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -75,11 +75,22 @@ OPTIONS
 	Like --get-all, but interprets the name as a regular expression.
 
 --global::
-	Use global ~/.gitconfig file rather than the repository .git/config.
+	For writing options: Write to global ~/.gitconfig file rather than
+	the repository .git/config.
++
+For reading options: Read only from global ~/.gitconfig rather than
+from all available files.
++
+See also <<FILES>>.
 
 --system::
-	Use system-wide $(prefix)/etc/gitconfig rather than the repository
-	.git/config.
+	For writing options: Write to system-wide $(prefix)/etc/gitconfig
+	rather than the repository .git/config.
++
+For reading options: Read only from system-wide $(prefix)/etc/gitconfig
+rather than from all available files.
++
+See also <<FILES>>.
 
 --remove-section::
 	Remove the given section from the configuration file.
@@ -106,18 +117,59 @@ OPTIONS
 	by 1024, 1048576, or 1073741824 prior to output.
 
 
+[[FILES]]
+FILES
+-----
+
+There are three files where git-config will search for configuration
+options:
+
+.git/config::
+	Repository specific configuration file. (The filename is
+	of course relative to the repository root, not the working
+	directory.)
+
+~/.gitconfig::
+	User-specific configuration file. Also called "global"
+	configuration file.
+
+$(prefix)/etc/gitconfig::
+	System-wide configuration file.
+
+If no further options are given, all reading options will read all of these
+files that are available. If the global or the system-wide configuration
+file are not available they will be ignored. If the repository configuration
+file is not available or readable, git-config will exit with a non-zero
+error code. However, in neither case will an error message be issued.
+
+All writing options will per default write to the repository specific
+configuration file. Note that this also affects options like '--replace-all'
+and '--unset'. *git-config will only ever change one file at a time*.
+
+You can overwrite these rules either by command line options or by environment
+variables. The '--global' and the '--system' options will limit the file used
+to the global or system-wide file respectively. The GIT_CONFIG environment
+variable has a similar effect, but you can specify any filename you want.
+
+The GIT_CONFIG_LOCAL environment variable on the other hand only changes
+the name used instead of the repository configuration file. The global and
+the system-wide configuration files will still be read. (For writing options
+this will obviously result in the same behavior as using GIT_CONFIG.)
+
+
 ENVIRONMENT
 -----------
 
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
-	Using the "--global" option forces this to ~/.gitconfig.
+	Using the "--global" option forces this to ~/.gitconfig. Using the
+	"--system" option forces this to $(prefix)/etc/gitconfig.
 
 GIT_CONFIG_LOCAL::
-	Currently the same as $GIT_CONFIG; when Git will support global
-	configuration files, this will cause it to take the configuration
-	from the global configuration file in addition to the given file.
+	Take the configuration from the given file instead if .git/config.
+	Still read the global and the system-wide configuration files, though.
 
+See also <<FILES>>.
 
 
 [[EXAMPLES]]
-- 
1.5.2-rc3.GIT
