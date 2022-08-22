Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93DC32792
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiHVTvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiHVTvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:51:06 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B005006A
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u6so4371683qvp.5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=61WnEJtEOMxH7DdglrD6RuoqWGFPUieBr48HGPuFatM=;
        b=RGYH+XEKhWNjlK/rqDYZe3jZqtAY4A0PmXRglmLHnhwcfq6vBcglKNr/7HBb9dIIgG
         fJbDIll3lNG6TMHr1NtIZEFfYA1UjqL9HG5VxhoKBK+Xunmr0y7P6Y7b/Jo5sjOX1qWG
         Ge4xAq7psFDP4lgiHHsLVdRd/KlhEHSWIfYqkhZE/EQbbZZAF6TEPWzvxXOaDqHyVLo7
         vM8DkCC+dtn6zVznCi7eQapv12aLqxhJcruPVsbwgDJKUN2ATxyRIgxeQWTKGShmH3Ti
         MOmB+Ik8aKRmJhQwiqegvQnX/gMzQcUGjdzUQHM5UFwoFrv8ai33K7EHMrfZyjZ+XL9p
         1iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=61WnEJtEOMxH7DdglrD6RuoqWGFPUieBr48HGPuFatM=;
        b=BEhQG/E3UQANZzI8+TxGPrbOP6HdnOsUUPxXJ5T+Ey06Nt8fDaQXMpoIRjpT7cgqr7
         njOCxeEcqUJDOmFhzxQsHhvXInEZ5b9/5doucOdhKVBjj6B7tZIivVA1E8X+WYeVOw9y
         JuGPHiegmVpCJk8KS2YW1FPT0l/jJSE2Oj8V31DM3z8zO+zWCoiSiVIwa7hBNL3s9e2R
         CN1bic0LqcPeC3McIlAHkmunB77+EOJovdTgHvz9cKD0JYV9ymPFJYBH036pOAYFJ/kS
         w1wd1/bT1JBmTf2TRrIvd6An5/87A4QO4IPLP/y5nk8neChywtCyPTnaQklGpWuhR4yi
         wdAw==
X-Gm-Message-State: ACgBeo2fFSkSGv0DwGXVJlO7o5mZ1uLtWwEku9V2T64E7lmx2u1/enJU
        csaTsBhbXw5n427uLTJoTj1yj4uGZFHHixUp
X-Google-Smtp-Source: AA6agR5QNOhk+WjLn13BUaIDBuR9xSds9LDTl7dTHyJb0eEX3/tBnH49RcBPp3p+NluAbbARzDI+iw==
X-Received: by 2002:a05:6214:262f:b0:477:734:3177 with SMTP id gv15-20020a056214262f00b0047707343177mr17323290qvb.67.1661197850391;
        Mon, 22 Aug 2022 12:50:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h11-20020ac8514b000000b00342f4fc290esm9511877qtn.71.2022.08.22.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:50 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 7/7] midx.c: avoid adding preferred objects twice
Message-ID: <887ab9485faa21f5a5cd889d97895ed41013803d.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last commit changes the behavior of midx.c's `get_sorted_objects()`
function to handle the case of writing a MIDX bitmap while reusing an
existing MIDX and changing the identity of the preferred pack
separately.

As part of this change, all objects from the (new) preferred pack are
added to the fanout table in a separate pass. Since these copies of the
objects all have their preferred bits set, any duplicates will be
resolved in their favor.

Importantly, this includes any copies of those same objects that come
from the existing MIDX. We know at the time of adding them that they'll
be redundant if their source pack is the (new) preferred one, so we can
avoid adding them to the list in this case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index bd1d27090e..148ecc2f14 100644
--- a/midx.c
+++ b/midx.c
@@ -595,7 +595,8 @@ static void midx_fanout_sort(struct midx_fanout *fanout)
 
 static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					struct multi_pack_index *m,
-					uint32_t cur_fanout)
+					uint32_t cur_fanout,
+					int preferred_pack)
 {
 	uint32_t start = 0, end;
 	uint32_t cur_object;
@@ -605,6 +606,15 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
+		if ((preferred_pack > -1) &&
+		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {
+			/*
+			 * Objects from preferred packs are added
+			 * separately.
+			 */
+			continue;
+		}
+
 		midx_fanout_grow(fanout, fanout->nr + 1);
 		nth_midxed_pack_midx_entry(m,
 					   &fanout->entries[fanout->nr],
@@ -680,7 +690,8 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 		fanout.nr = 0;
 
 		if (m)
-			midx_fanout_add_midx_fanout(&fanout, m, cur_fanout);
+			midx_fanout_add_midx_fanout(&fanout, m, cur_fanout,
+						    preferred_pack);
 
 		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 			int preferred = cur_pack == preferred_pack;
-- 
2.37.0.1.g1379af2e9d
