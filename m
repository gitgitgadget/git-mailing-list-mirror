Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807811F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbcHCQnr (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34614 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so37223430wma.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pu+0SrMiER0zxHZ17xeUVlBUOf5hYOIR0bP5UGFareg=;
        b=snUCuTG0Azba1qW0bdIq2aUP9Jd0IzuwphA12YgQlk/Cmg+zllYg7Qp1L+wAkkhMve
         4yJuH/ZozSXBCCT896cz62aGj2I3s9EIFj6php5F3L7KDppNat5lUk/BeasXoV1p3j8j
         5y6TrPZuRcrZW8PMTRFmpfnCE6/Psh+3Yo0nzIBb0fB/FyCE/1Xulc3IVI6T0m75LUtW
         +vMNzbvuYuqbJufa5nPKVppIqYqEuSuWgmsdfipcBE1rbSlwigm0VeFToEOM72fYr2TW
         EkuY0hEICTf6XI8KsqPwMWkvkOpDNtELDfXo43UtojDR7zhO8RNVD2Y6IF6DJn3sdvl9
         UnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pu+0SrMiER0zxHZ17xeUVlBUOf5hYOIR0bP5UGFareg=;
        b=kAiSNfvSr/xMj7t69F8w/KXeJzQ6PL79va95yqA51wJPqr6xB4OGXk6QCGakJaHuhO
         Rt2qE8MNdY1GymVeXT63G7HKUSW2Tylt+Uf5AU06Yp5LAdXoubZKtiwYdYvifFkx6jCW
         D4E6Wopjd8xPJ50XKNBUHilxyOepmJSmh6Jjo81BWDohO2gfjxGrlu/EaapBrMw605Sg
         7PKP0F3I6/UUkdbgln+WlKpmG2LQKfc94sKVLRmPLNmoo6nZWZc2AKpxEaG2+U7LL4BN
         RNtde0dNGjksJ+GLU69Zuz4GznS9fhJERKzaSQly/utheZ6m/GPZg+sfJLdo9bvvhDcx
         KpgQ==
X-Gm-Message-State: AEkoouu2x+qRLnxGaWlpilGWcJCIexD7L73Ra3+miwe+Sn3aXx+pQb5g4eVLf6TOjQ36ow==
X-Received: by 10.28.135.133 with SMTP id j127mr70725457wmd.9.1470242555137;
        Wed, 03 Aug 2016 09:42:35 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:34 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 07/12] run-command: add clean_on_exit_handler
Date:	Wed,  3 Aug 2016 18:42:20 +0200
Message-Id: <20160803164225.46355-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Some commands might need to perform cleanup tasks on exit. Let's give
them an interface for doing this.

Please note, that the cleanup callback is not executed if Git dies of a
signal. The reason is that only "async-signal-safe" functions would be
allowed to be call in that case. Since we cannot control what functions
the callback will use, we will not support the case. See 507d7804 for
more details.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 run-command.c | 12 ++++++++----
 run-command.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 33bc63a..6ca75f3 100644
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
+		if (!in_signal && p->clean_on_exit_handler)
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

