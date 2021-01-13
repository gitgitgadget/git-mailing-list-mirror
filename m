Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDFAC43219
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37A5235F8
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbhANCJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbhAMWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:26 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E9C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:04 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a13so1571743qvv.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s/jzWv7ik0siGaWEbLup/aObJEvS0hexzhbxZN1XUSg=;
        b=qEWVlbxTLbhivMaCYbfkf42S9o/jOO9+xUj87aNBwMIwqTGIcf7vErsiFOui1mlJB8
         RqfXD9y9Ygf3OWX0jxIIdssUW4Zt88nyq/7m2ZK/R3nCsVolmKjnyoKoQeQeb439x2bp
         7pSFmQGR9G3l5qsET5M8UFGG0oAxp55KaCLBHfNiTsSTT0NFxtP9DuLbmrxp1DAoFuBK
         1Vjso2KxTUjc0H00xavcOaUxeIKafdLT5zL46kfdNuwMTUjem65y0+maihtJHh4KrD4V
         CJvd2XDTQTQXsNIGiIclM/eVezrpFFeNYkQlUS2dDzcFlvB3/JwKzYGbpTnQmxFEOyQH
         80CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/jzWv7ik0siGaWEbLup/aObJEvS0hexzhbxZN1XUSg=;
        b=OQ5t1wMqrEGHXUrlFCRvu0d9VEpUyRGS8aKZ9smPqSbi2X/pQ7pfDxPGwoQYQDVp9r
         KwyyNPWwJWtR17XuIev3w+zzXTjjWPaWtTepBoxRQDP3Csa4qHz0R4vU1iDFAuQVSURH
         14O8Qo7y+FqM3bN+DOUv7AqlEENJ5Pvb6uZJukI+MfYcJgNwc3XvJRY9UqVAoOw3iLuR
         mKTyh2o4PMr9PbR0z5CmhYHL7MvnvoyiCeVZnQoWxm4+G5vaD8Sct4XpGxbvSUcM3mXt
         npOgE7In1nZsG7THCPOPBx+ZkE82ua4NeX+Dlrn/WagimFHfWZKoLyyXe9dto1c2lYxO
         dfiQ==
X-Gm-Message-State: AOAM5305DFKRt6Z0KUf3O4BvfV0Qog5hUGn4syZco8HOZxQdrHfhDTR8
        5k+lv5rsEYacicrPzcUd7P5K+1MXomomxw==
X-Google-Smtp-Source: ABdhPJzv10b+Pnr7AkzOJ2iPspX/uz3eQ6IHHFprCuEQ5evI+shLIQqandfkuw45dHBy21QtdVsFgA==
X-Received: by 2002:a0c:f283:: with SMTP id k3mr4787255qvl.48.1610576643361;
        Wed, 13 Jan 2021 14:24:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id s186sm1887847qka.98.2021.01.13.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:02 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 08/20] get_size_by_pos(): convert to new revindex API
Message-ID: <31ac6f57033f942be5ab4eff96e482a93fda4196.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another caller that holds onto a 'struct revindex_entry' by
replacing the direct indexing with calls to 'pack_pos_to_offset()' and
'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 27a7a8ac4c..89a528a91b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -835,11 +835,11 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 	oi.sizep = &size;
 
 	if (pos < pack->num_objects) {
-		struct revindex_entry *entry = &pack->revindex[pos];
-		if (packed_object_info(the_repository, pack,
-				       entry->offset, &oi) < 0) {
+		off_t ofs = pack_pos_to_offset(pack, pos);
+		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
-			nth_packed_object_id(&oid, pack, entry->nr);
+			nth_packed_object_id(&oid, pack,
+					     pack_pos_to_index(pack, pos));
 			die(_("unable to get size of %s"), oid_to_hex(&oid));
 		}
 	} else {
-- 
2.30.0.138.g6d7191ea01

