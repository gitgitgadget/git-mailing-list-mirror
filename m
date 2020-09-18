Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8597C43467
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F28223119
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MpgTvXEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgIRDAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgIRC7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B2C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so4638636qkj.7
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qHGXdd7LBSqjrTbecK1XReWVHX+AO0cedxhIxp6MvCI=;
        b=MpgTvXEP/vpNQO/6XY80YA3qBjvQjWAs3uvD9wvr02L2k+J8OB/ho+mV7fxLmDJb1p
         LFsODtX5MpUjMgCYgVs7ibmsKHI3thX8TjFzh0CBV4op9j343u8tki+sEvhQLq3oWXqY
         dW9fD9qVjkD/KOmZFweyPSVXFsW/ijDJFPtw+P1C93cew0bmoZKFoB3juKj9U1vRwQU9
         oy6lj/Rjjz28feQnjL6EbV4zBVoLAsF/BOMaSwb4kc82lT7TKPPeqo6EYibb3/vAVByc
         K0nNGZYG0f44e17RFwpsYSJEJMAGenLFxKJXp+3ZbJxxaaluiGAsCCPfIJXkjvglTe2C
         xDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qHGXdd7LBSqjrTbecK1XReWVHX+AO0cedxhIxp6MvCI=;
        b=DmzUuAFqeOz2vpD2/QAs7Q+zegFUuDKb9/miB7xDftL3M6cMvXeMSWPwbSvQCbTegI
         tF05S9q1jyO5KIRUdob96cAbAtyuuCnvyXCC0RnoF4gVe4KRaDoR9owNPtVKOU3SM1HA
         Ow/+itDWieK98ASGrJv4iVGcL3kQoT/3KdEZskoFz6EF6l+NL36JEXQklafD10guxjRl
         7BwdTnmgQfu2R+FU09moNV2RkppcMV9rGHWMUkIt7KfGCt2W+8A99LbgislBeun5Hzno
         0WQPku2ngPDxqwEH5w5ecUZTbCaHXPqCqVSCyCACCJkTYFyMm/3BZUbpQ1r8CcqOUrP6
         QYEg==
X-Gm-Message-State: AOAM531QYBpz0cMF+9Wi4Z62iFvUp5b7f1yAYh0qYxTnM773FfMvJjTp
        Y5Y0UuRQRXWgerPkGEcBou+niNhj/xOUJ6VW
X-Google-Smtp-Source: ABdhPJyODV3MOj6SpC3jcxZN8rKn46Q2X/zEWLQJryOVIWafoMaxDgIxRQfU5QxK0MiXBxGQ5bQ3Aw==
X-Received: by 2002:a37:9301:: with SMTP id v1mr20088290qkd.350.1600397982658;
        Thu, 17 Sep 2020 19:59:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id v56sm1282754qtc.49.2020.09.17.19.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:42 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 09/13] bloom/diff: properly short-circuit on max_changes
Message-ID: <2e4944996ec486b5828f6bc2e62014424c8d6fef.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Commit e3696980 (diff: halt tree-diff early after max_changes,
2020-03-30) intended to create a mechanism to short-circuit a diff
calculation after a certain number of paths were modified. By
incrementing a "num_changes" counter throughout the recursive
ll_diff_tree_paths(), this was supposed to match the number of changes
that would be written into the changed-path Bloom filters.
Unfortunately, this was not implemented correctly and instead misses
simple cases like file modifications. This then does not stop very
large changed-path filters from being written (unless they add or remove
many files).

To start, change the implementation in ll_diff_tree_paths() to instead
use the global diff_queue_diff struct's 'nr' member as the count. This
is a way to simplify the logic instead of making more mistakes in the
complicated diff code.

This has a drawback: the diff_queue_diff struct only lists the paths
corresponding to blob changes, not their leading directories. Thus,
get_or_compute_bloom_filter() needs an additional check to see if the
hashmap with the leading directories becomes too large.

One reason why this was not caught by test cases was that the test in
t4216-log-bloom.sh that was supposed to check this "too many changes"
condition only checked this on the initial commit of a repository. The
old logic counted these values correctly. Update this test in a few
ways:

1. Use GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS to reduce the limit,
   allowing smaller commits to engage with this logic.

2. Create several interesting cases of edits, adds, removes, and mode
   changes (in the second commit). By testing both sides of the
   inequality with the *_MAX_CHANGED_PATHS variable, we can see that
   the count is exactly correct, so none of these changes are missed
   or over-counted.

3. Use the trace2 data value filter_found_large to verify that these
   commits are on the correct side of the limit.

Another way to verify the behavior is correct is through performance
tests. By testing on my local copies of the Git repository and the Linux
kernel repository, I could measure the effect of these short-circuits
when computing a fresh commit-graph file with changed-path Bloom filters
using the command

  GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=N time \
    git commit-graph write --reachable --changed-paths

and reporting the wall time and resulting commit-graph size.

For Git, the results are

|        |      N=1       |       N=10     |      N=512     |
|--------|----------------|----------------|----------------|
| HEAD~1 | 10.90s  9.18MB | 11.11s  9.34MB | 11.31s  9.35MB |
| HEAD   |  9.21s  8.62MB | 11.11s  9.29MB | 11.29s  9.34MB |

For Linux, the results are

|        |       N=1      |     N=20      |     N=512     |
|--------|----------------|---------------|---------------|
| HEAD~1 | 61.28s  64.3MB | 76.9s  72.6MB | 77.6s  72.6MB |
| HEAD   | 49.44s  56.3MB | 68.7s  65.9MB | 69.2s  65.9MB |

Naturally, the improvement becomes much less as the limit grows, as
fewer commits satisfy the short-circuit.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.c              |   9 +++-
 diff.h               |   2 -
 t/t4216-log-bloom.sh | 100 +++++++++++++++++++++++++++++++++++++++----
 tree-diff.c          |   5 +--
 4 files changed, 100 insertions(+), 16 deletions(-)

diff --git a/bloom.c b/bloom.c
index 2d6aef9098..db9fb82437 100644
--- a/bloom.c
+++ b/bloom.c
@@ -222,7 +222,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diffopt.num_changes <= settings->max_changed_paths) {
+	if (diff_queued_diff.nr <= settings->max_changed_paths) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
@@ -259,6 +259,12 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			diff_free_filepair(diff_queued_diff.queue[i]);
 		}
 
+		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
+			if (computed)
+				*computed |= BLOOM_TRUNC_LARGE;
+			goto cleanup;
+		}
+
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
 		filter->data = xcalloc(filter->len, sizeof(unsigned char));
 
@@ -268,6 +274,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			add_key_to_filter(&key, filter, settings);
 		}
 
+	cleanup:
 		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
diff --git a/diff.h b/diff.h
index e0c0af6286..1d32b71885 100644
--- a/diff.h
+++ b/diff.h
@@ -287,8 +287,6 @@ struct diff_options {
 
 	/* If non-zero, then stop computing after this many changes. */
 	int max_changes;
-	/* For internal use only. */
-	int num_changes;
 
 	int ita_invisible_in_index;
 /* white-space error highlighting */
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 593571358d..123b46a0db 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -181,21 +181,103 @@ test_expect_success 'persist filter settings' '
 	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
 '
 
+test_max_changed_paths () {
+	grep "\"max_changed_paths\":$1" $2
+}
+
+test_filter_computed () {
+	grep "\"key\":\"filter-computed\",\"value\":\"$1\"" $2
+}
+
+test_filter_trunc_large () {
+	grep "\"key\":\"filter-trunc-large\",\"value\":\"$1\"" $2
+}
+
 test_expect_success 'correctly report changes over limit' '
-	git init 513changes &&
+	git init limits &&
 	(
-		cd 513changes &&
-		for i in $(test_seq 1 513)
+		cd limits &&
+		mkdir d &&
+		mkdir d/e &&
+
+		for i in $(test_seq 1 2)
 		do
-			echo $i >file$i.txt || return 1
+			printf $i >d/file$i.txt &&
+			printf $i >d/e/file$i.txt || return 1
 		done &&
-		git add . &&
+
+		mkdir mode &&
+		printf bash >mode/script.sh &&
+
+		mkdir foo &&
+		touch foo/bar &&
+		touch foo.txt &&
+
+		git add d foo foo.txt mode &&
 		git commit -m "files" &&
-		git commit-graph write --reachable --changed-paths &&
-		for i in $(test_seq 1 513)
+
+		# Commit has 7 file and 4 directory adds
+		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
+			GIT_TRACE2_EVENT="$(pwd)/trace" \
+			git commit-graph write --reachable --changed-paths &&
+		test_max_changed_paths 10 trace &&
+		test_filter_computed 1 trace &&
+		test_filter_trunc_large 1 trace &&
+
+		for path in $(git ls-tree -r --name-only HEAD)
 		do
-			git -c core.commitGraph=false log -- file$i.txt >expect &&
-			git log -- file$i.txt >actual &&
+			git -c commitGraph.readChangedPaths=false log \
+				-- $path >expect &&
+			git log -- $path >actual &&
+			test_cmp expect actual || return 1
+		done &&
+
+		# Make a variety of path changes
+		printf new1 >d/e/file1.txt &&
+		printf new2 >d/file2.txt &&
+		rm d/e/file2.txt &&
+		rm -r foo &&
+		printf text >foo &&
+		mkdir f &&
+		printf new1 >f/file1.txt &&
+
+		# including a mode-only change (counts as modified)
+		git update-index --chmod=+x mode/script.sh &&
+
+		git add foo d f &&
+		git commit -m "complicated" &&
+
+		# start from scratch and rebuild
+		rm -f .git/objects/info/commit-graph &&
+		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
+			GIT_TRACE2_EVENT="$(pwd)/trace-edit" \
+			git commit-graph write --reachable --changed-paths &&
+		test_max_changed_paths 10 trace-edit &&
+		test_filter_computed 2 trace-edit &&
+		test_filter_trunc_large 2 trace-edit &&
+
+		for path in $(git ls-tree -r --name-only HEAD)
+		do
+			git -c commitGraph.readChangedPaths=false log \
+				-- $path >expect &&
+			git log -- $path >actual &&
+			test_cmp expect actual || return 1
+		done &&
+
+		# start from scratch and rebuild
+		rm -f .git/objects/info/commit-graph &&
+		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=11 \
+			GIT_TRACE2_EVENT="$(pwd)/trace-update" \
+			git commit-graph write --reachable --changed-paths &&
+		test_max_changed_paths 11 trace-update &&
+		test_filter_computed 2 trace-update &&
+		test_filter_trunc_large 0 trace-update &&
+
+		for path in $(git ls-tree -r --name-only HEAD)
+		do
+			git -c commitGraph.readChangedPaths=false log \
+				-- $path >expect &&
+			git log -- $path >actual &&
 			test_cmp expect actual || return 1
 		done
 	)
diff --git a/tree-diff.c b/tree-diff.c
index 6ebad1a46f..7cebbb327e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -434,7 +434,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		if (diff_can_quit_early(opt))
 			break;
 
-		if (opt->max_changes && opt->num_changes > opt->max_changes)
+		if (opt->max_changes && diff_queued_diff.nr > opt->max_changes)
 			break;
 
 		if (opt->pathspec.nr) {
@@ -521,7 +521,6 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* t↓ */
 			update_tree_entry(&t);
-			opt->num_changes++;
 		}
 
 		/* t > p[imin] */
@@ -539,7 +538,6 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
 			update_tp_entries(tp, nparent);
-			opt->num_changes++;
 		}
 	}
 
@@ -557,7 +555,6 @@ struct combine_diff_path *diff_tree_paths(
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	opt->num_changes = 0;
 	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
 
 	/*
-- 
2.28.0.510.g375ecf1f36

