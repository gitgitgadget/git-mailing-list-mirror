Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2D3C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiESRxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiESRx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D36E91
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so8292613wrc.0
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U/b7p4PaQXRYi92J/Vf1N8AIaihhQJSBvxJIqADio1c=;
        b=FLLZp/50kxDbAL/ENRKjAMhOY8JfTpRz+75EsRu4iYsixAQaONTD8SQl6AYeXsGN7n
         SlVCEysKTtakStm63IydNspJFK2sKYX8utbrWJH0T1GXFXEdJ5xiYtVNzFzHfmewIoT9
         CBifbnGx0O4vrY8x06Zhebj4v8PLVrffvsTvdy0IRzw0QTlOoiuBRwl9lIbLDKd3PE3H
         YwVCL3jFai0FXJvC6NvJ7xfBxFRk2HXQwu7oFonFzqQLKUabivtCBMlBWZLd3m02me7L
         ClmvLeDF3vGtXBeuI2oDo4gFydi8XtCp2ZFmaORHmly9shAM1OGyl8RWT9VnT4tJPvCX
         S2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U/b7p4PaQXRYi92J/Vf1N8AIaihhQJSBvxJIqADio1c=;
        b=26mNS99mUcppSsLafwy91YUxDFfrisXKpQx4ErhizfTESwvgb9eErbnUsaJQ7C8w1C
         zPSzzbh3dy1fex/u4VBKjhZ3EZztY0kkZc0aPQsxSYzpUzopgJ3IHjY0nk0VETMER4mV
         LLC0L41xIiX03lBy4fn3lwSji3bkE7yR33UBThlPmhH8fiDIjSKz2QFfjVXB4cQ+eqTP
         OCvYnpGT1BG34eYNntnu/OsGIisBXXkD0COV0+oQLxd7TZQWsw6r8JyaAsmLJMuc2XZR
         ma1PkOOZIEtMi9Ig1ljsaT3PCTPQcznlg9kCgCU4f3eYLIt5JL74fQ64ekOd1uude14v
         gdfw==
X-Gm-Message-State: AOAM5339HCfjNCo4+TGt6c+uIAkSTHfH1Dw584tNwrRVz1hEdM0/btct
        M9QRyEIsMgsagR+LU8mMnc+sZWmAgo8=
X-Google-Smtp-Source: ABdhPJw8qs2kuK6V30JNDPU3jd1/Z4iz5kDTk0tzJKqO5IJrgaJHlwaCGNC3jqIbavwEK9r3UKqepg==
X-Received: by 2002:adf:fb90:0:b0:20c:62bd:652d with SMTP id a16-20020adffb90000000b0020c62bd652dmr5234094wrr.402.1652982764940;
        Thu, 19 May 2022 10:52:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020adfba4b000000b0020c6fa5a797sm195276wrg.91.2022.05.19.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:44 -0700 (PDT)
Message-Id: <269c206c331bb43006678beaa20832a75754c3df.1652982758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:32 +0000
Subject: [PATCH v2 04/10] sparse-index: introduce partially-sparse indexes
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
index 2a06ef58051..c2cd3bdb614 100644
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

