Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD1C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042C461263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFHJCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhFHJC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26414C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m137so16988619oig.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5KgwGlwLHzGtv5uxkotd1A0NZNABRJclx5c3gKg/7s=;
        b=dDvUErif9y7Bk7Uua63iT91t8vPtoqDd/PaAwOTrTw+OQCEU2upXrJy3fNuNW+lijM
         TJbHw9Z6ub0nFthgkCAHtEoGWgaQW5zuohmNFlSJ8kZHZ7ehRLlwY5PmZtR/udE/6stu
         ztjWlxccuDLaAlLnAAWl4EjdpvyMBr+hruHgoZrqZAKKkH/FvEfsHKdpGJ6V5YKuV3/h
         grcyLXglb+43PSfQmO5sGJRCTVhomm5iGTqrCtu6m1uQtUIH1DW9Peid9NZjf/jaPs1e
         Yob4oqjP9cyEvsDJKoNhvvJqp8WA85GCUxBREjEKGEhaDTTgnuqnIpQ8GBmcn+5Eq5mV
         0ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5KgwGlwLHzGtv5uxkotd1A0NZNABRJclx5c3gKg/7s=;
        b=sjpGv81FDA4IxlpOh2ApJMX3nxOpx3NBET3sj2UjcxcgVJOmqvKz1+Ce/T0TOzAECw
         SX/jy/DYPX/Lrpvk2CmSFlf1qVSamVZz9kqzNXWyr74eRxzbFmumD8K962TedV5I0raZ
         QRX6B1VLLXWOpR2lTA242MXMmDiAvGK4d73cII3DSWjnUz28Kkx7c5b8/52y3aux2HTU
         1HvvOtoLZgEn8WvK7hAhWWqOPdSx+qQ3TvXDIBHcG8RelJIBpru7x7VPvxxWY5jV1YtB
         0DxCznbYI+o8pVdQPzVma0OL8ClAeyKaFcJKnDqdUb48Lm/rBYv8quE0IKle/KdouB/A
         HJqQ==
X-Gm-Message-State: AOAM530TyxfZDg4u0yCPQ2gdXQvIPW/Vkil6OWQlLIGT9dVTubks2kHd
        vQhA0+5M1B8csiLseRpYUcvAVFybz/0Brg==
X-Google-Smtp-Source: ABdhPJys5yAVMEYhJXIjO/UpousmfHU65keXegzch03ROfQ+06aFwKJ1k1qCTh8TECCBbvno0YD3rg==
X-Received: by 2002:aca:39d4:: with SMTP id g203mr2110017oia.158.1623142836338;
        Tue, 08 Jun 2021 02:00:36 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q16sm31052ott.56.2021.06.08.02.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/12] doc: asciidoc: remove unnecessary attribute
Date:   Tue,  8 Jun 2021 04:00:18 -0500
Message-Id: <20210608090026.1737348-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's part of asciidoc global configuration since 2012.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43ed..f7908f9dea 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -12,7 +12,6 @@
 
 [attributes]
 asterisk=&#42;
-plus=&#43;
 caret=&#94;
 startsb=&#91;
 endsb=&#93;
-- 
2.32.0.2.g41be0a4e50

