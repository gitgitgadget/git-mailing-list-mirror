Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F5C00528
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjGLXhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjGLXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4172173B
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bff89873d34so2839276.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205054; x=1691797054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7yYt3iF88/ToiMJeWwYRXgGWlAZOYP605Gzs2bR9aQ=;
        b=ubReKF2zHo1RXrDXHrB5Q1f1d+G5PajdKqnwoQXeMYuNFX/q8AP81ok5TT4/HIh1yO
         jZatLWK3xLI0g7t88PMkzMVXwvKMXZDa+gq/4BBoKIPtCms216+8gw51ap1FTjCHkJIY
         UyvE1rA9b9WZTMsvT3/i152oeBRpw8Q73zCFaquDMKsoFJgKF7VFXVZ62+p/2xMuIUY4
         dcSMh3yCT33WDM+McHGi23MGN/WrEVv0FsVsh8pdLpHhMy5LPJ+jX3Xo2T/p5aGTPwwa
         FUl4T9pDn2lPiToa49HmLCrvcsVD4+OirDkpnuPxKlWhL+wDpZWg9EQBBjo9uOabHO1W
         SQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205054; x=1691797054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7yYt3iF88/ToiMJeWwYRXgGWlAZOYP605Gzs2bR9aQ=;
        b=hxG0ObRJyLbXADVzp6tP3/CDsGzgcIrQW2Yaea747LoAdiPwztpD96u7IwvDybwkWo
         uZ9KZoB9g153pJcjITGd84qSYKsuhp4CBJMBBMYemh2BUV8u67n9rl+wwL/8FS8rdbYX
         YltM04IAFunvtEMXkxU4hCLTgT7/IEigN9Z61FybN3KVJNQuX9c+QkDI2Erk+BKrm/gm
         ou6o7zZ1Ap7MW98P6jTMiyunMT9CkEF4j4eYgAspZGPekQoHui4ST9SFVMotMSDcyHYv
         Mxr0buXvRo+5bhOEIxGADQphv6uJWK3U20OKykLS2gBa8KCzGnaRrM7jV9z6EKc29Gn9
         dAbA==
X-Gm-Message-State: ABy/qLaZlQ/Dv64Nbjh9fYPQtHVkADZTRdUNCRfVdCUW3GsACmny65nF
        Zhnxxjlara5Ip57nIwdSfOwdqgH3xbYXe2BxHIM26Q==
X-Google-Smtp-Source: APBJJlF70za8sUymoNz7AfHmloMFT6Xw+VUkpJM6bYV3kv+WUQ7srD73V9gR4PsQJFvS3fFgGbLVgA==
X-Received: by 2002:a0d:fbc5:0:b0:570:63d3:9685 with SMTP id l188-20020a0dfbc5000000b0057063d39685mr113802ywf.25.1689205053924;
        Wed, 12 Jul 2023 16:37:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dee45000000b005772646629csm1445817ywe.144.2023.07.12.16.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:33 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 03/20] packfile.c: use checked arithmetic in
 `nth_packed_object_offset()`
Message-ID: <750d38cbeba42416d98895d6e0004d1ca6329ce5.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous commits, ensure that we use
`st_add()` or `st_mult()` when computing values that may overflow the
32-bit unsigned limit.

Note that in each of these instances, we prevent 32-bit overflow
already since we have explicit casts to `size_t`.

So this code is OK as-is, but let's clarify it by using the `st_xyz()`
helpers to make it obvious that we are performing the relevant
computations using 64 bits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 70acf1694b..e8e01e348e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1948,14 +1948,15 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	const unsigned int hashsz = the_hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
-		return ntohl(*((uint32_t *)(index + (hashsz + 4) * (size_t)n)));
+		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
 	} else {
 		uint32_t off;
-		index += 8 + (size_t)p->num_objects * (hashsz + 4);
-		off = ntohl(*((uint32_t *)(index + 4 * n)));
+		index += st_add(8, st_mult(p->num_objects, hashsz + 4));
+		off = ntohl(*((uint32_t *)(index + st_mult(4, n))));
 		if (!(off & 0x80000000))
 			return off;
-		index += (size_t)p->num_objects * 4 + (off & 0x7fffffff) * 8;
+		index += st_add(st_mult(p->num_objects, 4),
+				st_mult(off & 0x7fffffff, 8));
 		check_pack_index_ptr(p, index);
 		return get_be64(index);
 	}
-- 
2.41.0.347.g7b976b8871f

