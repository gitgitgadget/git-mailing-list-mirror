From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/5] builtin-help: make list_commands() a bit more generic
Date: Tue, 29 Jul 2008 17:25:00 +0200
Message-ID: <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217344803.git.vmiklos@frugalware.org>
References: <cover.1217344802.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217344803.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 17:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNr5L-0001WP-BH
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 17:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbYG2PYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753596AbYG2PYo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 11:24:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46522 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbYG2PYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 11:24:37 -0400
Received: from vmobile.example.net (dsl5400FA31.pool.t-online.hu [84.0.250.49])
	by yugo.frugalware.org (Postfix) with ESMTP id CB8E51DDC5D;
	Tue, 29 Jul 2008 17:24:34 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 66D9E1AB590; Tue, 29 Jul 2008 17:25:04 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <fd19583955e9cea5b78a465d23bc127a51940048.1217344803.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217344802.git.vmiklos@frugalware.org>
References: <cover.1217344802.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90647>

That function now takes two paramters to control the prefix of the
listed commands, and a second parameter to specify the title of the
table. This can be useful for listing not only all git commands, but
specific ones, like merge strategies.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 help.c |   18 ++++++++++--------
 help.h |    1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/help.c b/help.c
index 08188f5..7a42517 100644
--- a/help.c
+++ b/help.c
@@ -506,23 +506,25 @@ static unsigned int load_command_list(const char *prefix)
 	return longest;
 }
 
-static void list_commands(void)
+void list_commands(const char *prefix, const char *title)
 {
-	unsigned int longest = load_command_list(NULL);
+	unsigned int longest = load_command_list(prefix);
 	const char *exec_path = git_exec_path();
 
 	if (main_cmds.cnt) {
-		printf("available git commands in '%s'\n", exec_path);
-		printf("----------------------------");
-		mput_char('-', strlen(exec_path));
+		printf("available %s in '%s'\n", title, exec_path);
+		printf("----------------");
+		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
 		pretty_print_string_list(&main_cmds, longest);
 		putchar('\n');
 	}
 
 	if (other_cmds.cnt) {
-		printf("git commands available from elsewhere on your $PATH\n");
-		printf("---------------------------------------------------\n");
+		printf("%s available from elsewhere on your $PATH\n", title);
+		printf("---------------------------------------");
+		mput_char('-', strlen(title));
+		putchar('\n');
 		pretty_print_string_list(&other_cmds, longest);
 		putchar('\n');
 	}
@@ -702,7 +704,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands();
+		list_commands("git-", "git commands");
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.h b/help.h
index 73da8d6..0741662 100644
--- a/help.h
+++ b/help.h
@@ -2,5 +2,6 @@
 #define HELP_H
 
 int is_git_command(const char *s, const char *prefix);
+void list_commands(const char *prefix, const char *title);
 
 #endif /* HELP_H */
-- 
1.6.0.rc0.14.g95f8.dirty
