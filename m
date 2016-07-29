Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9151F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbcG2Xi1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34487 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcG2XiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so17717587wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rco8Gp8bthre/7rY0aykcepQfwFOo9Bck7mQ0/ZclO8=;
        b=cu4l2g+R8oToTRIE6fLmq42URm9epxldh1TxODLdEVNhM9i6PsOolOwZ3uam+20pwK
         5umdGDIrhGpxQPLxpRzMj+j+2DUIdPen4v/HGth5kFVDuiQveR8JO14xs5jIw1DLISYv
         hq4GNe9vJe4gqLmgCUBWmfiwEdz4bQRhuF6ZFoLSifhjvgIlm1BEcCnFYXuGjg+QcXdF
         BitgTkNFHMiA6K7B5r8mZBhPBw3cJyZZ5bpcJdMX262imn+2h823CmVt99ryM6GCOrlB
         RTENreaKk/34/swCVdemTEonKG9aDeM/2NaI5blhsZgub5WNEN7fh7GSp1jPkHORxJtX
         KsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rco8Gp8bthre/7rY0aykcepQfwFOo9Bck7mQ0/ZclO8=;
        b=Jo3WnujfdioEW0uqGwOX3tUGbjQP2EjBaF2z77M0bJYKqW2GICJkh3G2OQUgaRVCM1
         9oOIWRbIqXbMPxircADS+DN3nDsQ1diGpHf9ySK58IsQ8MawH6q19XoTSoK8dwFvdeeG
         FK1AW/UXm6rPYcsPPn4scK+kf/LrnyigBILiVhlP2J5L5ryvNu2i/+so5frI9Gajh4rY
         +E2kmWHco5nGxfza8ySxuvo2aWM6prO6dYCiUUCck+6ZcJeX9MJfVleJOq0C9jgbq4Lk
         lPznboHT0uGpS8KnKWVeaWEFN4All2eubpieSBIHLYkSCbBOx5EeDlLW3ZxRWcU1QCtW
         Uong==
X-Gm-Message-State: AEkoousRb1C95I/PGPoF9CklDdBSddcEgaH+0oL1P63pcqwV157JE3w9a0XT1qUTsfedlA==
X-Received: by 10.28.226.85 with SMTP id z82mr3472984wmg.101.1469835492607;
        Fri, 29 Jul 2016 16:38:12 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:12 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 06/10] run-command: add clean_on_exit_handler
Date:	Sat, 30 Jul 2016 01:37:57 +0200
Message-Id: <20160729233801.82844-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Some commands might need to perform cleanup tasks on exit. Let's give
them an interface for doing this.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 run-command.c | 12 ++++++++----
 run-command.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 33bc63a..197b534 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
 
 struct child_to_clean {
 	pid_t pid;
+	void (*clean_on_exit_handler)(pid_t);
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -30,6 +31,8 @@ static void cleanup_children(int sig, int in_signal)
 {
 	while (children_to_clean) {
 		struct child_to_clean *p = children_to_clean;
+		if (p->clean_on_exit_handler)
+			p->clean_on_exit_handler(p->pid);
 		children_to_clean = p->next;
 		kill(p->pid, sig);
 		if (!in_signal)
@@ -49,10 +52,11 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }
 
-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup(pid_t pid, void (*clean_on_exit_handler)(pid_t))
 {
 	struct child_to_clean *p = xmalloc(sizeof(*p));
 	p->pid = pid;
+	p->clean_on_exit_handler = clean_on_exit_handler;
 	p->next = children_to_clean;
 	children_to_clean = p;
 
@@ -422,7 +426,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd->clean_on_exit_handler);
 
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -483,7 +487,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >= 0)
-		mark_child_for_cleanup(cmd->pid);
+		mark_child_for_cleanup(cmd->pid, cmd->clean_on_exit_handler);
 
 	argv_array_clear(&nargv);
 	cmd->argv = sargv;
@@ -752,7 +756,7 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
 
-	mark_child_for_cleanup(async->pid);
+	mark_child_for_cleanup(async->pid, NULL);
 
 	if (need_in)
 		close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index 5066649..59d21ea 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,6 +43,7 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	void (*clean_on_exit_handler)(pid_t);
 };
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
-- 
2.9.0

