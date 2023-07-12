Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDFBC0015E
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjGLXhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjGLXhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6081FF7
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:40 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57a6df91b1eso56842187b3.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205059; x=1691797059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+eKKd2Xv2yoPgePE2cYqk74E9Fbvjeb4VfHtVmi9KI=;
        b=gaBtKNqqfxM40R5X3N1hMWxZrMmXsH7EYIWmGfddQFZYKL/bL0sJSVVeE8bcwKmBeo
         LzlcyMZN2ZyKYZsegxuJw3RELH+bDpRYF8o9rlUIE6knGL7jKG5COgPpoUg3n48xAXRV
         rSTAMPR6zAITa/2HblenQPdYN4pGERs7xQ1mPv/7jg2IPRKb3VBpeabyWT97jHAMgWGV
         fIMy46towyU/vIFmMHG115VnNv1PXmyX4Zy4ZCwqPwXpWL3tAfgT0QzLrqDuEanvjsxV
         tL70wbreOyqsKAKmz1SJBC+KaAgAywh8aNQYyMGAA8oKJaTgoWT3ENL345Dvc+7p/y8s
         9zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205059; x=1691797059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+eKKd2Xv2yoPgePE2cYqk74E9Fbvjeb4VfHtVmi9KI=;
        b=W9Y6d42xNmgxixLtI+/JauHqXmx4nExjAi76dKru+dAqiL8GYsxZCeziGTqBuRUUZt
         7zYzkd+00z9O3riiXrEDDO6WSYerrZ7UyFI1To0FiWXx2GeLdxWqU7yiASOmc+xnP3AU
         0lNoRZwsN+9TBjPne10tkwQF6+M94aSoAZKAT/z+OVg9Yzt1bO8d3NHjB+R0bxXP1e1+
         6e+Ncn86GnVyHWA+mIXR1lSCm8VGBh3VU8dkmNQyQkD6TKNVCpPCmyn8hAlvGrBqYE6i
         Wqi+C8Uauw4AxP/giHj3EtZATZ8WL9ucp5z0m9FH5vwj8TadfyF+05I58JvFgOxcROVF
         /jVA==
X-Gm-Message-State: ABy/qLaryTaBC7gxFlXdZbV/9yF+eDzbX/tmWFiPoWwKEN9DfrhpXGTe
        K2I9/Mj9147zURva5UQvlWvDQ09erC1Qom7ezYCHUA==
X-Google-Smtp-Source: APBJJlGioOHxAt8dNe17uyG9VYh1eMtKW9LJqnTTOnjMAPRziGVwgeMSk0ur38l+jxh/VVIJR05FtA==
X-Received: by 2002:a81:7d86:0:b0:57a:5039:aa77 with SMTP id y128-20020a817d86000000b0057a5039aa77mr121039ywc.15.1689205059751;
        Wed, 12 Jul 2023 16:37:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w18-20020a814912000000b0057a92cd7f95sm1442407ywa.100.2023.07.12.16.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:39 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 05/20] midx.c: prevent overflow in `nth_midxed_object_oid()`
Message-ID: <1a60b79296c567da33cb8e7001ff21c484836989.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, avoid overflow when looking up
an object's OID in a MIDX when its position is greater than
`2^32-1/m->hash_len`.

As usual, it is perfectly OK for a MIDX to have as many as 2^32-1
objects (since we use 32-bit fields to count the number of objects at
each fanout layer). But if we have more than `2^32-1/m->hash_len` number
of objects, we will incorrectly perform the computation using 32-bit
integers, overflowing the result.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 449c10289c..dbc63c0d42 100644
--- a/midx.c
+++ b/midx.c
@@ -254,7 +254,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	if (n >= m->num_objects)
 		return NULL;
 
-	oidread(oid, m->chunk_oid_lookup + m->hash_len * n);
+	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n));
 	return oid;
 }
 
-- 
2.41.0.347.g7b976b8871f

