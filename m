From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 3/7] "current_exec_path" is a misleading name, use "argv_exec_path"
Date: Sat, 27 Oct 2007 01:36:51 -0700
Message-ID: <1193474215-6728-3-git-send-email-srp@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
 <1193474215-6728-2-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:37:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhAU-00083R-MS
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbXJ0IhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXJ0IhE
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:37:04 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:45256 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbXJ0Ig7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:36:59 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1IlhA9-00056V-Qm; Sat, 27 Oct 2007 03:36:57 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 7A67E4F21CC; Sat, 27 Oct 2007 01:36:55 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11179.g60ba
In-Reply-To: <1193474215-6728-2-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62473>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 exec_cmd.c |   12 ++++++------
 exec_cmd.h |    2 +-
 git.c      |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..8b681d0 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -5,11 +5,11 @@
 
 extern char **environ;
 static const char *builtin_exec_path = GIT_EXEC_PATH;
-static const char *current_exec_path;
+static const char *argv_exec_path = 0;
 
-void git_set_exec_path(const char *exec_path)
+void git_set_argv_exec_path(const char *exec_path)
 {
-	current_exec_path = exec_path;
+	argv_exec_path = exec_path;
 }
 
 
@@ -18,8 +18,8 @@ const char *git_exec_path(void)
 {
 	const char *env;
 
-	if (current_exec_path)
-		return current_exec_path;
+	if (argv_exec_path)
+		return argv_exec_path;
 
 	env = getenv(EXEC_PATH_ENVIRONMENT);
 	if (env && *env) {
@@ -34,7 +34,7 @@ int execv_git_cmd(const char **argv)
 {
 	char git_command[PATH_MAX + 1];
 	int i;
-	const char *paths[] = { current_exec_path,
+	const char *paths[] = { argv_exec_path,
 				getenv(EXEC_PATH_ENVIRONMENT),
 				builtin_exec_path };
 
diff --git a/exec_cmd.h b/exec_cmd.h
index 849a839..da99287 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -1,7 +1,7 @@
 #ifndef GIT_EXEC_CMD_H
 #define GIT_EXEC_CMD_H
 
-extern void git_set_exec_path(const char *exec_path);
+extern void git_set_argv_exec_path(const char *exec_path);
 extern const char* git_exec_path(void);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
diff --git a/git.c b/git.c
index efed91c..c7cabf5 100644
--- a/git.c
+++ b/git.c
@@ -51,7 +51,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 		if (!prefixcmp(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
-				git_set_exec_path(cmd + 1);
+				git_set_argv_exec_path(cmd + 1);
 			else {
 				puts(git_exec_path());
 				exit(0);
-- 
gitgui.0.8.4.11178.g9a1bf-dirty
