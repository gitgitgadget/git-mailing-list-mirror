Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64D120987
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbcJHLZs (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33046 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbcJHLZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id i130so6637960wmg.0
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RzzM+6nrT4MDRM+loz5d6jmeKmK5bKt4dVkEg4Q2rgY=;
        b=wFtbz0QnA6RD5GrghOQjfxsww7p6D6p3uWqisC3L+C9RAdAfhPZCjepIT5qt7rrCS3
         peVUpEEAzPR7QIBeXLb3uWDdU8c0FP2T7jJXb+x64NrhJyPFtI/cd/udB2jcb8YEMIUj
         nFauPBhRt9YUvNvRQJjrXtEnm+E+IX/CHTWwLNlI68PIi1SuWGOXlcNluooGi+2IwD7z
         ILn/jKKHNtWw7SJOUlFnUJt+wlkRhEeXHQG06J9ylyIolbeVFT15ThjiWWGExj9kRfsh
         MH1YY6dygN+evg0PF753GMwUaNaNfpFafzpGQ0XGFU8onOKGDeJP6UU6lu8/QKAsr0XQ
         GGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RzzM+6nrT4MDRM+loz5d6jmeKmK5bKt4dVkEg4Q2rgY=;
        b=KmJUTk7Jv2wN1D9DPm7pEYU9Qm8tbNjYp4Rc6rO5ZOzmBnUwIIjo4Ulwmt3+TFP5Su
         gTt/hE6AHXDeSLnSf+TW5D8sE9qg0ab5cpNii0W7DUZlmMxlB6R3HtM5d5jvQfDiVwO4
         K6rHopaYTrCdtRemM6FxlmmR6nWliIzErK3HQ+Erv5GW4JfOmP0vEFJMgYVBdpdCwKRk
         d6bhXQBiS2Fd9CXUURayvpeWZad67Tyws4SsuILhFkWfORVDbfzNjVgbNpuUin6z5xNC
         UqDcQ06aFH30ahl9+/N9+R2Vc2cC+iRSq+uZq6jaLRC06rUUt5U75tQ859xxgQdGHwhl
         6dXg==
X-Gm-Message-State: AA6/9RldmZ/u8Z3VsvQbHoQnYZRi+go5XlQJ9LctXPzVgkaUstL2IRbsf6awDuQsWbzS2w==
X-Received: by 10.28.154.76 with SMTP id c73mr3047586wme.48.1475925938441;
        Sat, 08 Oct 2016 04:25:38 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:37 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 04/14] run-command: add clean_on_exit_handler
Date:   Sat,  8 Oct 2016 13:25:20 +0200
Message-Id: <20161008112530.15506-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Some processes might want to perform cleanup tasks before Git kills them
due to the 'clean_on_exit' flag. Let's give them an interface for doing
this. The feature is used in a subsequent patch.

Please note, that the cleanup callback is not executed if Git dies of a
signal. The reason is that only "async-signal-safe" functions would be
allowed to be call in that case. Since we cannot control what functions
the callback will use, we will not support the case. See 507d7804 for
more details.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 run-command.c | 19 +++++++++++++++----
 run-command.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3269362..e5fd6ff 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
 
 struct child_to_clean {
 	pid_t pid;
+	struct child_process *process;
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -31,6 +32,15 @@ static void cleanup_children(int sig, int in_signal)
 	while (children_to_clean) {
 		struct child_to_clean *p = children_to_clean;
 		children_to_clean = p->next;
+
+		if (p->process && !in_signal) {
+			struct child_process *process = p->process;
+			if (process->clean_on_exit_handler) {
+				trace_printf("trace: run_command: running exit handler for pid %d", p->pid);
+				process->clean_on_exit_handler(process);
+			}
+		}
+
 		kill(p->pid, sig);
 		if (!in_signal)
 			free(p);
@@ -49,10 +59,11 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }
 
-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup(pid_t pid, struct child_process *process)
 {
 	struct child_to_clean *p = xmalloc(sizeof(*p));
 	p->pid = pid;
+	p->process = process;
 	p->next = children_to_clean;
 	children_to_clean = p;
 
@@ -422,7 +433,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd);
 
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -483,7 +494,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >= 0)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd);
 
 	argv_array_clear(&nargv);
 	cmd->argv = sargv;
@@ -765,7 +776,7 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
 
-	mark_child_for_cleanup(async->pid);
+	mark_child_for_cleanup(async->pid, NULL);
 
 	if (need_in)
 		close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index cf29a31..dd1c78c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,6 +43,8 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	void (*clean_on_exit_handler)(struct child_process *process);
+	void *clean_on_exit_handler_cbdata;
 };
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
-- 
2.10.0

