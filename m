Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B1C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C005520872
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aYAHFVSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgIPSHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbgIPSHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A7C061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so6844232qtj.7
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KY5DLSiAztKca4b5UTZ+e54C1v4rWfLhOel86owC76U=;
        b=aYAHFVSKs7GyaxIIptbYUQl5i9cwwW3LQwLyrVC5viZZYYwwLpagoaA9jJZtxRK3Wm
         95BJcIFvS9QYEQsB+W9SMAZRXCIJhG8HRBE1wA2x3KzSxyj1mjemwuYhr+KZLhzauc9c
         DVAe8ewicsYunzhLC4g2Uw/BXaEmsSc6d0LAEzH2NyXeUyJSi27i2hYVdnH+KKG3WU2X
         IGLVTRKfOI11HVl6XNybig2nQjvaSi32Xp8c/g/puW41lt5lFhj0q86il78D4lrzkDKx
         7DQgfZjUZG+JhV1S1QMmEA1frvRKSZqVZ53QOLw8OjdXYYcvItX0zy2IUues0Cm+t8/F
         o3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KY5DLSiAztKca4b5UTZ+e54C1v4rWfLhOel86owC76U=;
        b=qO8rPHa/edTdEKB7e1G8LPIziXeOWghnPAyZuA6HUToKvuuqutfULpTHr+UuDgWP0Q
         pIIPObsf821lUjGPnUv2DXVRRMJa2I6VL+r588KVtwUu41LvqNVNIjbVQE05BEZkh+FV
         dyBR/ZaCcddJKlDy2mPzgXYG2JbixeCX7F5VO69KX+UlkMvdOWxc7pmOQd4qoN6vz0pr
         nirpRRuXWxPtvFYhs0lg5Z8G+e6yz/qIvYTS2S3Mbsw1he8hRGNswg5B+mYqYiU+wd7z
         oUEokDAJaCDxagJUsGK8woPan1uNPftld1V3dz0VPAheu/mOf6EKhTChM/mnkqYGutZl
         87Yw==
X-Gm-Message-State: AOAM532iJhrr/x6IaSCC4SbKGYhx9b1ird/Nct5he1hOpSSpD2zl0G+Y
        cn9HEItwh5m99OJTBCMcass2USUmpWvhnDXe
X-Google-Smtp-Source: ABdhPJx0HCAghc4i1KGZh1nUZurkDteO8aFvPi4vHl+UnTXIfPg1ft0eJjUGbGYn44OtOBEc/Pe0YQ==
X-Received: by 2002:ac8:568f:: with SMTP id h15mr12082071qta.232.1600279623141;
        Wed, 16 Sep 2020 11:07:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id s47sm20431310qtb.13.2020.09.16.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:07:02 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 02/13] t4216: use an '&&'-chain
Message-ID: <677b2f1692b3b6dca8695e415fdb11b320b0a432.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a759bfa9ee (t4216: add end to end tests for git log with Bloom
filters, 2020-04-06), a 'rm' invocation was added without a
corresponding '&&' chain.

When 'trace.perf' already exists, everything works fine. However, the
function can be executed without 'trace.perf' on disk (eg., when the
subset of tests run is altered with '--run'), and so the bare 'rm'
complains about a missing file.

To remove some noise from the test log, invoke 'rm' with '-f', at which
point it is sensible to place the 'rm -f' in an '&&'-chain, which is
both (1) our usual style, and (2) avoids a broken chain in the future if
more commands are added at the beginning of the function.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 715912ad0f..cd89c75002 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -58,7 +58,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
-- 
2.28.0.510.g86fdc5f89a

