Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC31C4332E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AE1235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbhANCFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbhAMWZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:52 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DFC0617A6
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:10 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h19so2275469qtq.13
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KYD+b+Qf3QpTk8jEzVklSRxKA6eMCZRnIVnPFQom6eA=;
        b=bJThc14WGm/MskkkM3eUloWYMTsFG3Ll20UYz9g2Qgvb4Zh6PjMHkA9rEl3SlAXEV5
         gjUyMlfSeMesua7zjb612zGwuiImEOhR4k+HFIBeqvHQ0Wj+SAgQTjk/LWRj6IoLoE63
         xp33Gtw/0ZQR1GZhJReUqkZXPKjbgQx2s+8xeL1oTLhrH6sVswknvGp3eHet2vPVOLxR
         YT52W6MJleHVedOXE1mSoCw/dCQ7ojEEBXPDNO/1S+C+8zBpE03oiODF9pAqVRvBapqn
         qpbQZMWJl3x76fp2EIRGmLhVte6rqhBeIZZ69e7GL5+bHMP447UDb0CsRw70nHK1JcNo
         q1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KYD+b+Qf3QpTk8jEzVklSRxKA6eMCZRnIVnPFQom6eA=;
        b=Rwjbo6ouuFoEHj4+XDI+XA+o5SDoR+fSoCmaNqippwvfq8pptJVtGiqwnO9qJNnQke
         ohhYjirHpVmAWN4SiayLpKUfWBHnjIAWKm/OIj988auu2tY4GZKQjGRAZii2PCL0OtOC
         amYu4QzRMGjR1zA8EwhFZml/oush1N1YWfAOUnY5AO0Jd4z4zZDxK4RU+Mh1p4/ZQBoZ
         IJjFh4ecOtNMcE/Bhi28WbPgIrOFskmY7R5HdFQSzyy+XUb8hWvY0uxs42BRw2GKuFwD
         8WiGuTNIw1+xXCt2rj6udFzdzEkHV0kXWNL2spI55qym9TGQTl7ru5t2vj7+3tlwzYhE
         uF4g==
X-Gm-Message-State: AOAM533FoTk6EGSGtc6shVcqvxpqKuh6r+nVcT3mrRxhnDb75Z8WattP
        1+PTD+IjLUuLd9oJOGdMdse8bKzS1w5KiA==
X-Google-Smtp-Source: ABdhPJwgUWYEOXcckmcfO7/wkgrMPlUUKM9teXFxAsdr3pH0myjgpwLTzxL7iA7mQO5QiKlE4nkDSQ==
X-Received: by 2002:aed:2ba5:: with SMTP id e34mr4599597qtd.146.1610576649048;
        Wed, 13 Jan 2021 14:24:09 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id p75sm1933341qka.72.2021.01.13.14.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:08 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 09/20] try_partial_reuse(): convert to new revindex API
Message-ID: <acd80069a2bea5cede6b68302b7ff8097924dcd0.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another instance of direct revindex manipulation by calling
'pack_pos_to_offset()' instead (the caller here does not care about the
index position of the object at position 'pos').

Note that we cannot just use the existing "offset" variable to store the
value we get from pack_pos_to_offset(). It is incremented by
unpack_object_header(), but we later need the original value. Since
we'll no longer have revindex->offset to read it from, we'll store that
in a separate variable ("header" since it points to the entry's header
bytes).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 89a528a91b..1fdf7ce20a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1069,23 +1069,21 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 			      struct bitmap *reuse,
 			      struct pack_window **w_curs)
 {
-	struct revindex_entry *revidx;
-	off_t offset;
+	off_t offset, header;
 	enum object_type type;
 	unsigned long size;
 
 	if (pos >= bitmap_git->pack->num_objects)
 		return; /* not actually in the pack */
 
-	revidx = &bitmap_git->pack->revindex[pos];
-	offset = revidx->offset;
+	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
 	if (type < 0)
 		return; /* broken packfile, punt */
 
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
-		int base_pos;
+		uint32_t base_pos;
 
 		/*
 		 * Find the position of the base object so we can look it up
@@ -1096,11 +1094,10 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * more detail.
 		 */
 		base_offset = get_delta_base(bitmap_git->pack, w_curs,
-					     &offset, type, revidx->offset);
+					     &offset, type, header);
 		if (!base_offset)
 			return;
-		base_pos = find_revindex_position(bitmap_git->pack, base_offset);
-		if (base_pos < 0)
+		if (offset_to_pack_pos(bitmap_git->pack, base_offset, &base_pos) < 0)
 			return;
 
 		/*
-- 
2.30.0.138.g6d7191ea01

