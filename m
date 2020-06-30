Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC2C433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB3620775
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DSOpFkkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390203AbgF3RRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgF3RRs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAFDC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h23so16225679qtr.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cstlyRmFAZ4ElAum6E647R/XATai5HJrwLf5gyGDnrQ=;
        b=DSOpFkkgGMHBauHmgWieEHgBHoefKclRhOhQvTWcuSaG+vXibX95vyGw5ezVnuVmat
         rDQFPFr3uDIHDt764ICwDH8A31/EYr/A+H+/8n01MXwZFK1mVsevv4tcLGGrKxoQG0iq
         PskiX9Z3Hb+ZrzVA+0HgxNb4N7fdPgKqUhjY/e5DquYnLf+0YkcKsq1cclkgHXYGsX2I
         DHSy3GTwQpVAc1Kalwg/q5/1KADC16QLAUCQ5IQzDKu3XI0MZxl+4QrQuzCb7nB4PFnf
         aKzOmgruU8AtNbcR4jKLvSKGniuJ0K70qOAe0YjlN/5o7Dv+IGUg+l+G9Bwf/ln3o3Og
         hDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cstlyRmFAZ4ElAum6E647R/XATai5HJrwLf5gyGDnrQ=;
        b=mFbtZt8qbkmce6hRCTWX/Zv6bExOal32Ybz6tRyjbO779ihNv0am1Vlff7JI2nEMX+
         hZNRcj5YGnJ8OfMLr8Jch1feAKOn/yNZnwe8EH0R4knlIwPpDuscB6gTWZ+QESPDWS3E
         +Cy0xefQjVX1UDFu2wyaGL/NrZxVEAGSGaqmYhcKed6Nu4Bu5CoaoBbtwvhS56043Nnn
         unGWZDDChJtUweSOI3/8MbEKVBwXBiY0RJtlUoZUA5HD/ZDGEM3PcxZpjdJP2uw1sgkK
         jLv43i9C5srzzfyQvDJy0eJ0bE2Dchzwhe5PZ6xiWbc1lBZZQIzdzXUB4GP9FQgsOEF8
         fmQA==
X-Gm-Message-State: AOAM530rw0lTMW25R0DTJnKhu4Jj3T2V+VXSEsuHUhbyOCSea6QKrzUE
        0yH4TKv66xYQugRDIneU8nlW7pojrtIXPA==
X-Google-Smtp-Source: ABdhPJypSdqIaz0VRAR6XnkfpXLTa9BqH01hEoQDFpdC1Gdjj6gWENV1TmDv5fpbyuXMBQJasLA+vA==
X-Received: by 2002:aed:3124:: with SMTP id 33mr12986444qtg.215.1593537466703;
        Tue, 30 Jun 2020 10:17:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f0ef:6367:5d8f:d7c])
        by smtp.gmail.com with ESMTPSA id 79sm3591161qkd.134.2020.06.30.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:46 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:17:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 2/3] t4216: fix broken '&&'-chain
Message-ID: <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
References: <cover.1593536481.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593536481.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a759bfa9ee (t4216: add end to end tests for git log with Bloom
filters, 2020-04-06), a 'rm' invocation was added without a
corresponding '&&' chain.

This ends up working fine when the file already exists, in which case
'rm' exits cleanly and the rest of the function executes normally. When
the file does _not_ exist, however, 'rm' returns an unclean exit code,
causing the function to terminate.

Fix this by making the test use an '&&'-chain, and passing '-f' to
ignore missing files (as can be the case when specifying which tests are
'--run').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c855bcd3e7..0b4cc4f8d1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -53,7 +53,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
-- 
2.27.0.224.g4cfa086e50

