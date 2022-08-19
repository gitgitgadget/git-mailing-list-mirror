Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B732C32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352638AbiHSVah (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352568AbiHSVaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85AC104B3A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c9so3033654qkk.6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ZaKuBtWVTlemWiVOiVNpqCfcFRaKxUfBq3eH7HUa1gU=;
        b=VCKY+Zh/8/kUIpuwt/rkFyfolqi8QRorwJEhyKMuGah9kfXt1A0tXr6jegTK6mTQW6
         iaJu86xlqA0rdmxDe3lIh129D5AkY+5DBkEYffBvIpx51XyHx8OKcCdl5cXwV9d6SEsC
         OIfZcsuRKP8o/2K9a4zDlSYv9QaYD5b65pj+hrVWsm9FtAxAl6Bcdkr7li1ufBp8XX8K
         HxkDGBC9xEzVOe3taMLuR1SUavzU5H9cV2rFMAsnj7YSVhhDJzl1vgm/afTOXGbjCcfw
         DzZfRVvSYcphRVCIrAXgFMj/8QwbFeoHr9+4JG03ql2KsreWKgWo9TNej+Fw+ca6Z7eR
         YIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZaKuBtWVTlemWiVOiVNpqCfcFRaKxUfBq3eH7HUa1gU=;
        b=Hw63ziK0xazGWqzq2dAOSNj10ZaWPe+/q36wyRIKj28WhbnsNgbMW54cwkZHHTsLve
         auVmEohmhIF3Onuh1wOe/fQJdfRboa0T6+J9FSOrNQQKTu1mUUIhxhKC75bLikFwz58m
         Cp2fijCCGQGq1vjin4wYgjhqLiVmhwh6EqOO1+aAmBhzgbM9VNz7fU/yhKnKPfrBTTaw
         vfDoWEJL51qtMJW2EDvtiXQrzjnnNWE1TBDd572aTRF9rZGFP/odngu1xbLo1u+n/KXJ
         MuxbFfYlBalcsIzzhCCzL/0MG6Mnlr+cmPauYBSJJInSxAItEuFl3O4v6HtgwdlWI5Na
         JOzQ==
X-Gm-Message-State: ACgBeo1Tlj0Vw0BXlQRu9MEEDgp/jhsfnR9jI/Bh5382ASSlMfdKYU4m
        LK+qDUZNj1dNMlcewlDCvg2gM2EW//TiBa1M
X-Google-Smtp-Source: AA6agR66l+buark168l98Z7NdRDmudWT8YQpdbKW/Di7qELNfms0yYt3rE/zbnh+4Flf4BdGbQCF0Q==
X-Received: by 2002:a05:620a:4149:b0:6bb:2c53:4702 with SMTP id k9-20020a05620a414900b006bb2c534702mr6776216qko.656.1660944619828;
        Fri, 19 Aug 2022 14:30:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05620a478200b006bb024c5021sm4824832qkb.25.2022.08.19.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:19 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 4/6] midx.c: extract `midx_fanout_add_midx_fanout()`
Message-ID: <92b82c83ea31a7453be7a3414c725b2fda13065b.1660944574.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
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

