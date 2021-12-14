Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B72C433FE
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbhLNBzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243991AbhLNBzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:45 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDDC061371
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b187so21428900iof.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ua2pp3357xioWAVxo2bJptKzW277e02pttZKmcGXvAk=;
        b=dj9j8GR7vM2eJSWY+xUvSqU0dhBZh+C0Pr/j3JQR0y/Jma11w2QExD34RY17PsfBlT
         2Dp7tckpJho03a8BxeWkqZzWQm2aFfFoKHRtyo5QBReIl6HJReM2VNUIqnhex7GgljIY
         MyqsKq+xCMmN7BoEzPwt0m8DQxvNOeYkrnotyV6sb1v0s8QpE67AxxZsRqGlpQFzJqa6
         uK99VrSm6MB+NYmfX5Lf/fZUfLO/7NZhohrxwBNoSWTyTSdmS0OtV4vSfuziVDx4ARxh
         E8/3cNspKSG5pjksIbk8twCmZQDnJG7LGLqh3OKQM2YQcCui+2bWAUmKkayELmQ1s4Ag
         W4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ua2pp3357xioWAVxo2bJptKzW277e02pttZKmcGXvAk=;
        b=E3n8b0ifPsoOTgoVpKfxaEa5PH8SU7BUzB5qYp5/F7A4R6pXgHDP7z0/QtEO8yFCr7
         hM0O/+bOEVFFFXkBO/YIiNVP5QbuX+hhkrYsz0mGxIkzh8tu3M2KtFaHdoN4+MvgCh9m
         a9qgBxtMQvQ4cUXCRm5ioWx04xexiFKcU4Lt318h60/dkfWJCnzRbjTqBVxoySlCxaVI
         Xrpn7D9ZDZ9nDleo5usRQKnhtwYoi0kBrEvVOqcnzW1wZGtv+lXG0Cubc3RAp26ucuoL
         5omT69leCw0VgwRRoszNv+NNUOPy504/5c6Hyi9/QD6+OWwaSYrRr8y3dKzwjQIWzfqk
         ZOkg==
X-Gm-Message-State: AOAM532HduOGB+xQedq2BMl/4H/p+gZpjTzWfKg3IXOLtefkcVjKTtT8
        TL1C/plCKuQeiKRnt+DjH7Suvd8Kd/iGuP8l
X-Google-Smtp-Source: ABdhPJyjiksAF5oxcC2XpG2FhR0LZ7P7X5fWvycXrO4MKpIQiekWu2gf2D208o6J8NJpLXZCFYFbvQ==
X-Received: by 2002:a02:6901:: with SMTP id e1mr1239810jac.0.1639446944192;
        Mon, 13 Dec 2021 17:55:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4da28sm185444173.52.2021.12.13.17.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:43 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 7/8] t/lib-bitmap.sh: parameterize tests over reverse
 index source
Message-ID: <fa91631024c40dd55372f46c9cb1620d1075c482.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
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
index 771c41c2ea..0a35daf939 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -275,18 +275,24 @@ midx_pack_source () {
 
 test_rev_exists () {
 	commit="$1"
+	kind="$2"
 
 	test_expect_success 'reverse index exists' '
 		GIT_TRACE2_EVENT_NESTING=10 \
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
@@ -296,7 +302,7 @@ midx_bitmap_core () {
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
 
-	test_rev_exists HEAD
+	test_rev_exists HEAD "$rev_kind"
 
 	basic_bitmap_tests
 
@@ -326,7 +332,7 @@ midx_bitmap_core () {
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
 
-	test_rev_exists HEAD
+	test_rev_exists HEAD "$rev_kind"
 
 	basic_bitmap_tests
 
@@ -429,6 +435,8 @@ midx_bitmap_core () {
 }
 
 midx_bitmap_partial_tests () {
+	rev_kind="${1:-rev}"
+
 	test_expect_success 'setup partial bitmaps' '
 		test_commit packed &&
 		git repack &&
@@ -438,7 +446,7 @@ midx_bitmap_partial_tests () {
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap
 	'
 
-	test_rev_exists HEAD~
+	test_rev_exists HEAD~ "$rev_kind"
 
 	basic_bitmap_tests HEAD~
 }
-- 
2.34.1.25.gb3157a20e6

