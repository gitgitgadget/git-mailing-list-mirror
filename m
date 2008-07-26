From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/7] builtin-help: make list_commands() a bit more generic
Date: Sat, 26 Jul 2008 13:54:47 +0200
Message-ID: <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
 <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
 <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiNB-0002Vg-AH
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbYGZLyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYGZLya
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:30 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54447 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYGZLyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:25 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id 5A94E1DDC5F
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A6C4F1AB592; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90212>

That function now takes two paramters to control the prefix of the
listed commands, and a second parameter to specify the title of the
table. This can be useful for listing not only all git commands, but
specific ones, like merge strategies.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 help.c |   10 +++++-----
 help.h |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/help.c b/help.c
index d71937e..f71fff4 100644
--- a/help.c
+++ b/help.c
@@ -501,13 +501,13 @@ static unsigned int load_command_list(const char *prefix)
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
+		printf("available %s in '%s'\n", title, exec_path);
 		printf("----------------------------");
 		mput_char('-', strlen(exec_path));
 		putchar('\n');
@@ -516,7 +516,7 @@ static void list_commands(void)
 	}
 
 	if (other_cmds.cnt) {
-		printf("git commands available from elsewhere on your $PATH\n");
+		printf("%s available from elsewhere on your $PATH\n", title);
 		printf("---------------------------------------------------\n");
 		pretty_print_string_list(&other_cmds, longest);
 		putchar('\n');
@@ -697,7 +697,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
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
