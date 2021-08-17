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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E39C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B85A60FBF
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhHQNYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbhHQNYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0FC06124A
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u1so13753598wmm.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=siV5lRTXPuRg8PtQx00TLBS2bGCepL9AAAoIBksPutM=;
        b=r7qG2+jCE6fi5NrT28r21iQx9BO623i5vg4QEGlbY/SJlOGIp+kA44ld8SHf2sq0x8
         UpehA5MOBxqrxuPPaCfAV67msIU46culUkx25Mb+MS5z3bnIQba+Xr2M/wwTMQQVzszp
         2aO8/y0A33VVGlKd0cpLDKB9T7sjO5Avqv+rI5AjlP3cVmuafHoAHq2UElacrKjFsrW6
         J/fiQBljZXSBVgxUPoDTinSPy6d4qUPWAh55bQQWrcG4UxsgkibvVjpzHwkhsllsUyp4
         hMw+pbGZbdCgp6fjU6lKtUd2v1Zo/fPkrv/+ba4lw/CnDqSqdDkvSD/kE0gdMoaOhqBr
         JYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=siV5lRTXPuRg8PtQx00TLBS2bGCepL9AAAoIBksPutM=;
        b=gc9JYnfQIrJ3lQBIvZSYA0q4ZCtSKNKKT5oOatNEr+l0qfP5IswLgTw1ZnQmPXM1pC
         NTJr6sqh0JtGTXY9RYT714AUUAUJp/ZW0x5S5A07pNWo/QcIvgm7VK85QGBQJjmienuv
         FGT8QqKD/PsyNNvSNUoR/Cosj8rPtDxt4SLn8xIluy6XWNv7ruLmd2rts70WKoGMX1A/
         Lw1aSNR4xHjazZCl+t+4W+qGgIT7hyczjwWt9D4EcRaLpco5B/PTWSkVuoK1HkngySi8
         5h2Cwv+54oma1X3Ge27/trJXTWmfg+T6lYalMwq0a8mIswrk4EdYyOf/PoNK7uXyXBoK
         7+Gg==
X-Gm-Message-State: AOAM531XqRpd+2e5n4ptCXykweyKht767lfOt1BwZ0f/CC26VG9c+q1O
        ull5neu6FNqUmAdIVD5jCPyv1G8e3+A=
X-Google-Smtp-Source: ABdhPJw97CTy86xu6BKDNOUf4uhgK9Ef8fXjRXn49nU73stKiHvYYnromqvcyofWiojxuAHqehMyYQ==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr380985wmf.145.1629206612344;
        Tue, 17 Aug 2021 06:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm2591408wrv.65.2021.08.17.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:31 -0700 (PDT)
Message-Id: <b0ece4b7dccf0cbe0477b3a6d238ea1362aed24d.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:21 +0000
Subject: [PATCH v3 7/8] sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

To that end, create the SPARSE_INDEX_IGNORE_CONFIG flag that will skip
these config checks when enabled. All current consumers are modified to
pass '0' in the new 'flags' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c   |  4 ++--
 sparse-index.c | 30 ++++++++++++++++--------------
 sparse-index.h |  3 ++-
 3 files changed, 20 insertions(+), 17 deletions(-)

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
index 2efc9fd4910..532fd11787e 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -124,7 +124,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-int convert_to_sparse(struct index_state *istate)
+int convert_to_sparse(struct index_state *istate, int flags)
 {
 	int test_env;
 
@@ -135,20 +135,22 @@ int convert_to_sparse(struct index_state *istate)
 	if (!istate->repo)
 		istate->repo = the_repository;
 
-	/*
-	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
-	 * index.sparse config variable to be on.
-	 */
-	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
-	if (test_env >= 0)
-		set_sparse_index_config(istate->repo, test_env);
+	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
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
 
 	if (init_sparse_checkout_patterns(istate) < 0)
 		return 0;
diff --git a/sparse-index.h b/sparse-index.h
index 1115a0d7dd9..475f4f0f8da 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,8 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-int convert_to_sparse(struct index_state *istate);
+#define SPARSE_INDEX_IGNORE_CONFIG (1 << 0)
+int convert_to_sparse(struct index_state *istate, int flags);
 
 /*
  * Some places in the codebase expect to search for a specific path.
-- 
gitgitgadget

