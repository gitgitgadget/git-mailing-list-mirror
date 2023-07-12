Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89AEEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjGLXhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjGLXhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:45 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE51FCC
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5701eaf0d04so82678767b3.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205057; x=1691797057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLU39YylH/x9Y3EwN3WYovqewoUwGi66uEa9KFJ1XUI=;
        b=JLVbEq2Sr8tdU7iW0m7KhjChVflpl+wwihtmVit4G6k6uQgt1Ji+ukI6GiJP7eGioD
         Ox2HJVwEyfhzP6wt936k2ZbLMyDRpfH5CsxH8avU73pV05He4c1stLCiZsZcK0AQLKHh
         0ZVd/PNR4XzwqweoMoz9bue1uvyThom3uhiU+33Penm6/PqkZMpMColxMXPoNTutbdar
         SjhRiuPd2qda16zBzi7SHW1QaXAGcEmXzBGjZdHY2pFGy3LlbfZVbbaLelHb6VRx8o5W
         b8GWGgucpN3rrXLQPt2T4aiH2Z/YkD6yR2wsABxuTVnXv3/F0ISvHDnv1OY8v22XR3El
         M+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205057; x=1691797057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLU39YylH/x9Y3EwN3WYovqewoUwGi66uEa9KFJ1XUI=;
        b=OXaDLVgymgtzn3uGTora4x6oWVfg8XeB+qiH6VfvAQSqlhwMDSu3qg1AwaGGIfXT+j
         g5pHIIf8vJZnghfwuqjDzAGpDw/0tdQFuT/rLH23nJfJ0BsVDOgVgpicYwPhuJvTlGFg
         LirFfhTKB2Y44roUgtCWFbqsfJ5W5iQM2RUhYeGBYVUJp7XGeG7NgBy2yyS4wLDiIM7N
         mzLIV1AQyFfUMJ6i3HigVHZ6XmCwYVHmRrZphsBCDp+PYy6qzkof/4H3u2nkUbhVV2a0
         F6lX1+bl//xjbhIkTntb4C30RAbt1fwxvpkHhArtDfxeikNVy2qxNhC+JEbNY9tgET3c
         ai8g==
X-Gm-Message-State: ABy/qLZXfqp731skcuUwPM0n1uxHkqkGCh4hrfrC1ieQZaqhD/Nkyoay
        rhU9lximjW2oj3dn5jU3PDTI1NgNM+knc8f++JDnKA==
X-Google-Smtp-Source: APBJJlEogbmcjXySwbFA3uPsAi6dqgJOFEJmMQCB7VGIBV2IwoXk0rtfaZ1DGzJL3T+9I0ejogE2Ow==
X-Received: by 2002:a81:a191:0:b0:572:83de:a011 with SMTP id y139-20020a81a191000000b0057283dea011mr55957ywg.35.1689205057137;
        Wed, 12 Jul 2023 16:37:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q127-20020a0de785000000b00545a081849esm1470250ywe.46.2023.07.12.16.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:36 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 04/20] midx.c: use `size_t`'s for fanout nr and alloc
Message-ID: <bdad7286046e5f4ae43d4b2571fab2d3e31912c7.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `midx_fanout` struct is used to keep track of a set of OIDs
corresponding to each layer of the MIDX's fanout table. It stores an
array of entries, along with the number of entries in the table, and the
allocated size of the array.

Both `nr` and `alloc` are stored as 32-bit unsigned integers. In
practice, this should never cause any problems, since most packs have
far fewer than 2^32-1 objects.

But storing these as `size_t`'s is more appropriate, and prevents us
from accidentally overflowing some result when multiplying or adding to
either of these values. Update these struct members to be `size_t`'s as
appropriate.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index db459e448b..449c10289c 100644
--- a/midx.c
+++ b/midx.c
@@ -584,12 +584,14 @@ static void fill_pack_entry(uint32_t pack_int_id,
 
 struct midx_fanout {
 	struct pack_midx_entry *entries;
-	uint32_t nr;
-	uint32_t alloc;
+	size_t nr, alloc;
 };
 
-static void midx_fanout_grow(struct midx_fanout *fanout, uint32_t nr)
+static void midx_fanout_grow(struct midx_fanout *fanout, size_t nr)
 {
+	if (nr < fanout->nr)
+		BUG("negative growth in midx_fanout_grow() (%"PRIuMAX" < %"PRIuMAX")",
+		    (uintmax_t)nr, (uintmax_t)fanout->nr);
 	ALLOC_GROW(fanout->entries, nr, fanout->alloc);
 }
 
-- 
2.41.0.347.g7b976b8871f

