Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F92C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA08610A3
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhHXQRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhHXQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F8C061796
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a21so27065850ioq.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bwJLEVJAqDBg7h/hClOBrPy1jfzi4ZxSTwORxqWd3PU=;
        b=hg2gc9kq4KR/GnLC3+zvjEfTIe1Iozhu2P7LfYt29Cy2/6D62hz7YiUxaR/mgehdx/
         7rpHjjw+G3JLsyCCDsS75vnO/FMnUpOVRJ/PjrxSBQtHd7IIGD2LypIem3WqJ2ukwJHE
         /q62fNDyMFzwwiYQB/SlmAKt4jUEOwPcCT2lCjEL9jm3ICLOXhMQ+YxL42zgjMzQ/2d+
         gpmfKot7JzkhhiMceHyf/XIjCS7bGvNSK5aeC2tvSMbibqmB7NS5l0kceLspb+aM259l
         SUK46OgkDFMYE/zBbZibs4MoCzWzSx6iQOumM9zZVPT8Hb5oW8irm5m0F91gLl2VXyiQ
         V6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bwJLEVJAqDBg7h/hClOBrPy1jfzi4ZxSTwORxqWd3PU=;
        b=XXQ0TEyKLiSwevVz3WpoOOjK6isrqIz2FGNta9gdkWWppl6VPWbvkwfb3zX9yYlXSP
         uekCYPc115S9NeW/nm/5p7UNXB2fRW9wgQQAOhRn10QlQmDlvDjVvKo3JWspncI3Od9E
         Q0bUXWb3tuabEEBlVjSispLD/d6FZlIhnGQCMB4X0/ch26vXucRU0tcnQvrf5wWAxpQN
         t656wHUDx6nIq1/+qawA+JcmZO0jEmTOQsi9/AZaojbLkZVJQwCp9iyz23Jig33G1J/E
         iE89BfJHGXBIcn17pWSdr85IsELKOgfsnZnyQUT7fBXcZ49vRwHceKDG5EPqLkEZH3yt
         I4gw==
X-Gm-Message-State: AOAM530fPzwYWBupCtKt/sdhg2osmr6r/E8K/YtzavQac/Hs7+o8krKG
        lT72F51NB6SgktGlQDAg/AcW7ZBjgQ5WWBRJ
X-Google-Smtp-Source: ABdhPJwR4UldYX40S7C1okwiT8dtedrzzOc3W8VWIsXeqOV83zt+nRhVFTqNMwuN4y3rb8CktcB1Ag==
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr31408028iod.81.1629821792115;
        Tue, 24 Aug 2021 09:16:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o11sm10090547ilf.86.2021.08.24.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:31 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 16/25] t5310: move some tests to lib-bitmap.sh
Message-ID: <a92af898846531878e291acbb5cd7ed2ee18d644.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
 t/lib-bitmap.sh         | 236 ++++++++++++++++++++++++++++++++++++++++
 t/t5310-pack-bitmaps.sh | 227 +-------------------------------------
 2 files changed, 240 insertions(+), 223 deletions(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index fe3f98be24..77464da6fd 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -1,3 +1,6 @@
+# Helpers for scripts testing bitmap functionality; see t5310 for
+# example usage.
+
 # Compare a file containing rev-list bitmap traversal output to its non-bitmap
 # counterpart. You can't just use test_cmp for this, because the two produce
 # subtly different output:
@@ -24,3 +27,236 @@ test_bitmap_traversal () {
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
+
+	test_expect_success 'enumerating progress counts pack-reused objects' '
+		count=$(git rev-list --objects --all --count) &&
+		git repack -adb &&
+
+		# check first with only reused objects; confirm that our
+		# progress showed the right number, and also that we did
+		# pack-reuse as expected.  Check only the final "done"
+		# line of the meter (there may be an arbitrary number of
+		# intermediate lines ending with CR).
+		GIT_PROGRESS_DELAY=0 \
+			git pack-objects --all --stdout --progress \
+			</dev/null >/dev/null 2>stderr &&
+		grep "Enumerating objects: $count, done" stderr &&
+		grep "pack-reused $count" stderr &&
+
+		# now the same but with one non-reused object
+		git commit --allow-empty -m "an extra commit object" &&
+		GIT_PROGRESS_DELAY=0 \
+			git pack-objects --all --stdout --progress \
+			</dev/null >/dev/null 2>stderr &&
+		grep "Enumerating objects: $((count+1)), done" stderr &&
+		grep "pack-reused $count" stderr
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
index b02838750e..4318f84d53 100755
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
@@ -461,40 +276,6 @@ test_expect_success 'truncated bitmap fails gracefully (cache)' '
 	test_i18ngrep corrupted.bitmap.index stderr
 '
 
-test_expect_success 'enumerating progress counts pack-reused objects' '
-	count=$(git rev-list --objects --all --count) &&
-	git repack -adb &&
-
-	# check first with only reused objects; confirm that our progress
-	# showed the right number, and also that we did pack-reuse as expected.
-	# Check only the final "done" line of the meter (there may be an
-	# arbitrary number of intermediate lines ending with CR).
-	GIT_PROGRESS_DELAY=0 \
-		git pack-objects --all --stdout --progress \
-		</dev/null >/dev/null 2>stderr &&
-	grep "Enumerating objects: $count, done" stderr &&
-	grep "pack-reused $count" stderr &&
-
-	# now the same but with one non-reused object
-	git commit --allow-empty -m "an extra commit object" &&
-	GIT_PROGRESS_DELAY=0 \
-		git pack-objects --all --stdout --progress \
-		</dev/null >/dev/null 2>stderr &&
-	grep "Enumerating objects: $((count+1)), done" stderr &&
-	grep "pack-reused $count" stderr
-'
-
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

