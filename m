Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE6BC4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9973F6103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbhHaUxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbhHaUxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17454C0612AF
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y18so833950ioc.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5I5iCRwXj1odODBDC0Zi2ykOdJx9BfcfMSR4YOfpZQ=;
        b=kwN56Xj6+kqflYnOOeto0g+BVXDE2Q98mJXAMb1Gu9yVyRXdo7Kz/+oj2g7W1+VoxX
         DbALaAtm/dRHHqiV0yX6Aknubcyt8h4yIz3Y7Owei0rB6anq37rtMqDCDFZZOG90XQos
         2T2ipmAxQLfqbro0q0jdiCEryMOFvVLHw9BKosWV82YWbPDsZJ/M0Pjql/HaPHQ/v9kb
         wkRiMawCx/y/Dc/Cmi23jHf2ZhGlCgennwDzRkkx2ztxyUYYoWcdkV8SiWWEFoa7JR5y
         oNWd82aCTsVVWNbu/bMvkCBP+vi+qUWCeb779uSFbhf3tf11EEv6pEs2ssl5TwgZAPNZ
         k+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5I5iCRwXj1odODBDC0Zi2ykOdJx9BfcfMSR4YOfpZQ=;
        b=Y2if3Bwi0y6uvgqDAxqLu4jtCSWaoo9i6ohwykQFDYXKd45F5E5gc5Vik93DtAJrle
         HmeRqpqRfO0AG+nyPJzCZ4pS0YRvcg8E48NeBIF9Mkollh35HxVRM2JSCFKnd1jAAG0p
         QsDWOgixoAcf+4/h60xMJFE3Zx99Q4oV0g0M1BpbnY7YMaKVBDgD5b8vuDI14gv0isLO
         T9NadS448wUPxpYY3fXc3J2wLrOs6XujrgDjQwZvVtIXLiCI6D0WhBpcsT3ukADAvsCd
         tfNT2eaxfYvjFSAeRCZ9N4pZgyk1uY1mbpE7b4p8227DC1wjrXfOSQr+urZ6XNS1stVb
         OutQ==
X-Gm-Message-State: AOAM532EyWBOrgewPwrWCpZHIzIuo462S/ohGrLl5xLZux48L2N+pfTa
        TWiyV8dWx1Lqckk4Az5lUNZFyCSn8jvIFE/O
X-Google-Smtp-Source: ABdhPJxB01PpZ1GtaIW5hUDfPZwPalHBxz5iQ7ekksstnBcCC17LuzZxvIHEKbJSyrRIVpzbYEEIVQ==
X-Received: by 2002:a6b:5c0c:: with SMTP id z12mr18053584ioh.171.1630443152252;
        Tue, 31 Aug 2021 13:52:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a17sm10886203ilp.75.2021.08.31.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:31 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 20/27] t5326: test multi-pack bitmap behavior
Message-ID: <8895114ace2e9d5392f5c71b7ea4190b90c01db8.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
 t/t5326-multi-pack-bitmaps.sh | 286 ++++++++++++++++++++++++++++++++++
 1 file changed, 286 insertions(+)
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
new file mode 100755
index 0000000000..4ad7c2c969
--- /dev/null
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -0,0 +1,286 @@
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
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+	test_path_is_file $midx-$(midx_checksum $objdir).rev
+'
+
+basic_bitmap_tests
+
+test_expect_success 'create new additional packs' '
+	for i in $(test_seq 1 16)
+	do
+		test_commit "$i" &&
+		git repack -d || return 1
+	done &&
+
+	git checkout -b other2 HEAD~8 &&
+	for i in $(test_seq 1 8)
+	do
+		test_commit "side-$i" &&
+		git repack -d || return 1
+	done &&
+	git checkout second
+'
+
+test_expect_success 'create multi-pack midx with bitmaps' '
+	git multi-pack-index write --bitmap &&
+
+	ls $objdir/pack/pack-*.pack >packs &&
+	test_line_count = 25 packs &&
+
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+	test_path_is_file $midx-$(midx_checksum $objdir).rev
+'
+
+basic_bitmap_tests
+
+test_expect_success '--no-bitmap is respected when bitmaps exist' '
+	git multi-pack-index write --bitmap &&
+
+	test_commit respect--no-bitmap &&
+	git repack -d &&
+
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+	test_path_is_file $midx-$(midx_checksum $objdir).rev &&
+
+	git multi-pack-index write --no-bitmap &&
+
+	test_path_is_file $midx &&
+	test_path_is_missing $midx-$(midx_checksum $objdir).bitmap &&
+	test_path_is_missing $midx-$(midx_checksum $objdir).rev
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
+				git repack -Ad &&
+				git multi-pack-index write --bitmap
+			else
+				git repack -Adb
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
+				git repack -d &&
+				git multi-pack-index write --bitmap
+			else
+				git repack -Adb
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
+		test_must_fail git multi-pack-index write --bitmap 2>err &&
+		grep "doesn.t have full closure" err &&
+		test_path_is_missing $midx
+	)
+'
+
+test_expect_success 'setup partial bitmaps' '
+	test_commit packed &&
+	git repack &&
+	test_commit loose &&
+	git multi-pack-index write --bitmap 2>err &&
+	test_path_is_file $midx &&
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+	test_path_is_file $midx-$(midx_checksum $objdir).rev
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
+		stale_rev=$midx-$(midx_checksum $objdir).rev &&
+		rm $midx &&
+
+		# Then write a new MIDX.
+		test_commit new &&
+		git repack &&
+		git multi-pack-index write --bitmap &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
+		test_path_is_missing $stale_bitmap &&
+		test_path_is_missing $stale_rev
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
+		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
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
2.33.0.96.g73915697e6

