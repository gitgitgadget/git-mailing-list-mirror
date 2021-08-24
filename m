Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678BAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52149611C8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhHXVyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhHXVxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:53:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426CC0617AE
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e5so16779110wrp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3oiI703uZHfsbLGPVj5VdwMJxHrMiU10UfZYn2zc1t4=;
        b=LlWfiJP93QHgmB7B4e0MTRXLR6pzRCgRgoCbrBOW/af6bwfJjPsunwDrB8ffo1HBEL
         2KV3SmziIP45fZUyHO6cKyJfMWFn2tzcP6xvaG0qSBPCXwLVPq+USiNJq2c8gN+5LWMJ
         wQ/EaG2osUudF6OCRlq2CJ1gmRcPLJ5X6fz8J0KtUBnqCeWToeXlnSB2c9NocRj4N4/S
         yU9QJPZ7T6/P1UJROdz65KAfwg33qKhteoR9B9xaJTjQAta1Qh8ys4a1ABZuqFJJal+u
         Fvq8RXuun9uvBlrGetAh/F910WDUPfRBAmSLXljt7UpKxDD8AkeSSLLlZdw5oaXBhnUb
         wejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3oiI703uZHfsbLGPVj5VdwMJxHrMiU10UfZYn2zc1t4=;
        b=NL/OAxpxjhY8LogsclgI1FtnaX7F9avV3wpY78XAxNEfEjwJaA9VQhMvwLTB43Jtmu
         wCp+Trvr7UG38DIrPZ7clsXONpgR7aJQLZgjZ1r0OPZV5cTvdAyhf1MYpb+65U5wzamQ
         InaQfnbCEB54GC+oOB5bDb0icZ5s4BQI2li+0csP4N+Dql/gzVihjtI1tn+TImo6tP5m
         z5nT8vPsd7hC+lZ/bGk4ul3wDGUp5uyK3c0oK3XT3gfL1QidwpJICuMGR1xrVoa8Q2vg
         rt4Uqq1EhE+Jcy2R0Cu9iRQrFy5Qw0v8X6vvhGSQ21w5Q7NT25AWrzJQFm0u/kFMtn08
         gVgg==
X-Gm-Message-State: AOAM531b4bhslJg6pvRb3A3+u/Gsvlj+i8QGPcz2x8xcCBnYckR/VFzy
        l9LU6hw5BnUM4XXqYlNl58tIVJTz3Aw=
X-Google-Smtp-Source: ABdhPJxGC7aNCFyGwEIuqtOCA/mNsaXQ1reyQs3z3z4FevcDeYJmUkNOknQVDFBqex2UXJd2MeKLZA==
X-Received: by 2002:adf:f889:: with SMTP id u9mr10744520wrp.67.1629841970477;
        Tue, 24 Aug 2021 14:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4sm20091627wrc.34.2021.08.24.14.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:52:50 -0700 (PDT)
Message-Id: <df4bbec744f5cd4a060082212d95a36b812fa50b.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:52:45 +0000
Subject: [PATCH v2 6/6] sparse-index: integrate with cherry-pick and rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The hard work was already done with 'git merge' and the ORT strategy.
Just add extra tests to see that we get the expected results in the
non-conflict cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rebase.c                         |  6 ++++
 builtin/revert.c                         |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 39 ++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 33e09619005..27433d7c5a2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -559,6 +559,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -1430,6 +1433,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4c..6c4c22691bd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -136,6 +136,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			PARSE_OPT_KEEP_ARGV0 |
 			PARSE_OPT_KEEP_UNKNOWN);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 60d7400d014..bbc6de712c4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -527,6 +527,38 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
+test_expect_success 'cherry-pick/rebase with conflict outside cone' '
+	init_repos &&
+
+	for OPERATION in cherry-pick rebase
+	do
+		test_all_match git checkout -B tip &&
+		test_all_match git reset --hard merge-left &&
+		test_all_match git status --porcelain=v2 &&
+		test_all_match test_must_fail git $OPERATION merge-right &&
+		test_all_match git status --porcelain=v2 &&
+
+		# Resolve the conflict in different ways:
+		# 1. Revert to the base
+		test_all_match git checkout base -- deep/deeper2/a &&
+		test_all_match git status --porcelain=v2 &&
+
+		# 2. Add the file with conflict markers
+		test_all_match git add folder1/a &&
+		test_all_match git status --porcelain=v2 &&
+
+		# 3. Rename the file to another sparse filename and
+		#    accept conflict markers as resolved content.
+		run_on_all mv folder2/a folder2/z &&
+		test_all_match git add folder2 &&
+		test_all_match git status --porcelain=v2 &&
+
+		test_all_match git $OPERATION --continue &&
+		test_all_match git status --porcelain=v2 &&
+		test_all_match git rev-parse HEAD^{tree} || return 1
+	done
+'
+
 test_expect_success 'merge with outside renames' '
 	init_repos &&
 
@@ -665,8 +697,11 @@ test_expect_success 'sparse-index is not expanded' '
 	(
 		sane_unset GIT_TEST_MERGE_ALGORITHM &&
 		git -C sparse-index config pull.twohead ort &&
-		ensure_not_expanded merge -m merge update-folder1 &&
-		ensure_not_expanded merge -m merge update-folder2
+		for OPERATION in "merge -m merge" cherry-pick rebase
+		do
+			ensure_not_expanded merge -m merge update-folder1 &&
+			ensure_not_expanded merge -m merge update-folder2 || return 1
+		done
 	)
 '
 
-- 
gitgitgadget
