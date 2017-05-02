Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6002207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbdEBWYg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:36 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36128 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdEBWXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:49 -0400
Received: by mail-pg0-f49.google.com with SMTP id t7so67988544pgt.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GihA67VxdIX1wf6f/v791TvK/GaXR2URjcd5xGVfjc8=;
        b=mjVdWq9iWZ99z9mniPMsmVgG4OA8sKk9vvtxKoncBGc0W6EfV4dEpB67JjiIAd0jVe
         FM2QFZyETF02nlNymLKzsKxHAx2qU592IfZzDlpQe9aUZSXlhmJR6luF3MFFZOERr2wC
         fC7xlHSiM+hxLEWQLErmzqvmwe0Hho5QNdXB+CnpK74n5svMM7WI9N33jGwqQc0fjbAQ
         L0qehEkFk/IdNc+CryVzEz6nNoTz0v3fiF93TvReUTYyxAV+PmPgCRhnKjW0UeQxHUP1
         RLgmnTGAuG/JEoFWkaKQ9Avna6Dzk23JC+Zt+tj2YmTVGyLeWkwr/nMIQx1jzzEgZT3H
         l5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GihA67VxdIX1wf6f/v791TvK/GaXR2URjcd5xGVfjc8=;
        b=arVNfjiiLWDdPBteBVzD5U/w+NYtW+6ABX57NMp8PA3sr7SMZfN5DOvVv0YMqeD3VY
         BPxCK+hqK3dwEBHjkcdztvTbX/AM9106CuazLrRLM6PpLM7R8OyS1+/6dgETD43NlrJc
         QpnkiPOEkCJt2Wuc7RmQaNYR2biArn02+0/ZwPK4EToO5s0zh8JTaAkrhS9WwBcUhFnK
         5SlQCmOoiGToaWhKBm4vbhSgFsZppQmSY2yuBlIrtnteRdimi3Y/3Jtd1C+gZDMkFjJG
         Ru+ws8++rG/xzA+WguSt28gtxLklCfADNRtXbUsV+PnwON+CyHjHSmB+fDY1NYdJTRXU
         XFEg==
X-Gm-Message-State: AN3rC/68Y9kWefDRTwMVlsA/UHe0NGA5r5BuZh7UaNaN1DXJ9mnPap1R
        eRWpRPlC5EoGDGIj
X-Received: by 10.84.224.206 with SMTP id k14mr15637576pln.162.1493763829025;
        Tue, 02 May 2017 15:23:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id 194sm4699072pgf.62.2017.05.02.15.23.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/24] cache.h: drop remove_file_from_cache
Date:   Tue,  2 May 2017 15:23:15 -0700
Message-Id: <20170502222322.21055-18-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression path; @@
-remove_file_from_cache(path)
+remove_file_from_index(&the_index, path)

Additionally drop the define from cache.h manually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                |  4 ++--
 builtin/commit.c       |  2 +-
 builtin/reset.c        |  2 +-
 builtin/rm.c           |  2 +-
 builtin/update-index.c | 10 +++++-----
 cache.h                |  1 -
 merge-recursive.c      | 16 ++++++++--------
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/apply.c b/apply.c
index 66d4969e72..8a61f19d03 100644
--- a/apply.c
+++ b/apply.c
@@ -4230,7 +4230,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
  static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
  {
 	 if (state->update_index) {
-		 if (remove_file_from_cache(patch->old_name) < 0)
+		 if (remove_file_from_index(&the_index, patch->old_name) < 0)
 			 return error(_("unable to remove %s from index"), patch->old_name);
 	 }
 	 if (!state->cached) {
@@ -4418,7 +4418,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
 
-	remove_file_from_cache(patch->new_name);
+	remove_file_from_index(&the_index, patch->new_name);
 	for (stage = 1; stage < 4; stage++) {
 		if (is_null_oid(&patch->threeway_stage[stage - 1]))
 			continue;
diff --git a/builtin/commit.c b/builtin/commit.c
index ef12ea3991..fa962c4f86 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -290,7 +290,7 @@ static void add_remove_files(struct string_list *list)
 			if (add_to_cache(p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
-			remove_file_from_cache(p->string);
+			remove_file_from_index(&the_index, p->string);
 	}
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 0e19d6e8d5..90c56b46f2 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -125,7 +125,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		struct cache_entry *ce;
 
 		if (is_missing && !intent_to_add) {
-			remove_file_from_cache(one->path);
+			remove_file_from_index(&the_index, one->path);
 			continue;
 		}
 
diff --git a/builtin/rm.c b/builtin/rm.c
index c77c941ef0..f479100298 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -343,7 +343,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!quiet)
 			printf("rm '%s'\n", path);
 
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			die(_("git rm: unable to remove %s"), path);
 	}
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e0738f74bf..8c4911e920 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -243,7 +243,7 @@ static int remove_one_path(const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
-	if (remove_file_from_cache(path))
+	if (remove_file_from_index(&the_index, path))
 		return error("%s: cannot remove from the index", path);
 	return 0;
 }
@@ -376,7 +376,7 @@ static int process_path(const char *path)
 		 * so updating it does not make sense.
 		 * On the other hand, removing it from index should work
 		 */
-		if (allow_remove && remove_file_from_cache(path))
+		if (allow_remove && remove_file_from_index(&the_index, path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -459,7 +459,7 @@ static void update_one(const char *path)
 	}
 
 	if (force_remove) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		return;
@@ -541,7 +541,7 @@ static void read_index_info(int nul_term_line)
 
 		if (!mode) {
 			/* mode == 0 means there is no such path -- remove */
-			if (remove_file_from_cache(path_name))
+			if (remove_file_from_index(&the_index, path_name))
 				die("git update-index: unable to remove %s",
 				    ptr);
 		}
@@ -658,7 +658,7 @@ static int unresolve_one(const char *path)
 		goto free_return;
 	}
 
-	remove_file_from_cache(path);
+	remove_file_from_index(&the_index, path);
 	if (add_index_entry(&the_index, ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
diff --git a/cache.h b/cache.h
index 4c12ff265e..88c6f8a7df 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
diff --git a/merge-recursive.c b/merge-recursive.c
index 6420dc1951..c5bf1fb6a2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -582,7 +582,7 @@ static int update_stages(struct merge_options *opt, const char *path,
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			return -1;
 	if (o)
 		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
@@ -617,7 +617,7 @@ static int remove_file(struct merge_options *o, int clean,
 	int update_working_directory = !o->call_depth && !no_wd;
 
 	if (update_cache) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			return -1;
 	}
 	if (update_working_directory) {
@@ -1084,7 +1084,7 @@ static int handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		ret = remove_file_from_cache(path);
+		ret = remove_file_from_index(&the_index, path);
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
@@ -1145,7 +1145,7 @@ static int conflict_rename_delete(struct merge_options *o,
 		return -1;
 
 	if (o->call_depth)
-		return remove_file_from_cache(dest->path);
+		return remove_file_from_index(&the_index, dest->path);
 	else
 		return update_stages(o, dest->path, NULL,
 				     rename_branch == o->branch1 ? dest : NULL,
@@ -1263,14 +1263,14 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 				return -1;
 		}
 		else
-			remove_file_from_cache(a->path);
+			remove_file_from_index(&the_index, a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
 			if (update_file(o, 0, &add->oid, add->mode, b->path))
 				return -1;
 		}
 		else
-			remove_file_from_cache(b->path);
+			remove_file_from_index(&the_index, b->path);
 	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
 		return -1;
 
@@ -1759,7 +1759,7 @@ static int merge_content(struct merge_options *o,
 	if (df_conflict_remains) {
 		char *new_path;
 		if (o->call_depth) {
-			remove_file_from_cache(path);
+			remove_file_from_index(&the_index, path);
 		} else {
 			if (!mfi.clean) {
 				if (update_stages(o, path, &one, &a, &b))
@@ -1887,7 +1887,7 @@ static int process_entry(struct merge_options *o,
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge = -1;
 			else if (o->call_depth)
-				remove_file_from_cache(path);
+				remove_file_from_index(&the_index, path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
-- 
2.13.0.rc1.39.ga6db8bfa24

