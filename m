From: skimo@liacs.nl
Subject: [PATCH 15/22] make redirecting stdout to /dev/null available via run_command_v_opt
Date: Thu, 24 May 2007 00:23:04 +0200
Message-ID: <1179958992141-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFn-0003VS-CC
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873AbXEWWXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757564AbXEWWXr
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:47 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33757 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755709AbXEWWXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:38 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNLGn011600;
	Thu, 24 May 2007 00:23:26 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 00B277DDAD; Thu, 24 May 2007 00:23:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48199>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 run-command.c |    1 +
 run-command.h |    9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 806af46..d5b8ba2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -150,6 +150,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->argv = argv;
 	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
+	cmd->no_stdout = opt & RUN_COMMAND_NO_STDOUT ? 1 : 0;
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
 	cmd->clear_git_env = opt & RUN_COMMAND_CLEAR_GIT_ENV ? 1 : 0;
diff --git a/run-command.h b/run-command.h
index 7724118..e3e897a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -30,10 +30,11 @@ int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
-#define RUN_COMMAND_NO_STDIN 1
-#define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
-#define RUN_COMMAND_STDOUT_TO_STDERR 4
-#define RUN_COMMAND_CLEAR_GIT_ENV	(1 << 3)
+#define RUN_COMMAND_NO_STDIN 		(1 << 0)
+#define RUN_COMMAND_NO_STDOUT 		(1 << 1)
+#define RUN_GIT_CMD			(1 << 2)	/* git sub-command */
+#define RUN_COMMAND_STDOUT_TO_STDERR 	(1 << 3)
+#define RUN_COMMAND_CLEAR_GIT_ENV	(1 << 4)
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_cd(const char **argv, int opt, const char *dir);
 
-- 
1.5.2.784.g5532e
