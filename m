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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39DFC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBB860FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHQRJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhHQRJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10CC0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so2629401wmb.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SXglbYF5i3mCU+SWgUZKfoy6r5uUdP5lH28zMDqaTwk=;
        b=G9RGfQG/dnQyf4l+3hw8ydM3kkc0ZsKHJ322gMQGhMXSjdiZarf9P71iMzBoKUpOrE
         RQ1odjNe1o084LiWX6hoT1NaITGyDJEdGiKBzM8H854kpn7Nt/hE/ei6KQGJxj2Ccub5
         VN1tLNnXcNqKpzdVApwJXOojX7+M7V4J72gaInnTk2IEd4hsqFtpI/dMfSn2PN7dOS0N
         GE45JOvXL51dJe8DjwEFj2Zcey0lkebzlysyZP8jxuDFdoIJipDoFMFT7ELNy9x2Hxja
         Ys+C8CLkqOqb4yEizSgoF0im5y6u3iKxkbkZQoE/7mxY9NeEpm4rGiUAQTq46HmNl4OT
         rkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SXglbYF5i3mCU+SWgUZKfoy6r5uUdP5lH28zMDqaTwk=;
        b=E0pFV+73ICcL+K6PQWvtsaxl1gGeLbZqNDjL7o9b7PVj05RmssE7+/BVNsQk300eNg
         xZ8+WfyqPZLTNaTeaq6QmAkigFfFlU0Vqv638DQYvYkzR1hrUpNZdDheqeFwPe0j0dev
         MX8ZEDwdHl+INT8gDWfb/fT17DnyJjsXZOz/onO1OVZFvmMWq/HOHKiLp+QkW4SurZtS
         60zXy35o1q0qDRqsAblDqiXjj7m1f6A5CtJK86FO8R4lzi4pnO1xzOReDoj0fXuG0z3x
         ZC65oJ4u/Y/a8f+O2NDXKWkIHfcoO4CTXu9C6c9qR5kXHyxXCKgLDM+3MT2l3Qr3V5Go
         OmHw==
X-Gm-Message-State: AOAM5307vJgLkvJcDeAOaN5HEvyZ8u6plxa98WvZM7cAci9b7WdApT5e
        0FM46SxQAOP6ZAgNq5G834100h8/oo8=
X-Google-Smtp-Source: ABdhPJynaYGj7GPDTCwdyolQDSxcT++5V8la7SHNtwPteV8x8G3bTjpbnS83s0diNsCBw5Qkg0xMPA==
X-Received: by 2002:a05:600c:b51:: with SMTP id k17mr4419487wmr.149.1629220129361;
        Tue, 17 Aug 2021 10:08:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm3177028wrr.48.2021.08.17.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
Message-Id: <350ed86a4533d7fe332aebdf88cc474ceaf30ffe.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:44 +0000
Subject: [PATCH 6/6] sparse-index: integrate with cherry-pick and rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
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
 t/t1092-sparse-checkout-compatibility.sh | 41 ++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)

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
index a52d2edda54..c047b95b121 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -532,6 +532,38 @@ test_expect_success 'merge with conflict outside cone' '
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
 
@@ -670,9 +702,12 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/untracked.txt &&
 	ensure_not_expanded add . &&
 
-	ensure_not_expanded checkout -f update-deep &&
-	ensure_not_expanded merge -s ort -m merge update-folder1 &&
-	ensure_not_expanded merge -s ort -m merge update-folder2
+	for OPERATION in "merge -s ort -m merge" cherry-pick rebase
+	do
+		ensure_not_expanded checkout -f -B temp update-deep &&
+		ensure_not_expanded $OPERATION update-folder1 &&
+		ensure_not_expanded $OPERATION update-folder2 || return 1
+	done
 '
 
 test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
-- 
gitgitgadget
