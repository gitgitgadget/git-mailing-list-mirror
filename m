Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4DC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D65E22254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfwfQ5e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404925AbgJORWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404912AbgJORWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDEDC0613D6
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so4539915wrn.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GMYSRsXU/HWjpgrMbY+93Un80eytoVco4XZ/LJ7MDTM=;
        b=lfwfQ5e0aSCpb01tnMk6RjLh18SkJm6LEhdCrh+fxSg4ZCmyYQSqGoEHlByDqthMyT
         +zCrGAlgUHi0lB6twJDcGPZUDAqutCtUV1d05QV/y5KaF61rdO2N42BspZVRoskANWG0
         rDfx3SYRGanly1g/nu1TQPSM3BZl1BTZe7MnFV7YFdyXGZ2IdA0bp2fYAH56cla0VTfa
         Tq4n2RjDN7huW2ml0SyChQaA3tCZpnb5ia46uDp38hNFR/b+nXJlZxBDRcrSkLWWy0MO
         omhbS3OopwgBGnwcjCbkPIP/88DPh5b5faukQAY9r9W5srT/lsI3RgRUsNeg6huUpYEu
         am3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GMYSRsXU/HWjpgrMbY+93Un80eytoVco4XZ/LJ7MDTM=;
        b=R89txDqdCVgMmpQe34eoZBTZ7ssWK2ELYEoK9O3Z/EDdhvx03KWe5kkzwiJVV5gm85
         ty7OniBr0Nbi4TGjByR/jMrXVJ6RV9akzEo4sKBZpfDDebGWmlL1Xw3VkMKaXtEw9SPK
         UbB3G/tX8QNvGBRKnNvhbEOSRBIHkXddnioKCsMjb4/mM3Edn0pH2pHFb+CstJBXdStg
         WgQpNXXVJpyphs2ARn3X3iU3AngIib8eX4/QNvVPSrVmmafMkDTpCi1fTfn1mEJzmn51
         O97eHUTy/incRHCOicvm7hhOr8tiahBzqpQs8ojRPZBz36fVL07TriSt4sBDA/t1nRxZ
         ATGQ==
X-Gm-Message-State: AOAM530i9Yne6e9KvQkV56xm+5jyE79CgfC/A3Ey8d2x1BhhYZ7Ezbq4
        c0LaJey2j2Qi23FsDz3WhLxAuwwxHWI=
X-Google-Smtp-Source: ABdhPJz9mmHrKBS+eAo7ClYGRjL+m+Q9Du5zJqcHfBUrEwICYZq/VjjXYafJXUxDK/3ocSj3c4dCPQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr6007224wrb.292.1602782531300;
        Thu, 15 Oct 2020 10:22:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm5706089wra.29.2020.10.15.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:10 -0700 (PDT)
Message-Id: <145c63ed8c61126dd19dbcdbe3fed81c32862f0a.1602782524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:22:03 +0000
Subject: [PATCH v4 7/8] maintenance: use 'incremental' strategy by default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git maintenance (register|start)' subcommands add the current
repository to the global Git config so maintenance will operate on that
repository. It does not specify what maintenance should occur or how
often.

To make it simple for users to start background maintenance with a
recommended schedlue, update the 'maintenance.strategy' config option in
both the 'register' and 'start' subcommands. This allows users to
customize beyond the defaults using individual
'maintenance.<task>.schedule' options, but also the user can opt-out of
this strategy using 'maintenance.strategy=none'.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 17 +++++++++++++++++
 builtin/gc.c                      | 10 ++++++++++
 t/t7900-maintenance.sh            | 20 ++++++++++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 7628a6d157..b5944b4c51 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -37,6 +37,23 @@ register::
 	`maintenance.<task>.schedule`. The tasks that are enabled are safe
 	for running in the background without disrupting foreground
 	processes.
++
+The `register` subcomand will also set the `maintenance.strategy` config
+value to `incremental`, if this value is not previously set. The
+`incremental` strategy uses the following schedule for each maintenance
+task:
++
+--
+* `gc`: disabled.
+* `commit-graph`: hourly.
+* `prefetch`: hourly.
+* `loose-objects`: daily.
+* `incremental-repack`: daily.
+--
++
+`git maintenance register` will also disable foreground maintenance by
+setting `maintenance.auto = false` in the current repository. This config
+setting will remain after a `git maintenance unregister` command.
 
 run::
 	Run one or more maintenance tasks. If one or more `--task` options
diff --git a/builtin/gc.c b/builtin/gc.c
index a8248e7a45..e3098ef6a1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1434,6 +1434,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 
 static int maintenance_register(void)
 {
+	char *config_value;
 	struct child_process config_set = CHILD_PROCESS_INIT;
 	struct child_process config_get = CHILD_PROCESS_INIT;
 
@@ -1441,6 +1442,15 @@ static int maintenance_register(void)
 	if (!the_repository || !the_repository->gitdir)
 		return 0;
 
+	/* Disable foreground maintenance */
+	git_config_set("maintenance.auto", "false");
+
+	/* Set maintenance strategy, if unset */
+	if (!git_config_get_string("maintenance.strategy", &config_value))
+		free(config_value);
+	else
+		git_config_set("maintenance.strategy", "incremental");
+
 	config_get.git_cmd = 1;
 	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 7440a0ea19..20184e96e1 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -354,11 +354,14 @@ test_expect_success 'register and unregister' '
 	git config --global --add maintenance.repo /existing1 &&
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
+
 	git maintenance register &&
-	git config --global --get-all maintenance.repo >actual &&
-	cp before after &&
-	pwd >>after &&
-	test_cmp after actual &&
+	test_cmp_config false maintenance.auto &&
+	git config --global --get-all maintenance.repo >between &&
+	cp before expect &&
+	pwd >>expect &&
+	test_cmp expect between &&
+
 	git maintenance unregister &&
 	git config --global --get-all maintenance.repo >actual &&
 	test_cmp before actual
@@ -392,4 +395,13 @@ test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
+test_expect_success 'register preserves existing strategy' '
+	git config maintenance.strategy none &&
+	git maintenance register &&
+	test_config maintenance.strategy none &&
+	git config --unset maintenance.strategy &&
+	git maintenance register &&
+	test_config maintenance.strategy incremental
+'
+
 test_done
-- 
gitgitgadget

