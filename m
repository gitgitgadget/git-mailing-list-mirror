Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A16EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjGLXiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjGLXhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:47 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B0211E
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:43 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57712d00cc1so88008267b3.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205062; x=1691797062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u1fSyA8Kfv4EfNOQdEkgrUkcm7F6h7cP/QnUxUMEgw=;
        b=G8Z7jsfRSb/Fgn9DCPHBmMyCg4IXyxyIhTPTO6WybnxLvqyzDH7LqU7a2y5FRcDnqZ
         A33BY8m7kcFYZRKScF4TZqgpVFRAMVy3gl6mC0sUOzLeZuTv3wnGMll19I9FvWjo1Z/9
         iAqIv6GLGn3JCsljNjyk8iZzYNDyPFWvW6H/0cVrwQaPg9Lu2nMLz8lbzo0gm8pfXRpW
         VRs8dp9uU50//2LvhblA81p0i0mykkvNbKJHEJmcbtzUYjwLKkZXtpJ3QzDnX9a/O1Hl
         MqSC6m0H1JVKfD+zAOux3WfvkMCC+HdZgft6mByp2M3/gxeK/H7FcM36seEj7uQezTwo
         5OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205062; x=1691797062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u1fSyA8Kfv4EfNOQdEkgrUkcm7F6h7cP/QnUxUMEgw=;
        b=Gbu7e2vd+wYibzgoEKtYscKgJqAjC/dmrRAfZfgNjRzAxaDmvsYeNTfitYnVkiAfUZ
         /+QjsjmhqTGrovv/l5JqDizNk+F55r7oSjgWVqKajFGo5XAqWBZnNHct4Lp2u8qnw7+N
         bGuT4/KKUurJnEcNo8JML/X76M7TJqil2mVIKFqFp1RJPmIn5YPjFlZDa2KzcaiSADfl
         QzMR2/EBlUzgmrFUaAv81n8YAM7Waot2xMusLH9hXUIOPybNmJFWZfJoGbmrGCRyP4tv
         0CJCG1kfwp2EphjOdQfAnToVBA1E+DfQ1ZUosmhuJaTzlBO7bCuz+pursf87jV2Dusgk
         2pwQ==
X-Gm-Message-State: ABy/qLZXiavtVkcxCQWtMMttVz25KQyxbLxZDVCQh/3dEIbTCLSsdwI1
        m4guSM0Zyan8fxkPwluSUwiI4hXeyl6rOYDfmK8//w==
X-Google-Smtp-Source: APBJJlEiJ1F26t8x/gOzCzFdHUQ3UEfZXkC36WPDylmq/KVnhiSm7gNraaqxHqMeac10VsjzFla0UA==
X-Received: by 2002:a81:71c1:0:b0:57a:6df7:5ccd with SMTP id m184-20020a8171c1000000b0057a6df75ccdmr136020ywc.13.1689205062421;
        Wed, 12 Jul 2023 16:37:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p187-20020a0de6c4000000b00577335ea38csm1450982ywe.121.2023.07.12.16.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:42 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 06/20] midx.c: prevent overflow in `nth_midxed_offset()`
Message-ID: <7973822d87d571d472be336a3e102ce2b3c85fc2.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous patches, avoid an overflow when looking
up object offsets in the MIDX's large offset table by guarding the
computation via `st_mult()`.

This instance is also OK as-is, since the left operand is the result of
`sizeof(...)`, which is already a `size_t`. But use `st_mult()` instead
here to make it explicit that this computation is to be performed using
64-bit unsigned integers.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index dbc63c0d42..a5a4ff4398 100644
--- a/midx.c
+++ b/midx.c
@@ -271,7 +271,8 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 			die(_("multi-pack-index stores a 64-bit offset, but off_t is too small"));
 
 		offset32 ^= MIDX_LARGE_OFFSET_NEEDED;
-		return get_be64(m->chunk_large_offsets + sizeof(uint64_t) * offset32);
+		return get_be64(m->chunk_large_offsets +
+				st_mult(sizeof(uint64_t), offset32));
 	}
 
 	return offset32;
-- 
2.41.0.347.g7b976b8871f

