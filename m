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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AFDC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D826127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhHXVwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhHXVwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE1C0617AE
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z9so33286433wrh.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M+K0Z9WIqh5h1pKa505Bywi5J0nM3YeVcKgYGu5P63g=;
        b=AMYHVr6NQj08noxdS7ORl6QxRGWCBfqJ++ZdkX+i31WK8q9clWjysa1/C5NxTAsN6W
         yAmU4RJAkDk7zYobyDbJlaH72TOzZ59sOsOvchhIxGrtOF+8CbxKN24eMoqhkBKxjItI
         MfQ7xUKu9ztclNY4Mq9TUeebvghh3zRWbw/Z20UmRMtEow7AK98JcXe3GuCrz7HpLzBZ
         S6vA9Qddxg/tLlBoDc33/UqhS2S3YAr6w+OnW3yxVtGcLPVORRdka8pLI5BUkfhNpqnc
         8e33HMJpL4VtDA5DnRxOlNQ4z6elZXJ0D6PnReabje67KkmHbAzB3pagnZRRCjmDRj5V
         UCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M+K0Z9WIqh5h1pKa505Bywi5J0nM3YeVcKgYGu5P63g=;
        b=eUNR7qeTcrLTJRMyRieHJGdcmXu2UG8PmCgrZ252aIU75xG6lGX271Jr445IqMDdDo
         Hki8UX+kTZS2tejizZ6jXlbV2yUm+tOHGn9md4ExTETt0Wf38uc3S7wOMuMEu5Q+K8uS
         IzEoXUpi95yI4FMe2RvKp1BxdINyyLcchJghKwhobohb7+/qCPfDVuQ239EczEaDBXpR
         uYz/dlWrusrL82q3y3GM8K/F+/vchjulajHgUtXIDd12lanPQOhB7+c4cOrZPouXFiPG
         MSxYY5I+z14BTsKnVobld77eZ0Gtl52HFQQQTLSB7Ere2U45CrnV2UuBDf8MuIem9qYb
         PGmw==
X-Gm-Message-State: AOAM533ceCJcgtrj2J2GdJ/wz73Ye8PRjpLNjzDnm8oQaGFbaVZCq9kU
        QsfLvfpv8wZnL1iEm9oP/Zw2/FCD7w0=
X-Google-Smtp-Source: ABdhPJwui8AS9RqXkQaCy487J36LCxhz3v4dHdJKcCZSCivie6jClOTMFozfLoQZOLMWDivAdX8FlQ==
X-Received: by 2002:adf:e604:: with SMTP id p4mr5290708wrm.37.1629841910913;
        Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm3507246wmc.47.2021.08.24.14.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
Message-Id: <cab9360b1e9405e62482e3ccf417a8f8d5b2c7d1.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:42 +0000
Subject: [PATCH v4 08/10] sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
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

