Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C12C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7C522DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgLEBvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbgLEBvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:12 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B97C08E864
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:19 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q25so7038253qkm.17
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Mv8LHfO4l+/7PUxhwyKCCiixlZeZ4LmqRPhF2OIQZmM=;
        b=hJS9UZOX7QDGFpebfa1b5k/BuytG/wxOdQDX2Cp2xzxAirtkuJuORTZ4HjTouuLLo8
         MyHSgzSLI+Qb8OLxtJKdpXNxVgoUTo4aYB1EsCeSv9kbKsYFIRVOjwoeDZnyICbmHGDC
         ORpikle2NaOdJAzT49vPWz+JOATcaSl8AbgPqY1qnYLz6Ty6vR3FrnOj00mXVVRtAcue
         I85oKDY/axT8Ja5+wg8U0WZfCiuEUvpMhgZzYKU7wlrJCIXH63rzaOWvxiyenJN6weFd
         F5oveK8ZkQqzKVzK9rjjizQ45eFpfk9CpkXqdOhpKRPuU2KZBmEs5oHm8zDXJi1VhU5q
         0zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mv8LHfO4l+/7PUxhwyKCCiixlZeZ4LmqRPhF2OIQZmM=;
        b=J4qwgz38BrGhNOl+muxXYPb84F9WUpwcNLUYQYLS+v5dbiZL3z4HQUDqBMMhKBXV3B
         PHkuZPcnmpZN/gObccRFB/ZOl+vML6fvFbA4au3xFFHiNjBT2lX0K19npp9kugCEJ8hi
         2dwExXeA3KS8VubJvQMy83A4LplhC+9HpJEaoUyvvTxNBiyyL2kKInPFE67wH9jrNzaO
         7Cq2Lmf7rk19AQNZgKaOWnPc3LpHmJN9fjyfB/6ZierrBnfz7yuNAs2RS7yyq/UxBElu
         xVNuYCjAlFrK3SB9J3vuCBD4ydra7E7Eevld4ZbooHoHv9WxPMAH8CfAmgfNe9zKCvRN
         KEZQ==
X-Gm-Message-State: AOAM5300i61yAQEaFZriahrOwQpnzdgrozcj3SGnOl78UsanBgrhmK7y
        /Wxdy/PWjKfC+XNL83vAMqbf0CRb1YmcOfdTmPWap+dW/Kd4kvDqgLQ6tdPzccs72gIj3qqCHjy
        Eq96rbDuF3TFd1FeGmtRQYYSVMAe5DSJxoft4Lfova5iv3oNbIeVmrjJwvz1ZIqrtIYMf6D1jmg
        ==
X-Google-Smtp-Source: ABdhPJzaw1ad+uyLtU4AfSmBrtLWqYEVoKW1p/0KSoVeaIjhuc767H2kzbgfhr2Uq341bR5lk/gn6HSW5nHV40yAVY0=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:44ef:: with SMTP id
 p15mr9429020qvt.37.1607133018270; Fri, 04 Dec 2020 17:50:18 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:43 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 15/17] post-update: use hook.h library
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
be specified in the config as well as the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 ++
 builtin/receive-pack.c     | 26 +++++++-------------------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 2c59c537f9..1412cd5846 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -498,6 +498,8 @@ Both standard output and standard error output are forwarded to
 `git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
+Hooks run during 'post-update' will be run in parallel by default.
+
 reference-transaction
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b929a3505c..66af00fd8c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1678,33 +1678,21 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
-
-	hook = find_hook("post-update");
-	if (!hook)
-		return;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		if (!proc.args.nr)
-			strvec_push(&proc.args, hook);
-		strvec_push(&proc.args, cmd->ref_name);
+		strvec_push(&opt.args, cmd->ref_name);
 	}
-	if (!proc.args.nr)
+	if (!opt.args.nr)
 		return;
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "post-update";
+	if (use_sideband)
+		opt.consume_sideband = hook_output_to_sideband;
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
-	}
+	run_hooks("post-update", &opt);
+	run_hooks_opt_clear(&opt);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.28.0.rc0.142.g3c755180ce-goog

