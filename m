Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7692EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjGLXiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjGLXhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:50 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA11FF0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:48 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579de633419so81735117b3.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205068; x=1691797068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzLc63qihmr54itTZhOj4+LHeXKDpE9PTqcI9TATag0=;
        b=1FwGLZiJalk9mHHbTeDrf4qZtHQVX8YxqTYyHaoj+XsfNfp0UDuiwq8k2jg5XvN08t
         6vmmQvfOX01BHLOni/njw76N1TWiIBDqc/QCtx0gD6cyBSnRJ8LJ+ZlGGnYdhWft6UWk
         c/yKdkPxojbJgVTaiaZ/JK3JxFjBEjbwl0ZfuCAhciqO0z3jpx90ZmfK9d/AtM59KK7K
         f6pntrKr4UhTDJHE+aac7vpBbIjaUd8gUox+S1ncjy6f2MB+paaeFjKKq4mj+cvHohRV
         Ka9hwE7eJUydUCZtDnw3yaVsEq0GgNdOo3myG/5o7NYWrKTtUmiVfc1A716GUawkasR1
         PJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205068; x=1691797068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzLc63qihmr54itTZhOj4+LHeXKDpE9PTqcI9TATag0=;
        b=R8Ld8SNYfBMrApCFPjrLcT0EThNfOkk6wa7J2pbVGFvm2bbCsamGdtn9v2XAk+UgqG
         TWq++En5elx3rmwUxHiytVbPoVSIUiY0u03TcrQjDPPxQ6K8FF3o+TcTRfU938LpxTsI
         jkBlMLIGI9n4Wiq33FKLcHN8BD+hkhbK9CpeUreNyw1KQGfTApFNFKBpTU3mfkd1Xeu+
         fqu9JcPBAb+DgkPH425YiHImn2FXdpFVx/PFv7Wb2AwwRruyf+vh6KVTBfSuuPfLOb4H
         TAH9ZZlnGPTfmriQ4TJsK3yymY8yZNA0+iU0hFQLNKU9a0zeUY7J8E/BRWUBAbJrx/UH
         pm3A==
X-Gm-Message-State: ABy/qLYuvuILwtPhXImC6z4LoBTdU6AGxvYKVvJixBeOZM59DoRADAcB
        F5SlNEhr57DrruL5rIbj8QB7c1ER0ecVWmC4SDsCpA==
X-Google-Smtp-Source: APBJJlFh9kMd1fzY9yvbFDXzPr4PVJkRRproQgRNqT1MBQquMF4Uv4bucrEphiHqOQ0vZ1DElcgRyg==
X-Received: by 2002:a81:6704:0:b0:57a:8de6:86b1 with SMTP id b4-20020a816704000000b0057a8de686b1mr91330ywc.31.1689205067757;
        Wed, 12 Jul 2023 16:37:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o8-20020a0dcc08000000b0054c0f3fd3ddsm1483859ywd.30.2023.07.12.16.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:47 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 08/20] midx.c: prevent overflow in `write_midx_internal()`
Message-ID: <09bd84700bd1904cd5340d5c4dbf7bd84ae1922d.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a MIDX, we use the chunk-format API to write out each
individual chunk of the MIDX. Each chunk of the MIDX is tracked via a
call to `add_chunk()`, along with the expected size of that chunk.

Guard against overflow when dealing with a MIDX with a large number of
entries (and consequently, large chunks within the MIDX file itself) to
avoid corrupting the contents of the MIDX itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index b176745df1..57c53dbd4a 100644
--- a/midx.c
+++ b/midx.c
@@ -1501,21 +1501,22 @@ static int write_midx_internal(const char *object_dir,
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
 		  write_midx_oid_fanout);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  (size_t)ctx.entries_nr * the_hash_algo->rawsz,
+		  st_mult(ctx.entries_nr, the_hash_algo->rawsz),
 		  write_midx_oid_lookup);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
-		  (size_t)ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
+		  st_mult(ctx.entries_nr, MIDX_CHUNK_OFFSET_WIDTH),
 		  write_midx_object_offsets);
 
 	if (ctx.large_offsets_needed)
 		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
-			(size_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
+			st_mult(ctx.num_large_offsets,
+				MIDX_CHUNK_LARGE_OFFSET_WIDTH),
 			write_midx_large_offsets);
 
 	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
 		ctx.pack_order = midx_pack_order(&ctx);
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
-			  ctx.entries_nr * sizeof(uint32_t),
+			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
 			  write_midx_revindex);
 	}
 
-- 
2.41.0.347.g7b976b8871f

