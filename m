Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D744C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E422A64E45
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBRDPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBRDPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:15:09 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92074C061788
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:29 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id g3so338941qvl.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D7a2htNh5TmV1PuPKkr4mM1Sv6UdleXGHbTmlSyJ708=;
        b=QBN5nD0ouzn+QBE9JJlmLMH6mNfuV5jWxSdm8gdI06GkkWoxTep02zhej5fLtjwj49
         y65JMMSMa+iK2kVPubMAZjT3WYnhgmnEcb39EZMZ99jIc/qDsiquD293GtL4CIq8ujHp
         RV7PO0z9ldAG2MF03fACccAFj8ouvIjdmF2/ClR/JF24NJ0Vsw83fnS0dREx0HXlabdy
         NyrQYn9Ex37MZ9qBkoSOVG+aOzp/I2Paq0e1oLzrVM+iYfDrRp4pTU+MAucexRafGaNp
         SOGHXrgFhBi5cWblEpbXFVL73ysZzeG+hh1JBIT9pXpzSjf2uv5xhvoLb8cq6CO/8Quy
         /N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7a2htNh5TmV1PuPKkr4mM1Sv6UdleXGHbTmlSyJ708=;
        b=XNBOOXPt4x1sBvyyLWWLTplDMZcKGxJmtSbBwAQHuCx+Gw8Czjrkgv5zO14u4eQe4v
         7Ffrgn3pxRel0+HPVQsPTcNABNqgt+O91dQeWp0h/laLYHh0UQEpP8rYzXFtcGTRfeyd
         a72v6BpXCQN0tmenCi+reiV7uQrN0vTP2NDgo2zEuX6x7KHDRwSxth5opHkLNxv6WUjS
         7UEjXMvgVAbaBY6xfRv6pDIfmLwvH+KWLLwMwLubFFm1JhJr8aUQ3KYrK/fZRdyR7i7q
         l/xUQ9q5yTjHkHbbtpWDTVI9+t9QzqjH5m8NFk0WQ49zArQmStb8vEDzIk5rLNlrh9YH
         4bXA==
X-Gm-Message-State: AOAM533+Nnnaa1qQyuyMnIg+LQl5Qj7maLTDq/G3hVQ0hUIUo6K3vztX
        8qmXx0p1E89DDnta6e5J6HExo3MQLFMDygH9
X-Google-Smtp-Source: ABdhPJxV3uJ2dINg8z4efkU15RYCxpKWbbF6xlIXGsaJBvz79EaRB17NTNvK95nqBHhqQavLbPlCxw==
X-Received: by 2002:ad4:4aaf:: with SMTP id i15mr2549053qvx.3.1613618068547;
        Wed, 17 Feb 2021 19:14:28 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id l127sm3151941qke.3.2021.02.17.19.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:28 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 4/8] p5303: add missing &&-chains
Message-ID: <f9a5faf77322f6735a0283e793711629ebf3b65a.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

These are in a helper function, so the usual chain-lint doesn't notice
them. This function is still not perfect, as it has some git invocations
on the left-hand-side of the pipe, but it's primary purpose is timing,
not finding bugs or correctness issues.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index ce0c42cc9f..d90d714923 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -28,11 +28,11 @@ repack_into_n () {
 			push @commits, $_ if $. % 5 == 1;
 		}
 		print reverse @commits;
-	' "$1" >pushes
+	' "$1" >pushes &&
 
 	# create base packfile
 	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack
+	git pack-objects --delta-base-offset --revs staging/pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
-- 
2.30.0.667.g81c0cbc6fd

