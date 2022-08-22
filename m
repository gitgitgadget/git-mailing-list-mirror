Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF421C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiHVTvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiHVTuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30095283F
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:48 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w28so8777634qtc.7
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IJc+d+l0tYTwna4fuOdWhSK5he40CommzX41O51/Bug=;
        b=nb3LyijBTs0PsRiD9sfAfIt7F8G/Eu+XeLD/N7uiJPRn3VSfLgtD5oOqdD0qMRMEe/
         fKql7UU47IwbG0BeYJVaOaGn3sS1EGXtVNbRX7NXdymbwDuMaaRkYaTZGK+LX9k9zRt4
         OcMzjoicwjoxgySpNA1i7U8/+KPraCzNXz84OZTkFDi85ntzMi9YkYZy0CoTSZWsA9jj
         qp7fQgGeSA4CRzB9pCb3eQDd1mA+2qz9S550shN0i8hQPNc5pZU3u1jaC5d90zCn28gY
         TVa/UVUn9dbtRCb1SYG+WAUZOO7Rc74sUwu0n8OkwmNmR6AIFOocvP5WSPOTZn+FUPWj
         n5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IJc+d+l0tYTwna4fuOdWhSK5he40CommzX41O51/Bug=;
        b=yUmvdMK3PbKNLndzBw1ajBvGjK5r+4c5Hzn46rCkYI2CfkUnO9gIe99vLNcoEuJEjF
         Cc1ZsQFRam8/SkmMmiBXi4wSPPdBStfNFjn/WPf20h7Jo8idVlgPL0Jz6fNPA+Zud2bG
         RO18wUIb/A0hH7dkIwwz+piETbMvK5Z1XIF75YQmqhxxs93r9fezDplGDc1yWr6bYamb
         T81wRItTl7VVKezaCqd3KNwAwVBXsWfZe0z1mvNBGtfVTVRN6QR1gwAtEH3bLQnp974u
         JgHD3npbnrPSGEfy74+SNotj4m/YSnte04rAJiLkaUCbCibExlOaG3afo/+r4AiGE8Li
         Bzdg==
X-Gm-Message-State: ACgBeo3efdevyowuIDmqqmmep63e3C/IWp3rCtxyGgjN15txc3K72Z6A
        jr8OSA7cpjW75dHnPmpAb25mqhltyp4whU2o
X-Google-Smtp-Source: AA6agR6HziyWn85XmsOH6ST1KT+MiDZ2TooHdlRkgxABBP4uwgfjLglnSH7qfIOQM5qaQpMT49ms+w==
X-Received: by 2002:a05:622a:8a:b0:344:5611:7a8a with SMTP id o10-20020a05622a008a00b0034456117a8amr16883035qtw.565.1661197847734;
        Mon, 22 Aug 2022 12:50:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d134-20020ae9ef8c000000b006b942f4ffe3sm11001800qkg.18.2022.08.22.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:47 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 6/7] midx.c: include preferred pack correctly with
 existing MIDX
Message-ID: <d301c4d87f8a490c90268aa251a94253f1e2b730.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
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

This resolves the bug demonstrated by t5326.174 ("preferred pack change
with existing MIDX bitmap").

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                        | 14 +++++++-------
 t/t5326-multi-pack-bitmaps.sh | 13 +++++--------
 2 files changed, 12 insertions(+), 15 deletions(-)

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
index c364677ae8..89ecd1062c 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -338,19 +338,16 @@ test_expect_success 'preferred pack change with existing MIDX bitmap' '
 		git pack-objects --all --unpacked $objdir/pack/pack0 &&
 
 		# Generate a new MIDX which changes the preferred pack
-		# to a pack contained in the existing MIDX, such that
-		# not all objects from p2 that appear in the MIDX had
-		# their copy selected from p2.
+		# to a pack contained in the existing MIDX.
 		git multi-pack-index write --bitmap \
 			--preferred-pack="pack-$p2.pack" &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
-		# When the above circumstances are met, an existing bug
-		# in the MIDX machinery will cause the reverse index to
-		# be read incorrectly, resulting in failed clones (among
-		# other things).
-		test_must_fail git clone --no-local . clone2
+		# When the above circumstances are met, the preferred
+		# pack should change appropriately and clones should
+		# (still) succeed.
+		git clone --no-local . clone2
 	)
 '
 
-- 
2.37.0.1.g1379af2e9d

