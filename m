Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AEF2098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756519AbcJPXU6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:20:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35573 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756479AbcJPXU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:20:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id s8so11496435pfj.2
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z26VzGtZwi2/2WkMnWdsrr3lIVifp/i5KxN7cavUAsk=;
        b=CxBWqq5qMsZnpOucVBXy3zd1Xo3gW0bxI052z7fas1XpSYwfgI3JDwskxJHMH0pjHU
         A+x14a4twmXIPX81JinydqjmFwYJj8kDERcxNNauBOpFp2Mi6xpDnh7x+Iod+OGnOkyX
         0Ti63JQJ02CsRiZ5IHlEcvmAW2gPYLE5XyujL2tfTz2W7SZrlbdfoHoGoLIevZ1zbw7j
         CaQarDWJMgecOALkeMz1lrgaxlMBeoc7lxeOx25gddOfi6RfCb+fvPYn0XFGD/nDdvvN
         wQ8TzqDY9sZhUH2ZvV3Xyjx9wtIk+bygOUl/vVO++LeISgRxawbS1ltdvGJhBlehAWMZ
         Fq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z26VzGtZwi2/2WkMnWdsrr3lIVifp/i5KxN7cavUAsk=;
        b=Pf6nSRbpjtWcQiMaVqAyrlKgqFI2bELSEWyTKWpoe8PjiKMtgp/LPCaSaiobOyZP7R
         doO6wxzC774Cmo7TMSTU7SQu2VQ6L50+u31KQnpegoantISy1HPr1OW3wk1tM0c7s43l
         xcdXzOXNJtv3bYxiEwcF1qszMEd+jM/UcgDef16nT0wVisSIsQ7SglPQGw+QZOaHNFEA
         2PKXUi3LjDSeCxn1AE0ONvFtWJCkygtA9PiIht5MP2C0bQVk9m20+J3lCfk+Tcp2ZVwW
         r4z0NJStXqPWNCNErlOruXC24egO/2psM8CK6D1WL6GiLrepxRUy7UG4kySZfY+G0jnW
         g+PQ==
X-Gm-Message-State: AA6/9RmnBWSWNJoPA8cGP7GPf+o2eQdDAFNzQIIkL/0IzOzOjU0ir5nPJkk6xB//k/SN5g==
X-Received: by 10.98.70.29 with SMTP id t29mr34034788pfa.185.1476660056785;
        Sun, 16 Oct 2016 16:20:56 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.20.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:20:54 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 04/14] run-command: add clean_on_exit_handler
Date:   Sun, 16 Oct 2016 16:20:28 -0700
Message-Id: <20161016232038.84951-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
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
 run-command.c | 22 ++++++++++++++++++----
 run-command.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3269362..ca905a9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
 
 struct child_to_clean {
 	pid_t pid;
+	struct child_process *process;
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -31,6 +32,18 @@ static void cleanup_children(int sig, int in_signal)
 	while (children_to_clean) {
 		struct child_to_clean *p = children_to_clean;
 		children_to_clean = p->next;
+
+		if (p->process && !in_signal) {
+			struct child_process *process = p->process;
+			if (process->clean_on_exit_handler) {
+				trace_printf(
+					"trace: run_command: running exit handler for pid %"
+					PRIuMAX, (uintmax_t)p->pid
+				);
+				process->clean_on_exit_handler(process);
+			}
+		}
+
 		kill(p->pid, sig);
 		if (!in_signal)
 			free(p);
@@ -49,10 +62,11 @@ static void cleanup_children_on_exit(void)
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
 
@@ -422,7 +436,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd);
 
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -483,7 +497,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >= 0)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd);
 
 	argv_array_clear(&nargv);
 	cmd->argv = sargv;
@@ -765,7 +779,7 @@ int start_async(struct async *async)
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

