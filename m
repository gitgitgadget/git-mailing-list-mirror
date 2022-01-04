Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EDFC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiADSPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiADSPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:54 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68206C061395
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:53 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id fq10so35120529qvb.10
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=duo42mmwjDG7xzHwpCbjszexAEaF0rYVp05lq6fruSo=;
        b=i0VQg2XKHZwLatgDtAHQhwmmXsRP0CYdMiVMrmxtd1qPQkwjstDi0ehateCUP74SyN
         KfpI5woGkYPDtebujM5o8OTab8ZIhLN1Kg/q1KCV5jG1XGDy3Oz5FQALRYweO4tG6pIr
         H/V8gyvepvdjs+fXIqV/p78jpIgEnK+79O+4JfHz2h4ucNdTF+9o255ubKvHDRFg0t8Y
         zmaXOwrM+hJBUiRVdKaGx+7tVflGjO98xlciDrvvLnJoyUIqXEIddVah56s7UimJtR/K
         l4Vw+yN0guYrGZCm2bZhF0Ctench7wi8PEseOs5F1hyt5EDOaxKPf+sm3Xoac/8JjUho
         8EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=duo42mmwjDG7xzHwpCbjszexAEaF0rYVp05lq6fruSo=;
        b=KS4j9MVCqbeSMmdg9xJswxFKpeFOs2ZRQKkxp/s+H6Ce9/inzhv1pIKfn5T6jImc0+
         ctvyhiplBnOrZaziixzBRBRUEW1mFfAUMrT+ro1tYBfr+hsMBlpFGyiPiyx8lyrhDDo/
         8E7pg+sTF55DCl6ba3gpMEIaXKo7koDQdep+kD+IUG8vi1zdSs7fIaDhJCx/Kov/wK/1
         Gbam66AgqI9ifFK/QhQ3+9nkAdBv6bGz2H6zfjSN/d90ktR5LdFGu31YW+AYIuXXV8Cn
         SvFCGK18CTeT6IPJN07Fda5XM6CJ1Hf/34qUZcQUuLLvEpsaArlz0QhckZjZILmhm3nm
         qmvw==
X-Gm-Message-State: AOAM533VgvhkPz3g6+TPjsFWFeMO6CSLzX/8W60fEgxsPSwxYNVuqc3H
        UKz9C+hHRPWlsC+/GbiL5hHb/rMwqiS5sPqf
X-Google-Smtp-Source: ABdhPJxrDtdinURh6gspw/JEPMaExyYqJ2d2gsKOgtQkrZ3fn7EoZ79Wll4kyFIbdQ+X0hfDlzd5fA==
X-Received: by 2002:ad4:5be5:: with SMTP id k5mr47247822qvc.19.1641320152440;
        Tue, 04 Jan 2022 10:15:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p16sm30741697qtx.19.2022.01.04.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:52 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 5/9] t5326: extract `test_rev_exists`
Message-ID: <33502d6a17b6b927d43a015859e40e6cdaab6667.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
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
 t/t5326-multi-pack-bitmaps.sh | 37 +++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 1a9581af30..999740f8c7 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -17,16 +17,29 @@ midx_pack_source () {
 	test-tool read-midx --show-objects .git/objects | grep "^$1 " | cut -f2
 }
 
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
@@ -52,10 +65,11 @@ test_expect_success 'create multi-pack midx with bitmaps' '
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
@@ -66,7 +80,6 @@ test_expect_success '--no-bitmap is respected when bitmaps exist' '
 
 	test_path_is_file $midx &&
 	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-	test_path_is_file $midx-$(midx_checksum $objdir).rev &&
 
 	git multi-pack-index write --no-bitmap &&
 
@@ -206,10 +219,11 @@ test_expect_success 'setup partial bitmaps' '
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
@@ -224,7 +238,6 @@ test_expect_success 'removing a MIDX clears stale bitmaps' '
 
 		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
 		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
-		stale_rev=$midx-$(midx_checksum $objdir).rev &&
 		rm $midx &&
 
 		# Then write a new MIDX.
@@ -234,9 +247,7 @@ test_expect_success 'removing a MIDX clears stale bitmaps' '
 
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
-		test_path_is_missing $stale_bitmap &&
-		test_path_is_missing $stale_rev
+		test_path_is_missing $stale_bitmap
 	)
 '
 
@@ -257,7 +268,6 @@ test_expect_success 'pack.preferBitmapTips' '
 		git multi-pack-index write --bitmap &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
 
 		test-tool bitmap list-commits | sort >bitmaps &&
 		comm -13 bitmaps commits >before &&
@@ -267,7 +277,6 @@ test_expect_success 'pack.preferBitmapTips' '
 			<before | git update-ref --stdin &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		git -c pack.preferBitmapTips=refs/tags/include \
@@ -305,7 +314,6 @@ test_expect_success 'writing a bitmap with --refs-snapshot' '
 		grep "$(git rev-parse two)" bitmaps &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		# Then again, but with a refs snapshot which only sees
@@ -350,7 +358,6 @@ test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
 		) >snapshot &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
-- 
2.34.1.25.gb3157a20e6

