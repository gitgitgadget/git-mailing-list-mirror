Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD1FC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62644610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhDISMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhDISMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BCC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q26so6729464qkm.6
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urkpKRCVUcnkeA5xm5AkC500A1RReChHW2zksdFNMEU=;
        b=Y32qPnFrY2GnjdmoBhdubkfBSn+fR3PTUBebny2ITdo4wTNFD0AINA481inRYPwhqW
         fwd/eW8+ucbb+8GLvkWuAWnRztbxCvKWUfLKE3i5xk1KzOyhT4OzUpdfcJP/x3xwup/P
         3yprkYaxeeNzA5I0EPXGpwxij1zGV0Sy8ywpeb4kOhnchNKSPra2aLGuE+mAsYGqXDtT
         evg8/9FQPWNO9oIhv4LeZB0vQ8mhUbZNl3GdZy14XBgzuZAtUqymRqDfd9ezGLgyQgL0
         KnOaxDjVNRV8hJpP/1e74HLaIGECzumWd0lzFy40vc2N9cmPxIjjjdzpf+z2NFtCzosp
         IlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urkpKRCVUcnkeA5xm5AkC500A1RReChHW2zksdFNMEU=;
        b=SRgR4qZuWLh9zl/4HhbHfjuyP+ykWW29g9GNjRObJQLqL8HfZpQzAjxXC+qeHXmw+v
         XqyyY93vtgonghVILYkgZF8kqI9DG7CtDyhsOdzPpSSPkovDk/uSbWkPwz6Bva7BT2ZE
         jrM3xPVOYYKIDpCSXPVynuN/fCaJHhEuff7J3q2Pnl6GmHQBwkXyUZAHsisQlTVNLXT2
         rvvZGOjAdeztqCVsNBt8S2ypmsCqNLPMNicJBzdEt79DiuUnCb4kMqN7/7Yhkd6xxc+E
         qKyJIi+0WcbmGJyKvX0zIgRuqK5XVSmoqyO/U0yLT3qz47iekOpfB0zMqXrolJEi2/vv
         h8+A==
X-Gm-Message-State: AOAM532mlFo04AFIO3wW14uI1Djep61VpX1B/OksbU1GBqFN4xgSn/rg
        P9xGepXNJYYzOCJZ8g29Exv322FYEKjxeF7f
X-Google-Smtp-Source: ABdhPJwk2ggzhaFQhlxP7Nic3kD4lC/2LYO3genSm2+lfHgDkyzSmup9WnVxvn1fUQYmSfKtebmwvg==
X-Received: by 2002:a37:40d5:: with SMTP id n204mr14934161qka.79.1617991931428;
        Fri, 09 Apr 2021 11:12:11 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id y9sm2315699qtf.58.2021.04.09.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:11 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 18/22] t5319: don't write MIDX bitmaps in t5319
Message-ID: <dbd953815b640dfafa9044a70dc6dacbbf9302a4.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
index 5641d158df..69f1c815aa 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -474,7 +474,8 @@ test_expect_success 'repack preserves multi-pack-index when creating packs' '
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-	git -c repack.writeBitmaps=true repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=true repack -ad &&
 	git multi-pack-index write &&
 	git rev-list --test-bitmap HEAD
 '
-- 
2.31.1.163.ga65ce7f831

