Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C476C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23AB23A6A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbhAHSRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:17:40 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB9C0612FE
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:16:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q1so11154199ilt.6
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xW1uGJUcALzTWC2RA9kvuibHnE8HFT+26c0A+Pv9EQ=;
        b=Q+dToZtzKK+KPLZy8e6ljxFlQvdcrwAkmlgtaE1+4+H/HpRd58rMv8aq85njluywvN
         OnqIDAASsKxDbGmKNAzGI1F2LJ+jq5SnkXOiUoZdXGpLCFIEyt1eKKRxP93am5U8mOzN
         J+pZOk1e2KGqaNivAz58dMWpvx7khYfLG6sfTZ6Xldr4+F4S3L+PBLZERrrg7hgeFDlR
         AfRPxGOdHCxeeAX3YGXIrZ56XgaOurWyYnu9cVk7Ic10/28O9VL42efJjlWksO4kx8+D
         o3Lt8OhvGZly6WaNuG4TlRKAVHX8SeWL42jV1iO8nvYClvzCG5ib+bBh2nT0hRhp9dkA
         Z0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xW1uGJUcALzTWC2RA9kvuibHnE8HFT+26c0A+Pv9EQ=;
        b=iVftVFLhNx9MwJL6uVdTjhcKhL5vrTjmlnrxo662RFidM2NZGGpYbeZOfLGe1FvDs2
         RUYYfGboD1hHQRbPrgefW8sz2O6FEbaa4jbysJjp/8ldoqB5MRaMYJ3OfXd5UD0WQCTu
         HsKSdq7eHFfIILa7/bk4bMeDN41UFBds/s7iJnewLDTV1rylh3g2k8aRNeriv4//Mwvw
         DAe05Rac2M9fA+ieIzZ/QpADcXs5GRQQ3Di0ZhpQwd7jNwOH2XfaCqEGKGX946MwMEDt
         BseHi8f2peSr8BzqVbNi7nDTZ7yNoHcvtXtfMs1doI/fSRqKXFqVK55j83x8cUGGGoNF
         NhjQ==
X-Gm-Message-State: AOAM531d2Q11Cm3OhEQWj+QXEYnF1JOdUgXCTyoFu06mHni1VuA+/Frh
        DnlDXRJkGIXS6YYQ+ns5x4/hLGAVmY0tvA==
X-Google-Smtp-Source: ABdhPJxJmQs95qkOoN/67WhkVIuAHSi2JZpY+vH7uK12DtjQ6+r4CHviUD4JngvarAShsokOkDI/Eg==
X-Received: by 2002:a92:d8cc:: with SMTP id l12mr4851141ilo.225.1610129819161;
        Fri, 08 Jan 2021 10:16:59 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id s12sm7592881ilp.66.2021.01.08.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:16:58 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:16:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 04/20] write_reused_pack_verbatim(): convert to new revindex
 API
Message-ID: <14b35d01a062f2dfdd710718b659064042dc21d6.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
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
index ea7df9270f..4341bc27b4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -948,7 +948,7 @@ static size_t write_reused_pack_verbatim(struct hashfile *out,
 		off_t to_write;
 
 		written = (pos * BITS_IN_EWORD);
-		to_write = reuse_packfile->revindex[written].offset
+		to_write = pack_pos_to_offset(reuse_packfile, written)
 			- sizeof(struct pack_header);
 
 		/* We're recording one chunk, not one object. */
-- 
2.30.0.138.g6d7191ea01

