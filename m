Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B727C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiAYWlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiAYWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:18 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E57C061765
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:14 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i14so18103621ila.11
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u7UFXQ9oTi4aOWlq3EWONM/LhIyqs24tSgpua/jpgaA=;
        b=yR7j/E6qWxBTUkoGxczyyl5ue7Zr1K0eqraX3pUWCetFsqAFUSKGp7gOdgMSXmhENi
         vTjfMy5wjGMSkMxNO+uBvyYqvYChnLPoaaWe48SfPbpPAOtGiZSrz8jJJDWss7m9d6of
         cNRPJrjBydH5yvxKiNdVJtQzXmC3/Bix0/pzjjcntV6KPJyewpnDmHWWZ8mlwJX2fZgW
         y0yBevWuCJeY/B13G6oK4XH4VeryGBVXHtsm4wzoKUaGNHer8mHYE6/0OmG6Nu7qnK7X
         0nUEJG+TaGhuKqJ2XZL9VSEUAANz3h59B6UtQkbhE9xFviSinvPQ7sGHEalFzwLtNY6l
         Gb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7UFXQ9oTi4aOWlq3EWONM/LhIyqs24tSgpua/jpgaA=;
        b=XvFOb61dNmqt0R6L9BlQChZyKWcb+55QPg63SNRjWMdFSJl4B86+8o06wJ4/6IqisQ
         8VHPMsUx72lDIbOZUq8ilqcwLAj66jsotuhPe6bjp5FEmhIRk34zGx3CFwHJAiXqIHi7
         nqJXf1uq55YpMgG3/P9pMUDFhVqBg7sTji7MpeA7hUKZqmWA1zB6XTkokDBxoL4UXpON
         EwadedzHZECKOoQ/wT5nBuTrH1qbgXOAL/kPXi7iDUkwuLC39UMRkHyMZjPwphYemua2
         g14x02F1j2vbEYfznh3PQrKblOO60mPnk0ngmnNt4nqlKFopfxdPMcZWPHGCODRSneWc
         xNZA==
X-Gm-Message-State: AOAM533LZSJcX8kQlOR6wPVl7zFl44U3zvia0zzGTxaI/pKPR77A8mfg
        rid0UzPkEK6E4AFblvaNMS1SgTKA3oEgEg==
X-Google-Smtp-Source: ABdhPJwXAmrYF2Z8Mbe5JUm9TBmveZbGInsdnfQPQFvT91vLytl11KH11pad7xDbR29KfMKnoDJKUg==
X-Received: by 2002:a05:6e02:180e:: with SMTP id a14mr11003582ilv.307.1643150473896;
        Tue, 25 Jan 2022 14:41:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x19sm33333iov.33.2022.01.25.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:13 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 6/9] t5326: move tests to t/lib-bitmap.sh
Message-ID: <00c6e914b45b8a7fd52fd62c7cf020272793f83d.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t5326, we have a handful of tests that we would like to run twice:
once using the MIDX's new `RIDX` chunk as the source of the
reverse-index cache, and once using the separate `.rev` file.

But because these tests mutate the state of the underlying repository,
and then make assumptions about those mutations occurring in a certain
sequence, simply running the tests twice in the same repository is
awkward.

Instead, extract the core of interesting tests into t/lib-bitmap.sh to
prepare for them to be run twice, each in a separate test script. This
means that they can each operate on a separate repository, removing any
concerns about mutating state.

For now, this patch is a strict cut-and-paste of some tests from t5326.
The tests which did not move are not interesting with respect to the
source of their reverse index data.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-bitmap.sh               | 177 ++++++++++++++++++++++++++++++++++
 t/t5326-multi-pack-bitmaps.sh | 173 +--------------------------------
 2 files changed, 179 insertions(+), 171 deletions(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 21d0392dda..48a8730a13 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -1,6 +1,9 @@
 # Helpers for scripts testing bitmap functionality; see t5310 for
 # example usage.
 
+objdir=.git/objects
+midx=$objdir/pack/multi-pack-index
+
 # Compare a file containing rev-list bitmap traversal output to its non-bitmap
 # counterpart. You can't just use test_cmp for this, because the two produce
 # subtly different output:
@@ -264,3 +267,177 @@ have_delta () {
 midx_checksum () {
 	test-tool read-midx --checksum "$1"
 }
+
+# midx_pack_source <obj>
+midx_pack_source () {
+	test-tool read-midx --show-objects .git/objects | grep "^$1 " | cut -f2
+}
+
+test_rev_exists () {
+	commit="$1"
+
+	test_expect_success 'reverse index exists' '
+		GIT_TRACE2_EVENT=$(pwd)/event.trace \
+			git rev-list --test-bitmap "$commit" &&
+
+		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
+		grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"rev\"" event.trace
+	'
+}
+
+midx_bitmap_core () {
+	setup_bitmap_history
+
+	test_expect_success 'create single-pack midx with bitmaps' '
+		git repack -ad &&
+		git multi-pack-index write --bitmap &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+	'
+
+	test_rev_exists HEAD
+
+	basic_bitmap_tests
+
+	test_expect_success 'create new additional packs' '
+		for i in $(test_seq 1 16)
+		do
+			test_commit "$i" &&
+			git repack -d || return 1
+		done &&
+
+		git checkout -b other2 HEAD~8 &&
+		for i in $(test_seq 1 8)
+		do
+			test_commit "side-$i" &&
+			git repack -d || return 1
+		done &&
+		git checkout second
+	'
+
+	test_expect_success 'create multi-pack midx with bitmaps' '
+		git multi-pack-index write --bitmap &&
+
+		ls $objdir/pack/pack-*.pack >packs &&
+		test_line_count = 25 packs &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+	'
+
+	test_rev_exists HEAD
+
+	basic_bitmap_tests
+
+	test_expect_success '--no-bitmap is respected when bitmaps exist' '
+		git multi-pack-index write --bitmap &&
+
+		test_commit respect--no-bitmap &&
+		git repack -d &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		git multi-pack-index write --no-bitmap &&
+
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap &&
+		test_path_is_missing $midx-$(midx_checksum $objdir).rev
+	'
+
+	test_expect_success 'setup midx with base from later pack' '
+		# Write a and b so that "a" is a delta on top of base "b", since Git
+		# prefers to delete contents out of a base rather than add to a shorter
+		# object.
+		test_seq 1 128 >a &&
+		test_seq 1 130 >b &&
+
+		git add a b &&
+		git commit -m "initial commit" &&
+
+		a=$(git rev-parse HEAD:a) &&
+		b=$(git rev-parse HEAD:b) &&
+
+		# In the first pack, "a" is stored as a delta to "b".
+		p1=$(git pack-objects .git/objects/pack/pack <<-EOF
+		$a
+		$b
+		EOF
+		) &&
+
+		# In the second pack, "a" is missing, and "b" is not a delta nor base to
+		# any other object.
+		p2=$(git pack-objects .git/objects/pack/pack <<-EOF
+		$b
+		$(git rev-parse HEAD)
+		$(git rev-parse HEAD^{tree})
+		EOF
+		) &&
+
+		git prune-packed &&
+		# Use the second pack as the preferred source, so that "b" occurs
+		# earlier in the MIDX object order, rendering "a" unusable for pack
+		# reuse.
+		git multi-pack-index write --bitmap --preferred-pack=pack-$p2.idx &&
+
+		have_delta $a $b &&
+		test $(midx_pack_source $a) != $(midx_pack_source $b)
+	'
+
+	rev_list_tests 'full bitmap with backwards delta'
+
+	test_expect_success 'clone with bitmaps enabled' '
+		git clone --no-local --bare . clone-reverse-delta.git &&
+		test_when_finished "rm -fr clone-reverse-delta.git" &&
+
+		git rev-parse HEAD >expect &&
+		git --git-dir=clone-reverse-delta.git rev-parse HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success 'changing the preferred pack does not corrupt bitmaps' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit A &&
+			test_commit B &&
+
+			git rev-list --objects --no-object-names HEAD^ >A.objects &&
+			git rev-list --objects --no-object-names HEAD^.. >B.objects &&
+
+			A=$(git pack-objects $objdir/pack/pack <A.objects) &&
+			B=$(git pack-objects $objdir/pack/pack <B.objects) &&
+
+			cat >indexes <<-EOF &&
+			pack-$A.idx
+			pack-$B.idx
+			EOF
+
+			git multi-pack-index write --bitmap --stdin-packs \
+				--preferred-pack=pack-$A.pack <indexes &&
+			git rev-list --test-bitmap A &&
+
+			git multi-pack-index write --bitmap --stdin-packs \
+				--preferred-pack=pack-$B.pack <indexes &&
+			git rev-list --test-bitmap A
+		)
+	'
+}
+
+midx_bitmap_partial_tests () {
+	test_expect_success 'setup partial bitmaps' '
+		test_commit packed &&
+		git repack &&
+		test_commit loose &&
+		git multi-pack-index write --bitmap 2>err &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+	'
+
+	test_rev_exists HEAD~
+
+	basic_bitmap_tests HEAD~
+}
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 999740f8c7..100ac90d15 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -9,134 +9,7 @@ test_description='exercise basic multi-pack bitmap functionality'
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
-objdir=.git/objects
-midx=$objdir/pack/multi-pack-index
-
-# midx_pack_source <obj>
-midx_pack_source () {
-	test-tool read-midx --show-objects .git/objects | grep "^$1 " | cut -f2
-}
-
-test_rev_exists () {
-	commit="$1"
-
-	test_expect_success 'reverse index exists' '
-		GIT_TRACE2_EVENT=$(pwd)/event.trace \
-			git rev-list --test-bitmap "$commit" &&
-
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
-		grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"rev\"" event.trace
-	'
-}
-
-setup_bitmap_history
-
-test_expect_success 'create single-pack midx with bitmaps' '
-	git repack -ad &&
-	git multi-pack-index write --bitmap &&
-	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
-'
-
-test_rev_exists HEAD
-
-basic_bitmap_tests
-
-test_expect_success 'create new additional packs' '
-	for i in $(test_seq 1 16)
-	do
-		test_commit "$i" &&
-		git repack -d || return 1
-	done &&
-
-	git checkout -b other2 HEAD~8 &&
-	for i in $(test_seq 1 8)
-	do
-		test_commit "side-$i" &&
-		git repack -d || return 1
-	done &&
-	git checkout second
-'
-
-test_expect_success 'create multi-pack midx with bitmaps' '
-	git multi-pack-index write --bitmap &&
-
-	ls $objdir/pack/pack-*.pack >packs &&
-	test_line_count = 25 packs &&
-
-	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
-'
-
-test_rev_exists HEAD
-
-basic_bitmap_tests
-
-test_expect_success '--no-bitmap is respected when bitmaps exist' '
-	git multi-pack-index write --bitmap &&
-
-	test_commit respect--no-bitmap &&
-	git repack -d &&
-
-	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-
-	git multi-pack-index write --no-bitmap &&
-
-	test_path_is_file $midx &&
-	test_path_is_missing $midx-$(midx_checksum $objdir).bitmap &&
-	test_path_is_missing $midx-$(midx_checksum $objdir).rev
-'
-
-test_expect_success 'setup midx with base from later pack' '
-	# Write a and b so that "a" is a delta on top of base "b", since Git
-	# prefers to delete contents out of a base rather than add to a shorter
-	# object.
-	test_seq 1 128 >a &&
-	test_seq 1 130 >b &&
-
-	git add a b &&
-	git commit -m "initial commit" &&
-
-	a=$(git rev-parse HEAD:a) &&
-	b=$(git rev-parse HEAD:b) &&
-
-	# In the first pack, "a" is stored as a delta to "b".
-	p1=$(git pack-objects .git/objects/pack/pack <<-EOF
-	$a
-	$b
-	EOF
-	) &&
-
-	# In the second pack, "a" is missing, and "b" is not a delta nor base to
-	# any other object.
-	p2=$(git pack-objects .git/objects/pack/pack <<-EOF
-	$b
-	$(git rev-parse HEAD)
-	$(git rev-parse HEAD^{tree})
-	EOF
-	) &&
-
-	git prune-packed &&
-	# Use the second pack as the preferred source, so that "b" occurs
-	# earlier in the MIDX object order, rendering "a" unusable for pack
-	# reuse.
-	git multi-pack-index write --bitmap --preferred-pack=pack-$p2.idx &&
-
-	have_delta $a $b &&
-	test $(midx_pack_source $a) != $(midx_pack_source $b)
-'
-
-rev_list_tests 'full bitmap with backwards delta'
-
-test_expect_success 'clone with bitmaps enabled' '
-	git clone --no-local --bare . clone-reverse-delta.git &&
-	test_when_finished "rm -fr clone-reverse-delta.git" &&
-
-	git rev-parse HEAD >expect &&
-	git --git-dir=clone-reverse-delta.git rev-parse HEAD >actual &&
-	test_cmp expect actual
-'
+midx_bitmap_core
 
 bitmap_reuse_tests() {
 	from=$1
@@ -213,18 +86,7 @@ test_expect_success 'missing object closure fails gracefully' '
 	)
 '
 
-test_expect_success 'setup partial bitmaps' '
-	test_commit packed &&
-	git repack &&
-	test_commit loose &&
-	git multi-pack-index write --bitmap 2>err &&
-	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
-'
-
-test_rev_exists HEAD~
-
-basic_bitmap_tests HEAD~
+midx_bitmap_partial_tests
 
 test_expect_success 'removing a MIDX clears stale bitmaps' '
 	rm -fr repo &&
@@ -398,35 +260,4 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
 	)
 '
 
-test_expect_success 'changing the preferred pack does not corrupt bitmaps' '
-	rm -fr repo &&
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit A &&
-		test_commit B &&
-
-		git rev-list --objects --no-object-names HEAD^ >A.objects &&
-		git rev-list --objects --no-object-names HEAD^.. >B.objects &&
-
-		A=$(git pack-objects $objdir/pack/pack <A.objects) &&
-		B=$(git pack-objects $objdir/pack/pack <B.objects) &&
-
-		cat >indexes <<-EOF &&
-		pack-$A.idx
-		pack-$B.idx
-		EOF
-
-		git multi-pack-index write --bitmap --stdin-packs \
-			--preferred-pack=pack-$A.pack <indexes &&
-		git rev-list --test-bitmap A &&
-
-		git multi-pack-index write --bitmap --stdin-packs \
-			--preferred-pack=pack-$B.pack <indexes &&
-		git rev-list --test-bitmap A
-	)
-'
-
 test_done
-- 
2.34.1.455.gd6eb6fd089

