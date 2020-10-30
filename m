Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30469C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EA2215A4
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYI89NzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgJ3Dmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D7AC0613E4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:03 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 9so5385402oir.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VZpHTdzpL/PlKMflmLf8gPE63e8+wDxFMIr98axago=;
        b=jYI89NzPXXOmaOQzBw/8r4HsVB/Ew5A8euTFTcsYvyyixm4R6N+sgEuemUf6C+iZh9
         5dgz3KIgrFvrWy/HEN9Irvho6A1Cwcw/hkG2eiePT1ghHYgx7SEYkZsWDnkI2BssbJoW
         LCjJSrg2i+yXbjT0q8tvpjjtTherWGlLzwsuTry8QbqVdzUMI576xy8XL5wbIVYXckyh
         6WYOIw/x9kutMV+eEbLeFsNg0yBnHuXqGKt1+jrJRo+ddZX6iFyx30yzxZQyWAisa8D3
         OjEtT6AUtUC4jvT8kE/qHts64YOU9lfn5HCDpvlSd5Pn15HZdXHA0aHsh4ePxQMGxTKN
         BwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VZpHTdzpL/PlKMflmLf8gPE63e8+wDxFMIr98axago=;
        b=c2xPPlex9ggOkM3DAUoNK8GfvpHh1tpq7o9UgPZQpByCvTZ0eH3cY9eMpLie5XTjvv
         OEde6ykNqczLo8Be/P3fwQbkwIcd4uOucTL1c3jPI6ZtETMy0F3YCVo4ux8s2NJtyVyJ
         GESIV+mshd7V2TX3gxJ5yEQMdQgW2jDb5kuOmv7GiicoBOfb8n8CN2FUcrAhlNFi+bLv
         PBDjdV8XqWCR73PFdF8o20cBtwO1JoCSC8ejMSww9uNcj2d6k9oYRNE4m8paq56vluiO
         d0yC5i/C5JZMuKWngmVdfXxH6/OViqv8gmwm7RIIQYeggwfclMdFVt2sWuzmw9MO5X8S
         6wWA==
X-Gm-Message-State: AOAM533rJHnT8DsqiNJILeTqLjVbynJJvN4Hjlrq7otFzGy6Ng8G6Wc1
        BqFlRHTJ4E31LMQtCXtNDe29HuB0I0OWVQ==
X-Google-Smtp-Source: ABdhPJwdWbz5RcOZXLhc6sCBH35BveBGPrUbfXGVpjw830KZZXZuqN9lBGhCklh0myc/SL4HHznAsA==
X-Received: by 2002:aca:ecca:: with SMTP id k193mr273723oih.96.1604029322787;
        Thu, 29 Oct 2020 20:42:02 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:42:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 19/20] merge-ort: add implementation of record_unmerged_index_entries()
Date:   Thu, 29 Oct 2020 20:41:30 -0700
Message-Id: <20201030034131.1479968-20-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
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
index 4da671d647..0b091c86eb 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,7 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "cache-tree.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
@@ -714,10 +715,94 @@ static int record_unmerged_index_entries(struct merge_options *opt,
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
2.29.1.56.ga287c268e6.dirty

