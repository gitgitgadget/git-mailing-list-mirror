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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CFC4167B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68E122D74
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394077AbgLMIHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394041AbgLMIGe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:06:34 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FD1C0611CE
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:47 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id a11so5515524wrr.13
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1k06gWoziwVjj9jXw2JYtrRTtEGJ87h3blUvQeqMuRw=;
        b=F/qSDUNKMXtZ16vp38er9wbe1BombDmpUQ/JIe4ooseibTMvgKYC2ZY3dPnDt9kaCy
         Q1G+gfbhGFbkq/iH0CRFIl5loldcPxqR8gtsgd4fpHhTjGCxM4D5nCth442psYg8Zcgh
         9z/C7II/bKic5ezhH+Ce/v3LwVuSFnx/N+1OnZhtcpNE8lIjeLGNq4EArO4DUf980JZa
         098WKoxJHclW5ncsPx2vMlPHfAaHhTwTahESmhDaqxTsRncO4H8hpWJRiLyO3D03FRUX
         KdbHukcseVj4TvUHZ7eIvp2azhnWZRvvt9LlNCfz/hkw0lM/K+fW6P30uZcY0y3A10W9
         AMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1k06gWoziwVjj9jXw2JYtrRTtEGJ87h3blUvQeqMuRw=;
        b=By16boBoRDQy2WQ7/4ja6B8Lke3wTHZHpy33munFHlQqvA7YC6aS3Std1aegMvAFnz
         9Sxl1/6VAaCZVBWX1ioBonIT73NSxi3+N+z6APnFrC5AQG6iQwPGBRjNk6lD3z40LBvm
         VUGnE1csPNz4mknvg/TQrSv+z/5eLTbulV1tl0wsPELOUAxbAFiXcCR0HzTgqBdsVtaQ
         LbBSiztDF3r0mxXblcqlSEi++yVhz/BsR1DKtvXryC+MQCDvArRHTvn/i0q6Mu+aOBkJ
         I1ykEXvi3TYqAGPcXJ73EuiNMiwdvmhT2ZbxSrzNeL7lBlo1iHeUC1KeR869RzbGU6hW
         kWYw==
X-Gm-Message-State: AOAM533LYQeuvwB/FNlSV9vFhDaTiqoZCBPqcz69M58cCa7Gfjb+WM81
        +O/RPTZip+WPiF0qViRQ258S2/sCMNA=
X-Google-Smtp-Source: ABdhPJzilhy8Spxuc8Gpni8JbiY0UAVn9EjUsXJEmMtTLOmAREyAExWS0KrbL4/gIAGLXEz9K3Xq5Q==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr11700201wru.86.1607846686059;
        Sun, 13 Dec 2020 00:04:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v125sm23423325wme.42.2020.12.13.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:45 -0800 (PST)
Message-Id: <ee831c8cece2f6c8a784ed415103f73175f07987.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:26 +0000
Subject: [PATCH v3 19/20] merge-ort: add implementation of
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
index 3c4f64e2675..47cd772e805 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,7 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "cache-tree.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
@@ -1026,10 +1027,95 @@ static int record_conflicted_index_entries(struct merge_options *opt,
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
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
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

