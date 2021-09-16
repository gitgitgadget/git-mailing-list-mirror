Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9017C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 02:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A856103E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 02:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhIPCjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 22:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhIPCjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 22:39:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E55C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:37:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so4327250qtk.5
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ua8jrO+dITR1I0mn8T/k3xhRd5xui+AA9CNpsIZaoQ=;
        b=oxEaQlFZuDTmKpoVzYXWD5FWLB3oE86oSpwkbe0GukJQ4pWbYgGvBjjGCn3ZzI9y4A
         Mj7b34j+A1l9Xn2156aKA5sxjz1buAZxUHpSEwRcRfRLdNWmMKBDV6PISr/ifdLm7QIA
         OWr6xLdnSxudZbgDxQ1oJw5paC7dFmR+G42LNoVix+e86o+xM+cwmeN3KplbOk4elrVn
         q1sFshu5RKh/7x/bWGT5Rd5k/cDHgcPRXUlGwdr3+htR0taEtcLYbx1w13erJUQWOQTE
         89srRch/VSLSp2PGQx866vF8qFNCEfnhxmRKgbnb3BEZ2uMdfWHI/jSGlPiyGp0H9qqS
         vK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ua8jrO+dITR1I0mn8T/k3xhRd5xui+AA9CNpsIZaoQ=;
        b=f9Z2VHe2HheZgM25OqHE9MgTtsssQiNdTidlsoaKjrqnKypI+vKoWvvsLaH5Ov0DZS
         +VOjE6fHZj7Q/6Gj28YqEql9LG8WU/ZvyCEJ/pxyxIz0aI+A3jH3ZIQuROCAl75+CSwS
         81GfdNkmrKYGUmdqxznR/Rzl2GhMrgUxQXAQFaLU7KxZpWNlQ90GDsw1dPo9vM4l9uHj
         9hYDTjM75bnVo2wXZCjs+V85+THdS1M00b2DIFoyrEKk0me5afDrFujUBMJdPy/KBtAe
         KQ2Nn97JfcrOjry36chChDvCZsPTWUwBtWWfaxADVI+Icz1rIzuja4ZPpztICF2CF2PR
         eRug==
X-Gm-Message-State: AOAM531UBmwx6KbPnaHEV74FU6rNbIiLzn+PSt4qZzE32R9pFruq0/fz
        Va5NLACGrRSUG37/5vay+Q3m9WzVT6s=
X-Google-Smtp-Source: ABdhPJynhNeut5hWt4yQbmOwtulNVmFBFwjUL8z0rvNxKNb8hb2RNKRYVp3alJ1Y64IxVo4V0ZMFVA==
X-Received: by 2002:aed:204b:: with SMTP id 69mr3061775qta.24.1631759868113;
        Wed, 15 Sep 2021 19:37:48 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w20sm1498753qkj.116.2021.09.15.19.37.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 19:37:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] tree-diff: fix leak when not HAVE_ALLOCA
Date:   Wed, 15 Sep 2021 19:37:05 -0700
Message-Id: <20210916023706.55760-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210916023706.55760-1-carenas@gmail.com>
References: <20210916023706.55760-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b8ba412bf7 (tree-diff: avoid alloca for large allocations, 2016-06-07)
adds a way to route some bigger allocations out of the stack and free
them through the addition of two conveniently named macros, but leaves
the calls to free the xalloca part, which could be also in the heap,
if the system doesn't HAVE_ALLOCA (ex: macOS).

Add the missing free call, and while at it, change the expression to
match in both macros for easy of readability.

This avoids a leak reported by LSAN as while running t0000 but that
wouldn't fail the test (which will be fixed next) :

  SUMMARY: LeakSanitizer: 1034 byte(s) leaked in 15 allocation(s).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 tree-diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index 1572615bd9..437c98a70e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -21,7 +21,9 @@
 		ALLOC_ARRAY((x), nr); \
 } while(0)
 #define FAST_ARRAY_FREE(x, nr) do { \
-	if ((nr) > 2) \
+	if ((nr) <= 2) \
+		xalloca_free((x)); \
+	else \
 		free((x)); \
 } while(0)
 
-- 
2.33.0.481.g26d3bed244

