Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF45C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5742245C
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dsrKHeRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHERFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgHERCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:50 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306A5C06174A
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:50 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s15so16636001qvv.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UkG0VbkkbfTo4r4sgGsVzU492HVkMStyXADq+pBNjSA=;
        b=dsrKHeRkGZ/QNV2n8Ty9sR8PykZVu4RmCDk9pn+67CvxTgGpQ7vukS2LRI5UuauTG7
         R891fjQxjyd/caQfu1gIjuVn0J6E23YaqzI2XRMTdcXe5r17M6mJe+hx+N6MuclcaWGB
         6zpAehs8HYQNTg4vd4u6BhRO1YbpcZkbdzoXwuBQEpC1ROMOearB3XhpnKRUwMABrGZJ
         I3jYGAVc2dXtodGBBnYoh2pIGAbD82cYlYHJNP0/jf0BHWCd3B/rlSCwaXX4mnJHQ8hq
         u9UF4Q8XjXvDKp63jpyC9/15H8YNW1N213LDbUTGjWaXjX3Q6zM9xZ9lx4U/qBaDH4f4
         MjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UkG0VbkkbfTo4r4sgGsVzU492HVkMStyXADq+pBNjSA=;
        b=iyAqc2GK6MzmstIKSG9M9twtk6bPXhLZ3n+Y2B8nvCFwBpMvBVr7HuqcVIiS24f0pG
         hlR5Zq7Ooudg0PgyrhjyZkCk1jGw2WZkcGeLzTSzTixlzSObFl8TyJUD+8iruwiXJ+bG
         WDuLBen7s1Am72/9kXM4AtRkiLHsndv9QlfqOUpI47x+fczV17xpxBl331vKKmUaactw
         aHdfKsJdukH3RrfM2ZkSoaT2uZt6Jir0E8olq8EFU5AEMqiIFkUdzHF0XJrWIMPFFPc+
         U0CW1b4gIrka4I2pzTuBp45Cvt/chDxlz53RIXDLbyvXBkho7IXX4Zb5M8zf1TCzTDVC
         knug==
X-Gm-Message-State: AOAM531g0d2h520CNSVQaPDOXN55kNA6uW/HYCJOS7hcF40yDaOzPFn3
        P73aPpLI8AiAjH6wjteTquv0M6OEcL6vMQ==
X-Google-Smtp-Source: ABdhPJwU+tRnqHfbY1UdHaWepOuKgg2OhO9BBqpRhQnAYjOaDaqtB55A34Zv0TUooYAMdbF7er1TAQ==
X-Received: by 2002:ad4:5388:: with SMTP id i8mr4627901qvv.202.1596646968683;
        Wed, 05 Aug 2020 10:02:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id q29sm2636272qtc.10.2020.08.05.10.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:47 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 09/14] bloom/diff: properly short-circuit on max_changes
Message-ID: <d1c4bbcaa9627068d5d9fbd0e4a2e8c8834a4bd3.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
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
---
 bloom.c              |  6 +++-
 diff.h               |  2 --
 t/t4216-log-bloom.sh | 85 +++++++++++++++++++++++++++++++++++++++-----
 tree-diff.c          |  5 +--
 4 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/bloom.c b/bloom.c
index 0cf1962dc5..ed54e96e57 100644
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
@@ -259,6 +259,9 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			diff_free_filepair(diff_queued_diff.queue[i]);
 		}
 
+		if (hashmap_get_size(&pathmap) > settings->max_changed_paths)
+			goto cleanup;
+
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
 		filter->data = xcalloc(filter->len, sizeof(unsigned char));
 
@@ -268,6 +271,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
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
index eb2bcc51f0..21b67677ef 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -177,20 +177,87 @@ test_expect_success 'persist filter settings' '
 '
 
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
+		grep "\"max_changed_paths\":10" trace &&
+		grep "\"filter_found_large\":1" trace &&
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
+		grep "\"max_changed_paths\":10" trace-edit &&
+		grep "\"filter_found_large\":2" trace-edit &&
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
+		grep "\"max_changed_paths\":11" trace-update &&
+		grep "\"filter_found_large\":0" trace-update &&
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
2.28.0.rc1.13.ge78abce653

