Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB5C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiHVTuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiHVTut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE545006A
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so8720774qkl.10
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ZaKuBtWVTlemWiVOiVNpqCfcFRaKxUfBq3eH7HUa1gU=;
        b=eNd9L1CQKoD1v4WdtiB7/beZ5HQUdzL6p9ucc2h2FVHGzuN/tycqfdxv9wp3HJJxY3
         nVDTFxr5MCEVXquvQEtCl0OS0/XuzI4jE6TiwT09VWdisOD0cfwtkJDemk0jc0tIaiUy
         lxl0TVpxynZ8qv93m4CPOGkFTIoQF5guP9xbUhRKNKG2bc4USrsp0FHSpe8j+ImUO3rv
         NaA+qTfvbHyD74r6k4rMLdZ+TD/r4WiLce+TRPETTOVEFSzEEnMwlMTVIcglvjffQhon
         hmKP5jWd2JU8kSmfW3Ul0HaCFYxOWerKDGITsjJr2pgXiEUCJ7sCh/3/19vnPenQDbE+
         p0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZaKuBtWVTlemWiVOiVNpqCfcFRaKxUfBq3eH7HUa1gU=;
        b=lJNsSM2atxEis7gFM+ryupaNCp9laoacxUvasHlLaA7PkqK36+Za7L53WLwovQIW09
         cCI1kSaZqTorzfOnqmExYDpWE3CZit775opI1+4KCFMRtwaYDfEs9Yo9O175bAxcIzvi
         XmVcz/J0/sMfWEt0bnDCBMbDqjBBCasC7m5KQ/qgxHLzZ70Gs0UEr1J/Yuzx1XHs88oQ
         wMH7JRXNdn9z1M1lnGby1JeQr5yl9egkFTRes+SGVX/E0RTTfVRg03XjBk7mbtG4STOA
         6gr+Jyhq3x8WG60aINPoIhy0eSLtL7em2d3yioP+hxig+Uha9iRTdKbFnZ/JDSgyyVNy
         Z+mA==
X-Gm-Message-State: ACgBeo0DUZw1+mJjGNP6y//NQxkp5v2mGcTuHktNM5z/HjA+jh52UP+1
        vQr1lrxpIq8d64T0WMhK96zAaXxdA7ixKwBR
X-Google-Smtp-Source: AA6agR4110MgiynTtBUfbImx7+1zpKuxxmGwuGM7kXhEA7gwvUHHGNcn0J/HCM46YsJgXppHoD/ogw==
X-Received: by 2002:a37:87c7:0:b0:6bb:20e8:ee3c with SMTP id j190-20020a3787c7000000b006bb20e8ee3cmr13783713qkd.474.1661197842267;
        Mon, 22 Aug 2022 12:50:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9264191b5sm12192958qke.32.2022.08.22.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:41 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 4/7] midx.c: extract `midx_fanout_add_midx_fanout()`
Message-ID: <2351a9fc27140b99d9306eebcdb306df711f3c83.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a routine to add all objects whose object ID's first byte is
`cur_fanout` from an existing MIDX.

This function will only be called once, so extracting it is purely
cosmetic to improve the readability of `get_sorted_entries()` (its sole
caller) below.

The functionality is unchanged in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/midx.c b/midx.c
index cdb6c481c7..0d40089c4d 100644
--- a/midx.c
+++ b/midx.c
@@ -593,6 +593,31 @@ static void midx_fanout_sort(struct midx_fanout *fanout)
 	QSORT(fanout->entries, fanout->nr, midx_oid_compare);
 }
 
+static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
+					struct multi_pack_index *m,
+					int preferred_pack,
+					uint32_t cur_fanout)
+{
+	uint32_t start = 0, end;
+	uint32_t cur_object;
+
+	if (cur_fanout)
+		start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
+	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
+
+	for (cur_object = start; cur_object < end; cur_object++) {
+		midx_fanout_grow(fanout, fanout->nr + 1);
+		nth_midxed_pack_midx_entry(m,
+					   &fanout->entries[fanout->nr],
+					   cur_object);
+		if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
+			fanout->entries[fanout->nr].preferred = 1;
+		else
+			fanout->entries[fanout->nr].preferred = 0;
+		fanout->nr++;
+	}
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -633,25 +658,9 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (m) {
-			uint32_t start = 0, end;
-
-			if (cur_fanout)
-				start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
-			end = ntohl(m->chunk_oid_fanout[cur_fanout]);
-
-			for (cur_object = start; cur_object < end; cur_object++) {
-				midx_fanout_grow(&fanout, fanout.nr + 1);
-				nth_midxed_pack_midx_entry(m,
-							   &fanout.entries[fanout.nr],
-							   cur_object);
-				if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
-					fanout.entries[fanout.nr].preferred = 1;
-				else
-					fanout.entries[fanout.nr].preferred = 0;
-				fanout.nr++;
-			}
-		}
+		if (m)
+			midx_fanout_add_midx_fanout(&fanout, m, preferred_pack,
+						    cur_fanout);
 
 		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 			uint32_t start = 0, end;
-- 
2.37.0.1.g1379af2e9d

