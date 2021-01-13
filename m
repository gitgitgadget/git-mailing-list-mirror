Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F80C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B3C23447
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbhANCF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbhAMWZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:51 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DD5C0617A7
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:31 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d11so1553247qvo.11
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLvmRTXhb3illIomvZeL4AS45p4cH2WTpKemzSExl2M=;
        b=p7KtcP29e3AzF3cjcTCtRON5fyZHTfPHe617YDyIAz6mAMi6tnzaY3kiq/YnYrrqwo
         7IzCkN94IHP3XM/l6E6ZZrIM5a5FLVDY3XVyya+VAlo346qO+QqkQn0gHRkprxDyaNdn
         1WtNVEY10J+uRL4In5Ncop1ul/Zbc+HQCNbIsS8Z6pfA1iORpS7nbIDySocqOrH7/6Tv
         QJtgTX69covomaqHEgDaisOiMTvHERhEar6NxiKS9NU/M9SdW629VqYTjJa+FwbuwEfS
         xqKmGzj9lD5GjjkuXQQ0l+Gp7XnAMe0A7MvfDP+bKbjdUjBDeOTkURB/TVe97spPDXcx
         MW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLvmRTXhb3illIomvZeL4AS45p4cH2WTpKemzSExl2M=;
        b=ClmThFIVKiNJL3oq+VxfLs8BLH4y9/hMDOTdmSNFLs30MXQPJSUWZQFCw4+dio1Jtw
         WMUfWtw2c3bNex2S3zOQIbT90zxO7sM7709cnjEy+Em5uGMMebFllKalqW0Hv1qIgqrh
         mv66HbYxc8TfvTeoewakHR0TpduDoQETOqyP0wCxiqYZNhdVJTKeraqBUIAn/DSyVAS7
         Fd6ZHCa/ONbXibvhjz7/U+qIEgP9IdQoElJR0TtnaiCZ+t7IBF7Z/oSaVqsy4Gh1aWan
         sC50KnuY/32hH7tDomVJHBAkWyEirpqA/aF7fK0ybgupYuLEVvHheduU1aIYn0wxvyi2
         JUzQ==
X-Gm-Message-State: AOAM531VVy8rEKiQj7J36AAlAaym/6Ue7SQRTzw3lMiVEP99j5WPAFKT
        427p66JnBNp1QMwHOXfkOfe8nnFIjFvYVw==
X-Google-Smtp-Source: ABdhPJysfPwPW0htuWs4aZ8s343mIVLGZpiW5G3I/U1ybbFmEYVymHcLgT80Zfb15dxXdAqkulFlJw==
X-Received: by 2002:ad4:54a3:: with SMTP id r3mr4640665qvy.26.1610576670441;
        Wed, 13 Jan 2021 14:24:30 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id k7sm1829834qtg.65.2021.01.13.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:29 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 10/20] rebuild_existing_bitmaps(): convert to new revindex
 API
Message-ID: <569acdca7f4a5aa25b625280266dfe40dc4fdefe.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another instance of looking at the revindex directly by instead
calling 'pack_pos_to_index()'. Unlike other patches, this caller only
cares about the index position of each object in the loop.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1fdf7ce20a..60fe20fb87 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1392,11 +1392,10 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < num_objects; ++i) {
 		struct object_id oid;
-		struct revindex_entry *entry;
 		struct object_entry *oe;
 
-		entry = &bitmap_git->pack->revindex[i];
-		nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
+		nth_packed_object_id(&oid, bitmap_git->pack,
+				     pack_pos_to_index(bitmap_git->pack, i));
 		oe = packlist_find(mapping, &oid);
 
 		if (oe)
-- 
2.30.0.138.g6d7191ea01

