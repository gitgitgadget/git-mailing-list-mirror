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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD8FC4332F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6410161132
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346754AbhIHBnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346727AbhIHBnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB9C0617A8
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so692726wrv.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M+K0Z9WIqh5h1pKa505Bywi5J0nM3YeVcKgYGu5P63g=;
        b=HrlYllE9PfDjE4VgD4a/ZWl/HeF7nGhNW8ArUvhB3lHpOmzFtXiK9aEk9cjwYVmx0X
         K2GybSBbvGJWuGao4SU7VZtOaU5ays9Y4u6DkwVWiK3Af/bmCKJpDamzqM9Y4pwevqow
         EgmNiDWZ/K9JiRJuzdHODJJy0I34Ifc5liC8lNqmkKoLFwP37yhrk2O+0AzgnAywwGcd
         BqwqO9csWAsh3i6C3AOORVb5QyCVzDR1gZC1zULECSF9G15EiIfa+DBG94tRttkLqCXd
         xSahae+LvvTiOOynC/UKQusr8k2yYg4nMIYlNT2MJdVZ+IFBg19PyWM4KEmLrSszS6jH
         kHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M+K0Z9WIqh5h1pKa505Bywi5J0nM3YeVcKgYGu5P63g=;
        b=B7VB+X8hv8oYdzkieRLCeIQg6U6WpQfq91i//e038b9p7R08a1hhkp5fBknNYmpHgE
         qXe+g/Jzryiw0FGfzF7Xe2U+IRFNAcU5FddwF98tmsZiuasKjU8rWMHW3GHMlSgQxuD6
         THu8XnRPehEY6EebOZcSDCPDCdSovPRHGM0Ez4uqlVss3a1awz1AvBHOPcvz/kgcdfID
         GoP61BES2XI35DPP2LM2s3ibY16WLcUAsQ7zbVRVIhR4Soa04GHX9JXzLDCstuJY/BUO
         e1CBydkX+vtG6cLOWQ7rThxbT39bJdpRMqqrnvUsK65gp9s4GkAKKwMKXr67sKb1YXUZ
         csPA==
X-Gm-Message-State: AOAM531iYwTON8XfFCB7vNDadwSr1fTk2EzDb1Ui1QmNryUHRqTOMOgn
        Vn3CaZfbAqHzaRMJ/ednfsR+rGA2UmA=
X-Google-Smtp-Source: ABdhPJwA9wkZwd6XkdpKtMNQ1AcMnzHMuHvxBQIkJDfoayov9E4r/objAAwm6oMrAjI/LVn2C5tWoQ==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr1119250wrn.122.1631065359787;
        Tue, 07 Sep 2021 18:42:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i27sm589611wmb.40.2021.09.07.18.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:39 -0700 (PDT)
Message-Id: <d57f48c445cc148a7070fca799a3e57aa3dace76.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:32 +0000
Subject: [PATCH v5 8/9] sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The convert_to_sparse() method checks for the GIT_TEST_SPARSE_INDEX
environment variable or the "index.sparse" config setting before
converting the index to a sparse one. This is for ease of use since all
current consumers are preparing to compress the index before writing it
to disk. If these settings are not enabled, then convert_to_sparse()
silently returns without doing anything.

We will add a consumer in the next change that wants to use the sparse
index as an in-memory data structure, regardless of whether the on-disk
format should be sparse.

To that end, create the SPARSE_INDEX_MEMORY_ONLY flag that will skip
these config checks when enabled. All current consumers are modified to
pass '0' in the new 'flags' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c   |  4 ++--
 sparse-index.c | 37 ++++++++++++++++++++++---------------
 sparse-index.h |  3 ++-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9048ef9e905..f5d4385c408 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3069,7 +3069,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	int ret;
 	int was_full = !istate->sparse_index;
 
-	ret = convert_to_sparse(istate);
+	ret = convert_to_sparse(istate, 0);
 
 	if (ret) {
 		warning(_("failed to convert to a sparse-index"));
@@ -3182,7 +3182,7 @@ static int write_shared_index(struct index_state *istate,
 	int ret, was_full = !istate->sparse_index;
 
 	move_cache_to_base_index(istate);
-	convert_to_sparse(istate);
+	convert_to_sparse(istate, 0);
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
diff --git a/sparse-index.c b/sparse-index.c
index 23f7c3bd361..0bc45f60ac5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -122,30 +122,37 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-int convert_to_sparse(struct index_state *istate)
+int convert_to_sparse(struct index_state *istate, int flags)
 {
 	int test_env;
-	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
+	if (istate->sparse_index || !istate->cache_nr ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!istate->repo)
 		istate->repo = the_repository;
 
-	/*
-	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
-	 * index.sparse config variable to be on.
-	 */
-	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
-	if (test_env >= 0)
-		set_sparse_index_config(istate->repo, test_env);
+	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
+		/*
+		 * The sparse index is not (yet) integrated with a split index.
+		 */
+		if (istate->split_index)
+			return 0;
+		/*
+		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
+		 * index.sparse config variable to be on.
+		 */
+		test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
+		if (test_env >= 0)
+			set_sparse_index_config(istate->repo, test_env);
 
-	/*
-	 * Only convert to sparse if index.sparse is set.
-	 */
-	prepare_repo_settings(istate->repo);
-	if (!istate->repo->settings.sparse_index)
-		return 0;
+		/*
+		 * Only convert to sparse if index.sparse is set.
+		 */
+		prepare_repo_settings(istate->repo);
+		if (!istate->repo->settings.sparse_index)
+			return 0;
+	}
 
 	if (init_sparse_checkout_patterns(istate))
 		return 0;
diff --git a/sparse-index.h b/sparse-index.h
index 1115a0d7dd9..9f3d7bc7faf 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,8 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-int convert_to_sparse(struct index_state *istate);
+#define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
+int convert_to_sparse(struct index_state *istate, int flags);
 
 /*
  * Some places in the codebase expect to search for a specific path.
-- 
gitgitgadget

