Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE9BC433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2F723A77
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbhAHSRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:17:36 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDBCC0612FD
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:16:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 2so7139638qtt.10
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UP73oMI7bhb0Pt6RrRRL5A/CykLwrQAxYltzzm+s29k=;
        b=xqIo1rea/81RUIBivrX2i/Ie4DHaeBnKEUdHI1Ict7P5D8bBzuANFkc3c4YCq2ua99
         Cr1r7l0PdLyVwLTKYQwIYWK074LGPg2o3134HzD8APvC6HmnOIPAjfBAwVDj7IO+y9Cz
         anZ03EczkGM5ukUS0hx7R3ElY3A+L0TNcnJZM+Vf8Lmcth+tpqY//bZ8UXActQQcihBG
         DHKaxnUuB+j/7Up7yTo7IN5AZCg6QjmTeiP7Vk9BcOO9pLjGc2fepy+X6EeVXwGELBTX
         oJoQ0Jpg7sm/pAf1a6V87EJ+WcMyOlZoEq87VIgTNRBqKyVunj8MH8lQpMl9abxPUVCu
         IYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UP73oMI7bhb0Pt6RrRRL5A/CykLwrQAxYltzzm+s29k=;
        b=tdPiiKkqRNNt2Nb8V7LBTiNrJpR2jerl4O6hKLmiOYY9QweGeZ1mhpQ+RkAxU/j21K
         it9XRXGXSX7q4wjmyx0sI15Yg8eVuHmF74qnKQ3LWIlkAb//k1ACMIZkwnzmvNTgNzwS
         AOejgLe2UZJivppA1XtGmAIPYHnmEwlvclkVlFpugHo87jlrH77dGx0cQ0CUyhF2P+IY
         eJ6dAnkb6ObBvoDHu4OwIUrDD3ZueQqaXCJcwTreGL0BFY9AS/MtS91AHioDl1r/h0Fb
         eWbPmuIUGJ+F1LkyPmvvKewG6Fz6+MFNnjiJl6InQcIHnXwKPHOK65I2LatQmrsqYrnv
         Wpsw==
X-Gm-Message-State: AOAM530ks5rQh7RYrLd1OAG7Ly4P2FHLC9tPKOaMO0p82A+JSwPhkwfs
        INkbCmkH+d1XyMJoYFMZzhWMn6WwwI3ASw==
X-Google-Smtp-Source: ABdhPJykd27brv1uH43UWQfLy/MHGvBCp7AgDl2QjSbc6KQwlQk0xQDcpceMVM+jRbzgr42sEK/+Tg==
X-Received: by 2002:ac8:1c38:: with SMTP id a53mr4818855qtk.70.1610129814876;
        Fri, 08 Jan 2021 10:16:54 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id 127sm5235003qkj.51.2021.01.08.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:16:54 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:16:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 03/20] write_reused_pack_one(): convert to new revindex API
Message-ID: <81ab11e18c0b00030019f9f521216f3469fdd744.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace direct revindex accesses with calls to 'pack_pos_to_offset()'
and 'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 03d25db442..ea7df9270f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -866,8 +866,8 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 	enum object_type type;
 	unsigned long size;
 
-	offset = reuse_packfile->revindex[pos].offset;
-	next = reuse_packfile->revindex[pos + 1].offset;
+	offset = pack_pos_to_offset(reuse_packfile, pos);
+	next = pack_pos_to_offset(reuse_packfile, pos + 1);
 
 	record_reused_object(offset, offset - hashfile_total(out));
 
@@ -887,11 +887,15 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 
 		/* Convert to REF_DELTA if we must... */
 		if (!allow_ofs_delta) {
-			int base_pos = find_revindex_position(reuse_packfile, base_offset);
+			uint32_t base_pos;
 			struct object_id base_oid;
 
+			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
+				die(_("expected object at offset %"PRIuMAX),
+				    (uintmax_t)base_offset);
+
 			nth_packed_object_id(&base_oid, reuse_packfile,
-					     reuse_packfile->revindex[base_pos].nr);
+					     pack_pos_to_index(reuse_packfile, base_pos));
 
 			len = encode_in_pack_object_header(header, sizeof(header),
 							   OBJ_REF_DELTA, size);
-- 
2.30.0.138.g6d7191ea01

