Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9397BC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiAYWlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiAYWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:18 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0233C061744
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:16 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e79so25498773iof.13
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ahHgmFwDyherQZGLThvnABviCUK+6qUyvDyUogSc9Kk=;
        b=X8sOB3T+dH4pxibrjn/fkmzHNC6LMOOofc8aFBISAc/pKVkIuqKT0ETFaWYk1jmfz2
         +T0BfOvYfHyRc7ui+9YN31GFr1euGs4C5ZZA1tw01uWkumLZ+9yQ6527cWIk7xfFWKAa
         ookNm9070Ez9l5fjCQoQfCXcGCCZvdodKCJwFh2zjUK6XPZD8NJrTF7FQF6V1Bq34p7I
         E81PohCooRZhSPt2CqcqrmWTJIeQsJOV5K4PiiRAWYCCthq0RpvqC4rT4betuNRey0C8
         WKDMHewNIiPUsLtFMqMkCaXZ4Ar/wVyKfV4kXUJyz4UxA0nsAqCmibtwBZlstOD4zO4O
         uUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ahHgmFwDyherQZGLThvnABviCUK+6qUyvDyUogSc9Kk=;
        b=qaIzo5PLXVY125xOYghtxVmsuO+Bxs3Lr37oSmMQU2ZHvwVRXqNdgYRjj/07H1RvdN
         U8AnXtm4JiTGbATadZ+lwHlifOxsRe7+h6a687pxzTHOXvqhjLAuxsyb1Gq7ucWssGia
         K0js4kZGdvBlWyOJrPBRtK00RkcTePnmVRn8q3lf6Oc0O5EJDVI9UfU2uPsA/790bryz
         6jzOfP4BdByqpxb/wU3HvTFr1BRLncnkMpCPbG2Mb0ZEhWq3/GP68UCgmULIrGh8M9mh
         xoj2sphGkl5S7Tpgfc7H8MVxR+Ih6NZm6/6p1t/DYburw6iFhEOxxCznic6JZUmKRqQI
         dnHw==
X-Gm-Message-State: AOAM531F9ukZPaCAWGP89jriwIcBl2/9buCsWjlAtGEcHu/uumkNm7p+
        6MMBsA9jTpO6B6pAoen6gXla7/dRY7IuSw==
X-Google-Smtp-Source: ABdhPJzwNZZOxSY1iNeXsEs24nIOPeRPnrYMXLQ8s5gsH6PxR18U2FZPxl7GddGGJy5XddZdDfm+mA==
X-Received: by 2002:a5e:dc44:: with SMTP id s4mr4603198iop.143.1643150476252;
        Tue, 25 Jan 2022 14:41:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p9sm9480714iln.61.2022.01.25.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:16 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 7/9] t/lib-bitmap.sh: parameterize tests over reverse
 index source
Message-ID: <3f35ef64991cae47024ee1d2ce17d800094c59f7.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for reading the reverse index data out of the MIDX itself,
teach the `test_rev_exists` function to take an expected "source" for
the reverse index data.

When given "rev", it asserts that the MIDX's `.rev` file exists, and is
loaded when verifying the integrity of its bitmaps. Otherwise, it
ensures that trace2 reports the source of the reverse index data as the
same string which was given to test_rev_exists().

The following patch will implement reading the reverse index data from
the MIDX itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-bitmap.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 48a8730a13..253895c04e 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -275,17 +275,23 @@ midx_pack_source () {
 
 test_rev_exists () {
 	commit="$1"
+	kind="$2"
 
-	test_expect_success 'reverse index exists' '
+	test_expect_success "reverse index exists ($kind)" '
 		GIT_TRACE2_EVENT=$(pwd)/event.trace \
 			git rev-list --test-bitmap "$commit" &&
 
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
-		grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"rev\"" event.trace
+		if test "rev" = "$kind"
+		then
+			test_path_is_file $midx-$(midx_checksum $objdir).rev
+		fi &&
+		grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"$kind\"" event.trace
 	'
 }
 
 midx_bitmap_core () {
+	rev_kind="${1:-rev}"
+
 	setup_bitmap_history
 
 	test_expect_success 'create single-pack midx with bitmaps' '
@@ -295,7 +301,7 @@ midx_bitmap_core () {
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
 
-	test_rev_exists HEAD
+	test_rev_exists HEAD "$rev_kind"
 
 	basic_bitmap_tests
 
@@ -325,7 +331,7 @@ midx_bitmap_core () {
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
 
-	test_rev_exists HEAD
+	test_rev_exists HEAD "$rev_kind"
 
 	basic_bitmap_tests
 
@@ -428,6 +434,8 @@ midx_bitmap_core () {
 }
 
 midx_bitmap_partial_tests () {
+	rev_kind="${1:-rev}"
+
 	test_expect_success 'setup partial bitmaps' '
 		test_commit packed &&
 		git repack &&
@@ -437,7 +445,7 @@ midx_bitmap_partial_tests () {
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
 
-	test_rev_exists HEAD~
+	test_rev_exists HEAD~ "$rev_kind"
 
 	basic_bitmap_tests HEAD~
 }
-- 
2.34.1.455.gd6eb6fd089

