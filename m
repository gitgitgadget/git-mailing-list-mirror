Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B4F20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755961AbdDMSdN (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:33:13 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36068 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755349AbdDMSdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:07 -0400
Received: by mail-pg0-f42.google.com with SMTP id g2so34005855pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HD4DBHcI9EwJDJ9GMNfPa+SrtRxQNffRHIrEjXgYeFc=;
        b=VMdrkBVm4WVAZYOItlBjD1MxTl7mAMY+WslhYIqy2HZJbpqVbPZstet1Y3V93AYWuq
         ezdpLsjTDIhA98rmtaqyoj8vMIUEokdeIm3rd5QIj+7skPyJqBFyKpoFy/HcWyKEoYKa
         rpyHsVliKpoz+tw6vzy9JmHnfjllAbaeeiedSmseuYd4G2g346HaZaa0JcR2Gpt8p5yT
         UWL9zOsHQcieaVeB2CrToD3V9IDfaAK22RtKflzl8IvNeX/kCYtIrHSiMbRNXdZIyIQN
         VBfB7cmzLD2/lDp+bG8hvx/bI1aY+jK0qFfpXT64NijI/cb2ybwldJKeeA2HVVVYO890
         /nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HD4DBHcI9EwJDJ9GMNfPa+SrtRxQNffRHIrEjXgYeFc=;
        b=ikD1Mt/Z3p1PMk872xKdb6IjMcHn9RZ/qJqKGtZd9HQYwh1rTXIgwu4PFgLHyRgnzM
         WTWlSgjuuznp3WzjNM/0OkbpQX0pn3iC5foi/mSoP4HKh+lzp3ztKe4mkZgN3TVqtSLa
         9c6mB4NpLgIuCQcw5h/DQ3U0tRkpZdEK96v5b0NP2TGJE1XM89G8UZ+juc+ueOonXf8k
         42H2J4O8rDvSIYDUeQanHhh7gveiwxiV5LaRKcPAb4kaxiqwIEzjA7VevGkE2OQxndll
         6c3tgk1GKddS7sBugqDL+59zjVQejw2R644icXmsKHnt5WzjFY11DAXl+vQXXs2a5X6C
         0gjQ==
X-Gm-Message-State: AN3rC/6M+6nAx/CPOo/uwyhCrfgLNFMryixcmX3jmw4gpQ+9QkZptFae
        v2B73EAaT2R0OEqN
X-Received: by 10.98.66.212 with SMTP id h81mr3430666pfd.182.1492108387106;
        Thu, 13 Apr 2017 11:33:07 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:33:05 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 4/6] run-command: don't die in child when duping /dev/null
Date:   Thu, 13 Apr 2017 11:32:50 -0700
Message-Id: <20170413183252.4713-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5e2a03145..6751b8319 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,18 +117,6 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
-{
-	int fd = open("/dev/null", O_RDWR);
-	if (fd < 0)
-		die_errno(_("open /dev/null failed"));
-	if (dup2(fd, to) < 0)
-		die_errno(_("dup2(%d,%d) failed"), fd, to);
-	close(fd);
-}
-#endif
-
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
@@ -458,12 +446,20 @@ int start_command(struct child_process *cmd)
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
+	int null_fd = -1;
 	char **childenv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
+	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
+		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC | O_NONBLOCK);
+		if (null_fd < 0)
+			die_errno(_("open /dev/null failed"));
+		set_cloexec(null_fd);
+	}
+
 	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
 
@@ -487,7 +483,7 @@ int start_command(struct child_process *cmd)
 		atexit(notify_parent);
 
 		if (cmd->no_stdin)
-			dup_devnull(0);
+			dup2(null_fd, 0);
 		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
@@ -497,7 +493,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stderr)
-			dup_devnull(2);
+			dup2(null_fd, 2);
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
@@ -507,7 +503,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stdout)
-			dup_devnull(1);
+			dup2(null_fd, 1);
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
@@ -558,6 +554,8 @@ int start_command(struct child_process *cmd)
 	}
 	close(notify_pipe[0]);
 
+	if (null_fd > 0)
+		close(null_fd);
 	argv_array_clear(&argv);
 	free(childenv);
 }
-- 
2.12.2.762.g0e3151a226-goog

