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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99864C432BE
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8410F6052B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhG3LsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbhG3LsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:48:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C2C06179B
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c16so10928974wrp.13
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x597iJhFZtqHN/owTNr70zLbjS3o+LrLy4Fac+UnZeU=;
        b=NVQ9bjTr7/cc8DFbpyr8nlSKreadW8a4/2NUadbeukD6X8d7eZxldzamHX8k7FWEfB
         LQladRyFql9R14o6dm22KamdwdDAxIhM1H/zKl37AqaqRlPTHlgAF05odUrPwsqxI+bV
         OsQakJ5BMU7k7I8MPDW1jN+0ADBBXLJMkr2a4sTKaAen9TdXUUU/vJJKq5Ux3PMH3Inf
         HXODGwNUnztX8Vxd5UPRDWm9nsvewBP/xk+QSlZ436RyEcb2ZnJDPvPyT3vrPZpQJqTn
         4AYBvnOQwToXnF3liRIIUtgB/77wQrUWbZfdJ3vkktq1tD50rAktPP+lmRGBda7fipkN
         h/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x597iJhFZtqHN/owTNr70zLbjS3o+LrLy4Fac+UnZeU=;
        b=PkaqiEnpo79pTXd8mPiMu0/W5PxrUMFsdWHA9cy4YAR5Pl6hO53ax2rb3wUz5P6JCX
         g3S9SwqoXBUAB6VeOXMkiWIO8eBNlXAicaND0DAvHne3pfzPLb5KufMFiH2vmG7sqEZB
         mJKjWraz2ptS1G2N1aB9ryoa+zqGQ+rJyMVwLJZR/HvczsMOQQ1kFofuMfI6AyEolNRP
         8ceSXtNFWRv9CpT05icgGaE4cwIiyVj12XhI3UAXrF0QNtczENhTpG6V5aVYacvihcy3
         M5SsoBhGuxbCNR1OF3Sjj+WNu/uzxwySLAmnefneNWij8JmRAdzrxv93rXg8vxlngvnT
         pGfg==
X-Gm-Message-State: AOAM5320Ocgz0GhtuM1wtDmkBb0jE0yIdQwmSCTkzVWWIK9M9leslwQL
        JRgNEgO+Si3mI83EDa81+VePLUmRpuY=
X-Google-Smtp-Source: ABdhPJzFUbscPqaT03LBIipC6WvL9vWZBiKfjCcdtRphzKdWwCHBSpOx2f+fGBVwAqjROa3hXMCiJQ==
X-Received: by 2002:adf:b1c5:: with SMTP id r5mr2684132wra.146.1627645672775;
        Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm1377736wre.83.2021.07.30.04.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
Message-Id: <de30dbac25e78e5ad81053b60c3ec2ab6256fde2.1627645665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:44 +0000
Subject: [PATCH v3 9/9] merge-ort: remove compile-time ability to turn off
 usage of memory pools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Simplify code maintenance a bit by removing the ability to toggle
between usage of memory pools and direct allocations.  This allows us to
also remove and simplify some auxiliary functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 63 +++++++++++++----------------------------------------
 1 file changed, 15 insertions(+), 48 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 86ab8f60121..63829f5cace 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -37,8 +37,6 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
-#define USE_MEMORY_POOL 1 /* faster, but obscures memory leak hunting */
-
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
  * indices refer to one of the sides of the three-way merge.  This is so
@@ -623,11 +621,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
-#if USE_MEMORY_POOL
 	mem_pool_discard(&opti->internal_pool, 0);
 	if (!reinitialize)
 		opti->pool = NULL;
-#endif
 
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
@@ -693,12 +689,10 @@ static void path_msg(struct merge_options *opt,
 static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
 						 const char *path)
 {
+	/* Similar to alloc_filespec(), but allocate from pool and reuse path */
 	struct diff_filespec *spec;
 
-	if (!pool)
-		return alloc_filespec(path);
-
-	/* Similar to alloc_filespec, but allocate from pool and reuse path */
+	assert(pool != NULL);
 	spec = mem_pool_calloc(pool, 1, sizeof(*spec));
 	spec->path = (char*)path; /* spec won't modify it */
 
@@ -712,12 +706,10 @@ static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
 					     struct diff_filespec *one,
 					     struct diff_filespec *two)
 {
+	/* Same code as diff_queue(), except allocate from pool */
 	struct diff_filepair *dp;
 
-	if (!pool)
-		return diff_queue(queue, one, two);
-
-	/* Same code as diff_queue, except allocate from pool */
+	assert(pool != NULL);
 	dp = mem_pool_calloc(pool, 1, sizeof(*dp));
 	dp->one = one;
 	dp->two = two;
@@ -726,27 +718,6 @@ static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
 	return dp;
 }
 
-static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
-{
-	if (!pool)
-		return xcalloc(count, size);
-	return mem_pool_calloc(pool, count, size);
-}
-
-static void *pool_alloc(struct mem_pool *pool, size_t size)
-{
-	if (!pool)
-		return xmalloc(size);
-	return mem_pool_alloc(pool, size);
-}
-
-static void *pool_strndup(struct mem_pool *pool, const char *str, size_t len)
-{
-	if (!pool)
-		return xstrndup(str, len);
-	return mem_pool_strndup(pool, str, len);
-}
-
 /* add a string to a strbuf, but converting "/" to "_" */
 static void add_flattened_path(struct strbuf *out, const char *s)
 {
@@ -875,9 +846,9 @@ static void setup_path_info(struct merge_options *opt,
 	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
 	assert(resolved == (merged_version != NULL));
 
-	mi = pool_calloc(opt->priv->pool, 1,
-			 resolved ? sizeof(struct merged_info) :
-				    sizeof(struct conflict_info));
+	mi = mem_pool_calloc(opt->priv->pool, 1,
+			     resolved ? sizeof(struct merged_info) :
+					sizeof(struct conflict_info));
 	mi->directory_name = current_dir_name;
 	mi->basename_offset = current_dir_name_len;
 	mi->clean = !!resolved;
@@ -1170,7 +1141,7 @@ static int collect_merge_info_callback(int n,
 	len = traverse_path_len(info, p->pathlen);
 
 	/* +1 in both of the following lines to include the NUL byte */
-	fullpath = pool_alloc(opt->priv->pool, len + 1);
+	fullpath = mem_pool_alloc(opt->priv->pool, len + 1);
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
 	/*
@@ -2389,9 +2360,9 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		/* Find the parent directory of cur_path */
 		char *last_slash = strrchr(cur_path, '/');
 		if (last_slash) {
-			parent_name = pool_strndup(opt->priv->pool,
-						   cur_path,
-						   last_slash - cur_path);
+			parent_name = mem_pool_strndup(opt->priv->pool,
+						       cur_path,
+						       last_slash - cur_path);
 		} else {
 			parent_name = opt->priv->toplevel_dir;
 			break;
@@ -3701,7 +3672,7 @@ static void process_entry(struct merge_options *opt,
 		 * the directory to remain here, so we need to move this
 		 * path to some new location.
 		 */
-		new_ci = pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
+		new_ci = mem_pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
 
 		/* We don't really want new_ci->merged.result copied, but it'll
 		 * be overwritten below so it doesn't matter.  We also don't
@@ -3794,7 +3765,8 @@ static void process_entry(struct merge_options *opt,
 			const char *a_path = NULL, *b_path = NULL;
 			int rename_a = 0, rename_b = 0;
 
-			new_ci = pool_alloc(opt->priv->pool, sizeof(*new_ci));
+			new_ci = mem_pool_alloc(opt->priv->pool,
+						sizeof(*new_ci));
 
 			if (S_ISREG(a_mode))
 				rename_a = 1;
@@ -4482,13 +4454,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	/* Initialization of various renames fields */
 	renames = &opt->priv->renames;
-#if USE_MEMORY_POOL
 	mem_pool_init(&opt->priv->internal_pool, 0);
-	opt->priv->pool = &opt->priv->internal_pool;
-#else
-	opt->priv->pool = NULL;
-#endif
-	pool = opt->priv->pool;
+	pool = opt->priv->pool = &opt->priv->internal_pool;
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->dirs_removed[i],
 					    NOT_RELEVANT, pool, 0);
-- 
gitgitgadget
