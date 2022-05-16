Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D93C433FE
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbiEPSL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiEPSLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE03DA46
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g17so3463292wrb.11
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jp8LPibzt32PIJ60geqqfZp5GnxycP5I2Gk84UF/cHE=;
        b=SxULzl4GAE2qafds8w4fLKpK7CNBvPwq2k6S9GUCax1q6M+mF3SvARjK21cwlglskc
         AzU6jMPVI2y+dpBgCTJiXSLr+PV3EntfBFDClIVe12BKAOXkhXF+EyJbiZyz4KkknrWp
         4qA/KzLagCeOfwHyCU9QQA3AS/it0CFhDk3pgK0rg4EZd3fVPtNNPKe/2vWS+r/4AGdk
         ei7lcsfg73SR909SKTf4a8YdqCSlAS/Vz6eN4J98X8VRTb9877VizgQy9/jUPodRNts8
         m+fKPlfQcefzf6TYakj9tnMfVGsu0Pj3kEAs3UzjxNF+AmtQdlAh/y/KPw69MsPooZda
         VVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jp8LPibzt32PIJ60geqqfZp5GnxycP5I2Gk84UF/cHE=;
        b=ozMfje88cJ3RD9BqrcWWASWRqN3wJpuL64c3HlJHAyDjvP68baDkogIKu5W0OsZzfB
         qs4A1jFqmfspMpIWeMro+Hl90DfBo5uFOd+pLBMzRmL0gsCsZnn0Uc4GD5gDFYF1b/Nk
         jvI10KT0zwCav2VzMwML0wXUvIXS/33pceH8OL6u16bOkag/lj4RMvic8kbbas83fuU4
         YbYB8D3jUjlB9NXAxiwv77uTIYg1Ou8oimkphFxqDmpuM1g+TMe85EkpGVkLptm/xPxZ
         mVy6zZ0NNWUpNcRRLaFTMhjp3sJa06EDszyfmIiEfb5A+tqAieFpz5oFL0hj1hAI6DvS
         eNsg==
X-Gm-Message-State: AOAM533eCoO8ouI6h0uC7yqkmasaYvAxRzR9yQURuo3G4n/u8BaY2Mwd
        VuleIB37DBmDoT6B+r1yhIU4trZym2M=
X-Google-Smtp-Source: ABdhPJz1BQHFWlQisPmFRSVlQxRN0NeQQRrBaPN49LcjkOAhePFCeX1AAhddlSjdDgFEsT2TgJNEMg==
X-Received: by 2002:adf:fe44:0:b0:20d:412:9775 with SMTP id m4-20020adffe44000000b0020d04129775mr7311168wrs.626.1652724702399;
        Mon, 16 May 2022 11:11:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s20-20020adf9794000000b0020c5253d902sm10025897wrb.78.2022.05.16.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:41 -0700 (PDT)
Message-Id: <eba63cc12af4f60320b34a54eef691b9f59d86bc.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:31 +0000
Subject: [PATCH 6/8] sparse-index: complete partial expansion
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

To complete the implementation of expand_to_pattern_list(), we need to
detect when a sparse directory entry should remain sparse. This avoids a
full expansion, so we now need to use the PARTIALLY_SPARSE mode to
indicate this state.

There still are no callers to this method, but we will add one in the
next change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 3d8eed585b5..0bad5503304 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -297,8 +297,24 @@ void expand_to_pattern_list(struct index_state *istate,
 	 * continue. A NULL pattern set indicates a full expansion to a
 	 * full index.
 	 */
-	if (pl && !pl->use_cone_patterns)
+	if (pl && !pl->use_cone_patterns) {
 		pl = NULL;
+	} else {
+		/*
+		 * We might contract file entries into sparse-directory
+		 * entries, and for that we will need the cache tree to
+		 * be recomputed.
+		 */
+		cache_tree_free(&istate->cache_tree);
+
+		/*
+		 * If there is a problem creating the cache tree, then we
+		 * need to expand to a full index since we cannot satisfy
+		 * the current request as a sparse index.
+		 */
+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+			pl = NULL;
+	}
 
 	if (!istate->repo)
 		istate->repo = the_repository;
@@ -317,8 +333,14 @@ void expand_to_pattern_list(struct index_state *istate,
 	full = xcalloc(1, sizeof(struct index_state));
 	memcpy(full, istate, sizeof(struct index_state));
 
+	/*
+	 * This slightly-misnamed 'full' index might still be sparse if we
+	 * are only modifying the list of sparse directories. This hinges
+	 * on whether we have a non-NULL pattern list.
+	 */
+	full->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
+
 	/* then change the necessary things */
-	full->sparse_index = 0;
 	full->cache_alloc = (3 * istate->cache_alloc) / 2;
 	full->cache_nr = 0;
 	ALLOC_ARRAY(full->cache, full->cache_alloc);
@@ -330,11 +352,22 @@ void expand_to_pattern_list(struct index_state *istate,
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
 		struct pathspec ps;
+		int dtype;
 
 		if (!S_ISSPARSEDIR(ce->ce_mode)) {
 			set_index_entry(full, full->cache_nr++, ce);
 			continue;
 		}
+
+		/* We now have a sparse directory entry. Should we expand? */
+		if (pl &&
+		    path_matches_pattern_list(ce->name, ce->ce_namelen,
+					      NULL, &dtype,
+					      pl, istate) <= 0) {
+			set_index_entry(full, full->cache_nr++, ce);
+			continue;
+		}
+
 		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
 			warning(_("index entry is a directory, but not sparse (%08x)"),
 				ce->ce_flags);
@@ -360,7 +393,7 @@ void expand_to_pattern_list(struct index_state *istate,
 	/* Copy back into original index. */
 	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
 	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
-	istate->sparse_index = 0;
+	istate->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
 	free(istate->cache);
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
@@ -374,7 +407,7 @@ void expand_to_pattern_list(struct index_state *istate,
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	cache_tree_update(istate, 0);
+	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
 
 	trace2_region_leave("index",
 			    pl ? "expand_to_pattern_list" : "ensure_full_index",
-- 
gitgitgadget

