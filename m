Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C90C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbhLNBzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbhLNBzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:43 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04635C061748
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:43 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x6so21287230iol.13
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxKTn++M2CnEK0r4vZqINfkKGZzuhEWcsoyAegcxI0g=;
        b=Qfftd2gSANY/KQG5314TdBfb/oFTr6cm657D7+132YLjfMu16xofZNXBgWGZCau1Kn
         QoCjqqsatkoO43jxQ5wXsEbX0d1dAnxY8018RRbDT/Cs3WK11WICGtwJy6ylfpRJxSJE
         OqkqrhS5ujvhEFELf33/USpxMTLKHa+OjDRRpi5yLI4qLGDhR2ZivRi02a1xnQWcKDtI
         rCHv3QR/ua3sDl0/gdwyNA038aLl5Pf9Xrq4HmlPoAOfUvaup+Zlz89Dog0z/vkAKaM1
         CimX31AUbTlACIXVuFruD3U4+QwpUXugGawrHWhGmKm1zdSGqrfwb8pwxykZDc4cbZdP
         KXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UxKTn++M2CnEK0r4vZqINfkKGZzuhEWcsoyAegcxI0g=;
        b=5vwqOlGrpFDlrjFYXo5uk+VqghQE126Xnj1FIdbU5z0nu6TgQp2I+JZ4e1hBhT7qK8
         6+VS0/6caOqIQdkEOTJp6cJR3T6/xF6SxrMnU5IFplkh1ThQ2CJIACtFqZpDxFhxdQZW
         /ccBl5o98hDIBlKWs9XvUtkSPDDhUGmFZbjeyHpuSsp0gMuxVZjEuDPVU7Z8YMzMJQAY
         88QdGdlVqpt5GuNJRg83ZXWFLPtQ6SVH0yxow+8Jggqcy2X4j50J22VABdntjwFPYEs8
         5wmmoAa1FOLlISTPfzkia0tG6C/R/BOeSXps83io/x82v8lPhqiqMOtr3Kc1D68f9WrN
         3khA==
X-Gm-Message-State: AOAM533z5dWHOXRdt6OUXg5yYnCjSq/ufKVMz6G9TQ2p/apPJf384Vao
        EwYGBHdszX+esdaHX65GsBg1Pyq7DSlmKuBy
X-Google-Smtp-Source: ABdhPJyK25QHKAN3PXz9HFDsZWaYRh2q5QQg5k9DM3+szBc69ERsVZ+qMgI5EqeL5oEnbDtzx/t3iw==
X-Received: by 2002:a05:6602:13d3:: with SMTP id o19mr1683307iov.4.1639446941914;
        Mon, 13 Dec 2021 17:55:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j16sm686831ilr.60.2021.12.13.17.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:41 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 6/8] t5326: move tests to t/lib-bitmap.sh
Message-ID: <bf42b116e1872fd69164fe15f098b7a72e938c24.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
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
 t/lib-bitmap.sh               | 178 ++++++++++++++++++++++++++++++++++
 t/t5326-multi-pack-bitmaps.sh | 174 +--------------------------------
 2 files changed, 180 insertions(+), 172 deletions(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 21d0392dda..771c41c2ea 100644
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
@@ -264,3 +267,178 @@ have_delta () {
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
+		GIT_TRACE2_EVENT_NESTING=10 \
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
index 85a91c2675..100ac90d15 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -9,135 +9,7 @@ test_description='exercise basic multi-pack bitmap functionality'
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
-		GIT_TRACE2_EVENT_NESTING=10 \
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
@@ -214,18 +86,7 @@ test_expect_success 'missing object closure fails gracefully' '
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
@@ -399,35 +260,4 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
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

