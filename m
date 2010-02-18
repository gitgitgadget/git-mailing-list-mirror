From: Patrick Sudowe <patrick.sudowe@rwth-aachen.de>
Subject: [PATCH] show help message also for aliased commands
Date: Thu, 18 Feb 2010 02:29:22 +0100
Message-ID: <1266456562-88841-1-git-send-email-patrick.sudowe@rwth-aachen.de>
Cc: Patrick Sudowe <patrick.sudowe@rwth-aachen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 02:40:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhvNG-0006qh-Fl
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 02:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310Ab0BRBkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 20:40:05 -0500
Received: from vacuity.ath.cx ([85.10.202.48]:48288 "EHLO vacuity.ath.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab0BRBkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 20:40:03 -0500
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2010 20:40:03 EST
Received: from localhost.localdomain (f050095069.adsl.alicedsl.de [78.50.95.69])
	by vacuity.ath.cx (Postfix) with ESMTPSA id E4239AD408E;
	Thu, 18 Feb 2010 02:29:32 +0100 (CET)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140281>

git help 'alias' currently only shows the actual git command
'alias' refers to. This patch changes the behavior so that
the help for the actual git command is shown. The user usually
knows the aliases defined, and sometimes its just more convenient
to type something like git help co than git help checkout
to find out about some rarely used option.
The original message is still there, so users do not face
unexpected or surprising behavior.
---
 builtin-help.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 3182a2b..4d8906d 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -416,6 +416,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
 	const char *alias;
+	const char *cmd;
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
 
@@ -446,19 +447,22 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
 		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
-		return 0;
+		cmd = alias;
+	} else {
+		cmd = argv[0];
 	}
 
+
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
-		show_man_page(argv[0]);
+		show_man_page(cmd);
 		break;
 	case HELP_FORMAT_INFO:
-		show_info_page(argv[0]);
+		show_info_page(cmd);
 		break;
 	case HELP_FORMAT_WEB:
-		show_html_page(argv[0]);
+		show_html_page(cmd);
 		break;
 	}
 
-- 
1.7.0
