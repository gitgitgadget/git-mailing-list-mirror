Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E10EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGLXiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGLXhz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DCE2113
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:51 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5704fce0f23so86449487b3.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205070; x=1691797070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K45ZX/XKjpaBddWI/twC9FLpzPLFI9xWeSKIQfsT/3g=;
        b=w6qbmy6E4a/BZf/IO6GTenNOTeMKnLvy3P3K7y+lAXwF1taPBH6WH53Vf5ZfRcabyA
         TPs4upIIJLO3LGBb7/IxpV3YDIxUy5nUn+aHRnP7NN4WtZQIiXG6LxdpOg+EWfEdGAtF
         JVNzV2do/JxzGST4gczo70fD6dw1cLp1VaFr1NstyxEwNw6OdUdLSQW8iDPlo3S0HC6S
         4hWYeVErXQ+JlrT/2UbG+IMy0hcCSZonyxVjubI7SZDJW1FWJe8JBEB8HLSqZYrOC5cF
         l9Bh/wMdMcQRMxPOqINFPYVi5itqG7/hZHnnv4fGddnBIBSVnERehmISvg8Mq3sf7kLo
         5yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205070; x=1691797070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K45ZX/XKjpaBddWI/twC9FLpzPLFI9xWeSKIQfsT/3g=;
        b=Y5oDsKgAVdjQwaiP7Rm8bIOYj3yxm5PLrePtFeURX9+KdMKekgLSM2MQSAWkdieqiR
         o4H+SjT4RQ9Hts0HeK+c8BA+jMQU1A0VP2jGpYvuf7yZkSgORsXfIR/NoZ03f+3Z58bN
         4sHlUNJLA/UPSBkPpeaAaYB7uAI+kEx71L1QWwhFKvRXFavPmsVDbO2OSaT7vFArFqCN
         wv92lAkTlHAd81Gjh78Tx+ILdF/tKg9oX2DmTmtqxQ9mPGmKc8GBdYzwo4HERCBZHiVb
         zIxHMDZcFQ3fhJJ18mvjHvaT7WPHxwRSjYS87eWbFwlJpnkkY/9X6MuWTuLsVEOgl8l2
         vajQ==
X-Gm-Message-State: ABy/qLYV2JHV3CEbdE06+eJbraIsXNz7PSB0XGhKRNRo/NkO2V6HzFEF
        KqhdoPGiE92S9Bk39nOmAS2nxOX1Gu92TnF9zYX10A==
X-Google-Smtp-Source: APBJJlEmAz4RA61uKCY/olFZWhwSw8MA053Lwrw66T2bue4RAs3eoz/BN/4D7oRvo1ygudnywuV3rw==
X-Received: by 2002:a81:6c55:0:b0:57a:8ecb:11ad with SMTP id h82-20020a816c55000000b0057a8ecb11admr80303ywc.43.1689205070611;
        Wed, 12 Jul 2023 16:37:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v145-20020a814897000000b0057a8de72338sm1443038ywa.68.2023.07.12.16.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:50 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 09/20] midx.c: prevent overflow in
 `fill_included_packs_batch()`
Message-ID: <80c79f6fea2fdafb00e6c2866ae1756c1956d16e.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as in previous commits, avoid an integer overflow
when computing the expected size of a MIDX.

(Note that this is also OK as-is, since `p->pack_size` is an `off_t`, so
this computation should already be done as 64-bit integers. But again,
let's use `st_mult()` to make this fact clear).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 57c53dbd4a..a5e4094340 100644
--- a/midx.c
+++ b/midx.c
@@ -1994,8 +1994,8 @@ static int fill_included_packs_batch(struct repository *r,
 		if (open_pack_index(p) || !p->num_objects)
 			continue;
 
-		expected_size = (size_t)(p->pack_size
-					 * pack_info[i].referenced_objects);
+		expected_size = st_mult(p->pack_size,
+					pack_info[i].referenced_objects);
 		expected_size /= p->num_objects;
 
 		if (expected_size >= batch_size)
-- 
2.41.0.347.g7b976b8871f

