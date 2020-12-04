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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8490C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A162822CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgLDUtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgLDUtl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C4C094241
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:33 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so6515418wmc.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WdcUpPrt+KeTZ/lMASTVX5s+4NhAknn3qnvaVYr3LmE=;
        b=Wc+ISZFCDE9tUj2znaQthFzMpSXfDNOKyWrMgKqFuuIdKnvhij6wPEcl9NBE3JE1q9
         5WIClf1Emc4yIM5tuGfMcZbhR6NAF3O8Go36Pw/TcxK4MAyPeoaNyeoagy8+OVFXcWAi
         UAMEIxh848bZTPnh1iNsc0AlOsU6egSzYYhZoFRgLLOf48e2repPGEQrWdyq5+C7/lrX
         hZkdHqhlTE046lH9jGVA3ivDpO42RcD6RevT+mRdi4kZpN3ajJhvJ4GGz1fR3x4NGLS7
         RyVgCq9kxxtLSAtIW/zM5vAF320MNJRIk4KdAAPG8CXVhsh1CTFQru76FGGvk06cLAof
         7E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WdcUpPrt+KeTZ/lMASTVX5s+4NhAknn3qnvaVYr3LmE=;
        b=qFdCVDAhfyIvnLs6Opp1APN1+dTmO/2+fPpt9tvDMHf8duErseZv+yhoo6GJPubKOI
         aiCKFxKZWZ5S8sDWUGinK0jy0KOdv/4kq6cn+RXIWmsIsbZXYBpap7fz88x7LiuFtzIp
         +lYdm+414mZ0OZHaxBLWbSScsbt9eCM1HsHSVTABFsypWX8mfDWsSLdXKRQhsD6SuWbU
         vVYDgjiU6hiHukMoPUEURIYiSZfsZPVH8vmz+mGp2hCIWQnIIO3KgoiCgMR9nT9sTvg0
         URYZyrrYRz8zhfFZxxoTSq5ZPb8+7WZlfns/j69AudryY20I8ZoSWztU+Q6s6cgBqvP/
         S23A==
X-Gm-Message-State: AOAM533lI5LHEX+Tn3+SPVhqGqYdVHRAMGD7omlkM11kOz4B6d8Jg1NA
        NMaEX1Ftf6vyXoaLxdTk22ww4ayKeR0=
X-Google-Smtp-Source: ABdhPJynhcSq3fSsshWqcyUBUsI3xiUG4DW8f+TY8cy8es8xTYSX1kqsAzdvrrZRiExuLZIAk/NBNg==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr6250580wml.48.1607114912028;
        Fri, 04 Dec 2020 12:48:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm4354453wmk.12.2020.12.04.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:31 -0800 (PST)
Message-Id: <4efac38116dd43d50d0003d20f7cff301014315a.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:09 +0000
Subject: [PATCH v2 19/20] merge-ort: add implementation of
 record_conflicted_index_entries()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

After checkout(), the working tree has the appropriate contents, and the
index matches the working copy.  That means that all unmodified and
cleanly merged files have correct index entries, but conflicted entries
need to be updated.

We do this by looping over the conflicted entries, marking the existing
index entry for the path with CE_REMOVE, adding new higher order staged
for the path at the end of the index (ignoring normal index sort order),
and then at the end of the loop removing the CE_REMOVED-marked cache
entries and sorting the index.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index ba62f80420..faebee8e7e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,7 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "cache-tree.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
@@ -999,10 +1000,95 @@ static int record_conflicted_index_entries(struct merge_options *opt,
 					   struct strmap *paths,
 					   struct strmap *conflicted)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	int errs = 0;
+	int original_cache_nr;
+
 	if (strmap_empty(conflicted))
 		return 0;
 
-	die("Not yet implemented.");
+	original_cache_nr = index->cache_nr;
+
+	/* Put every entry from paths into plist, then sort */
+	strmap_for_each_entry(conflicted, &iter, e) {
+		const char *path = e->key;
+		struct conflict_info *ci = e->value;
+		int pos;
+		struct cache_entry *ce;
+		int i;
+
+		VERIFY_CI(ci);
+
+		/*
+		 * The index will already have a stage=0 entry for this path,
+		 * because we created an as-merged-as-possible version of the
+		 * file and checkout() moved the working copy and index over
+		 * to that version.
+		 *
+		 * However, previous iterations through this loop will have
+		 * added unstaged entries to the end of the cache which
+		 * ignore the standard alphabetical ordering of cache
+		 * entries and break invariants needed for index_name_pos()
+		 * to work.  However, we know the entry we want is before
+		 * those appended cache entries, so do a temporary swap on
+		 * cache_nr to only look through entries of interest.
+		 */
+		SWAP(index->cache_nr, original_cache_nr);
+		pos = index_name_pos(index, path, strlen(path));
+		SWAP(index->cache_nr, original_cache_nr);
+		if (pos < 0) {
+			if (ci->filemask != 1)
+				BUG("Conflicted %s but nothing in basic working tree or index; this shouldn't happen", path);
+			cache_tree_invalidate_path(index, path);
+		} else {
+			ce = index->cache[pos];
+
+			/*
+			 * Clean paths with CE_SKIP_WORKTREE set will not be
+			 * written to the working tree by the unpack_trees()
+			 * call in checkout().  Our conflicted entries would
+			 * have appeared clean to that code since we ignored
+			 * the higher order stages.  Thus, we need override
+			 * the CE_SKIP_WORKTREE bit and manually write those
+			 * files to the working disk here.
+			 *
+			 * TODO: Implement this CE_SKIP_WORKTREE fixup.
+			 */
+
+			/*
+			 * Mark this cache entry for removal and instead add
+			 * new stage>0 entries corresponding to the
+			 * conflicts.  If there are many conflicted entries, we
+			 * want to avoid memmove'ing O(NM) entries by
+			 * inserting the new entries one at a time.  So,
+			 * instead, we just add the new cache entries to the
+			 * end (ignoring normal index requirements on sort
+			 * order) and sort the index once we're all done.
+			 */
+			ce->ce_flags |= CE_REMOVE;
+		}
+
+		for (i = 0; i < 3; i++) {
+			struct version_info *vi;
+			if (!(ci->filemask & (1ul << i)))
+				continue;
+			vi = &ci->stages[i];
+			ce = make_cache_entry(index, vi->mode, &vi->oid,
+					      path, i+1, 0);
+			add_index_entry(index, ce, ADD_CACHE_JUST_APPEND);
+		}
+	}
+
+	/*
+	 * Remove the unused cache entries (and invalidate the relevant
+	 * cache-trees), then sort the index entries to get the conflicted
+	 * entries we added to the end into their right locations.
+	 */
+	remove_marked_cache_entries(index, 1);
+	QSORT(index->cache, index->cache_nr, cmp_cache_name_compare);
+
+	return errs;
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
gitgitgadget

