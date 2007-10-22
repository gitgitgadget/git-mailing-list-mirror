From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] "current_exec_path" is a misleading name, use "argv_exec_path"
Date: Mon, 22 Oct 2007 17:01:08 +0000
Message-ID: <20071022170108.GA29642@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 19:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik0kz-0006x4-KJ
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 19:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbXJVRHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXJVRHu
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 13:07:50 -0400
Received: from [207.210.74.68] ([207.210.74.68]:44416 "EHLO srparish.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbXJVRHt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 13:07:49 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2007 13:07:49 EDT
Received: (qmail 29719 invoked by alias); 22 Oct 2007 17:01:08 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62026>

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
index e1c99e3..f659338 100644
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
gitgui.0.8.4.11176.gd9205-dirty
