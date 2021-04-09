Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F5C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734136115B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhDISMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhDISMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9CC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:04 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id j26so6794727iog.13
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bnhu1WdSK2enzrNWsWRMgkG8Greqw8cXSJw8oJfXEGE=;
        b=u6x6vG8OTNricqXKTujNGq5PQ6hid98M0XZ9VvP6jl3fRWbHYXCy1xMFpbXi7UtQS6
         wQM8Orq4V1+eeg/OkYSSIrWvMSC41QismsVBRZLp1BvHLws6HmyzdynJNSBZytPtUe6F
         l5vJK4oeyNNv+rb/n4jxwYRbbtbNpmPE7gdZ0IiA6Uq9l7IAfrvpkWyfQiopiPX8sFH7
         YpfLJSEjO7iO2vOYXoUMBh3SvschSO5yw/qSI9OrVJNylfXb0sV3KqCSkRJwmBOMdns3
         AqTmjhvtSw+GqHPfyYJ0o5pWdrDJlJe3M0rMXvOAxNFrazI/asXTsd3cSMaTSPEZOtbu
         FamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnhu1WdSK2enzrNWsWRMgkG8Greqw8cXSJw8oJfXEGE=;
        b=gvvTY9i9E0WXszLRUCoVD7o7/xIUpdFGR7STbnh5ACY20sljqfQKTOACTJbRbNam3I
         udRLgsFnFP3vdD1wmM+v7tFydnOauQvEdAcC1WRj6Kk3p/RPu6TeksP5k4hV+hiWxK90
         2ascdSUeI6RbxhldIqgEDIKL+4tCPciHMiW6RbOWnqtz+w9sFxi21OdzD2jknUWPRQZl
         cndOYEwr5TJ2Z4gztWqoxZW8LPjbOMabVn49yfk2+qNAnchzxAQFW98woFmll9wcyDbE
         ZWy4n5nDQNNXnKw8Or6M9usMB8Vs7w7me3ZJqLj7vgIc4CmtpGyBMOp4OBBw9yauQO1n
         +ooQ==
X-Gm-Message-State: AOAM531E/xDmYzQ+/tbGygWrpftxmBfUiZDQ5VrbE8zTe/peJHbpkVOg
        /rP9bvBGG7AU0WWgbYSV7O9YLM9C2sFe2y3K
X-Google-Smtp-Source: ABdhPJww4X1SQ5wu1WXRCIZannUFSdwggSLQAriEnUV23yegeEQ/cJvWcLPyVQQV4/QiRQdXkwN7rg==
X-Received: by 2002:a05:6638:381c:: with SMTP id i28mr15605976jav.60.1617991923063;
        Fri, 09 Apr 2021 11:12:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id k14sm1512942iov.35.2021.04.09.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:02 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 16/22] t5326: test multi-pack bitmap behavior
Message-ID: <ff74181e85975690b4fccfb6b72fb80045f4adc7.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new test, t5326, which tests the basic
functionality of multi-pack bitmaps.

Some trivial behavior is tested, such as:

  - Whether bitmaps can be generated with more than one pack.
  - Whether clones can be served with all objects in the bitmap.
  - Whether follow-up fetches can be served with some objects outside of
    the server's bitmap

These use lib-bitmap's tests (which in turn were pulled from t5310), and
we cover cases where the MIDX represents both a single pack and multiple
packs.

In addition, some non-trivial and MIDX-specific behavior is tested, too,
including:

  - Whether multi-pack bitmaps behave correctly with respect to the
    pack-reuse machinery when the base for some object is selected from
    a different pack than the delta.
  - Whether multi-pack bitmaps correctly respect the
    pack.preferBitmapTips configuration.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 278 ++++++++++++++++++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
new file mode 100755
index 0000000000..51c4f9ad78
--- /dev/null
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -0,0 +1,278 @@
+#!/bin/sh
+
+test_description='exercise basic multi-pack bitmap functionality'
+. ./test-lib.sh
+. "${TEST_DIRECTORY}/lib-bitmap.sh"
+
+# We'll be writing our own midx and bitmaps, so avoid getting confused by the
+# automatic ones.
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
+objdir=.git/objects
+midx=$objdir/pack/multi-pack-index
+
+# midx_pack_source <obj>
+midx_pack_source () {
+	test-tool read-midx --show-objects .git/objects | grep "^$1 " | cut -f2
+}
+
+setup_bitmap_history
+
+test_expect_success 'enable core.multiPackIndex' '
+	git config core.multiPackIndex true
+'
+
+test_expect_success 'create single-pack midx with bitmaps' '
+	git repack -ad &&
+	git multi-pack-index write --bitmap &&
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+'
+
+basic_bitmap_tests
+
+test_expect_success 'create new additional packs' '
+	for i in $(test_seq 1 16)
+	do
+		test_commit "$i" &&
+		git repack -d
+	done &&
+
+	git checkout -b other2 HEAD~8 &&
+	for i in $(test_seq 1 8)
+	do
+		test_commit "side-$i" &&
+		git repack -d
+	done &&
+	git checkout second
+'
+
+test_expect_success 'create multi-pack midx with bitmaps' '
+	git multi-pack-index write --bitmap &&
+
+	ls $objdir/pack/pack-*.pack >packs &&
+	test_line_count = 26 packs &&
+
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+'
+
+basic_bitmap_tests
+
+test_expect_success '--no-bitmap is respected when bitmaps exist' '
+	git multi-pack-index write --bitmap &&
+
+	test_commit respect--no-bitmap &&
+	GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&
+
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+	git multi-pack-index write --no-bitmap &&
+
+	test_path_is_file $midx &&
+	test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
+'
+
+test_expect_success 'setup midx with base from later pack' '
+	# Write a and b so that "a" is a delta on top of base "b", since Git
+	# prefers to delete contents out of a base rather than add to a shorter
+	# object.
+	test_seq 1 128 >a &&
+	test_seq 1 130 >b &&
+
+	git add a b &&
+	git commit -m "initial commit" &&
+
+	a=$(git rev-parse HEAD:a) &&
+	b=$(git rev-parse HEAD:b) &&
+
+	# In the first pack, "a" is stored as a delta to "b".
+	p1=$(git pack-objects .git/objects/pack/pack <<-EOF
+	$a
+	$b
+	EOF
+	) &&
+
+	# In the second pack, "a" is missing, and "b" is not a delta nor base to
+	# any other object.
+	p2=$(git pack-objects .git/objects/pack/pack <<-EOF
+	$b
+	$(git rev-parse HEAD)
+	$(git rev-parse HEAD^{tree})
+	EOF
+	) &&
+
+	git prune-packed &&
+	# Use the second pack as the preferred source, so that "b" occurs
+	# earlier in the MIDX object order, rendering "a" unusable for pack
+	# reuse.
+	git multi-pack-index write --bitmap --preferred-pack=pack-$p2.idx &&
+
+	have_delta $a $b &&
+	test $(midx_pack_source $a) != $(midx_pack_source $b)
+'
+
+rev_list_tests 'full bitmap with backwards delta'
+
+test_expect_success 'clone with bitmaps enabled' '
+	git clone --no-local --bare . clone-reverse-delta.git &&
+	test_when_finished "rm -fr clone-reverse-delta.git" &&
+
+	git rev-parse HEAD >expect &&
+	git --git-dir=clone-reverse-delta.git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+bitmap_reuse_tests() {
+	from=$1
+	to=$2
+
+	test_expect_success "setup pack reuse tests ($from -> $to)" '
+		rm -fr repo &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit_bulk 16 &&
+			git tag old-tip &&
+
+			git config core.multiPackIndex true &&
+			if test "MIDX" = "$from"
+			then
+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ad &&
+				git multi-pack-index write --bitmap
+			else
+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb
+			fi
+		)
+	'
+
+	test_expect_success "build bitmap from existing ($from -> $to)" '
+		(
+			cd repo &&
+			test_commit_bulk --id=further 16 &&
+			git tag new-tip &&
+
+			if test "MIDX" = "$to"
+			then
+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&
+				git multi-pack-index write --bitmap
+			else
+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb
+			fi
+		)
+	'
+
+	test_expect_success "verify resulting bitmaps ($from -> $to)" '
+		(
+			cd repo &&
+			git for-each-ref &&
+			git rev-list --test-bitmap refs/tags/old-tip &&
+			git rev-list --test-bitmap refs/tags/new-tip
+		)
+	'
+}
+
+bitmap_reuse_tests 'pack' 'MIDX'
+bitmap_reuse_tests 'MIDX' 'pack'
+bitmap_reuse_tests 'MIDX' 'MIDX'
+
+test_expect_success 'missing object closure fails gracefully' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit loose &&
+		test_commit packed &&
+
+		# Do not pass "--revs"; we want a pack without the "loose"
+		# commit.
+		git pack-objects $objdir/pack/pack <<-EOF &&
+		$(git rev-parse packed)
+		EOF
+
+		git multi-pack-index write --bitmap 2>err &&
+		grep "doesn.t have full closure" err &&
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
+	)
+'
+
+test_expect_success 'setup partial bitmaps' '
+	test_commit packed &&
+	git repack &&
+	test_commit loose &&
+	git multi-pack-index write --bitmap 2>err &&
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
+'
+
+basic_bitmap_tests HEAD~
+
+test_expect_success 'removing a MIDX clears stale bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+		test_commit base &&
+		git repack &&
+		git multi-pack-index write --bitmap &&
+
+		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
+		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
+		rm $midx &&
+
+		# Then write a new MIDX.
+		test_commit new &&
+		git repack &&
+		git multi-pack-index write --bitmap &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		test_path_is_missing $stale_bitmap
+	)
+'
+
+test_expect_success 'pack.preferBitmapTips' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit_bulk --message="%s" 103 &&
+
+		git log --format="%H" >commits.raw &&
+		sort <commits.raw >commits &&
+
+		git log --format="create refs/tags/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		git multi-pack-index write --bitmap &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >before &&
+		test_line_count = 1 before &&
+
+		perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
+			<before | git update-ref --stdin &&
+
+		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+		rm -fr $midx-$(midx_checksum $objdir).rev &&
+		rm -fr $midx &&
+
+		git -c pack.preferBitmapTips=refs/tags/include \
+			multi-pack-index write --bitmap &&
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >after &&
+
+		! test_cmp before after
+	)
+'
+
+test_done
-- 
2.31.1.163.ga65ce7f831

