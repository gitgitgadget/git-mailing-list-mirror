Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C23C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352546AbiHSVaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352516AbiHSVaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7612104B3A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g16so4157031qkl.11
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xl0bw3hovoae6eENfiU7jhcPD4X5CtqHgODD0kT5nHE=;
        b=MglEoP7yfPDyPix1GngpLZkZEmDW0f8NSijbmOsKNlCWJ0Aqzx7Li7hOTOIe7/eSr0
         m7QQwYSN9SjO0WzOXwD8erKT4UvioN8C8f5de4Pz8hw/VhqZF10/fAFqnp22RvGHeUU4
         onlBNwE48+jyFQVuS+61o2YXRglV7tbH1G9U6sTcX+vmVaIOGXTEhUuJuDcuwzQiiIQC
         12vdybGkp7QIZ/U54fXcAgmCtQ4iB/xJ/xkkF8kAh2DvyHwgTZ2iNrjFHdi6c2TDiMPl
         XicsouFEm8LkMIw8LYeMpQF0Anxahf8bZvUqHdAlkTPAPxFIU14lrPgpiUWBIfyUzidT
         a3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xl0bw3hovoae6eENfiU7jhcPD4X5CtqHgODD0kT5nHE=;
        b=MRbIKpIoBjihWR2yANw5eYxVhouSB92Lq/gscpnEntYkfhfKCfpMu/hLkfBaEM+XS8
         4MX4UrdWq/Zp1u8Je6YY8bIc7AkWO0tgjsidFaiiDotCacjHUt7dZyDHjVQLT4bZl/rz
         ELZyaQ+F0ONEiTvIvVpzIoj05VodYvSxbt34EEL2Yk69wMMR5Nk395cOIWJ/Ac22j/sO
         VpAC8qe1GtJcXLRjsA957krL56TyrxE8hgncRPTY1MVSDnAS8UUp4sFYWPkAlx5w/ns9
         onMVyZfLfejJ3qSo1fvYVx+xZ9MZGJOjakXNQ9qPcvRNM5EgBEiE5qN0X3d4/IiiYhsp
         +x/g==
X-Gm-Message-State: ACgBeo3OpsKiheemacPv/X+2qk4NhNbvi2Szy3EPbIn1jKAQt97qARjQ
        lXV31JkzM4AF75OQFFmY5P4kVGShhcJ3pZDN
X-Google-Smtp-Source: AA6agR65bjQ4j7PRU+Bq8ZBycQKTOo38F9Dj+TvALb5gLz9m7sl958qR1gU+mkfHmN77eDXnsz8TIA==
X-Received: by 2002:a05:620a:13d1:b0:6ba:c5e8:eb0d with SMTP id g17-20020a05620a13d100b006bac5e8eb0dmr6326975qkl.569.1660944611707;
        Fri, 19 Aug 2022 14:30:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s21-20020ac85295000000b00343028a9425sm3655378qtn.16.2022.08.19.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:11 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 1/6] t5326: demonstrate potential bitmap corruption
Message-ID: <3e30ab1a19115107fc24a25118f2417319bd1b0d.1660944574.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to generate a corrupt MIDX bitmap when certain conditions
are met. This happens when the preferred pack "P" changes to one (say,
"Q") that:

  - "Q" has objects included in an existing MIDX,
  - but "Q" is different than "P",
  - and "Q" and "P" have some objects in common

When this is the case, not all objects from "Q" will be selected from
"Q" (ie., the generated MIDX will represent them as coming from a
different pack), despite "Q" being preferred.

This is an invariant violation, since all objects contained in the
MIDX's preferred pack are supposed to originate from the preferred pack.
In other words, all duplicate objects are resolved in favor of the copy
that comes from the MIDX's preferred pack, if any.

This violation results in a corrupt object order, which cannot be
interpreted by the pack-bitmap code, leading to broken clones and other
defects.

This test demonstrates the above problem by constructing a minimal
reproduction, and showing that the final `git clone` invocation fails.

The reproduction is mostly straightforward, except that the new pack
generated between MIDX writes (which is necessary in order to prevent
that operation from being a noop) must sort ahead of all existing packs
in order to prevent a different pack (neither "P" nor "Q") from
appearing as preferred (meaning all its objects appear in order at the
beginning of the pseudo-pack order).

Subsequent commits will first refactor the midx.c::get_sorted_entries()
function, and then fix this bug.

Reported-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4fe57414c1..a60cec5cab 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -307,4 +307,47 @@ test_expect_success 'graceful fallback when missing reverse index' '
 	)
 '
 
+test_expect_success 'preferred pack change with existing MIDX bitmap' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		test_commit other &&
+
+		git rev-list --objects --no-object-names base >p1.objects &&
+		git rev-list --objects --no-object-names other >p2.objects &&
+
+		p1="$(git pack-objects "$objdir/pack/pack" \
+			--delta-base-offset <p1.objects)" &&
+		p2="$(git pack-objects "$objdir/pack/pack" \
+			--delta-base-offset <p2.objects)" &&
+
+		# Generate a MIDX containing the first two packs, marking p1 as
+		# preferred, and ensure that it can be successfully cloned.
+		git multi-pack-index write --bitmap \
+			--preferred-pack="pack-$p1.pack" &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		git clone --no-local . clone1 &&
+
+		# Then generate a new pack which sorts ahead of any existing
+		# pack (by tweaking the pack prefix).
+		test_commit foo &&
+		git pack-objects --all --unpacked $objdir/pack/pack0 &&
+
+		# Generate a new MIDX which changes the preferred pack to a pack
+		# contained in the existing MIDX, such that not all objects from
+		# p2 that appear in the MIDX had their copy selected from p2.
+		git multi-pack-index write --bitmap \
+			--preferred-pack="pack-$p2.pack" &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test_must_fail git clone --no-local . clone2
+	)
+'
+
 test_done
-- 
2.37.0.1.g1379af2e9d

