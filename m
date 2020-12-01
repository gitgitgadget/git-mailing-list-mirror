Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A36CC71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E10221E2
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgLAW5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLAW5U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:57:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99388C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 14:56:40 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b12so2312978pjl.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Seyd3RQOAs9fc+6xtsP5RMazFA9kBqy1mobVUUvY8CU=;
        b=lelSPQXRhkenwVRWZuiu+Pw5RmUfKJFC6hzWhJatP10QoURTtjUHMHM74YKdsSy/gc
         ZFol37I4e/cbbW70piVX1m961s3OfPSoGPPke5vlb+yjpYPZTV17v57GM0ux1V7yoSVo
         ZFb2u9BTH4/W1aDfsFJcm60rTcj8laJLfl49DKoKQJtoJJYk/HWodMJamof8E03BXGci
         yKlDPPvrwbzlHwY1kTF9YIX3QeGpQKBEKtMh0S0nMcMHWhfhvH/6aYoo0mQdvtS9jC79
         4O8f5JtjkmdP9QfhJx6+4BCMzWM6tOT0zxYSsuzUm6JIt/oMqHqnXva4E2BDFNDGkZf0
         eItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Seyd3RQOAs9fc+6xtsP5RMazFA9kBqy1mobVUUvY8CU=;
        b=iBzpA51YlWxjZS7ovNfIPpuaHd3qMty/Suq+huOASfFgi9KagZXjeb00FCVi8emR++
         MWhLG6a/JuKsCx6g/qH5ed28OM2wt5fi1jswemW729NWeCGlYelhm0rDHeTs3bs3wzhs
         sYEdSHNIQV6gMPqibExgubuthbT0qp1PH+ftq1aUvm+v6J8895u1l+/2MLHLtoU0862S
         vSTFRwB3MWPCyhLsH3zlGav7fQbACtFnWZifAVjrIaCGpUIEXoV7AKayPhR8LLQZcHTl
         RQGZZO4QbOTAAdHYzOxqIJ0fs2CG/by0fXsufCeNPuXHueytHb0rvHfpDtEPj/eQnb5V
         qilQ==
X-Gm-Message-State: AOAM5312RfsB/9XAgEDPKfw5CCZYFN9DH4UkZr5oeDHZSkr4Y0tEt4CP
        v7MdbDbZXsxRGM8trYbX1NztcA==
X-Google-Smtp-Source: ABdhPJwaeJ4vTnYqXDWxDWrtBwb/M63MtduLfNLyIaBIraAleIlGvlbZ5y8PMIk5Ly8cz0Qm7g1XPQ==
X-Received: by 2002:a17:902:7d8e:b029:da:274:c75b with SMTP id a14-20020a1709027d8eb02900da0274c75bmr4991220plm.61.1606863400117;
        Tue, 01 Dec 2020 14:56:40 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z22sm768413pfn.153.2020.12.01.14.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:56:39 -0800 (PST)
Date:   Tue, 1 Dec 2020 17:56:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/23] ewah/ewah_bitmap.c: grow buffer past 1
Message-ID: <X8bKJUypb9WViUdt@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <36deaad366d66d10b96755dd6969bfe51123a2d4.1605123652.git.me@ttaylorr.com>
 <xmqqblfpqj4e.fsf@gitster.c.googlers.com>
 <X7vhrCbeFzxaEVvv@nand.local>
 <X7x0du3qoC4vuGtS@coredump.intra.peff.net>
 <X7x1PciN+bVDkJhr@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7x1PciN+bVDkJhr@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 09:51:41PM -0500, Jeff King wrote:
> On Mon, Nov 23, 2020 at 09:48:22PM -0500, Jeff King wrote:
>
> > > I think that we probably could just use ALLOC_GROW() as you suggest.
> > > Funny enough, reading through GitHub's chat logs, apparently this is
> > > something that Peff and I talked about. So, 16 probably came from
> > > alloc_nr(), but we probably stopped short of realizing that we could
> > > just use ALLOC_GROW as-is.
> >
> > That would probably be OK. It's a bit more aggressive, which could
> > matter if you have a large number of very small bitmaps. My original
> > goal of the "grow less aggressively" patch was to keep memory usage
> > down, knowing that I was going to be holding a lot of bitmaps in memory
> > at once. But even with micro-optimizations like this, it turned out to
> > be far too big in practice (and hence Stolee's work on top to reduce the
> > total number we hold at once).
>
> Oh, sorry, I was mixing this patch up with patches 6 and 7, which touch
> buffer_grow().  This is a totally separate spot, and this is a pure
> bug-fix.
>
> I think the main reason we didn't use ALLOC_GROW() here in the beginning
> is that the ewah code was originally designed to be a separate library
> (a port of the java ewah library), and didn't depend on Git code.
>
> These days we pull in xmalloc, etc, so we should be fine to use
> ALLOC_GROW().
>
> Likewise...
>
> > I think the real test would be measuring the peak heap of the series as
> > you posted it in v2, and this version replacing this patch (and the
> > "grow less aggressively" one) with ALLOC_GROW(). On something big, like
> > repacking all of the torvalds/linux or git/git fork networks.
> >
> > If there's no appreciable difference, then definitely I think it's worth
> > the simplicity of reusing ALLOC_GROW().
>
> All of this is nonsense (though it does apply to the question of using
> ALLOC_GROW() in bitmap_grow(), via patch 7).

You and I timed this a week or two ago, but I only just returned to this
topic today. Switching to ALLOC_GROW() doesn't affect the final memory
usage at all, so I changed patch 7 up to use that instead of more or
less open-coding alloc_nr().

> -Peff

Thanks,
Taylor
