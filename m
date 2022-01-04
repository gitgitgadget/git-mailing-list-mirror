Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A81C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiADSP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiADSP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:56 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21845C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:56 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t66so24243859qkb.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E12vkO/ps71LLId4vEM7DU+LX8fmvF1bBpY+mPbeZZA=;
        b=lr75691Av15gP8Wfg6jc3xgV4peIqvsdzFT0cwfbzk0qrZcvFFoP7Ik9fND8ZN1mV7
         PKx3w5y7CJ8KpVEE7Cnywd/gc6v+rlsnfdUZ5xlCh4pzdrejF64BgJjNYVcrmINrfBpB
         0AMipQY+zGLO87Xcv23oBF8LcA+NdQ2S4i1ECRx8ZQ6G/PLptSHq3XxLlT6s2PwBjBUf
         WUe0BRWTH/eJI5GL7mpfm9pLTwblfeHMzWH9oBqdY61BCk+1w7u/jwkDUeu4UmXWM+cv
         OS794ExCS8cMOrXQKyIjlPKKfb7JdQ/Xrjmtyjxq1+MfUn8XjcoBGV2PZtP0HydXtLYC
         auYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E12vkO/ps71LLId4vEM7DU+LX8fmvF1bBpY+mPbeZZA=;
        b=l2IdufXQ5kPefS/wVBm7k+q28p0qFlhZo2ZCScabEcd7NXdQpDnLbSZCou/zCPeHqk
         I0lCseYMCRoVNqI3p4X7pfxT8H8as4FmVtuo/2xZCe72ObvKHfzXIZKAl6njpLl+FfyW
         QtXNVI2pfNUs2BuVNZxYwoj/OQu67FK8u0oe5tmmY9CeJXmLtAVqL2fBbgqBKq5l5sE1
         OEYIbsNHwyOSzy41FxWCHgf8JF4tOGoqGpAG31JjH6VffIsy7fEGq39EaEBSPSPL9vlO
         /5MZ6lT6HsbagsKwH3/Bti3j7vQZpsb8gjaJcEhOjGwVYYFWNnIUglIwWLmW58AojfZy
         +PXA==
X-Gm-Message-State: AOAM532yZyLpnp6NaFOeyoG5u4c0TO3nsiN5sTZCeWZ1SSunfExzGJte
        9KPhMXwFFE1gYnYiWKll4YKmZyZp2qpePf7w
X-Google-Smtp-Source: ABdhPJz6hSs6uAVngZWgd15i9H97JnkhULDio+SvyFmyZxkJWO7Y18KFJlcbXz4xq8U8q7qmwdDxWA==
X-Received: by 2002:a05:620a:bc3:: with SMTP id s3mr36811218qki.197.1641320155002;
        Tue, 04 Jan 2022 10:15:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7sm34744279qtx.67.2022.01.04.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:54 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 6/9] t5326: move tests to t/lib-bitmap.sh
Message-ID: <76e23cae0f42afef982a4e94ec551335774be6f2.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
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
2.34.1.25.gb3157a20e6

