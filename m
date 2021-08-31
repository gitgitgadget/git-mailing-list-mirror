Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04EC43214
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E934F6103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhHaUxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbhHaUxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FADC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:40 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id u7so690385ilk.7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ne9hO33HlOEkL0I+Xo8+9iTfXidjrHnaKTzmCB49g5g=;
        b=pLi80PT3ykXoONYW22CKdz12D8+QAfzj89GTJZXJSG1gNLXhGVSfSitwlQxBuxMsyb
         p31EvWklbZuxbeC0VLu9lvsJJP4GdUcyFb5lEjrrs7A0cQGxS3JrBIU8ppy5UrvDL9r9
         zmOVmSh/NPFh9jUM9rQikVc0ZtzRkq/upR12wkElB8VJOSdTh08NKCogUhbGNzyEXy06
         t61SqqduBV158iRdmOEIekR3wXPIDUsd4RoeXc6VYR8LSoGH4imzoRMsQ90tjvQ/NZEV
         ASSB+kLCt2nk5fpF0Wtzq1w8g+DybDB44w0fxRmgWI1wuy/0ny4t2gafqTAC8KfMtJpY
         /QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ne9hO33HlOEkL0I+Xo8+9iTfXidjrHnaKTzmCB49g5g=;
        b=qvU4C+OiwVv827RzYfwoWbxGAvmxZBhQpss70IPAYqOzdAtzPB2zMIA0rf8OnM/6RE
         uMF4F7nwnP4IhDs3zOYyNc4BZVIxrQm4oJLaw/dLeydYSiwdsiuOA2Svy/VwwypSW+y1
         vApTuyQTGLPaQWN+lChKK632MPpg12pqpT5u8FV0m675WXR+CRY/y0kaljqnZ8nBHraI
         SN0/HDv4s3/koHGi9TMLhPq6T9qTp4BXtRdwjJ43lBudYsDmS/FaHOis14IwjEf7PxKx
         TqTsz0ev7C5PUMnWu3rvcqzSGgwvJDz1nSJfOcL7RYlM1ZcWWE4RtRP2OBFaHpQfsi5L
         yb5w==
X-Gm-Message-State: AOAM533xtriczgwjB2wpEnr2D3tTbgbPWn6ZZyc7HNq2vbA9+qcWX2UH
        t+vn5DR+F2p4eYPHSXoSzCDZcKHVqqkIOkmO
X-Google-Smtp-Source: ABdhPJwgeYMhlo0Hk8BI8H5KoB2FuBZG/JjmHCbGHgr1ZD90xhQrNJzHJQAKgipku/c5E4pLr77Dow==
X-Received: by 2002:a05:6e02:dcb:: with SMTP id l11mr21766442ilj.169.1630443159574;
        Tue, 31 Aug 2021 13:52:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z7sm10977974ilz.25.2021.08.31.13.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:39 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 23/27] t5319: don't write MIDX bitmaps in t5319
Message-ID: <92a6370e7715c34a1ac7ccc090ef501c1b5dcc58.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test is specifically about generating a midx still respecting a
pack-based bitmap file. Generating a MIDX bitmap would confuse the test.
Let's override the 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' variable to
make sure we don't do so.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d7e4988f2b..b3f9f3969d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -532,7 +532,8 @@ test_expect_success 'repack preserves multi-pack-index when creating packs' '
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-	git -c repack.writeBitmaps=true repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=true repack -ad &&
 	git multi-pack-index write &&
 	git rev-list --test-bitmap HEAD
 '
-- 
2.33.0.96.g73915697e6

