Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0454C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770482076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="L5b8sOPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHKUwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:52:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5924C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 2so140946qkf.10
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UkG0VbkkbfTo4r4sgGsVzU492HVkMStyXADq+pBNjSA=;
        b=L5b8sOPAdEdmYhfcyHXzZnEZLzKBZSu2To9fxTXs8BpenpdA1xAdvOKg9e1LPqJ7MM
         ltbCAnhMDhbUgO681DEou1CF8LagokOk+UYhuxQR507iPYfLtJ+27snmBe4ELjllJRHO
         7Elv5tH4RG8B9YJK1qO6+nxOxoIFW/vSax83fv6ZY69M7Vd68Mu0h0hNUSIaAZnS70D7
         HqV1CPVdohpj2OADPTCUFp1a4oyyrlaE9EZ0sI6ElABNgiSW3wcxCGdio2lmmvrSmQg2
         wtgdbSmuoAmgB6iwLVM4nhClgjRhFMWmnvJqSu+r63wXvA+Wza27P/keizS6MAZyU8ba
         pfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UkG0VbkkbfTo4r4sgGsVzU492HVkMStyXADq+pBNjSA=;
        b=gjfnM07asEP0xBIuSr71FUJVeEp3wUqZQF/RzD81A4MJ3ZPDFszGJgOBh4JXHpHHaz
         kw03JfsDARtAxB2bimlGM6c5y+qb8wetWtF9bNeXo3w0CEjTflsHAHCquxTF5afH9Iju
         1QiCEKGXH1bq9wFU0YCVPODkUC8IE5v2EpJ1luJdPWXYrFkt7cXFK4sawCeCKXqQkRkT
         w4q1EYyXGCkR7pCToNgnYMROa2YL7JqVOUT3poMI6YojIGH+Jf//6PPFByz8nnrD3lSz
         LHVOBYG5b9UE0PkrtKcjLcK0dCmRx6c26rGBTbfYpOc6OvryGUQ4Qu+aA5mGAbwuXBD0
         HZ7g==
X-Gm-Message-State: AOAM533Cmek91osP5NEHlZdEky52Q2BWBhx0McvNQWrqQAadXCevFvE5
        TpSw6lgaj0GE8wGlS/KDG3LPIjFV2dWWuj22
X-Google-Smtp-Source: ABdhPJzBeI7D/R/YtqOBHouSy2EUu+MW1Fo57cqmmkAA36F/7xf0VAXCaFXCYs0s4BFawHDSJb6loA==
X-Received: by 2002:a37:a7cc:: with SMTP id q195mr2997937qke.110.1597179118503;
        Tue, 11 Aug 2020 13:51:58 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id y3sm21924245qtj.55.2020.08.11.13.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:57 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 09/14] bloom/diff: properly short-circuit on max_changes
Message-ID: <cc1dc8b121c66247742f58b38af457bc1eed3208.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
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

