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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C23AC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6826122AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgLVAGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgLVAGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE6C0611E4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c21so312307pjr.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=95WssQGkSGjhfagG6g7ltjwqaKVtmBM5EOhXY6N4OsU=;
        b=GqbLcAxteGCqKS5gtMrqZBhFYHWyNNmIadqjeZBxasr+jT0R+OETaLieEK0T+/sBmK
         Ik4Tr/ClxCQW2rEyMS9beIae4qIfKQ8nLd82UbtXWrKjxGst0S3/pVQhjF54whLN+QZl
         hYDdqcWd2FK8G4WfN0ZF1+JIqeCyL36ciOR3oRrwvGtO1g23W91lqxg5lDjkDOw6vWq5
         JJN67P6oBnpVEUZGYOnICdS3ChrtjGeyB+UeX3yphJCMV98UmwmyAnrO2TAtRxeGDgS5
         RGu/8z4W5o4zLDniRiEy3NvepzStQrLZc1ar1LVVhOBpdAC88YSyoPN6TuHB2JiNuLFr
         0kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=95WssQGkSGjhfagG6g7ltjwqaKVtmBM5EOhXY6N4OsU=;
        b=FPjmbTY1FWULM1GRtPqwHH0FwbU4Zf6tiyc8Qvv6rPz1KEo/3rfdQb2MOCuhDD4Rcd
         DEb1PUgX9Ql0ynkUwivo+pg0f07h9Ie5kGl24jQ36S2jDeoyEbU1fQ0D+INHGbkpnn2r
         raBA+xI9aUa6/0l3cYC6IvFayBKBxBFAAHdoEPtwldXZF4gITa0La/c3xbJ8gmVBGmwG
         srIIXoxhvE96AIs/scWcCLv5D26ogliofxWBr98Gt5T32GaOU2Zro6/kFiBn3E4wjXTQ
         PaMnFuvn64D+4ZVNWSVTKF12SuC+Am8D/XHphgiueaugCdMvw99+/HfaynJSHtBjR17S
         msHQ==
X-Gm-Message-State: AOAM5319/f/UUk3Au5CU1YwjzeRQzzLyyewJkbtF4QtHQTClcJ2vvXhi
        dP9CZlyyIx31mjzZCgjdyjIYXKNaVdkle91AvPuLpwnhh49+zAY836XTlhtH553pp3PMZvEnRlG
        DYECkC829aOQ9mNHGRAP9dpHek5MNkfxAdgua7BrYtpyurXrAQcPUlnc283QUoSJUIKDnXOumxQ
        ==
X-Google-Smtp-Source: ABdhPJyNcTYN5Omu4FPnBHXdlsoFAAFgwfts4h3RThiCVGtZgBefq0f5ihJHDi71C8YqyQ2+vn68vsQYRGGJ1C2TjvI=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a63:d846:: with SMTP id
 k6mr17297051pgj.167.1608595510444; Mon, 21 Dec 2020 16:05:10 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:33 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 15/17] post-update: use hook.h library
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
index 4a6ad27404..5c23d5ed86 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1686,33 +1686,21 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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

