Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2548CC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBCA22CBE
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbhALQfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbhALQfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:35:03 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A43C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:34:23 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so1956879qtn.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xMO4davXLsvNtTSSk8dDtxfM/3J6/PpQ4K/r6OOOs4U=;
        b=ujYTZ+UQYI3oNnS1JV2x7EELtn8MsthI9tZ3bWa2zRcnYTxTXQFoPsVDBaRVmm7NWm
         G/2l/fEQCoaVwLjDJmp0wsd773S/mThfJp80ivKKS+6s+L/VopE7ZcDPkrcu386dzS3W
         BaUxjN8tFc8vly7pQhG5xpCyN8jy2gHCb0PvFr8i/CAfmkUS1kzDfox0pRh5Do2DDWx7
         hhfHWXlyeipzbq0nLibyD5gswMB42K+d0N+k1F+ioJZbCVVFCwgYjcXnC3R9IATBUH+I
         tl03tFNsY03LsQMCF0A4rIPrRTSaZ5lfGyIKasn8G1aocujIpH4zbTyoSjm0uY2/t2SJ
         3Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xMO4davXLsvNtTSSk8dDtxfM/3J6/PpQ4K/r6OOOs4U=;
        b=sMxKoJ9e6dNKf9S6tuhKcUFEePd/69PFFCQED+wDRJxufpulV+PJejfIW4AmqWCSbU
         7xszx3gHxrE5JvG0WElTixj/kypykMeR0OGu4l2YpV2sqB9IkSoxHwJ8g9Ej5lBKeG4W
         mzCWVuMJIti8rhA0yL7o1yrxKsYChZMVPP/+7EgWBoG02WIF+T2fYQz9gg9nBnFi57Hx
         KCqAvh2DrGGzWCpqPW4oLCzhNoChmZiKr/PNtlNZx1W7HAMzDZq64CRL068vhenz+n98
         NGCkCcG7RlJR3aPtVqFT3cMAoLuercOg/Cu1RXyINZ7MmPeaCiEYULubE5r68WbvgoHY
         G32g==
X-Gm-Message-State: AOAM5303US9ZJD8VBH4zFU0DFpLrs/KCDWuA5KB2bPillPlr5k/jM07z
        Koj2zeoZ8pMjvXy1oSizSydjLA==
X-Google-Smtp-Source: ABdhPJw1kMvyf+PwIsJrG56eXZrrkrCpDARY+ksjMBtJglX+7vJ7o7zIe+ZFSvlE9MFt4rTH2xhPbA==
X-Received: by 2002:ac8:4705:: with SMTP id f5mr5402735qtp.37.1610469262667;
        Tue, 12 Jan 2021 08:34:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id x25sm1523267qkx.88.2021.01.12.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:34:22 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:34:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 03/20] write_reused_pack_one(): convert to new revindex
 API
Message-ID: <X/3Pgn/HWVkncbgi@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <81ab11e18c0b00030019f9f521216f3469fdd744.1610129796.git.me@ttaylorr.com>
 <X/1ivewkRCD5BpcZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1ivewkRCD5BpcZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:50:05AM -0500, Jeff King wrote:
> > @@ -887,11 +887,15 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
> >
> >  		/* Convert to REF_DELTA if we must... */
> >  		if (!allow_ofs_delta) {
> > -			int base_pos = find_revindex_position(reuse_packfile, base_offset);
> > +			uint32_t base_pos;
> >  			struct object_id base_oid;
> >
> > +			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
> > +				die(_("expected object at offset %"PRIuMAX),
> > +				    (uintmax_t)base_offset);
>
> This error does mention the offset, which is good. But not the pack name
> (nor the object name, but we don't have it!).

Indeed we don't have the object name, but the pack is reuse_packfile
(which is statistically initialized), so we could do something like:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 10a16ced1e..8e40b19ee8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -893,8 +893,10 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 			struct object_id base_oid;

 			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
-				die(_("expected object at offset %"PRIuMAX),
-				    (uintmax_t)base_offset);
+				die(_("expected object at offset %"PRIuMAX" "
+				      "in pack %s"),
+				    (uintmax_t)base_offset,
+				    reuse_packfile->pack_name);

 			nth_packed_object_id(&base_oid, reuse_packfile,
 					     pack_pos_to_index(reuse_packfile, base_pos));

Which I think would be clearer.

> -Peff

Thanks,
Taylor
