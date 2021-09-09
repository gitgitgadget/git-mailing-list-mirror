Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C1CC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0208960F93
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbhIID1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350142AbhIID0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555AEC0613D9
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:25:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so322201wml.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I/jSGotHph8kLDRIU5d1Y/68nmelh25acg/xGCG6l3g=;
        b=A8ESGdAXvslJYmqPRRnzvU8JZJS4Y+WX4s37eRb2wHnYtxQilV76sN5QVb+Qkt+g6Q
         sYOe6AhIuo/QyvicX8WvkNkXt2hZLApD40NZJkNpXqsY45o8Xi/M8LyHAa3bm3lhJIbl
         g8rsEUe0yBVZeNmKDz22ETgTwAgCrvoCYa5O0DBXwSWnJoTmGfTgQ8z6F/GBGpZBUJEz
         haBYfkuz/4IwYvpPcaLQTb3C14bSlCVWFJVrBuT7b/VwOdw4BISm9W8dVapletsWyjmU
         EU9VZGkPNQmNWi4nST4d9Ld9qqgxTYiQiQvQ+mUjZpD1mrXHqKkA6WaUx9pn1Ld5hVi/
         kgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I/jSGotHph8kLDRIU5d1Y/68nmelh25acg/xGCG6l3g=;
        b=JnegoR2HTqPx4IIuqsW3OL4GVnLsyJFA1rX0QJs3/Kd0/12wSob8ywbb36u4+gM9Rd
         xNWi6gXr26jZV5e0yyDGsufm9pPGza1cmeH9h/bbo1MItsVpe3pRUfsGyW5d2f0bdzRM
         y1diM4jjREegWYbKuQaMAEx3EX9whLspsMxrpsls/h+07INpPUZrYGJgFFHvQiCOyuuc
         WZzboL6SrFcJEyYqylSRbZ84e9kp72IESihkPyt9w1oCMaVdnTZ3P2Qt/mXlFqR0Vwdu
         YUa85LSHCbZfcjd5nj9hjWQpxYbb+QjRxKd5QUObbE3E0lWVYiQnPpYzzY/DVjv51i82
         c6Xw==
X-Gm-Message-State: AOAM533/LTUCGn6w4aCnBJ9Ql/g6EmGc7j0a0dD0T4Zbsuks7U6tXyq8
        soSTUzJsbt6jB2kWOTKZrS8+W3t0yXwZNn7A
X-Google-Smtp-Source: ABdhPJwS2+3GYTne0x6IG2LU4BQOrr5S16G9mEmmR8tF8BjHFfYEWg4ruPTkco3JTXNXlpO2DUCFuw==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr612572wmi.74.1631157915681;
        Wed, 08 Sep 2021 20:25:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7sm310317wmq.13.2021.09.08.20.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:25:15 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:25:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 7/9] builtin/index-pack.c: move `.idx` files into place last
Message-ID: <8d67a715014b9daa9a6ca3a77be647e733324522.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as preceding patches to `git repack` and `git
pack-objects`, fix the identical problem in `git index-pack`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cd4e85f5bb..bf294d9083 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1523,11 +1523,11 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	rename_tmp_packfile(&final_pack_name, curr_pack_name, &pack_name,
 			    hash, "pack", from_stdin);
-	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
-			    hash, "idx", 1);
 	if (curr_rev_index_name)
 		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
 				    &rev_index_name, hash, "rev", 1);
+	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
+			    hash, "idx", 1);
 
 	if (do_fsck_object) {
 		struct packed_git *p;
-- 
2.33.0.96.g73915697e6

