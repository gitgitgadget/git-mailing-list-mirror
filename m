Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660E0C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiADSQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiADSP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:58 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D08C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:58 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kd9so35052328qvb.11
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amRhedGuSHl1b2MYxVwt+xMWJ0GNSUpVqqCAdkmPxnQ=;
        b=6j3aKgg+qsdq8d9alseGPmRGQBhoHNsmnsNfOpPRHakmKoQvJK19qopuBfBaj/0UgB
         Oul4Ywj6RuW9o2TabQUBLh3kw3tdmUSMfH7kFVL/LPmnDOb/4relM1DFUf+hSq8ktKMl
         z66OKBgacp6xn0t0EM2WAPgSetX3M19v1bxpo9XPPhNqYWVD2Q5szfi2wKwelh4jHwTB
         cTGIff3YgFEM3ew87i4nCGp9tm+bHy7tC+7GvCumfSL//oNwyekbCPjRB5FydiqekmqC
         AbMwn0dxo9NT3Jbf7xM4B7+WunMv09HySWEASvXJTZS4cxYGmoDiRh8JQWEUj7NgC69P
         dJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amRhedGuSHl1b2MYxVwt+xMWJ0GNSUpVqqCAdkmPxnQ=;
        b=r8W8QOvBGv16d+fl3NibOeGIEs7AEFF2igVpxAcV8yJr0bmpNIX2gsGh3BH4Y/JmPI
         u+wVn1gYJQINGBY5LsAD0DLBbxsWd0abCt8MnXEW4IK4h4f4wpPKx1tZOLWi8jIW5FX3
         04rF7BUXSSpD8LQg84/oQEUia2zBNrIldISR1eR+Hkz5ejxAR1+oq0k3JJgsFvkttl6t
         6yuzTIFu0iEIEftJaDGh8DXQSkivouY/IPN8IspzdTe6cXfYvXR+uBHQGfSg6z5RGDBg
         ZL/q7d588zn7ZCc5TdYxEUWiiw7Mjm7elIJix08JpQt4hXcJlTlFuWd5yMlchYB0u7YT
         HLaw==
X-Gm-Message-State: AOAM530D9aMZuUHrEhuGX1vLg7KrMzCEl/m3C6lbjhYw+QniINM8mJ0o
        8rC4K8eoZVWuwNFqFz6vWcb29E01i1cG5CFJ
X-Google-Smtp-Source: ABdhPJyG3+b97BegTRLd9NbikEGCe4reshLK1yXzIiwJgr5ZWTCSUCYkzwFE3q50ggwC6vgzt0KK2A==
X-Received: by 2002:a05:6214:29c1:: with SMTP id gh1mr46298575qvb.108.1641320157526;
        Tue, 04 Jan 2022 10:15:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j9sm31935089qkp.111.2022.01.04.10.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:57 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 7/9] t/lib-bitmap.sh: parameterize tests over reverse
 index source
Message-ID: <7ce3dc60f93d5154943a63f1c09345bd47fbc7c9.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
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
 t/lib-bitmap.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 48a8730a13..77b5f46a03 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -275,17 +275,23 @@ midx_pack_source () {
 
 test_rev_exists () {
 	commit="$1"
+	kind="$2"
 
 	test_expect_success 'reverse index exists' '
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
2.34.1.25.gb3157a20e6

