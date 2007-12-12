From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] git-help: add "web_or_man" and "web_or_info" config
 vars.
Date: Wed, 12 Dec 2007 06:33:25 +0100
Message-ID: <20071212063325.92cd29a8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2K8C-0007VQ-Lw
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 06:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbXLLF1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 00:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXLLF1H
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 00:27:07 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49201 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbXLLF1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 00:27:06 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9A6281AB2BD;
	Wed, 12 Dec 2007 06:27:04 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 6453F1AB2B7;
	Wed, 12 Dec 2007 06:27:04 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67996>

These configuration variables can be used when you want to
use a web browser if DISPLAY is set and "man" or "info"
otherwise.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-help.txt |   15 +++++++++++----
 help.c                     |   10 ++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index af5e5cb..c790584 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -24,10 +24,17 @@ up. The 'man' program is used by default for this purpose, but this
 can be overriden by other options.
 
 If no command line option is passed, the 'help.format' configuration
-variable will be checked. Supported values for this variable are
-"man", "info" and "web" (or "html" as a synonym to the latter). This
-makes git-help behave as if a command line option with the same long
-name as been passed to it.
+variable will be checked. The following values are supported for this
+variable; they make 'git-help' behave as their corresponding command
+line option:
+
+* "man" corresponds to '-m|--man',
+* "info" corresponds to '-i|--info',
+* "web" or "html" correspond to '-w|--web',
+* "web_or_man" corresponds to '-w|--web' if DISPLAY is set, '-m|--man'
+otherwise,
+* "web_or_info" corresponds to '-w|--web' if DISPLAY is set, '-i|--info'
+otherwise.
 
 Note that 'git --help ...' is identical as 'git help ...' because the
 former is internally converted into the latter.
diff --git a/help.c b/help.c
index af0a433..d46bc08 100644
--- a/help.c
+++ b/help.c
@@ -34,6 +34,16 @@ static void parse_help_format(const char *format)
 		help_format = web_format;
 		return;
 	}
+	if (!strcmp(format, "web_or_man")) {
+		char *display = getenv("DISPLAY");
+		help_format = display ? web_format : man_format;
+		return;
+	}
+	if (!strcmp(format, "web_or_info")) {
+		char *display = getenv("DISPLAY");
+		help_format = display ? web_format : info_format;
+		return;
+	}
 	die("unrecognized help format '%s'", format);
 }
 
-- 
1.5.3.7.2269.g4ae7
