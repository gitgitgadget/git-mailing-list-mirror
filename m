Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1947EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E955E61153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351473AbhIHLZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbhIHLZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39717C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d6so2697392wrc.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NhVGodYegspo2WMnVFa4iDfSwEgWB/VRcImjAbZjlZ4=;
        b=AyJ512aG3UG3YfCfYigumXuBBqvouVA1pu5UylyOKb/JejBU0WHu7C6uvICqULBhEb
         qcUTSaPEUWx8Tb89RP83BcZ43PHUqYthE+5y+TTQ475enqiCyyAIjrgBGTkvYHVFsvdA
         X9vQp4jSygAOtfJwaSwi6yQUKB3RqPxiO1ReNJAuSIb3BdFBmMu1FVGR9hFQZk5uwxvJ
         3GSoTf1sJZiSHqbSoH1jgEXTI3Scd8QqkpVZAE9++DcqG4fUB6W2woJQBz+m7LIL5+eK
         RJQMSFV6ErT+ZD451x+rhwQ58jQKO8EQgigY6Bsj0rbBtiQ6BtLevKINV20GpO2TDeOD
         BpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NhVGodYegspo2WMnVFa4iDfSwEgWB/VRcImjAbZjlZ4=;
        b=wlH/ggoY19OeRiUP0E+iP3i7Kpg+0R4IJ3og0V9L8yECIvduA9PhyZ8M7Jh2lL6Gyr
         nvMSBrxScr7+BnbXzs2DSod758+fzILK50bNQaCVuOe5RJOga0ukFiTHpt1eTdoDrCfJ
         zJQqkfA9DIQKVedF+Iq8mJwuERftO429Z84olO6+w4jDO7VMRGMYINXyMiqkNAv2li2R
         EYKR8rHet3NH4W5+71hvjy9U9SavuuvSNl+bbUh/BkcNSpmiVZTE44oXMd/lDxCzde6o
         kX/Cx6TKLHOspzE+3TYUphi1Ko18j8TK7JhzW9BM5EJpzWJxfTEFhWPedn2R2EAxzPh3
         RFAQ==
X-Gm-Message-State: AOAM533FkfRwIqJ6ye9Thdgoeahrd1n/m4HPnFP4TuA6jEALMozQom2n
        Fg2lcs8wlbtlu3YSiZCjnV95ouormMc=
X-Google-Smtp-Source: ABdhPJyaM7H/N23C68m4T28sUU5+MmQOtM7+PjC7bOyvTcdHYL7jDKV13pCU6kpzdFLd+6QWYdtFrg==
X-Received: by 2002:adf:de09:: with SMTP id b9mr3447644wrm.114.1631100246834;
        Wed, 08 Sep 2021 04:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm1838028wrp.49.2021.09.08.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:06 -0700 (PDT)
Message-Id: <36cecb22330dd52191e810a828eccbe098c48827.1631100241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
        <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:24:01 +0000
Subject: [PATCH v3 6/6] sparse-index: integrate with cherry-pick and rebase
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
index d9424ed6427..886e78715fe 100755
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
 	test_config -C sparse-index pull.twohead ort &&
 	(
 		sane_unset GIT_TEST_MERGE_ALGORITHM &&
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
