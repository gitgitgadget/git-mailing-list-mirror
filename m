Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B828920970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbdDNQ7i (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:38 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35401 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbdDNQ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:29 -0400
Received: by mail-pf0-f181.google.com with SMTP id i5so42727159pfc.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4jMviSDKSDVNAOXDfJKxqAYdphGZXaDMmOauztq2b4A=;
        b=d14ER3NQaB2CaaXYDDcnj7iVQPUzKOCnT3kO1hjIayz+bbE/AG5JQxJE3YCpPbTo0V
         1hREkKDuSIl7vBjDB2K4DhdRyIw5eM3m4JhnG9HzjIF5WsFAkxqM6jl1mxgI5H6jrfhu
         +/s4ndqDdLY/h36LzB6/IHZZnxU+6TZ0zDS2y2RUAek92ecRP5iLpbcZdFv0Pys3YWb/
         1pHR6K4oBqfZ7i5PJhLYhJ7XWR1DF30JQuYlH9he5/iUWpnhDrlOMllK5Hovzp+QIjSD
         gMMvc/uS6n6YTfXfmXN77HOgZF+vbcano+UadzIEsiUeTJpK5cnD/ilXqkxH5zJMKQ7f
         q1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4jMviSDKSDVNAOXDfJKxqAYdphGZXaDMmOauztq2b4A=;
        b=nYatKedgXr9oBnpC9cHDUm7+mjjdPzJleeQiF/qhwsjDFyEwX8LNtrvLknq67lx8BK
         lC51tg9bQzdWvXLMt7uGFAxtRvnN+IxXLA0vr9tVdvLUKuYuUnpouv7Uu0AMVe+r9AYw
         Ss5Z4dQ+zEpBGkWJ21Cg5XIuh8GWjKMqYLeH5RWCsCLA7C3LDLvY78LTn7v1vY+jkuYR
         vb9QtTSJPXWQsB7T6knEQeSNB6L3E64FI+wA4J2O4qbWsmrPHL8CH9V/YQ0lpzxjlCJR
         s7erJru++lyVKkFwer9JIqK4CnvT4SmZ+lm15p4/jaBrptxIv1U/Lz1PlIkUN3EN5SMc
         ZXqw==
X-Gm-Message-State: AN3rC/7tWha926wcbLm5fnaj6VSpy/nEzyguEeh+dAtZqvV/zdwBSnEJ
        f+1QB0u6Ch0Bxx+T
X-Received: by 10.84.143.195 with SMTP id 61mr9593038plz.158.1492189158546;
        Fri, 14 Apr 2017 09:59:18 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:17 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 06/10] run-command: don't die in child when duping /dev/null
Date:   Fri, 14 Apr 2017 09:58:58 -0700
Message-Id: <20170414165902.174167-7-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5864b5ff3..ee2c680ab 100644
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
@@ -464,12 +452,20 @@ int start_command(struct child_process *cmd)
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
 
@@ -493,7 +489,7 @@ int start_command(struct child_process *cmd)
 		atexit(notify_parent);
 
 		if (cmd->no_stdin)
-			dup_devnull(0);
+			dup2(null_fd, 0);
 		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
@@ -503,7 +499,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stderr)
-			dup_devnull(2);
+			dup2(null_fd, 2);
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
@@ -513,7 +509,7 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stdout)
-			dup_devnull(1);
+			dup2(null_fd, 1);
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
@@ -573,6 +569,8 @@ int start_command(struct child_process *cmd)
 	}
 	close(notify_pipe[0]);
 
+	if (null_fd >= 0)
+		close(null_fd);
 	argv_array_clear(&argv);
 	free(childenv);
 }
-- 
2.12.2.762.g0e3151a226-goog

