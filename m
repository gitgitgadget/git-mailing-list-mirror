Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E4C1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1857B222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgLHWEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbgLHWER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:17 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F7C0617A6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:37 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so263612otk.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aTPqehF/iR92lHl5qU6Qtb+pF/tTsVor4twzj8uNe5U=;
        b=OrBiAJ9M+vzL8kOQecVNx+9U7zWgXrxGunr64Gq4NDvdBbOg7WVo9auAWwwiz08oIj
         DeUqPFh0C0p19hLadl8VhIZuyL9mu6/N1BMTSLathkLufRCGTBLaYqDs2cFu/RqcrtIx
         Mr2OiUqyObIYm2JmRcv7a2v+Nr6r6YjBv8tjqLW37svG7pSStvyebQUFbpSQgN5G/4D6
         qxluIUzC1sZT9JcnJA/isewx2uphV4vpXmHgI2aXPbrPru1rEWCnFkZ0xNUhpUDcCcie
         Pk3rfpMBzH49Uhu5gbQR/mJoejTtrMxVJ8xREV9OTLJbxksSjaQaY2xaJgY2u6Pn6H8Q
         kdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTPqehF/iR92lHl5qU6Qtb+pF/tTsVor4twzj8uNe5U=;
        b=P3mWa5Wu0Vt6OyuKMqrJoSx42aFuLZBt3/ItZf4a2vMJTZNfsKWQCvyo3Vm1B0ZC+N
         3eJHfdx8aqZ0MxPoP4RdLyIrUndZCdOV1KHplFKRcL1K97kZ+bDqTnGXbYzjxKPbrdQH
         9W4xaJo5kBftgG5jRHwbSfeYTCYQrAtHPL5QJfPpvNC39qfSRk/lMcCmaZuQQOJB/nwl
         OM+EpTxuoitHxXN0fXQ5DNpo+QA9ZgtCAzjNqpjiQpTosY3LYeQObeU3IStf8zlBbWzX
         vgmLZjQk7725RAJBZ+gWS+bcSMY7bGx1+FJi9taQKsfmiKGaaqn+U98Y82yZ0mOw2ZVF
         wDoA==
X-Gm-Message-State: AOAM531rDceN3/V2RUHb3NVoZWOuXay1PTSGLmIz7BjaMA2qHi/5Bxh9
        CawGwCtSr9MVi7loY6OJ1e9VX4mwZDofbgqW
X-Google-Smtp-Source: ABdhPJyHurmSs0e46sPwPI/PFiHwYkCiqfu33wSST/+e3u8Pt3K9FNW4loiY8DKYLAGKwv7g2OnS4w==
X-Received: by 2002:a9d:2ac3:: with SMTP id e61mr144775otb.252.1607465015649;
        Tue, 08 Dec 2020 14:03:35 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v3sm8391oth.80.2020.12.08.14.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:35 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 05/24] rev-list: die when --test-bitmap detects a mismatch
Message-ID: <3cb41563725a16f87f65eb75c5c4f61b79abe1cc.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

You can use "git rev-list --test-bitmap HEAD" to check that bitmaps
produce the same answer we'd get from a regular traversal. But if we
detect an error, we only print "mismatch", and still exit with a
successful error code.

That makes the uses of --test-bitmap in the test suite (e.g., in t5310)
mostly pointless: even if we saw an error, the tests wouldn't notice.
Let's instead call die(), which will let these tests work as designed,
and alert us if the bitmaps are bogus.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 074d9ac8f2..4431f9f120 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1328,7 +1328,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (bitmap_equals(result, tdata.base))
 		fprintf(stderr, "OK!\n");
 	else
-		fprintf(stderr, "Mismatch!\n");
+		die("mismatch in bitmap results");
 
 	free_bitmap_index(bitmap_git);
 }
-- 
2.29.2.533.g07db1f5344

