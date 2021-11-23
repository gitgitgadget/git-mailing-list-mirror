Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567EFC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhKWAXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhKWAXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:23:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F68C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u18so35796403wrg.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EhqpCoJT+8YeldSMIWB/k40BGZlaaKWhf6LrVKaEhLE=;
        b=Qssq+kVurMIvgVQMywJZeD/jP0JqPDlfu0bRUxRYccnCUJVioH2xKU9TCPzPSqzp0I
         Dz/uvfr2RjAmSdIOjJYC040ZqFuGBHGkQmNDF+JOdgqV9BiV9HRWJBwhCv9fb5w7AvGi
         YtNPA7LV7pA1IGIbCg/YmYX8JMva+/shnjBAy7ukCX3GavIEO3QdE/C68oXRni/Mmeji
         Yib5M7pXGEzCHM4uA3ncUBAZAthGQH9U4FE/MFqqkHeDxz36ZkDlbth2l+EEgY+liHtf
         8c9klpbPgfPAJgSiGVWY+8RdVtm7OISFGb2L4DvuMpWTkmkw7CXxzppCDrHq4YJZkBl+
         5dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EhqpCoJT+8YeldSMIWB/k40BGZlaaKWhf6LrVKaEhLE=;
        b=Ix6TvfwQ73oUrybYUB+tHbyMAyw8l2ajibHa7N2jUYMbr+EJ0AXTiIkWtJs5O7SZPm
         kRnOb0q1f8R/T0I41aIygyhZXAkSrRRw5KI15mUXVuSCtokG0sXpzHKfM0JE8B4/hDzF
         YHi8sc9FTk13Fq/h6+733Or5kJdWx17lx452dxdCYOLQQmW9ylgVc1+vz0Fq0TcGeIOx
         WcMAbkAASATxHrSJF8uKyqCUzW0wKe35DhTU1GIfmygkK0m6qDuRbGFQtakGBqwOB+yv
         45PiRVmAZdKWUuGbzz81J/Rk2xbrPVJrGA91YWQSwWnEuqbiRORD8ZuQLArIAsZIRxk2
         083w==
X-Gm-Message-State: AOAM532p0PYJd09cT1ahwWTwnYgI8Q4mdzx4HEymYU0IlSwPueicITjv
        cR+9VQdbIAy9An0d2Jm5fJKMuO9Zgt4=
X-Google-Smtp-Source: ABdhPJz9n/QjtCkw7FV4m4hqgQAOSdWVy7jc9ngmqwOf350rAJD54JF5/Q2xnKlD8jGxfoZod4aUIg==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr1765030wrm.299.1637626836924;
        Mon, 22 Nov 2021 16:20:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm9988162wmp.34.2021.11.22.16.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:20:36 -0800 (PST)
Message-Id: <d2133ca1724258be01d7d2c3ac4888cd67eb3642.1637626833.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
References: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
        <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 00:20:32 +0000
Subject: [PATCH v5 3/4] sparse-index: add ensure_correct_sparsity function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

The `ensure_correct_sparsity` function is intended to provide a means of
aligning the in-core index with the sparsity required by the repository
settings and other properties of the index. The function first checks
whether a sparse index is allowed (per repository & sparse checkout pattern
settings). If the sparse index may be used, the index is converted to
sparse; otherwise, it is explicitly expanded with `ensure_full_index`.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 33 +++++++++++++++++++++++++++++----
 sparse-index.h |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 85613cd8a3a..a1d505d50e9 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -122,17 +122,17 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-int convert_to_sparse(struct index_state *istate, int flags)
+static int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	int test_env;
-	if (istate->sparse_index || !istate->cache_nr ||
-	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!istate->repo)
 		istate->repo = the_repository;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
+		int test_env;
+
 		/*
 		 * The sparse index is not (yet) integrated with a split index.
 		 */
@@ -168,6 +168,19 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (!istate->sparse_checkout_patterns->use_cone_patterns)
 		return 0;
 
+	return 1;
+}
+
+int convert_to_sparse(struct index_state *istate, int flags)
+{
+	/*
+	 * If the index is already sparse, empty, or otherwise
+	 * cannot be converted to sparse, do not convert.
+	 */
+	if (istate->sparse_index || !istate->cache_nr ||
+	    !is_sparse_index_allowed(istate, flags))
+		return 0;
+
 	/*
 	 * NEEDSWORK: If we have unmerged entries, then stay full.
 	 * Unmerged entries prevent the cache-tree extension from working.
@@ -316,6 +329,18 @@ void ensure_full_index(struct index_state *istate)
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
 
+void ensure_correct_sparsity(struct index_state *istate)
+{
+	/*
+	 * If the index can be sparse, make it sparse. Otherwise,
+	 * ensure the index is full.
+	 */
+	if (is_sparse_index_allowed(istate, 0))
+		convert_to_sparse(istate, 0);
+	else
+		ensure_full_index(istate);
+}
+
 /*
  * This static global helps avoid infinite recursion between
  * expand_to_path() and index_file_exists().
diff --git a/sparse-index.h b/sparse-index.h
index 9f3d7bc7faf..656bd835b25 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -4,6 +4,7 @@
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
 int convert_to_sparse(struct index_state *istate, int flags);
+void ensure_correct_sparsity(struct index_state *istate);
 
 /*
  * Some places in the codebase expect to search for a specific path.
-- 
gitgitgadget

