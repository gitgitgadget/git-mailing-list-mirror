Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC35AC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352654AbiHSVam (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352601AbiHSVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:27 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B83105236
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:26 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y4so4266145qvp.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+kD8uhULEgShWmro8+JgoRWcyj45Q9jnMb2lF/08h84=;
        b=NyMdWQgAIi/7v7mNBr1Ns6p5naMBOLC80atb3Uoy+p0+7Vp5mkairbhL8FScmLE7RX
         PDohfSS2murjNZoHf6b1v9WCy0hRP5op9zFu50L2Kbb9zRYlQwT+gGN8vm751D+94RCk
         LDha/3OZt8Z4jimor96qzgEYy2stuRrRzVOtt3QENxbwY2qLb8EY5fkRCBGjd8AHc5St
         7Gxzd8A1oWWDtDR4jOd0QdbCF6CpAXMoShNsGfrs2Yqut1UTih9l73LRouXLhrS0vx/H
         SZx7XTnfaMYRcT8LBUjyEy2Wl9v7NyxAxgz3c7i2q6CLATD/Mn8hbtElA0cr/YkCFzDq
         GoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+kD8uhULEgShWmro8+JgoRWcyj45Q9jnMb2lF/08h84=;
        b=BimBaEwze76G3LsuvstBj/JBDMLd9/KlNRa4PWt6vv40knYvQvFTA02OnnqafAABRv
         ZeMJMPsEm6XNE/ERgsstGND9RaBId3c6ZcsvudF1U21bEGgQUqoSoA6pxgMZmFg8+8Rw
         luvYGP8fQ1aXDztgustTZJfIDL+XuOesuUMNlnEu6YfUvOxYRKyO2TL4mza715NiiuSh
         l7bkb1EOvteXU39DHbF0IrUKJgyaa25Dfg/tkCY/zsu/zetCrDNQdJdgbn8OAMI3YeC8
         vzX49x0nJ8fQ/2Z1+L5092ZpX5P/KD1zRu8dm9LknKytLW/SMT1ZQt+N+nl/4gvQe62c
         WqZQ==
X-Gm-Message-State: ACgBeo1K+caB773PMD+cXDMUqUBlckKKmeFKf8m0SZzWu7yo0/QxkWBz
        +RqHD1wPCcGzhgHeo8z1kQxxm+2pmIA5Dhqj
X-Google-Smtp-Source: AA6agR5NNGbLDJxMauyUP7c7tmT4PDuWeSmXoMnBdc9KfF3NFoEJ5cx6mV9kddi7XQOB2BB0lQudOA==
X-Received: by 2002:a05:6214:262a:b0:496:ccc1:12c6 with SMTP id gv10-20020a056214262a00b00496ccc112c6mr1577273qvb.33.1660944625227;
        Fri, 19 Aug 2022 14:30:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q205-20020a3743d6000000b006bb296e3298sm4201541qka.20.2022.08.19.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:24 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 6/6] midx.c: include preferred pack correctly with existing
 MIDX
Message-ID: <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch resolves an issue where the object order used to generate a
MIDX bitmap would violate an invariant that all of the preferred pack's
objects are represented by that pack in the MIDX.

The problem arises when reusing an existing MIDX while generating a new
one, and occurs specifically when the identity of the preferred pack
changes from one MIDX to another, along with a few other conditions:

    - the new preferred pack must also be present in the existing MIDX

    - the new preferred pack must *not* have been the preferred pack in
      the existing MIDX

    - most importantly, there must be at least one object present in the
      physical preferred pack (ie., it shows up in that pack's index)
      but was selected from a *different* pack when the previous MIDX
      was generated

When the above conditions are all met, we end up (incorrectly)
discarding copies of some objects in the pack selected as the preferred
pack. This is because `get_sorted_entries()` adds objects to its list
by doing the following at each fanout level:

    - first, adding all objects from that fanout level from an existing
      MIDX

    - then, adding all objects from that fanout level in each pack *not*
      included in the existing MIDX

So if some object was not selected from the to-be-preferred pack when
writing the previous MIDX, then we will never consider it as a candidate
when generating the new MIDX. This means that it's possible for the
preferred pack to not include all of its objects in the MIDX's
pseudo-pack object order, which is an invariant violation of that order.

Resolve this by adding all objects from the preferred pack separately
when it appears in the existing MIDX (if one was present). This will
duplicate objects from that pack that *did* appear in the MIDX, but this
is fine, since get_sorted_entries() already handles duplicates. (A
future optimization in this area could avoid adding copies of objects
that we know already existing in the MIDX.)

Note that we no longer need to compute the preferred-ness of objects
added from the MIDX, since we only want to select the preferred objects
from a single source. (We could still mark these preferred bits, but
doing so is redundant and unnecessary).

This resolves the bug described in the first patch of this series.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                        | 14 +++++++-------
 t/t5326-multi-pack-bitmaps.sh |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index be8186eec2..bd1d27090e 100644
--- a/midx.c
+++ b/midx.c
@@ -595,7 +595,6 @@ static void midx_fanout_sort(struct midx_fanout *fanout)
 
 static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					struct multi_pack_index *m,
-					int preferred_pack,
 					uint32_t cur_fanout)
 {
 	uint32_t start = 0, end;
@@ -610,10 +609,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 		nth_midxed_pack_midx_entry(m,
 					   &fanout->entries[fanout->nr],
 					   cur_object);
-		if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
-			fanout->entries[fanout->nr].preferred = 1;
-		else
-			fanout->entries[fanout->nr].preferred = 0;
+		fanout->entries[fanout->nr].preferred = 0;
 		fanout->nr++;
 	}
 }
@@ -684,8 +680,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 		fanout.nr = 0;
 
 		if (m)
-			midx_fanout_add_midx_fanout(&fanout, m, preferred_pack,
-						    cur_fanout);
+			midx_fanout_add_midx_fanout(&fanout, m, cur_fanout);
 
 		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 			int preferred = cur_pack == preferred_pack;
@@ -694,6 +689,11 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						    preferred, cur_fanout);
 		}
 
+		if (-1 < preferred_pack && preferred_pack < start_pack)
+			midx_fanout_add_pack_fanout(&fanout, info,
+						    preferred_pack, 1,
+						    cur_fanout);
+
 		midx_fanout_sort(&fanout);
 
 		/*
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index a60cec5cab..4f3841661a 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -346,7 +346,7 @@ test_expect_success 'preferred pack change with existing MIDX bitmap' '
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
-		test_must_fail git clone --no-local . clone2
+		git clone --no-local . clone2
 	)
 '
 
-- 
2.37.0.1.g1379af2e9d
