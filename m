Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B54C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCF1206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWJrw6i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUWFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39060 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKUWFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so5449622wmi.4
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T4b8TadolwlSOZvHpfmF35nObWmTrbh1mpJa/MQa9ds=;
        b=IWJrw6i8U9WHUSqG+FmENh/HacPXBRf+fSQRt+XL9Yr8cWnmsAFgllTP3qcXsImgN+
         81csQJUPXg8Dq3I2TyyIAH/nTY7HZudr0Wx54EmLKchgt0CKMKkDfTP5f3UkIItFaagi
         P/1WXVU+uUU+hMNwgoXoUeKySt8HZXU+rJGOUSRVOHW6h2XC++qfOID/Em3VXCOJ9+er
         AK2i12vdtFMMEL345KMnif6xFGCN1diYdnEi8O2sPfJfIvcHHHJkfdHdh2GKt8gTv9Jv
         mNipd1Uu5Gsz32bzKzEzxMOqn9LBNJ6nGFllrSe0UChaxWJtHsem8OXmqUXwYBk7brx7
         SQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T4b8TadolwlSOZvHpfmF35nObWmTrbh1mpJa/MQa9ds=;
        b=MBzkJZTxkV/Sul/kwY3wXdklL6CKjHvF+v+1XvSZ0233T14n6xoNSZb1Qr/jlhsKdE
         noiQjw2A9Upl9/vYs9DqSgv7df8TMohP8nEyEVkMEsJ4oX7NdKr8/yxXRFrPKm/bLaB5
         fdJBUH3AVrFaY4gw6VU8IcnKWMaMBv1Y5v8FAJtIc/MWHNFFyMgL483matVXLV0jBjJr
         niBKH8dtk5SchyixczIl6O4xKa5v57aMe7Vgcs/ao3sXDo7RYn+nMCEhGn0P4BkeLkEl
         45lAwQlV1A4zYPgNxGmCWy+l44t8+rjRFysY0gn9OmWgTB137czWMz2NiUgLVRWUaN6R
         KG6Q==
X-Gm-Message-State: APjAAAXrxjYxb7zmFmYMcodSuOhzGyO0BC+IwGantBy4g5n6f5tL8Mhj
        qHKAcVJ9CmPotIGXFINarGL7Vf5N
X-Google-Smtp-Source: APXvYqxLsFEGa0+io2gNQeFitGEuyG8bFXPioaoPop6NySWW9O9MiaHArNsoVF0yCPB9baP3IvkG2g==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr113184wmk.8.1574373911617;
        Thu, 21 Nov 2019 14:05:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm5097677wrp.29.2019.11.21.14.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:11 -0800 (PST)
Message-Id: <3d0f951d33a64dffa2f09651eca6416ee883acab.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:44 +0000
Subject: [PATCH v6 12/19] unpack-trees: add progress to clear_ce_flags()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a large repository has many sparse-checkout patterns, the
process for updating the skip-worktree bits can take long enough
that a user gets confused why nothing is happening. Update the
clear_ce_flags() method to write progress.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        |  2 ++
 unpack-trees.c | 56 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 4980ee198e..d3c89e7a53 100644
--- a/cache.h
+++ b/cache.h
@@ -304,6 +304,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 struct split_index;
 struct untracked_cache;
+struct progress;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -326,6 +327,7 @@ struct index_state {
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
+	struct progress *progress;
 };
 
 /* Name hashing */
diff --git a/unpack-trees.c b/unpack-trees.c
index c0dca20865..8bb684ad62 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1269,7 +1269,8 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct pattern_list *pl,
-			    enum pattern_match_result default_match);
+			    enum pattern_match_result default_match,
+			    int progress_nr);
 
 /* Whole directory matching */
 static int clear_ce_flags_dir(struct index_state *istate,
@@ -1278,7 +1279,8 @@ static int clear_ce_flags_dir(struct index_state *istate,
 			      char *basename,
 			      int select_mask, int clear_mask,
 			      struct pattern_list *pl,
-			      enum pattern_match_result default_match)
+			      enum pattern_match_result default_match,
+			      int progress_nr)
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
@@ -1315,7 +1317,8 @@ static int clear_ce_flags_dir(struct index_state *istate,
 		rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 				      prefix,
 				      select_mask, clear_mask,
-				      pl, ret);
+				      pl, ret,
+				      progress_nr);
 	}
 
 	strbuf_setlen(prefix, prefix->len - 1);
@@ -1342,7 +1345,8 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct pattern_list *pl,
-			    enum pattern_match_result default_match)
+			    enum pattern_match_result default_match,
+			    int progress_nr)
 {
 	struct cache_entry **cache_end = cache + nr;
 
@@ -1356,8 +1360,11 @@ static int clear_ce_flags_1(struct index_state *istate,
 		int len, dtype;
 		enum pattern_match_result ret;
 
+		display_progress(istate->progress, progress_nr);
+
 		if (select_mask && !(ce->ce_flags & select_mask)) {
 			cache++;
+			progress_nr++;
 			continue;
 		}
 
@@ -1378,20 +1385,26 @@ static int clear_ce_flags_1(struct index_state *istate,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
-						       pl, default_match);
+						       pl, default_match,
+						       progress_nr);
 
 			/* clear_c_f_dir eats a whole dir already? */
 			if (processed) {
 				cache += processed;
+				progress_nr += processed;
 				strbuf_setlen(prefix, prefix->len - len);
 				continue;
 			}
 
 			strbuf_addch(prefix, '/');
-			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
-						  prefix,
-						  select_mask, clear_mask, pl,
-						  default_match);
+			processed = clear_ce_flags_1(istate, cache, cache_end - cache,
+						     prefix,
+						     select_mask, clear_mask, pl,
+						     default_match, progress_nr);
+
+			cache += processed;
+			progress_nr += processed;
+
 			strbuf_setlen(prefix, prefix->len - len - 1);
 			continue;
 		}
@@ -1406,19 +1419,27 @@ static int clear_ce_flags_1(struct index_state *istate,
 		if (ret == MATCHED)
 			ce->ce_flags &= ~clear_mask;
 		cache++;
+		progress_nr++;
 	}
+
+	display_progress(istate->progress, progress_nr);
 	return nr - (cache_end - cache);
 }
 
 static int clear_ce_flags(struct index_state *istate,
 			  int select_mask, int clear_mask,
-			  struct pattern_list *pl)
+			  struct pattern_list *pl,
+			  int show_progress)
 {
 	static struct strbuf prefix = STRBUF_INIT;
 	char label[100];
 	int rval;
 
 	strbuf_reset(&prefix);
+	if (show_progress)
+		istate->progress = start_delayed_progress(
+					_("Updating index flags"),
+					istate->cache_nr);
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
@@ -1428,9 +1449,10 @@ static int clear_ce_flags(struct index_state *istate,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
-				pl, 0);
+				pl, 0, 0);
 	trace2_region_leave("unpack_trees", label, the_repository);
 
+	stop_progress(&istate->progress);
 	return rval;
 }
 
@@ -1439,7 +1461,8 @@ static int clear_ce_flags(struct index_state *istate,
  */
 static void mark_new_skip_worktree(struct pattern_list *pl,
 				   struct index_state *istate,
-				   int select_flag, int skip_wt_flag)
+				   int select_flag, int skip_wt_flag,
+				   int show_progress)
 {
 	int i;
 
@@ -1463,7 +1486,7 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(istate, select_flag, skip_wt_flag, pl);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, pl, show_progress);
 }
 
 static int verify_absent(const struct cache_entry *,
@@ -1525,7 +1548,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
 	if (!o->skip_sparse_checkout)
-		mark_new_skip_worktree(o->pl, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, o->src_index, 0,
+				       CE_NEW_SKIP_WORKTREE, o->verbose_update);
 
 	if (!dfc)
 		dfc = xcalloc(1, cache_entry_size(0));
@@ -1590,7 +1614,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * If the will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
-		mark_new_skip_worktree(o->pl, &o->result, CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, &o->result,
+				       CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
+				       o->verbose_update);
 
 		ret = 0;
 		for (i = 0; i < o->result.cache_nr; i++) {
-- 
gitgitgadget

