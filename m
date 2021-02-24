Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30562C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64C464E90
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhBXTNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhBXTMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:12:21 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CEAC061797
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:01 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b24so2232621qtp.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FTPV/Vio+C3gf+tmi6dzfePMcY9p8Ik/AXdW3TRwAUo=;
        b=mW+xvpINfdcMu4dgr/xSj8RCS50hhQa+sRxctynNw1BzM3Qcizi1QtARu7iqIM9TC8
         mSB827OeBAKxV4oQvI+GpCeI6+KGj1l2Ld23McaOeyChS7SPpdPtd9vSR0DVdMU6vwpX
         +ylWjzP5eMeJ/JWS6uQ0vsjH02FxilmC7SHrlFjjpW56aI4qQi0eoDQvzYigQz9eUBsd
         1PVGrgScGxjPv83EZDP/FjKbud4XIMF8dM/08Ri/CtRDifCv2Xo256p0eq6pLbkfYnZ/
         mMQ7fwVzZTLXw46ee5jBcJTXt2NWi8cLFW4R+UJArnSCZTt5m1T36wm58fxus/q5sYjB
         05mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FTPV/Vio+C3gf+tmi6dzfePMcY9p8Ik/AXdW3TRwAUo=;
        b=Zy4JQwoXp2KHlIm2Y7nK3eE5C9CQo/GGcRL1bxVuLworlCqr0Mj8RtN/EBHTCyAxGn
         2ulF36GljmvMEdSDllcEZVVkNBk4EhMqiM9BMp4mpWXEwvB5gsDpNOsoKkKIFg53Xj3Y
         oN1+xsYFFgjMRm3Lifmaio1Ajo/bRytDeIzM24uAfzGzKm5vHOueB5MC+7zk+M4knKtO
         WYFR53XMKPZhCr7sFyWGb4Ks9B9BexhZ9QwAIPma3nMHcP5mLrR3EIVuPUo4KOp23Ybd
         j042mYPx9k55kQGbYc15dGLcep/qMBVlclswyB8fngRZLiLHKwUrl0qh9ZRWcLyEiaKC
         1C7A==
X-Gm-Message-State: AOAM533Fc36Ba5mQ4emav4d14KVx8uKwvOfdn1IWNmV0RxHW5bbP8KUF
        sQLz0YqpXREpiHiNAvsE/JxC9IdMeLu9Gyeb
X-Google-Smtp-Source: ABdhPJyIvnUhfZTVi9BfKjJA2uk7rg5lOTf0zKwqmBfMAFTHiTtcDjz1gkYl6MvECRzdHsGHuvbPAQ==
X-Received: by 2002:ac8:5786:: with SMTP id v6mr31275316qta.200.1614193800689;
        Wed, 24 Feb 2021 11:10:00 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id o20sm1893323qtp.92.2021.02.24.11.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:10:00 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 09/15] midx: don't free midx_name early
Message-ID: <976848bc4b40f1d1e7cdef5e5cf031ecd9f1ac0f.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will need to refer back to 'midx_name' later on in
the function. In fact, this variable is already free()'d later on, so
this makes the later free() no longer redundant.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/midx.c b/midx.c
index d2c56c4bc6..db043d3e65 100644
--- a/midx.c
+++ b/midx.c
@@ -973,7 +973,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
-	FREE_AND_NULL(midx_name);
 
 	if (ctx.m)
 		close_midx(ctx.m);
-- 
2.30.0.667.g81c0cbc6fd

