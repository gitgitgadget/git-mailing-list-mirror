Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6DC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DFF235FA
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbhANCJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbhAMWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:24:51 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F0C0617A3
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:51 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so20460qtw.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e4IZRUNxseGW/0LfUuiowaMAWmWkA9L1rs66EqMcUyo=;
        b=QzeRpO2ERaUpBoF5imetwhZerLFbXmNVyOjhO7qVhbLEYE1lQpk5vSMBN4t+e4AYYO
         SA3GKGwtUtA2jqSYLQDyCQ5uxGgXcja6qYQn+jEJh5NqLTsKIsw6d/TEH/lQJKi0mfOw
         RQOEUzzcUWzfkPsy+av6amFb51skaL9Q+wJAJBUzV+9Zn/JlaKMAdqHILnoggG8W9usu
         Hqifx1L4xEsn9kFqwx22u4RlINVzOwYKtLaBW4C5EA2UeTxx85yB+PN2e/ifChUBMlAN
         dZyqncdTupEq6e73KswTiBPdX1sqmFOZFwpLPi6kvkKu/XLFlOk04gmf2aw+l8hvufBs
         lqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4IZRUNxseGW/0LfUuiowaMAWmWkA9L1rs66EqMcUyo=;
        b=AhmcMwFQRhfWo1sNwdHVHmYoxGXa28RC6XwBQ2hV2Qp33g1O6RlUbQJx3kCfg3HgDd
         FhIwpNzAjvdGd7/rv+KO0Bvx1L3Tw3/DSfPiMp36HwEYbUEE3Eq6W9ZcQrtYg9fAXms0
         u3qglf/1pZ07aoRQtHpr50gMphP9dYurQJlYWWx703g6997nIxtvBmvSEb5nS7oV+V+B
         h9sSsrEPC4uPepAPgIs4haFAecAQLN2cPPYphyXMhGdTv8Y5gkkMGiFFGPB9syqaEI85
         +mz2euUrxzNfayV8Fb0cQX62NaMP2BwfB+E0+f2VvQDMyul+AhPZ9JRfY0t0BNMOLRRl
         46sA==
X-Gm-Message-State: AOAM532VHerIa8G9WLECYRe+Q392QXuaKV/jnWr2U+IHjpHC3DUgkTjt
        Hzber2s3KiNpDk3YIMu7xks1xK0tOKFnzw==
X-Google-Smtp-Source: ABdhPJzo/k38DszAJT79BnuripEfmotfJOd9ShhrtCKyPxBPVCdrMWKcrKOrRrTlOjssFLFDWCziPg==
X-Received: by 2002:aed:2123:: with SMTP id 32mr4509632qtc.325.1610576630498;
        Wed, 13 Jan 2021 14:23:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id i3sm1815248qtd.95.2021.01.13.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:49 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 05/20] check_object(): convert to new revindex API
Message-ID: <8e93ca38865a9fb9ff9bb264c6db9b6dc14e3029.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace direct accesses to the revindex with calls to
'offset_to_pack_pos()' and 'pack_pos_to_index()'.

Since this caller already had some error checking (it can jump to the
'give_up' label if it encounters an error), we can easily check whether
or not the provided offset points to an object in the given pack. This
error checking existed prior to this patch, too, since the caller checks
whether the return value from 'find_pack_revindex()' was NULL or not.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 77ce5583a2..5b0c4489e2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1817,11 +1817,11 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 				goto give_up;
 			}
 			if (reuse_delta && !entry->preferred_base) {
-				struct revindex_entry *revidx;
-				revidx = find_pack_revindex(p, ofs);
-				if (!revidx)
+				uint32_t pos;
+				if (offset_to_pack_pos(p, ofs, &pos) < 0)
 					goto give_up;
-				if (!nth_packed_object_id(&base_ref, p, revidx->nr))
+				if (!nth_packed_object_id(&base_ref, p,
+							  pack_pos_to_index(p, pos)))
 					have_base = 1;
 			}
 			entry->in_pack_header_size = used + used_0;
-- 
2.30.0.138.g6d7191ea01

