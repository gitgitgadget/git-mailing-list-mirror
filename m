Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD6C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FF1610CD
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhDISMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhDISML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6BC061763
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e186so6808884iof.7
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZ0l2LRhAv2TG2op0mypykW1kcDQNxN6GOoGtYGbeF4=;
        b=tQ1bcrekFnnuxUSgUdaTLjRhEYLQ5c74J50xh0DNzt/QdTlKq+ngya3TgacWxwGmN7
         HpWuOu8PE8baedkvagG3xgFiZM6lr6SR8JRDaMjbmpiTUW4d/bCcIuC7UhFTRVDhgtxO
         wqjAW7vVD5L4d/jlqp0xbIK4kHrC9FRykTjlHIGh/LFMWXcXQqAE8BbE7+gjnn+j3Lnm
         tYuQzU5lnp9fWaW1IeKTH2mSC68hYEjlPy2q8fAjoBfmuraWK1noTL3IoL3+t5iLpmDG
         3WEyPjGmzOaIeUojp8vnXj8eq2FdxeJQbCXS4HAb8Ok6VxYFFKKqj8XRhzL9AUDnsqyc
         37bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZ0l2LRhAv2TG2op0mypykW1kcDQNxN6GOoGtYGbeF4=;
        b=O7sOZZ6jgQinfEChBj8Hny7gEOxIGym7MjUZ9HHcqIor7iy4W6HuoFXYJGeHQPlmFS
         0MSmihqbsTc6ozZTIbFG0Ko6f/LJmJSKTycZYkFcTf17ET2fMuF9u1qRsN3Yq/thPQyj
         FqVa0Uy8dm23XeYeiIRjboHH4mK6F5rTsFEEWVWD43uDSYZTD5b9ynnOFo2NFNis2Mx2
         hk/7cV6vbsmGSrwJ2iVeHMILhvAn8L5Xo3xTNRz+L7oIpX9c8wmJprsGFk2FWgehSQFA
         STa+qJ6FgzajUZBTqsNxBXXqThDd6mcswueIk0HojplrIuZD1z7Jul4rNrmB5CPghWUL
         m6Kw==
X-Gm-Message-State: AOAM530F51u2Cm3WYz7Q5Lc5opqyKvQjHtj0RQMxSwONon81DtA1t01z
        cxrlQw804R9W4hvDH8yGwJ/5cB5ivIfzrjLt
X-Google-Smtp-Source: ABdhPJyAEBIbXLeziEUyOt0RBLRzvSWbyKt547rN8fkqs0lzzwo+BVyxMr5ox2HWP4ZSHkg45PEOqg==
X-Received: by 2002:a6b:e814:: with SMTP id f20mr3220304ioh.206.1617991915056;
        Fri, 09 Apr 2021 11:11:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id s15sm1449330ilv.13.2021.04.09.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:54 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 14/22] t5310: move some tests to lib-bitmap.sh
Message-ID: <570e3de9ed9d597cb2b9dcc38490836e45998e58.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll soon be adding a test script that will cover many of the same
bitmap concepts as t5310, but for MIDX bitmaps. Let's pull out as many
of the applicable tests as we can so we don't have to rewrite them.

There should be no functional change to t5310; we still run the same
operations in the same order.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-bitmap.sh         | 212 ++++++++++++++++++++++++++++++++++++++++
 t/t5310-pack-bitmaps.sh | 204 +-------------------------------------
 2 files changed, 216 insertions(+), 200 deletions(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index fe3f98be24..c655a9bf35 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -1,3 +1,6 @@
+# Helpers for scripts testing bitamp functionality; see t5310 for
+# example usage.
+
 # Compare a file containing rev-list bitmap traversal output to its non-bitmap
 # counterpart. You can't just use test_cmp for this, because the two produce
 # subtly different output:
@@ -24,3 +27,212 @@ test_bitmap_traversal () {
 	test_cmp "$1.normalized" "$2.normalized" &&
 	rm -f "$1.normalized" "$2.normalized"
 }
+
+# To ensure the logic for "maximal commits" is exercised, make
+# the repository a bit more complicated.
+#
+#    other                         second
+#      *                             *
+# (99 commits)                  (99 commits)
+#      *                             *
+#      |\                           /|
+#      | * octo-other  octo-second * |
+#      |/|\_________  ____________/|\|
+#      | \          \/  __________/  |
+#      |  | ________/\ /             |
+#      *  |/          * merge-right  *
+#      | _|__________/ \____________ |
+#      |/ |                         \|
+# (l1) *  * merge-left               * (r1)
+#      | / \________________________ |
+#      |/                           \|
+# (l2) *                             * (r2)
+#       \___________________________ |
+#                                   \|
+#                                    * (base)
+#
+# We only push bits down the first-parent history, which
+# makes some of these commits unimportant!
+#
+# The important part for the maximal commit algorithm is how
+# the bitmasks are extended. Assuming starting bit positions
+# for second (bit 0) and other (bit 1), the bitmasks at the
+# end should be:
+#
+#      second: 1       (maximal, selected)
+#       other: 01      (maximal, selected)
+#      (base): 11 (maximal)
+#
+# This complicated history was important for a previous
+# version of the walk that guarantees never walking a
+# commit multiple times. That goal might be important
+# again, so preserve this complicated case. For now, this
+# test will guarantee that the bitmaps are computed
+# correctly, even with the repeat calculations.
+setup_bitmap_history() {
+	test_expect_success 'setup repo with moderate-sized history' '
+		test_commit_bulk --id=file 10 &&
+		git branch -M second &&
+		git checkout -b other HEAD~5 &&
+		test_commit_bulk --id=side 10 &&
+
+		# add complicated history setup, including merges and
+		# ambiguous merge-bases
+
+		git checkout -b merge-left other~2 &&
+		git merge second~2 -m "merge-left" &&
+
+		git checkout -b merge-right second~1 &&
+		git merge other~1 -m "merge-right" &&
+
+		git checkout -b octo-second second &&
+		git merge merge-left merge-right -m "octopus-second" &&
+
+		git checkout -b octo-other other &&
+		git merge merge-left merge-right -m "octopus-other" &&
+
+		git checkout other &&
+		git merge octo-other -m "pull octopus" &&
+
+		git checkout second &&
+		git merge octo-second -m "pull octopus" &&
+
+		# Remove these branches so they are not selected
+		# as bitmap tips
+		git branch -D merge-left &&
+		git branch -D merge-right &&
+		git branch -D octo-other &&
+		git branch -D octo-second &&
+
+		# add padding to make these merges less interesting
+		# and avoid having them selected for bitmaps
+		test_commit_bulk --id=file 100 &&
+		git checkout other &&
+		test_commit_bulk --id=side 100 &&
+		git checkout second &&
+
+		bitmaptip=$(git rev-parse second) &&
+		blob=$(echo tagged-blob | git hash-object -w --stdin) &&
+		git tag tagged-blob $blob
+	'
+}
+
+rev_list_tests_head () {
+	test_expect_success "counting commits via bitmap ($state, $branch)" '
+		git rev-list --count $branch >expect &&
+		git rev-list --use-bitmap-index --count $branch >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting partial commits via bitmap ($state, $branch)" '
+		git rev-list --count $branch~5..$branch >expect &&
+		git rev-list --use-bitmap-index --count $branch~5..$branch >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting commits with limit ($state, $branch)" '
+		git rev-list --count -n 1 $branch >expect &&
+		git rev-list --use-bitmap-index --count -n 1 $branch >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting non-linear history ($state, $branch)" '
+		git rev-list --count other...second >expect &&
+		git rev-list --use-bitmap-index --count other...second >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting commits with limiting ($state, $branch)" '
+		git rev-list --count $branch -- 1.t >expect &&
+		git rev-list --use-bitmap-index --count $branch -- 1.t >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting objects via bitmap ($state, $branch)" '
+		git rev-list --count --objects $branch >expect &&
+		git rev-list --use-bitmap-index --count --objects $branch >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "enumerate commits ($state, $branch)" '
+		git rev-list --use-bitmap-index $branch >actual &&
+		git rev-list $branch >expect &&
+		test_bitmap_traversal --no-confirm-bitmaps expect actual
+	'
+
+	test_expect_success "enumerate --objects ($state, $branch)" '
+		git rev-list --objects --use-bitmap-index $branch >actual &&
+		git rev-list --objects $branch >expect &&
+		test_bitmap_traversal expect actual
+	'
+
+	test_expect_success "bitmap --objects handles non-commit objects ($state, $branch)" '
+		git rev-list --objects --use-bitmap-index $branch tagged-blob >actual &&
+		grep $blob actual
+	'
+}
+
+rev_list_tests () {
+	state=$1
+
+	for branch in "second" "other"
+	do
+		rev_list_tests_head
+	done
+}
+
+basic_bitmap_tests () {
+	tip="$1"
+	test_expect_success 'rev-list --test-bitmap verifies bitmaps' "
+		git rev-list --test-bitmap "${tip:-HEAD}"
+	"
+
+	rev_list_tests 'full bitmap'
+
+	test_expect_success 'clone from bitmapped repository' '
+		rm -fr clone.git &&
+		git clone --no-local --bare . clone.git &&
+		git rev-parse HEAD >expect &&
+		git --git-dir=clone.git rev-parse HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success 'partial clone from bitmapped repository' '
+		test_config uploadpack.allowfilter true &&
+		rm -fr partial-clone.git &&
+		git clone --no-local --bare --filter=blob:none . partial-clone.git &&
+		(
+			cd partial-clone.git &&
+			pack=$(echo objects/pack/*.pack) &&
+			git verify-pack -v "$pack" >have &&
+			awk "/blob/ { print \$1 }" <have >blobs &&
+			# we expect this single blob because of the direct ref
+			git rev-parse refs/tags/tagged-blob >expect &&
+			test_cmp expect blobs
+		)
+	'
+
+	test_expect_success 'setup further non-bitmapped commits' '
+		test_commit_bulk --id=further 10
+	'
+
+	rev_list_tests 'partial bitmap'
+
+	test_expect_success 'fetch (partial bitmap)' '
+		git --git-dir=clone.git fetch origin second:second &&
+		git rev-parse HEAD >expect &&
+		git --git-dir=clone.git rev-parse HEAD >actual &&
+		test_cmp expect actual
+	'
+}
+
+# have_delta <obj> <expected_base>
+#
+# Note that because this relies on cat-file, it might find _any_ copy of an
+# object in the repository. The caller is responsible for making sure
+# there's only one (e.g., via "repack -ad", or having just fetched a copy).
+have_delta () {
+	echo $2 >expect &&
+	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
+	test_cmp expect actual
+}
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f53efc8229..4318f84d53 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -25,93 +25,10 @@ has_any () {
 	grep -Ff "$1" "$2"
 }
 
-# To ensure the logic for "maximal commits" is exercised, make
-# the repository a bit more complicated.
-#
-#    other                         second
-#      *                             *
-# (99 commits)                  (99 commits)
-#      *                             *
-#      |\                           /|
-#      | * octo-other  octo-second * |
-#      |/|\_________  ____________/|\|
-#      | \          \/  __________/  |
-#      |  | ________/\ /             |
-#      *  |/          * merge-right  *
-#      | _|__________/ \____________ |
-#      |/ |                         \|
-# (l1) *  * merge-left               * (r1)
-#      | / \________________________ |
-#      |/                           \|
-# (l2) *                             * (r2)
-#       \___________________________ |
-#                                   \|
-#                                    * (base)
-#
-# We only push bits down the first-parent history, which
-# makes some of these commits unimportant!
-#
-# The important part for the maximal commit algorithm is how
-# the bitmasks are extended. Assuming starting bit positions
-# for second (bit 0) and other (bit 1), the bitmasks at the
-# end should be:
-#
-#      second: 1       (maximal, selected)
-#       other: 01      (maximal, selected)
-#      (base): 11 (maximal)
-#
-# This complicated history was important for a previous
-# version of the walk that guarantees never walking a
-# commit multiple times. That goal might be important
-# again, so preserve this complicated case. For now, this
-# test will guarantee that the bitmaps are computed
-# correctly, even with the repeat calculations.
+setup_bitmap_history
 
-test_expect_success 'setup repo with moderate-sized history' '
-	test_commit_bulk --id=file 10 &&
-	git branch -M second &&
-	git checkout -b other HEAD~5 &&
-	test_commit_bulk --id=side 10 &&
-
-	# add complicated history setup, including merges and
-	# ambiguous merge-bases
-
-	git checkout -b merge-left other~2 &&
-	git merge second~2 -m "merge-left" &&
-
-	git checkout -b merge-right second~1 &&
-	git merge other~1 -m "merge-right" &&
-
-	git checkout -b octo-second second &&
-	git merge merge-left merge-right -m "octopus-second" &&
-
-	git checkout -b octo-other other &&
-	git merge merge-left merge-right -m "octopus-other" &&
-
-	git checkout other &&
-	git merge octo-other -m "pull octopus" &&
-
-	git checkout second &&
-	git merge octo-second -m "pull octopus" &&
-
-	# Remove these branches so they are not selected
-	# as bitmap tips
-	git branch -D merge-left &&
-	git branch -D merge-right &&
-	git branch -D octo-other &&
-	git branch -D octo-second &&
-
-	# add padding to make these merges less interesting
-	# and avoid having them selected for bitmaps
-	test_commit_bulk --id=file 100 &&
-	git checkout other &&
-	test_commit_bulk --id=side 100 &&
-	git checkout second &&
-
-	bitmaptip=$(git rev-parse second) &&
-	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
-	git tag tagged-blob $blob &&
-	git config repack.writebitmaps true
+test_expect_success 'setup writing bitmaps during repack' '
+	git config repack.writeBitmaps true
 '
 
 test_expect_success 'full repack creates bitmaps' '
@@ -123,109 +40,7 @@ test_expect_success 'full repack creates bitmaps' '
 	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
 '
 
-test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
-	git rev-list --test-bitmap HEAD
-'
-
-rev_list_tests_head () {
-	test_expect_success "counting commits via bitmap ($state, $branch)" '
-		git rev-list --count $branch >expect &&
-		git rev-list --use-bitmap-index --count $branch >actual &&
-		test_cmp expect actual
-	'
-
-	test_expect_success "counting partial commits via bitmap ($state, $branch)" '
-		git rev-list --count $branch~5..$branch >expect &&
-		git rev-list --use-bitmap-index --count $branch~5..$branch >actual &&
-		test_cmp expect actual
-	'
-
-	test_expect_success "counting commits with limit ($state, $branch)" '
-		git rev-list --count -n 1 $branch >expect &&
-		git rev-list --use-bitmap-index --count -n 1 $branch >actual &&
-		test_cmp expect actual
-	'
-
-	test_expect_success "counting non-linear history ($state, $branch)" '
-		git rev-list --count other...second >expect &&
-		git rev-list --use-bitmap-index --count other...second >actual &&
-		test_cmp expect actual
-	'
-
-	test_expect_success "counting commits with limiting ($state, $branch)" '
-		git rev-list --count $branch -- 1.t >expect &&
-		git rev-list --use-bitmap-index --count $branch -- 1.t >actual &&
-		test_cmp expect actual
-	'
-
-	test_expect_success "counting objects via bitmap ($state, $branch)" '
-		git rev-list --count --objects $branch >expect &&
-		git rev-list --use-bitmap-index --count --objects $branch >actual &&
-		test_cmp expect actual
-	'
-
-	test_expect_success "enumerate commits ($state, $branch)" '
-		git rev-list --use-bitmap-index $branch >actual &&
-		git rev-list $branch >expect &&
-		test_bitmap_traversal --no-confirm-bitmaps expect actual
-	'
-
-	test_expect_success "enumerate --objects ($state, $branch)" '
-		git rev-list --objects --use-bitmap-index $branch >actual &&
-		git rev-list --objects $branch >expect &&
-		test_bitmap_traversal expect actual
-	'
-
-	test_expect_success "bitmap --objects handles non-commit objects ($state, $branch)" '
-		git rev-list --objects --use-bitmap-index $branch tagged-blob >actual &&
-		grep $blob actual
-	'
-}
-
-rev_list_tests () {
-	state=$1
-
-	for branch in "second" "other"
-	do
-		rev_list_tests_head
-	done
-}
-
-rev_list_tests 'full bitmap'
-
-test_expect_success 'clone from bitmapped repository' '
-	git clone --no-local --bare . clone.git &&
-	git rev-parse HEAD >expect &&
-	git --git-dir=clone.git rev-parse HEAD >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'partial clone from bitmapped repository' '
-	test_config uploadpack.allowfilter true &&
-	git clone --no-local --bare --filter=blob:none . partial-clone.git &&
-	(
-		cd partial-clone.git &&
-		pack=$(echo objects/pack/*.pack) &&
-		git verify-pack -v "$pack" >have &&
-		awk "/blob/ { print \$1 }" <have >blobs &&
-		# we expect this single blob because of the direct ref
-		git rev-parse refs/tags/tagged-blob >expect &&
-		test_cmp expect blobs
-	)
-'
-
-test_expect_success 'setup further non-bitmapped commits' '
-	test_commit_bulk --id=further 10
-'
-
-rev_list_tests 'partial bitmap'
-
-test_expect_success 'fetch (partial bitmap)' '
-	git --git-dir=clone.git fetch origin second:second &&
-	git rev-parse HEAD >expect &&
-	git --git-dir=clone.git rev-parse HEAD >actual &&
-	test_cmp expect actual
-'
+basic_bitmap_tests
 
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
@@ -461,17 +276,6 @@ test_expect_success 'truncated bitmap fails gracefully (cache)' '
 	test_i18ngrep corrupted.bitmap.index stderr
 '
 
-# have_delta <obj> <expected_base>
-#
-# Note that because this relies on cat-file, it might find _any_ copy of an
-# object in the repository. The caller is responsible for making sure
-# there's only one (e.g., via "repack -ad", or having just fetched a copy).
-have_delta () {
-	echo $2 >expect &&
-	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
-	test_cmp expect actual
-}
-
 # Create a state of history with these properties:
 #
 #  - refs that allow a client to fetch some new history, while sharing some old
-- 
2.31.1.163.ga65ce7f831

