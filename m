From: skimo@liacs.nl
Subject: [PATCH 1/3] run-command: optionally clear git environment
Date: Fri, 25 May 2007 23:07:11 +0200
Message-ID: <1180127233729-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 23:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrh0i-0008Ps-9k
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbXEYVHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbXEYVHg
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:07:36 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60870 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169AbXEYVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:07:34 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4PL7DHD031051;
	Fri, 25 May 2007 23:07:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 295E13C009; Fri, 25 May 2007 23:07:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48415>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 run-command.c |    6 ++++++
 run-command.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 7e779d3..5c47f45 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,6 +2,10 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
+static const char* git_env_list[] = { ALTERNATE_DB_ENVIRONMENT, DB_ENVIRONMENT,
+			CONFIG_ENVIRONMENT, GIT_DIR_ENVIRONMENT,
+			GRAFT_ENVIRONMENT, INDEX_ENVIRONMENT, NULL };
+
 static inline void close_pair(int fd[2])
 {
 	close(fd[0]);
@@ -153,6 +157,8 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
+	if (opt & RUN_COMMAND_CLEAR_GIT_ENV)
+		cmd->env = git_env_list;
 }
 
 int run_command_v_opt(const char **argv, int opt)
diff --git a/run-command.h b/run-command.h
index 7958eb1..a5374cc 100644
--- a/run-command.h
+++ b/run-command.h
@@ -33,6 +33,7 @@ int run_command(struct child_process *);
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
+#define RUN_COMMAND_CLEAR_GIT_ENV	(1 << 3)
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
 
-- 
1.5.2.838.gbeec
