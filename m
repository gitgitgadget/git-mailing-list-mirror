Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E6C433F8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A138A619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhC3NLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhC3NLV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D1C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so10305631wmc.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ik/sbiJcgAItjz8wBWyJm4savRMM9zWovCm7yugKB3U=;
        b=mBLlzaFyqgXQ81HHHoolXqEv1kHeTIMGr6gfDm2M8xjw3ef2OfgiBvIpJEgRCmGsMh
         pnAzjL9TZWDDuX8jdrsGgn2fFWDED4IKDOAV6fl3MY0mzU+LUAlCv4sL4cBwXpG8i87c
         Uje5C63x29kpIrtEimPIHOd+Gi0B9b/ujRH+vDgC2aDt9m7QpY7JDHyXfo7qCQdFTVx2
         oI9j/QSACL2V7grUqcFJRWL4v9uZaNu5jRKaBJ8CEZZBpE1+GxcWNdH1RPolB+grY2fB
         k1J+3ciaJviDuw5bs0OzaNihPBVe1zJMI131kurdyjEShEcp2dZHUqNXSUdsuHiygR5e
         FnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ik/sbiJcgAItjz8wBWyJm4savRMM9zWovCm7yugKB3U=;
        b=cyhvyeufoohZE7t6T4mNt1IX76NZp943yC7CZZ+mYCM/LuxvSCxonkTYWxFTULmzmX
         LOVHxiqzTToqsP7UQRgAyFd8Mi63OU8ZiRBLX3sCHRMX86WsfS9BY3CtkmlyazSuTm2n
         gtsA0ajmZfxCo4hL/yzFXg2GxZVl+rRXFXeKbwE/5out1q/5JO5Jabz8xQg9Fk+KZmPy
         jO6NRaH2s3X2+0YAlqS86WrSNDctKp4HeS91xy1Pnwrb6dKJoaMrwp57jB35OOkd/SDM
         xMawbos/nDUZ5JG28akPkvrX4Bt0ukzvHXrMODhtkPXrhQNn0B8rRMYuNqmRpYh/2OHN
         HbGg==
X-Gm-Message-State: AOAM532OYABzVK2QcgC4xQ5CaYzoLs/3kwqq1PRQN5c2kB5r38oXWEjV
        udlg/V/JrEvQVbeqlZrqwW5d2Qil49s=
X-Google-Smtp-Source: ABdhPJwfX3KRtrzmRUNFYayMPDClSFij1ckJlxG8br1uzBKzrBBvWcgVgePNo9yFjKEic8RlMN4M5Q==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr3986129wmq.183.1617109879072;
        Tue, 30 Mar 2021 06:11:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm3220872wmq.29.2021.03.30.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:18 -0700 (PDT)
Message-Id: <c22b4111e49ef810810c54d4afba25db342c24a6.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:59 +0000
Subject: [PATCH v5 16/21] sparse-index: add index.sparse config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When enabled, this config option signals that index writes should
attempt to use sparse-directory entries.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/index.txt |  5 +++++
 cache.h                        |  1 +
 repo-settings.c                |  7 +++++++
 repository.h                   |  3 ++-
 sparse-index.c                 | 34 +++++++++++++++++++++++++++++-----
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 7cb50b37e98d..75f3a2d10541 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -14,6 +14,11 @@ index.recordOffsetTable::
 	Defaults to 'true' if index.threads has been explicitly enabled,
 	'false' otherwise.
 
+index.sparse::
+	When enabled, write the index using sparse-directory entries. This
+	has no effect unless `core.sparseCheckout` and
+	`core.sparseCheckoutCone` are both enabled. Defaults to 'false'.
+
 index.threads::
 	Specifies the number of threads to spawn when loading the index.
 	This is meant to reduce index load time on multiprocessor machines.
diff --git a/cache.h b/cache.h
index 74b43aaa2bd1..8aede373aeb3 100644
--- a/cache.h
+++ b/cache.h
@@ -1059,6 +1059,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
diff --git a/repo-settings.c b/repo-settings.c
index d63569e4041e..0cfe8b787db2 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,4 +85,11 @@ void prepare_repo_settings(struct repository *r)
 	 * removed.
 	 */
 	r->settings.command_requires_full_index = 1;
+
+	/*
+	 * Initialize this as off.
+	 */
+	r->settings.sparse_index = 0;
+	if (!repo_config_get_bool(r, "index.sparse", &value) && value)
+		r->settings.sparse_index = 1;
 }
diff --git a/repository.h b/repository.h
index e06a23015697..a45f7520fd9e 100644
--- a/repository.h
+++ b/repository.h
@@ -42,7 +42,8 @@ struct repo_settings {
 
 	int core_multi_pack_index;
 
-	unsigned command_requires_full_index:1;
+	unsigned command_requires_full_index:1,
+		 sparse_index:1;
 };
 
 struct repository {
diff --git a/sparse-index.c b/sparse-index.c
index 7631f7bd00b7..6f4d95d35b1e 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -102,19 +102,43 @@ static int convert_to_sparse_rec(struct index_state *istate,
 	return num_converted - start_converted;
 }
 
+static int enable_sparse_index(struct repository *repo)
+{
+	const char *config_path = repo_git_path(repo, "config.worktree");
+
+	git_config_set_in_file_gently(config_path,
+				      "index.sparse",
+				      "true");
+
+	prepare_repo_settings(repo);
+	repo->settings.sparse_index = 1;
+	return 0;
+}
+
 int convert_to_sparse(struct index_state *istate)
 {
 	if (istate->split_index || istate->sparse_index ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
+	if (!istate->repo)
+		istate->repo = the_repository;
+
+	/*
+	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
+	 * index.sparse config variable to be on.
+	 */
+	if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
+		int err = enable_sparse_index(istate->repo);
+		if (err < 0)
+			return err;
+	}
+
 	/*
-	 * For now, only create a sparse index with the
-	 * GIT_TEST_SPARSE_INDEX environment variable. We will relax
-	 * this once we have a proper way to opt-in (and later still,
-	 * opt-out).
+	 * Only convert to sparse if index.sparse is set.
 	 */
-	if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
+	prepare_repo_settings(istate->repo);
+	if (!istate->repo->settings.sparse_index)
 		return 0;
 
 	if (!istate->sparse_checkout_patterns) {
-- 
gitgitgadget

