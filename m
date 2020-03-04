Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9509EC3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6BF214D8
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly03JnSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgCDLeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33773 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgCDLeK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:10 -0500
Received: by mail-pj1-f67.google.com with SMTP id o21so961693pjs.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhjHc34/ATq6WbzJJIUAc6MuNm7WpSCV14ih6g2SQYo=;
        b=Ly03JnSg0g8Jetc2hiQLyyi0oxqvu3P99VUVz/Tla561kst+XxCSq1N9lLUS5DMTFw
         nU0tqfdigpzras94lypNKvoBkqdH6Drk2n7EwXZzvvHE58KVcT+AeOWRIg665WJyF638
         qnACJeP3B3cFYXllw/b8N+0jOrXbzBKc2S9Tt4CKlfEIkK4xJCx8+yUYk1FYnZuTjHnH
         UcIiIkP9W8pRkYp619Rqy5Mx3q0Czc0AAWcJrxDrbz22bAxRdSxMY6JqfHL0hIirtFWV
         uoILstOnX7TADQxKJ0ki1fYDGuZkIwmJ4eqOTQYlfBWQROhq07U2qFE6oCaNgBPRtwgD
         FC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhjHc34/ATq6WbzJJIUAc6MuNm7WpSCV14ih6g2SQYo=;
        b=aW9A+13OO4kVIotcnZIOtzuH7iDvV0/M3NV4eEtTF9SwH7/JehGdjrr9IO5WN8/CcD
         A7dkHeniKCaGNNdvV1AwEgI9/BsxFpLBE7tvo20/OTc1b185GI9PKpAHV0eLmPdkz4UR
         iGZHT/KfkO9lUjx0kH6E6pBKQrbTZrK9vF4OX7VFvfiS2S4xVNE1SE+kjz14simgmmpC
         8lgP7aq3nWDxQCwFpES63fgcmbLm+Lrr68wCO4JlX4ZYRRMgAlsLueeDngP5rCF3cBXT
         rqjZvVkTGvgKYUGeNGcaiiqm/AUoFNFcsGapCJSE3ez5KPWnE6XIaUAiRaL8nGcWuHLz
         UfLg==
X-Gm-Message-State: ANhLgQ3hbw/0WQUfOtleWlFacVXK8eFiHHAHxGRAgNUcOzSUQewOHRP1
        3bs5WLrpkblExbrGjinujkB5ZGp63P44rQ==
X-Google-Smtp-Source: ADFU+vs84UWUvWlIZSS9TcpEmebDkvtZp4XS6gZlR2KrliovBjvnoaKOLDLxwdAnhPk7ti9miWfusw==
X-Received: by 2002:a17:90a:608:: with SMTP id j8mr2592732pjj.85.1583321648741;
        Wed, 04 Mar 2020 03:34:08 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:34:08 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] receive-pack: feed all commands to post-receive
Date:   Wed,  4 Mar 2020 19:33:07 +0800
Message-Id: <20200304113312.34229-3-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Feed all commands to "post-receive" hook, not only normal commands, but
also commands with "exec_by_hook" flag.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c           | 11 +++++++++--
 t/t5411-execute-commands-hook.sh |  8 ++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 24eb999ed4..c97abfbcd3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -669,6 +669,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 struct receive_hook_feed_state {
 	struct command *cmd;
+	int exec_all;
 	int exec_by_hook;
 	int hook_must_exist;
 	int skip_broken;
@@ -761,6 +762,8 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	while (cmd)
 		if (state->skip_broken && (cmd->error_string || cmd->did_not_exist))
 			cmd = cmd->next;
+		else if (state->exec_all)
+		       break;
 		else if (state->exec_by_hook && !cmd->exec_by_hook)
 			cmd = cmd->next;
 		else if (!state->exec_by_hook && cmd->exec_by_hook)
@@ -784,6 +787,7 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
+			    int exec_all,
 			    const struct string_list *push_options)
 {
 	struct receive_hook_feed_state state;
@@ -791,6 +795,7 @@ static int run_receive_hook(struct command *commands,
 
 	strbuf_init(&state.buf, 0);
 	state.cmd = commands;
+	state.exec_all = exec_all;
 	state.exec_by_hook = 0;
 	state.hook_must_exist = 0;
 	state.skip_broken = skip_broken;
@@ -840,6 +845,7 @@ static int run_execute_commands_pre_receive_hook(struct command *commands,
 
 	strbuf_init(&state.buf, 0);
 	state.cmd = commands;
+	state.exec_all = 0;
 	state.exec_by_hook = 1;
 	state.hook_must_exist = 0;
 	state.skip_broken = 0;
@@ -861,6 +867,7 @@ static int run_execute_commands_hook(struct command *commands,
 
 	strbuf_init(&state.buf, 0);
 	state.cmd = commands;
+	state.exec_all = 0;
 	state.exec_by_hook = 1;
 	state.hook_must_exist = 1;
 	state.skip_broken = 1;
@@ -1575,7 +1582,7 @@ static void execute_commands(struct command *commands,
 	}
 
 	if (seen_internal_exec)
-		if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
+		if (run_receive_hook(commands, "pre-receive", 0, 0, push_options)) {
 			for (cmd = commands; cmd; cmd = cmd->next) {
 				if (!cmd->error_string)
 					cmd->error_string = "pre-receive hook declined";
@@ -2114,7 +2121,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
 			report(commands, unpack_status);
-		run_receive_hook(commands, "post-receive", 1,
+		run_receive_hook(commands, "post-receive", 1, 1,
 				 &push_options);
 		run_update_post_hook(commands);
 		string_list_clear(&push_options, 0);
diff --git a/t/t5411-execute-commands-hook.sh b/t/t5411-execute-commands-hook.sh
index 2ff0d5cbcd..b6444ca047 100755
--- a/t/t5411-execute-commands-hook.sh
+++ b/t/t5411-execute-commands-hook.sh
@@ -125,7 +125,7 @@ test_expect_success "create local topic branch" '
 	)
 '
 
-test_expect_failure "push one special ref: refs/for/master" '
+test_expect_success "push one special ref: refs/for/master" '
 	(
 		cd work &&
 		git update-ref HEAD $B &&
@@ -182,7 +182,7 @@ test_expect_success "add back the execute-commands hook" '
 	mv $bare/hooks/execute-commands.ok $bare/hooks/execute-commands
 '
 
-test_expect_failure "push one special ref: refs/for/a/b/c" '
+test_expect_success "push one special ref: refs/for/a/b/c" '
 	(
 		cd work &&
 		git push origin HEAD:refs/for/a/b/c/my/topic
@@ -199,7 +199,7 @@ test_expect_failure "push one special ref: refs/for/a/b/c" '
 	test_cmp expect actual
 '
 
-test_expect_failure "push two special references" '
+test_expect_success "push two special references" '
 	(
 		cd work &&
 		git push origin \
@@ -300,7 +300,7 @@ test_expect_success "restore execute-commands hook" '
 	mv $bare/hooks/execute-commands.ok $bare/hooks/execute-commands
 '
 
-test_expect_failure "push mixed references successfully" '
+test_expect_success "push mixed references successfully" '
 	(
 		cd work &&
 		git push origin \
-- 
2.25.1.362.g51ebf55b93

