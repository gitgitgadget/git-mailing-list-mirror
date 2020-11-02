Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A1C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F65D2071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4aGhk2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKBUoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgKBUoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:15 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B44C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:14 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m143so6707887oig.7
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5N0LIVZr2Sf5o6RBc3AWQq3yrNEzWIeZxdNHMsH9Vg=;
        b=E4aGhk2JLki2mNTIqlCbCaTXpBX+IqRuys22pCMfAHW+I/5DbrQAlXfB4TwKKGEAjJ
         5bZWpjI4cMbqWy+R+MgZ436gyakT1xsm/AMwouMfLgO7ekcgs2myJ5qZc53aCo0QFqjH
         HbnznKegJwh+Ppc/BApkCFm2Lf3EtL9dnfwjl3QiZfAsbY/ppHRZxy5cWbDy7uX0Jb9o
         losqLF2xRkho0DoRojgGYpo19dWXWIPaBVNY/lksb4sSOYtJCW5j0hxFUJNOzoIbhIAx
         4FWwJd7x7B06mpGyP16ZstFakVGHcYFLIZSLXNDFSM/8GRbSsOKJTSqRhtbEofsbeiJL
         NePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5N0LIVZr2Sf5o6RBc3AWQq3yrNEzWIeZxdNHMsH9Vg=;
        b=Fe0Q+aejlDTDhBWE6HOKRfiaHrgDBVj/QLfYMf2spR4w0NQsU+gsp4wy1izU8cf3GB
         2fdcIl9JqtDlfyq6SdmEZ0lfVyoDo06mOCezdUlsaIByI1glk3WpI7JCBPJxhFyY3hd0
         VodDJwWuwoGABdIfLORb9ni3bUBmdjXwVQFpu4e4UlZHYuS+6gcTIVwnb6G6XzQ+QORu
         jQIDjldMtvUV6eQFQAO1BkP1MnNBCI6akxf3kXnxyqOg+FJiIZGfdozKKb2fTM54SsPK
         95DIHnCvdqAvZ//IWAgKcQcBrI5npYhlqnu1/sW0n6VHiEBnMUQLS6QAeQh5Lw8CRU9J
         cqrA==
X-Gm-Message-State: AOAM533EOkFkiRmeW0kh4C0jm3lj8Oa3G8lpVfhVOtlLGfj9PsyEYj/W
        epu9jiCXXBREI/JFO82ZQNAHORqnrkLtbQ==
X-Google-Smtp-Source: ABdhPJx3b/lPDgzUTlfFB8SuybOmGOkHo7KcMdKjIXJMYpB/hUvHrjrkDZOeFQqBAIjWbg1cFU/zNA==
X-Received: by 2002:a05:6808:5d7:: with SMTP id d23mr1890oij.56.1604349854131;
        Mon, 02 Nov 2020 12:44:14 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:13 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 19/20] merge-ort: add implementation of record_unmerged_index_entries()
Date:   Mon,  2 Nov 2020 12:43:43 -0800
Message-Id: <20201102204344.342633-20-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After checkout(), the working tree has the appropriate contents, and the
index matches the working copy.  That means that all unmodified and
cleanly merged files have correct index entries, but unmerged entries
need to be updated.

We do this by looping over the unmerged entries, marking the existing
index entry for the path with CE_REMOVE, adding new higher order staged
for the path at the end of the index (ignoring normal index sort order),
and then at the end of the loop removing the CE_REMOVED-marked cache
entries and sorting the index.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index b7c5973d4d..19c30117b0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,7 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "cache-tree.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
@@ -713,10 +714,94 @@ static int record_unmerged_index_entries(struct merge_options *opt,
 					 struct strmap *paths,
 					 struct strmap *unmerged)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	int errs = 0;
+	int original_cache_nr;
+
 	if (strmap_empty(unmerged))
 		return 0;
 
-	die("Not yet implemented.");
+	original_cache_nr = index->cache_nr;
+
+	/* Put every entry from paths into plist, then sort */
+	strmap_for_each_entry(unmerged, &iter, e) {
+		const char *path = e->key;
+		struct conflict_info *ci = e->value;
+		int pos;
+		struct cache_entry *ce;
+		int i;
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
+				BUG("Unmerged %s but nothing in basic working tree or index; this shouldn't happen", path);
+		} else {
+			ce = index->cache[pos];
+
+			/*
+			 * Clean paths with CE_SKIP_WORKTREE set will not be
+			 * written to the working tree by the unpack_trees()
+			 * call in checkout().  Our unmerged entries would
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
+			 * conflicts.  If there are many unmerged entries, we
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
+	 * cache-trees), then sort the index entries to get the unmerged
+	 * entries we added to the end into their right locations.
+	 */
+	remove_marked_cache_entries(index, 1);
+	QSORT(index->cache, index->cache_nr, cmp_cache_name_compare);
+
+	return errs;
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
2.29.0.471.ga4f56089c0

