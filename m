Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0150C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiAYWlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiAYWlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:17 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321FC061757
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q204so10967202iod.8
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXqyqKrGqhuyKnIcdyeOLlaH2ABLsAVJJgOjdVoX4EE=;
        b=YxzDqtxQfuIq3uec2bWIczJoCbHXll4jEifUkOkfHQSJPOZqIFnndZk9HzLh5SPNcd
         4oiby5mjnKXTRecrb32abH5q6iRtCMK30uyDiSIsBkpjXRTmmC7fyoEBr1CKzxQetvdh
         RNSXW9EdVrUW76in3L2ALAY9QhOphtLh/NfltWhJteRG6yq0IOFJB7/Civalz2pAwW8n
         mLVTDy1vq0cmIgO+DRjOmp5tOp0UIEXBsBhEtA+zOlTFnY8IREZIACvpMr6/I8/iFZA4
         qf5WPovr7F9qxms1Qo1F1qGzmg+jsZSkYKrydoLJihCy9ptLt0wiQtjDb9KRIhL8dQDZ
         G4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXqyqKrGqhuyKnIcdyeOLlaH2ABLsAVJJgOjdVoX4EE=;
        b=hTfGudBM9RimKWO/DvgknhgyN8WrzxCM5tPXb7j2CC0yHZtoTLVMRqAzHGjO8Wd1ET
         QDFtZ/Hpwr2UraAR69AIqBNZAUWUGglnJdCQ27vp9NHK6d/Eg2pu5aUIcajZMGWcbYnr
         1FwyEvYxOoLLm2jPSugCbBszG4FcISD4zZCJ8eZ7F/nV9fkqd+WN9xI+oI9lPs5HXVCo
         ETenf1991g9z0MhgsKPNP+zgw5F7d3ebA/FkUawzzcJhc7HSJXGaL+u/ipbXcRA6rCvT
         gDXbin4OkBWkWM5i9qeIAw0TDVAi5aQAQ1uhUFNxgBhCsVBO3wAVgVfgAvLalPdICWne
         mj5g==
X-Gm-Message-State: AOAM532YVlJasykBQwOXYw8vayQgd54fj90VOZwlx3djMnTU5B3KoWjE
        nOxNsWiv6aHkZzLe/aquMYBiGetcTGBN6A==
X-Google-Smtp-Source: ABdhPJx++QkwhyUL8UrZLjh8ZdCiMhBEZ8jRDvOD4oMoKshbb2Dj3gJtKtSpM8VrtQmPfH8BTPr9aw==
X-Received: by 2002:a05:6638:5ae:: with SMTP id b14mr7456127jar.285.1643150471567;
        Tue, 25 Jan 2022 14:41:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s12sm8200773ilv.40.2022.01.25.14.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:11 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 5/9] t5326: extract `test_rev_exists`
Message-ID: <b9c4ff863647c3719725b3ab290e055493b7d6af.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
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
2.34.1.455.gd6eb6fd089

