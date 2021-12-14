Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A7CC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbhLNBzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbhLNBzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:41 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D71C0613F8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:40 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e128so21485378iof.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6RimBHqEjmYfmIr76gFc1c7hkCw71cBB5Tu8e3M8pIg=;
        b=ektnd6kGDxSdGXuJlCi0EuuxPJ6UdOyqrIvQrqLIuoPKuwveIRkscyeSdFuOTcptbs
         /CvKDrHq2BbD28SqyHH4FE9zP9aqbg9aGlePqa9U8d46lGj7sjzdV9wM6FhyzgGN5rtO
         UBBqZzCcBL/2K74IO6L1fkdwb3uBf02qPThW4YJgQakxZwO1PEDvaisgAjzAEbsXpvRl
         uhCaV4H9RdLY1+2VDCf+mzuAWZC0W+E33M/X4FidiWsgdlPMSxmRQOnmoWwXZSBxpSZj
         f4YLJX+gXRJ/To6BpbPZ/hfVCmVp9MmkksyQEZeLeB9lgnk7QOFJlDYG600Olbeqlu0S
         ow+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6RimBHqEjmYfmIr76gFc1c7hkCw71cBB5Tu8e3M8pIg=;
        b=h3CoBxPT46unEi0RuwcXMVZGPUZldjeESRUiroa5Cl05kl6qUWRirUsfd4aTyrbf04
         NbT60wAQK7F6eCjLtSzrIkHhn3xM5dkJixjShpRFeQQxSOKv9nD/IFHpNPEFtEOJ7Sy0
         zbqWYFOP8fberH09TxOpz5p5fdS2WGNlv+9IGC7NIA5BX4TYUnbQXefcz1PGINJRhTME
         ufYCuoobsgu+AEkF1H6EHx2A+fwEj/RGeooGFu6w/cYaBBKkMu8DuFfsvL45Hoiij1Nb
         GaTx2pi+yYa1Mq8BK6RVgGm+0RnxU0LEluPry9SPDG0ZQoeaaZVzGPQHetuS2II+2AYD
         aJSw==
X-Gm-Message-State: AOAM531lK5SJ6/qxtwSvUQWnnjBuuYQQ8KvSjZqv70iKLnyiwOxUJseW
        bBPjcN2qvBSur8Vda6exHuASIjif1aBCiBDw
X-Google-Smtp-Source: ABdhPJyEbIJ3r9ZR9QEOMf/uu61fXjk16oktFzgVR6gFKchWDZrrNfSqxyPybGAITp8e3/Gro+2EFg==
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr1627124iow.119.1639446939556;
        Mon, 13 Dec 2021 17:55:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4daeasm187111173.274.2021.12.13.17.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:39 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 5/8] t5326: extract `test_rev_exists`
Message-ID: <73faab9f429221b7be88ea88ce59bc47afb57348.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To determine which source of data is used for the MIDX's reverse index
cache, introduce a helper which forces loading the reverse index, and
then looks for the special trace2 event introduced in a previous commit.

For now, this helper just looks for when the legacy MIDX .rev file was
loaded, but in a subsequent commit will become parameterized over the
the reverse index's source.

This function replaces checking for the existence of the .rev file. We
could write a similar helper to ensure that the .rev file is cleaned up
after repacking, but it will make subsequent tests more difficult to
write, and provides marginal value since we already check that the MIDX
.bitmap file is removed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 38 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 1a9581af30..85a91c2675 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -17,16 +17,30 @@ midx_pack_source () {
 	test-tool read-midx --show-objects .git/objects | grep "^$1 " | cut -f2
 }
 
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
 setup_bitmap_history
 
 test_expect_success 'create single-pack midx with bitmaps' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap &&
 	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-	test_path_is_file $midx-$(midx_checksum $objdir).rev
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 '
 
+test_rev_exists HEAD
+
 basic_bitmap_tests
 
 test_expect_success 'create new additional packs' '
@@ -52,10 +66,11 @@ test_expect_success 'create multi-pack midx with bitmaps' '
 	test_line_count = 25 packs &&
 
 	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-	test_path_is_file $midx-$(midx_checksum $objdir).rev
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 '
 
+test_rev_exists HEAD
+
 basic_bitmap_tests
 
 test_expect_success '--no-bitmap is respected when bitmaps exist' '
@@ -66,7 +81,6 @@ test_expect_success '--no-bitmap is respected when bitmaps exist' '
 
 	test_path_is_file $midx &&
 	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-	test_path_is_file $midx-$(midx_checksum $objdir).rev &&
 
 	git multi-pack-index write --no-bitmap &&
 
@@ -206,10 +220,11 @@ test_expect_success 'setup partial bitmaps' '
 	test_commit loose &&
 	git multi-pack-index write --bitmap 2>err &&
 	test_path_is_file $midx &&
-	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-	test_path_is_file $midx-$(midx_checksum $objdir).rev
+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 '
 
+test_rev_exists HEAD~
+
 basic_bitmap_tests HEAD~
 
 test_expect_success 'removing a MIDX clears stale bitmaps' '
@@ -224,7 +239,6 @@ test_expect_success 'removing a MIDX clears stale bitmaps' '
 
 		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
 		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
-		stale_rev=$midx-$(midx_checksum $objdir).rev &&
 		rm $midx &&
 
 		# Then write a new MIDX.
@@ -234,9 +248,7 @@ test_expect_success 'removing a MIDX clears stale bitmaps' '
 
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
-		test_path_is_missing $stale_bitmap &&
-		test_path_is_missing $stale_rev
+		test_path_is_missing $stale_bitmap
 	)
 '
 
@@ -257,7 +269,6 @@ test_expect_success 'pack.preferBitmapTips' '
 		git multi-pack-index write --bitmap &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
 
 		test-tool bitmap list-commits | sort >bitmaps &&
 		comm -13 bitmaps commits >before &&
@@ -267,7 +278,6 @@ test_expect_success 'pack.preferBitmapTips' '
 			<before | git update-ref --stdin &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		git -c pack.preferBitmapTips=refs/tags/include \
@@ -305,7 +315,6 @@ test_expect_success 'writing a bitmap with --refs-snapshot' '
 		grep "$(git rev-parse two)" bitmaps &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		# Then again, but with a refs snapshot which only sees
@@ -350,7 +359,6 @@ test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
 		) >snapshot &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
-- 
2.34.1.25.gb3157a20e6

