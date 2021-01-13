Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCBC4361A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6734F235FA
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbhANCJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAMWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:24:51 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63147C0617A2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:47 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 2so2287571qtt.10
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bm5o9vq3zI1B3K20xzsSXf0x0nbi7y6y2CnAt9jUucg=;
        b=a9Bm5s679fMBO50VlMdbJPAD6Eh/8HPkDHXHgV8jqUiXuDKvh6MMNw8GjFiFIVejCT
         Y9LhlvzYPRQxH2C0NzCVNIAGSGTf7KQwF6km29uy0O2ijpFoPeAbU3nbZ4ZhNfZXbJYF
         IipaPqQOpbFbiRQYKcUiGXAZi+PhaoaegPlbEtpkIS0ghxeSJ704ZX+AGQLOcNEG1ggb
         XwSpLsTOhXnaFCOwQkRcm5n3WALM/wMmfnp9b2uWiFCIxMHDE9+liuXq0F9LIIUD5kYc
         yf4BAracOWh6gBNE5qNYbb+4qTN3IoADmKVCDe4jkhCp1zuzHF0gyoNBkSVj/rtJywPS
         elBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bm5o9vq3zI1B3K20xzsSXf0x0nbi7y6y2CnAt9jUucg=;
        b=Rv2dnvXVizgQ3Jx86latKdpSEKgssSnPM8nrVdpzMVqX0mI90uXNlFggB8vO6JMvFs
         EmMWwFRzazP2UmmVrs47DEDbO8pGgm3Dv61SXcLlGWru+un6MDK8Vlow4ViA+Wt8Wdo9
         dgD+/+Z9ahE02EWfxThv2/NDso+QpLWqpFd6w2rvCybii4s+mG/QyvzK+NLQ4QeSsWFw
         GazW12y1/LQ+UmZwBsLGE01HvjzYin4fh0cu8uVEaX5HbgwAtmRIhbBhWPd9Sb0KwchZ
         o2RVHDJWHaiSlg5PueGKM5oXpbHppCTmYdhPQP+rYQ/IoJ1a1GZF7e1Ccz7BCMgoMhAO
         /TSg==
X-Gm-Message-State: AOAM531kBxW7Fb8FYfj0UxJqzjoeDcnXfgNLDSKaxHFi6QEf8/NrTKTg
        k4gkBVTth8RK6YMV0NYeaN5wQyj4Evf9yg==
X-Google-Smtp-Source: ABdhPJzcAC8LFQKU0nZtImt3bZ8px4YzMKoiVG0INVpzpG9ZkjCgqIGBc2xWi9q6BXgUFPIiahIQ/Q==
X-Received: by 2002:ac8:5a43:: with SMTP id o3mr4452233qta.222.1610576626358;
        Wed, 13 Jan 2021 14:23:46 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id q73sm1939483qke.16.2021.01.13.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:45 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 04/20] write_reused_pack_verbatim(): convert to new
 revindex API
Message-ID: <dd7133fdb76761b2758ff6986421e4a7755c54a9.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a direct access to the revindex array with
'pack_pos_to_offset()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8e40b19ee8..77ce5583a2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -952,7 +952,7 @@ static size_t write_reused_pack_verbatim(struct hashfile *out,
 		off_t to_write;
 
 		written = (pos * BITS_IN_EWORD);
-		to_write = reuse_packfile->revindex[written].offset
+		to_write = pack_pos_to_offset(reuse_packfile, written)
 			- sizeof(struct pack_header);
 
 		/* We're recording one chunk, not one object. */
-- 
2.30.0.138.g6d7191ea01

