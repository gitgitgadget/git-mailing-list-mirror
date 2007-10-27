From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 1/7] "git" returns 1; "git help" and "git help -a" return 0
Date: Sat, 27 Oct 2007 01:36:49 -0700
Message-ID: <1193474215-6728-1-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:37:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhAU-00083R-0X
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbXJ0IhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbXJ0IhA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:37:00 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:45253 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXJ0Ig7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:36:59 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1IlhA9-00056U-Qm; Sat, 27 Oct 2007 03:36:57 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 265DA4F21C8; Sat, 27 Oct 2007 01:36:55 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11179.g60ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62472>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 builtin.h |    1 +
 git.c     |    7 ++++---
 help.c    |    6 +++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin.h b/builtin.h
index 65cc0fb..9a6213a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -6,6 +6,7 @@
 extern const char git_version_string[];
 extern const char git_usage_string[];
 
+extern void list_common_cmds_help(void);
 extern void help_unknown_cmd(const char *cmd);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);
diff --git a/git.c b/git.c
index 23a430c..efed91c 100644
--- a/git.c
+++ b/git.c
@@ -450,9 +450,10 @@ int main(int argc, const char **argv)
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
 	} else {
-		/* Default command: "help" */
-		argv[0] = "help";
-		argc = 1;
+		/* The user didn't specify a command; give them help */
+		printf("usage: %s\n\n", git_usage_string);
+		list_common_cmds_help();
+		exit(1);
 	}
 	cmd = argv[0];
 
diff --git a/help.c b/help.c
index 1cd33ec..d4b1818 100644
--- a/help.c
+++ b/help.c
@@ -147,7 +147,7 @@ static void list_commands(const char *exec_path, const char *pattern)
 	putchar('\n');
 }
 
-static void list_common_cmds_help(void)
+void list_common_cmds_help(void)
 {
 	int i, longest = 0;
 
@@ -204,14 +204,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
-		exit(1);
+		exit(0);
 	}
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
 			list_commands(exec_path, "git-*");
-		exit(1);
+		exit(0);
 	}
 
 	else
-- 
gitgui.0.8.4.11178.g9a1bf-dirty
