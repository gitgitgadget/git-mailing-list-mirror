Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2326AC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiIVTqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiIVTqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:46:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591EA10B219
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:46:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so11165932wrm.7
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=HeLs2P8mzDXtdUG3l8455qx8bTGSR5MnnunmnhtFFiI=;
        b=Yv/sl19EYD2HjPSXrDyMJPFAEdQVN6sBzXYObme8w87HjO8ajMOsPzVM1HgC29Al3H
         tfdSi/I1IBD8t//mR7It6OjeM1AdnwLzetnANQ4JbSiVWTUEt6hCU7w/lYas/UfGvKJT
         FWuuCLm17O79dXwhgHPylUP45B48EZt7tvo4eC9tukVNDkGYUJ2UxmtHn+JouhB8+N4m
         WvCNexLYXJlm5HWsn3eGg/J6JojejmgW6yD6+N7oN70qoNwVIJVkPFx5uOAxZDaOfSgW
         Q0mxg0n/Mny8STeaBe0ebqOAAx1ZUQmlDI7FhEF+y+ED818IkvgopE4fKnFk5jUpUR6y
         SAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HeLs2P8mzDXtdUG3l8455qx8bTGSR5MnnunmnhtFFiI=;
        b=SV4CUURsVkENcBXwe2wpCQqd3ZJ53NG7Y4siup1e220H89hR4SPM+g0P1+q28STnnf
         l3D8sKzLgePcstJ4wReVfnmXXAash4dF5JC2hErUnzgux/jzxqd1i9toAwibfukBKrwp
         vo621qweVgcpYgwCQYFC+Pa10tnCcQrI4aM9NpjQ4+o8RkGq3GbkRHC2i/E7+fD/P+J+
         +4v3UMZwDZK31DOEVS/QXzdmYQC8XsyD2ZGWkKGXtAJoO/rtge4mqqe7fCyOM16eVkNl
         hkKMKDpJb0Xaommnkiv5mN7eRIT9vOmHBW268dKLQ53SBZku7e3+MLRrTRJXmPEHlQFV
         dbTQ==
X-Gm-Message-State: ACrzQf0xJa3cTnZa1rxN7pHk/sisJfVwglGdiDUU7A1Qh9PoaRDySbUU
        BEB/dKwBfI47PoEM0vfYGu8fYTbzieg=
X-Google-Smtp-Source: AMsMyM7y/2HHK0ewAouVX00Z/lIJVfE7AUrgsPiT6NKQWKFHbwvD4tFna5/JkDXzVwq67qa63t8FGw==
X-Received: by 2002:adf:e10f:0:b0:22a:43e8:969f with SMTP id t15-20020adfe10f000000b0022a43e8969fmr3271353wrz.292.1663876001456;
        Thu, 22 Sep 2022 12:46:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm5720533wrb.38.2022.09.22.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:46:40 -0700 (PDT)
Message-Id: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
References: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 19:46:39 +0000
Subject: [PATCH v3] merge-ort: fix segmentation fault in read-only
 repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

If the blob/tree objects cannot be written, we really need the merge
operations to fail, and not to continue (and then try to access the tree
object which is however still set to `NULL`).

Let's stop ignoring the return value of `write_object_file()` and
`write_tree()` and set `clean = -1` in the error case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    merge-tree: fix segmentation fault in read-only repositories
    
    Turns out that the segmentation fault reported by Taylor
    [https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened
    while testing merge-ort in a read-only repository, and that the upstream
    version of git merge-tree is as affected as GitHub's internal version.
    
    Changes since v2:
    
     * Completely changed the approach by no longer touching
       builtin/merge-tree.c but instead fixing the underlying merge-ort
       layer: we no longer ignore the return value of write_tree() and
       write_object_file().
    
    Changes since v1:
    
     * Using the SANITY prereq now
     * If the merge was aborted due to a write error, exit with a non-zero
       code even if the (potentially partial) merge is clean
     * The test case now also verifies that the git merge-tree command fails
       in a read-only repository even if the merge would have succeeded

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1362%2Fdscho%2Fmerge-tree-in-read-only-repos-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1362/dscho/merge-tree-in-read-only-repos-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1362

Range-diff vs v2:

 1:  1de4df3f471 ! 1:  198ff455f90 merge-tree: fix segmentation fault in read-only repositories
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    merge-tree: fix segmentation fault in read-only repositories
     +    merge-ort: fix segmentation fault in read-only repositories
      
     -    Independent of the question whether we want `git merge-tree` to report
     -    the tree name even when it failed to write the tree objects in a
     -    read-only repository, there is no question that we should avoid a
     -    segmentation fault.
     +    If the blob/tree objects cannot be written, we really need the merge
     +    operations to fail, and not to continue (and then try to access the tree
     +    object which is however still set to `NULL`).
      
     -    And when we report an invalid tree name (because the tree could not be
     -    written), we need the exit status to be non-zero.
     -
     -    Let's make it so.
     +    Let's stop ignoring the return value of `write_object_file()` and
     +    `write_tree()` and set `clean = -1` in the error case.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## builtin/merge-tree.c ##
     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 	struct commit_list *merge_bases = NULL;
     - 	struct merge_options opt;
     - 	struct merge_result result = { 0 };
     -+	const struct object_id *tree_oid;
     - 
     - 	parent1 = get_merge_parent(branch1);
     - 	if (!parent1)
     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 	if (o->show_messages == -1)
     - 		o->show_messages = !result.clean;
     - 
     --	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
     -+	tree_oid = result.tree ? &result.tree->object.oid : null_oid();
     -+	printf("%s%c", oid_to_hex(tree_oid), line_termination);
     - 	if (!result.clean) {
     - 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
     - 		const char *last = NULL;
     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     - 					      &result);
     + ## merge-ort.c ##
     +@@ merge-ort.c: static int tree_entry_order(const void *a_, const void *b_)
     + 				 b->string, strlen(b->string), bmi->result.mode);
     + }
     + 
     +-static void write_tree(struct object_id *result_oid,
     +-		       struct string_list *versions,
     +-		       unsigned int offset,
     +-		       size_t hash_size)
     ++static int write_tree(struct object_id *result_oid,
     ++		      struct string_list *versions,
     ++		      unsigned int offset,
     ++		      size_t hash_size)
     + {
     + 	size_t maxlen = 0, extra;
     + 	unsigned int nr;
     + 	struct strbuf buf = STRBUF_INIT;
     +-	int i;
     ++	int i, ret;
     + 
     + 	assert(offset <= versions->nr);
     + 	nr = versions->nr - offset;
     +@@ merge-ort.c: static void write_tree(struct object_id *result_oid,
     + 	}
     + 
     + 	/* Write this object file out, and record in result_oid */
     +-	write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
     ++	ret = write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
     + 	strbuf_release(&buf);
     ++	return ret;
     + }
     + 
     + static void record_entry_for_tree(struct directory_versions *dir_metadata,
     +@@ merge-ort.c: static void record_entry_for_tree(struct directory_versions *dir_metadata,
     + 			   basename)->util = &mi->result;
     + }
     + 
     +-static void write_completed_directory(struct merge_options *opt,
     +-				      const char *new_directory_name,
     +-				      struct directory_versions *info)
     ++static int write_completed_directory(struct merge_options *opt,
     ++				     const char *new_directory_name,
     ++				     struct directory_versions *info)
     + {
     + 	const char *prev_dir;
     + 	struct merged_info *dir_info = NULL;
     +-	unsigned int offset;
     ++	unsigned int offset, ret = 0;
     + 
     + 	/*
     + 	 * Some explanation of info->versions and info->offsets...
     +@@ merge-ort.c: static void write_completed_directory(struct merge_options *opt,
     + 	 * strcmp here.)
     + 	 */
     + 	if (new_directory_name == info->last_directory)
     +-		return;
     ++		return 0;
     + 
     + 	/*
     + 	 * If we are just starting (last_directory is NULL), or last_directory
     +@@ merge-ort.c: static void write_completed_directory(struct merge_options *opt,
     + 		 */
     + 		string_list_append(&info->offsets,
     + 				   info->last_directory)->util = (void*)offset;
     +-		return;
     ++		return 0;
     + 	}
     + 
     + 	/*
     +@@ merge-ort.c: static void write_completed_directory(struct merge_options *opt,
     + 		 */
     + 		dir_info->is_null = 0;
     + 		dir_info->result.mode = S_IFDIR;
     +-		write_tree(&dir_info->result.oid, &info->versions, offset,
     +-			   opt->repo->hash_algo->rawsz);
     ++		if (write_tree(&dir_info->result.oid, &info->versions, offset,
     ++			       opt->repo->hash_algo->rawsz) < 0)
     ++			ret = -1;
     + 	}
     + 
     + 	/*
     +@@ merge-ort.c: static void write_completed_directory(struct merge_options *opt,
     + 	/* And, of course, we need to update last_directory to match. */
     + 	info->last_directory = new_directory_name;
     + 	info->last_directory_len = strlen(info->last_directory);
     ++
     ++	return ret;
     + }
     + 
     + /* Per entry merge function */
     +@@ merge-ort.c: static void prefetch_for_content_merges(struct merge_options *opt,
     + 	oid_array_clear(&to_fetch);
     + }
     + 
     +-static void process_entries(struct merge_options *opt,
     +-			    struct object_id *result_oid)
     ++static int process_entries(struct merge_options *opt,
     ++			   struct object_id *result_oid)
     + {
     + 	struct hashmap_iter iter;
     + 	struct strmap_entry *e;
     +@@ merge-ort.c: static void process_entries(struct merge_options *opt,
     + 	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
     + 						   STRING_LIST_INIT_NODUP,
     + 						   NULL, 0 };
     ++	int ret;
     + 
     + 	trace2_region_enter("merge", "process_entries setup", opt->repo);
     + 	if (strmap_empty(&opt->priv->paths)) {
     + 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
     +-		return;
     ++		return 0;
       	}
     - 	merge_finalize(&opt, &result);
     --	return !result.clean; /* result.clean < 0 handled above */
     -+	return !result.tree || !result.clean; /* result.clean < 0 handled above */
     + 
     + 	/* Hack to pre-allocate plist to the desired size */
     +@@ merge-ort.c: static void process_entries(struct merge_options *opt,
     + 		 */
     + 		struct merged_info *mi = entry->util;
     + 
     +-		write_completed_directory(opt, mi->directory_name,
     +-					  &dir_metadata);
     ++		if (write_completed_directory(opt, mi->directory_name,
     ++					      &dir_metadata) < 0) {
     ++			ret = -1;
     ++			goto cleanup;
     ++		}
     + 		if (mi->clean)
     + 			record_entry_for_tree(&dir_metadata, path, mi);
     + 		else {
     +@@ merge-ort.c: static void process_entries(struct merge_options *opt,
     + 		fflush(stdout);
     + 		BUG("dir_metadata accounting completely off; shouldn't happen");
     + 	}
     +-	write_tree(result_oid, &dir_metadata.versions, 0,
     +-		   opt->repo->hash_algo->rawsz);
     ++	ret = write_tree(result_oid, &dir_metadata.versions, 0,
     ++			 opt->repo->hash_algo->rawsz);
     ++cleanup:
     + 	string_list_clear(&plist, 0);
     + 	string_list_clear(&dir_metadata.versions, 0);
     + 	string_list_clear(&dir_metadata.offsets, 0);
     + 	trace2_region_leave("merge", "process_entries cleanup", opt->repo);
     ++
     ++	return ret;
       }
       
     - int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + /*** Function Grouping: functions related to merge_switch_to_result() ***/
     +@@ merge-ort.c: redo:
     + 	}
     + 
     + 	trace2_region_enter("merge", "process_entries", opt->repo);
     +-	process_entries(opt, &working_tree_oid);
     ++	if (process_entries(opt, &working_tree_oid) < 0)
     ++		result->clean = -1;
     + 	trace2_region_leave("merge", "process_entries", opt->repo);
     + 
     + 	/* Set return values */
     + 	result->path_messages = &opt->priv->conflicts;
     + 
     +-	result->tree = parse_tree_indirect(&working_tree_oid);
     +-	/* existence of conflicted entries implies unclean */
     +-	result->clean &= strmap_empty(&opt->priv->conflicted);
     ++	if (result->clean >= 0) {
     ++		result->tree = parse_tree_indirect(&working_tree_oid);
     ++		/* existence of conflicted entries implies unclean */
     ++		result->clean &= strmap_empty(&opt->priv->conflicted);
     ++	}
     + 	if (!opt->priv->call_depth) {
     + 		result->priv = opt->priv;
     + 		result->_properly_initialized = RESULT_INITIALIZED;
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'can override merge of unrelated histories' '


 merge-ort.c                      | 64 +++++++++++++++++++-------------
 t/t4301-merge-tree-write-tree.sh |  9 +++++
 2 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 99dcee2db8a..f654296220e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3571,15 +3571,15 @@ static int tree_entry_order(const void *a_, const void *b_)
 				 b->string, strlen(b->string), bmi->result.mode);
 }
 
-static void write_tree(struct object_id *result_oid,
-		       struct string_list *versions,
-		       unsigned int offset,
-		       size_t hash_size)
+static int write_tree(struct object_id *result_oid,
+		      struct string_list *versions,
+		      unsigned int offset,
+		      size_t hash_size)
 {
 	size_t maxlen = 0, extra;
 	unsigned int nr;
 	struct strbuf buf = STRBUF_INIT;
-	int i;
+	int i, ret;
 
 	assert(offset <= versions->nr);
 	nr = versions->nr - offset;
@@ -3605,8 +3605,9 @@ static void write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
+	ret = write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
 	strbuf_release(&buf);
+	return ret;
 }
 
 static void record_entry_for_tree(struct directory_versions *dir_metadata,
@@ -3625,13 +3626,13 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
 			   basename)->util = &mi->result;
 }
 
-static void write_completed_directory(struct merge_options *opt,
-				      const char *new_directory_name,
-				      struct directory_versions *info)
+static int write_completed_directory(struct merge_options *opt,
+				     const char *new_directory_name,
+				     struct directory_versions *info)
 {
 	const char *prev_dir;
 	struct merged_info *dir_info = NULL;
-	unsigned int offset;
+	unsigned int offset, ret = 0;
 
 	/*
 	 * Some explanation of info->versions and info->offsets...
@@ -3717,7 +3718,7 @@ static void write_completed_directory(struct merge_options *opt,
 	 * strcmp here.)
 	 */
 	if (new_directory_name == info->last_directory)
-		return;
+		return 0;
 
 	/*
 	 * If we are just starting (last_directory is NULL), or last_directory
@@ -3739,7 +3740,7 @@ static void write_completed_directory(struct merge_options *opt,
 		 */
 		string_list_append(&info->offsets,
 				   info->last_directory)->util = (void*)offset;
-		return;
+		return 0;
 	}
 
 	/*
@@ -3769,8 +3770,9 @@ static void write_completed_directory(struct merge_options *opt,
 		 */
 		dir_info->is_null = 0;
 		dir_info->result.mode = S_IFDIR;
-		write_tree(&dir_info->result.oid, &info->versions, offset,
-			   opt->repo->hash_algo->rawsz);
+		if (write_tree(&dir_info->result.oid, &info->versions, offset,
+			       opt->repo->hash_algo->rawsz) < 0)
+			ret = -1;
 	}
 
 	/*
@@ -3798,6 +3800,8 @@ static void write_completed_directory(struct merge_options *opt,
 	/* And, of course, we need to update last_directory to match. */
 	info->last_directory = new_directory_name;
 	info->last_directory_len = strlen(info->last_directory);
+
+	return ret;
 }
 
 /* Per entry merge function */
@@ -4214,8 +4218,8 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	oid_array_clear(&to_fetch);
 }
 
-static void process_entries(struct merge_options *opt,
-			    struct object_id *result_oid)
+static int process_entries(struct merge_options *opt,
+			   struct object_id *result_oid)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
@@ -4224,11 +4228,12 @@ static void process_entries(struct merge_options *opt,
 	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
 						   STRING_LIST_INIT_NODUP,
 						   NULL, 0 };
+	int ret;
 
 	trace2_region_enter("merge", "process_entries setup", opt->repo);
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
-		return;
+		return 0;
 	}
 
 	/* Hack to pre-allocate plist to the desired size */
@@ -4270,8 +4275,11 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct merged_info *mi = entry->util;
 
-		write_completed_directory(opt, mi->directory_name,
-					  &dir_metadata);
+		if (write_completed_directory(opt, mi->directory_name,
+					      &dir_metadata) < 0) {
+			ret = -1;
+			goto cleanup;
+		}
 		if (mi->clean)
 			record_entry_for_tree(&dir_metadata, path, mi);
 		else {
@@ -4291,12 +4299,15 @@ static void process_entries(struct merge_options *opt,
 		fflush(stdout);
 		BUG("dir_metadata accounting completely off; shouldn't happen");
 	}
-	write_tree(result_oid, &dir_metadata.versions, 0,
-		   opt->repo->hash_algo->rawsz);
+	ret = write_tree(result_oid, &dir_metadata.versions, 0,
+			 opt->repo->hash_algo->rawsz);
+cleanup:
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
 	string_list_clear(&dir_metadata.offsets, 0);
 	trace2_region_leave("merge", "process_entries cleanup", opt->repo);
+
+	return ret;
 }
 
 /*** Function Grouping: functions related to merge_switch_to_result() ***/
@@ -4928,15 +4939,18 @@ redo:
 	}
 
 	trace2_region_enter("merge", "process_entries", opt->repo);
-	process_entries(opt, &working_tree_oid);
+	if (process_entries(opt, &working_tree_oid) < 0)
+		result->clean = -1;
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
 	result->path_messages = &opt->priv->conflicts;
 
-	result->tree = parse_tree_indirect(&working_tree_oid);
-	/* existence of conflicted entries implies unclean */
-	result->clean &= strmap_empty(&opt->priv->conflicted);
+	if (result->clean >= 0) {
+		result->tree = parse_tree_indirect(&working_tree_oid);
+		/* existence of conflicted entries implies unclean */
+		result->clean &= strmap_empty(&opt->priv->conflicted);
+	}
 	if (!opt->priv->call_depth) {
 		result->priv = opt->priv;
 		result->_properly_initialized = RESULT_INITIALIZED;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 28ca5c38bb5..013b77144bd 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -810,4 +810,13 @@ test_expect_success 'can override merge of unrelated histories' '
 	test_cmp expect actual
 '
 
+test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository' '
+	git init --bare read-only &&
+	git push read-only side1 side2 side3 &&
+	test_when_finished "chmod -R u+w read-only" &&
+	chmod -R a-w read-only &&
+	test_must_fail git -C read-only merge-tree side1 side3 &&
+	test_must_fail git -C read-only merge-tree side1 side2
+'
+
 test_done

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
gitgitgadget
