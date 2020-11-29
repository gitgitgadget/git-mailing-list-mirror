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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CEC3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D34207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5bKLiV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgK2HpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK2HpE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:45:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476FC08C5F2
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so10793992wrw.10
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Rr00YGAeqAyGLrmlvNPjplfA4WlpT4yQLtdYFYM6Bg=;
        b=m5bKLiV8w2FwYt7/Cb+Fn7qpWReubslakQsAbgiNwhMSenY+kql6CSc6Jg4HbflctY
         q8IQIzRt3FqdW0kVxLQ0lkEXL0FNt//wBeao4juPd5d8F0uItCCi5elKzs3zySoBPqyI
         zcVBv95/iUhq0zY1UKI4Svk5LjwAg+CEYx19UkO3LlEQ+s7nwGYX8BujvWJhFIS/h6ok
         cmA1C9ab7hEmuj3PVDPS5KehKbfUdVbRqL5B4+hL7ptTJRnhyNUPhNMW7nKtY/6o7Mvm
         MlohGPAIWyIk4La14rpZI6s5DZ5CJEPUldUCRWuLNoY3gDq+zDgioUpIzFY4dvgWV9ry
         qc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Rr00YGAeqAyGLrmlvNPjplfA4WlpT4yQLtdYFYM6Bg=;
        b=l43ZLGlG7OvHYAH/2JetTMd5SeCzMFgujl/SeLryHuAdC+2mJNk/q9+EGQ4ieAY3HU
         ygTaClfVNnsigEFPYksK9m6Rny9z8PWQiW2PymlF9QLYOdwoRXclCD1A5L9pSIi5q5cH
         YJRRVy/XcpuH2AzfUu0KCZcW/Um+RvX4bKcPslxD5mu39k2MiPR2d3LHozGVserf6c3P
         0Vy3+jGzKf4I28v8Af2VszkSG9ZSch6Fbg8UcxFfViEy0UfGlFh4Nz7d/ENvVUF/QSjW
         xWtzK4Lg3Vp3q+OjKuIKoPG2oDzxhHCHD9X1+EM9Jfcq2wkk4gCuloM7dr29SB84mrxz
         NaCw==
X-Gm-Message-State: AOAM533ppEliaAHLzi5wXyyPJZsJdFRYgRCt6HxTf96Lzqyy4rRaJDEV
        nng+ydKnztGS9rDEnydKvYJhCGVVZt4=
X-Google-Smtp-Source: ABdhPJw6fQEwmd7cJvqRRWvzpXM1K16ohc138OfXXSLD1+fKRv4aQ/cgAEZP0nPEwwhRtvhGchS6Rw==
X-Received: by 2002:a5d:6310:: with SMTP id i16mr21176936wru.284.1606635821070;
        Sat, 28 Nov 2020 23:43:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c187sm22235021wmd.23.2020.11.28.23.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:40 -0800 (PST)
Message-Id: <56b162c60993061e29c100ce4a27839d758033b8.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:22 +0000
Subject: [PATCH 19/20] merge-ort: add implementation of
 record_conflicted_index_entries()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 merge-ort.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 69b9fbe591..d1b98e2fca 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,7 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "cache-tree.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
@@ -988,10 +989,96 @@ static int record_conflicted_index_entries(struct merge_options *opt,
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
+			if (ci->filemask == 1)
+				cache_tree_invalidate_path(index, path);
+			else
+				BUG("Conflicted %s but nothing in basic working tree or index; this shouldn't happen", path);
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

