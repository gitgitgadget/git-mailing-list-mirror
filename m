Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8755C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiEPSL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbiEPSLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872ED3D4B2
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r23so5587364wrr.2
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tswqE/E8qRZ38Hi4y4SdPjJbnis3ScsuL3rg7yfjXV0=;
        b=RiVUl0fpv6P+sNglgx4nEA6ga/7GQ7p9CO6HGW7snnxaYHNYAUWk8PxBS6bsqKIgPL
         BKQHQpTIUNb9jzKLFOD8RJcgliiWEZqqWdSGEZ+Qez+1wg26F1pyfe3zvDiGvLmK1Vz0
         sOjIALccqkP7Tg4RWPD52cB2rNX++7/6O459n2Hw2rD0k/HHhfSCvmtN/SUZhNnCJJGM
         AugYTSOxR9J8uO7gZk1VRyp6HN1+pHXnuHgtiuja0bDnQ8IqW+gZ2KLW91hjXlxJxH25
         PXo6x2b0f6B3S15GIf7rnzySeId7tVDzvQURed/jWeC61aTMEFgt+PGd9dPA5jSl8ZSL
         fXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tswqE/E8qRZ38Hi4y4SdPjJbnis3ScsuL3rg7yfjXV0=;
        b=hiQ3Z/uKuyyF2tj9CvBHO99+ar7CzLGDUg0y1CpJDG1BTPSdE5/6w8HpMUVxFgiKEt
         R5H2NiBdeW3oITjjIJPYFRZyQ+bp9mSsOz8NfvJLGYxkp3W/TLurDYNRyoF3sG1J3dF+
         onMBFCIWXDY/7ZT5fV65FYV5R+Ud5Pykind7VqTAXlR5ef6NBjcExNR5/j8MqZRGrmsz
         cEz+v+utyyzJccOGIqAKSRJrHIX86tzuSpkM8MLf6TDDB8uhRpW39zqku/JKpTtRHCNh
         vXuYD5G8PS9v2iCH8AAV93h1GPXWeddnh6zeiVyoRK1Nrf4jGZPWBuQkRtZ0BcoNw5K1
         4rSA==
X-Gm-Message-State: AOAM533Klb9HJx+lP7gazNQe9W9Rbgh1jMQxbEwBriAvvrCjlnAiMCoI
        rTfeKG4qFCJEFWkovKJjH1iUJ4Ft+RA=
X-Google-Smtp-Source: ABdhPJw+X+MQiPrr/wN3G3GHM6M1p0JC2lZeiOQAzdRN6iqtGwUVuhqZxzKttK76ZsPAD+eQRl/OQQ==
X-Received: by 2002:a5d:47af:0:b0:20c:6701:50be with SMTP id 15-20020a5d47af000000b0020c670150bemr15007768wrb.148.1652724697533;
        Mon, 16 May 2022 11:11:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0a5600b003944821105esm14058wmq.2.2022.05.16.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:37 -0700 (PDT)
Message-Id: <d394d0e20e87c0bf7537b27a05f5afce3a84421d.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:27 +0000
Subject: [PATCH 2/8] sparse-index: introduce partially-sparse indexes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A future change will present a temporary, in-memory mode where the index
can both contain sparse directory entries but also not be completely
collapsed to the smallest possible sparse directories. This will be
necessary for modifying the sparse-checkout definition while using a
sparse index.

For now, convert the single-bit member 'sparse_index' in 'struct
index_state' to be a an 'enum sparse_index_mode' with three modes:

* COMPLETELY_FULL (0): No sparse directories exist.

* COMPLETELY_SPARSE (1): Sparse directories may exist. Files outside the
  sparse-checkout cone are reduced to sparse directory entries whenever
  possible.

* PARTIALLY_SPARSE (2): Sparse directories may exist. Some file entries
  outside the sparse-checkout cone may exist. Running
  convert_to_sparse() may further reduce those files to sparse directory
  entries.

The main reason to store this extra information is to allow
convert_to_sparse() to short-circuit when the index is already in
COMPLETELY_SPARSE mode but to actually do the necessary work when in
PARTIALLY_SPARSE mode.

The PARTIALLY_SPARSE mode will be used in an upcoming change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/sparse-checkout.c |  2 +-
 cache.h                   | 32 ++++++++++++++++++++++++--------
 read-cache.c              |  6 +++---
 sparse-index.c            |  6 +++---
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0217d44c5b1..88eea069ad4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -128,7 +128,7 @@ static void clean_tracked_sparse_directories(struct repository *r)
 	 * sparse index will not delete directories that contain
 	 * conflicted entries or submodules.
 	 */
-	if (!r->index->sparse_index) {
+	if (r->index->sparse_index == COMPLETELY_FULL) {
 		/*
 		 * If something, such as a merge conflict or other concern,
 		 * prevents us from converting to a sparse index, then do
diff --git a/cache.h b/cache.h
index 6226f6a8a53..2d067aca2fd 100644
--- a/cache.h
+++ b/cache.h
@@ -310,6 +310,28 @@ struct untracked_cache;
 struct progress;
 struct pattern_list;
 
+enum sparse_index_mode {
+	/*
+	 * COMPLETELY_FULL: there are no sparse directories
+	 * in the index at all.
+	 */
+	COMPLETELY_FULL = 0,
+
+	/*
+	 * COLLAPSED: the index has already been collapsed to sparse
+	 * directories whereever possible.
+	 */
+	COLLAPSED = 1,
+
+	/*
+	 * PARTIALLY_SPARSE: the sparse directories that exist are
+	 * outside the sparse-checkout boundary, but it is possible
+	 * that some file entries could collapse to sparse directory
+	 * entries.
+	 */
+	PARTIALLY_SPARSE = 2,
+};
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -323,14 +345,8 @@ struct index_state {
 		 drop_cache_tree : 1,
 		 updated_workdir : 1,
 		 updated_skipworktree : 1,
-		 fsmonitor_has_run_once : 1,
-
-		 /*
-		  * sparse_index == 1 when sparse-directory
-		  * entries exist. Requires sparse-checkout
-		  * in cone mode.
-		  */
-		 sparse_index : 1;
+		 fsmonitor_has_run_once : 1;
+	enum sparse_index_mode sparse_index;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
diff --git a/read-cache.c b/read-cache.c
index 4df97e185e9..cb9b33169fd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -112,7 +112,7 @@ static const char *alternate_index_output;
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	if (S_ISSPARSEDIR(ce->ce_mode))
-		istate->sparse_index = 1;
+		istate->sparse_index = COLLAPSED;
 
 	istate->cache[nr] = ce;
 	add_name_hash(istate, ce);
@@ -1856,7 +1856,7 @@ static int read_index_extension(struct index_state *istate,
 		break;
 	case CACHE_EXT_SPARSE_DIRECTORIES:
 		/* no content, only an indicator */
-		istate->sparse_index = 1;
+		istate->sparse_index = COLLAPSED;
 		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
@@ -3149,7 +3149,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 				 unsigned flags)
 {
 	int ret;
-	int was_full = !istate->sparse_index;
+	int was_full = istate->sparse_index == COMPLETELY_FULL;
 
 	ret = convert_to_sparse(istate, 0);
 
diff --git a/sparse-index.c b/sparse-index.c
index 37c7df877a6..79e8ff087bc 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -173,7 +173,7 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	 * If the index is already sparse, empty, or otherwise
 	 * cannot be converted to sparse, do not convert.
 	 */
-	if (istate->sparse_index || !istate->cache_nr ||
+	if (istate->sparse_index == COLLAPSED || !istate->cache_nr ||
 	    !is_sparse_index_allowed(istate, flags))
 		return 0;
 
@@ -214,7 +214,7 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	FREE_AND_NULL(istate->fsmonitor_dirty);
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 
-	istate->sparse_index = 1;
+	istate->sparse_index = COLLAPSED;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
 }
@@ -259,7 +259,7 @@ void expand_to_pattern_list(struct index_state *istate,
 	 * If the index is already full, then keep it full. We will convert
 	 * it to a sparse index on write, if possible.
 	 */
-	if (!istate || !istate->sparse_index)
+	if (!istate || istate->sparse_index == COMPLETELY_FULL)
 		return;
 
 	/*
-- 
gitgitgadget

