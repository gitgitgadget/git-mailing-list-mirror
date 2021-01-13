Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DAAC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEAF23447
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbhAMW1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 17:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbhAMWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:24:51 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F8C06179F
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:43 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 19so4430478qkm.8
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=th3JkT+WF9nKA4iSS3MEW4HqFzIjPMuj6pDG3bDURq8=;
        b=slvD1/lsh6fK16re9sTuA+WPCz7A2NDhNSdVeMGRtp7G8jrYX0DffEb7I2t85k/o4j
         awKlEjqN7rlzQCYNk7IIcEV2UZptuT561OZNQUebIE/THH8+8wSMF8uGXwTskDgq20DV
         +ExKTSHp5lpr1pWp0SJ+opYgnjx+vPwXqFNZDCzxItqbfNIMB5tkG4fZp6ypH0jwRJFZ
         Sf47+smJ4E+JkHTnQY7EftKN7jXcHFF+2cq+WxPctPI/BP2Ie94rmQFadrdsLtSoVf3e
         IFFuJhw9bAODG1zbUH56O+sMqbwNpT0YlLp6+rBAkFQbHTBwv6iL3LqIHCTx83nYLVQt
         SzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=th3JkT+WF9nKA4iSS3MEW4HqFzIjPMuj6pDG3bDURq8=;
        b=Sxi/tB2pqAkzPwbW10vhOBmTYzrUqSJN2WVigmMT+TrBLB6cVQoY05h3k/14r5YRyr
         av+M5AlYnb/a8RlRAQW/HgCx7hScpYEWFs338r4ImAo+WN3LUHP4b/PwnQjIGWrN8E5w
         JXlokWM69Q/tCbZOKXxmLpc7HsU2u0knReiK9FL4nnZg1QRfDBFLaf0/W3zy14lAHzus
         gQgh2bDq5hARf+Ag5PU4nREenGK8/JJpmrRqFFzruLVNBhYBweWK4uEk0nXejXHis4do
         cKkU87mFV/5Xo+IU6OrO6mk5/IRKSbFqLf42cQNUjDc+4xJRYAcs5axjnk0Tb4hL9jui
         zpSw==
X-Gm-Message-State: AOAM532d2WyJNgFc9OFFpH8hv5I2BAhoSnTo7ryvEVIWztwQ28JBvU6d
        TQjZTp141DpCEdbBGyD6B6VhjRYnzAJErQ==
X-Google-Smtp-Source: ABdhPJzIG5mkAPMPNTYW4KTI/i26W5YX8pladSc874mTIFTgNubrSjcHm1Qz2RbshhbQWGfgnbGbJw==
X-Received: by 2002:a37:aa57:: with SMTP id t84mr4571145qke.348.1610576622177;
        Wed, 13 Jan 2021 14:23:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id 128sm1933146qki.26.2021.01.13.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:41 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 03/20] write_reused_pack_one(): convert to new revindex API
Message-ID: <7676822a541bfef1861be01dc55d86d3d0cad494.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace direct revindex accesses with calls to 'pack_pos_to_offset()'
and 'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ab1fd853f1..8e40b19ee8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -868,8 +868,8 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 	enum object_type type;
 	unsigned long size;
 
-	offset = reuse_packfile->revindex[pos].offset;
-	next = reuse_packfile->revindex[pos + 1].offset;
+	offset = pack_pos_to_offset(reuse_packfile, pos);
+	next = pack_pos_to_offset(reuse_packfile, pos + 1);
 
 	record_reused_object(offset, offset - hashfile_total(out));
 
@@ -889,11 +889,17 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 
 		/* Convert to REF_DELTA if we must... */
 		if (!allow_ofs_delta) {
-			int base_pos = find_revindex_position(reuse_packfile, base_offset);
+			uint32_t base_pos;
 			struct object_id base_oid;
 
+			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
+				die(_("expected object at offset %"PRIuMAX" "
+				      "in pack %s"),
+				    (uintmax_t)base_offset,
+				    reuse_packfile->pack_name);
+
 			nth_packed_object_id(&base_oid, reuse_packfile,
-					     reuse_packfile->revindex[base_pos].nr);
+					     pack_pos_to_index(reuse_packfile, base_pos));
 
 			len = encode_in_pack_object_header(header, sizeof(header),
 							   OBJ_REF_DELTA, size);
-- 
2.30.0.138.g6d7191ea01

