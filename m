Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66B8C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E62610C9
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbhIHCnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhIHCnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:43:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:42:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so390797wmq.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cp6P1C3370/qEzONTCo+2tfc2IVRi38B5WDEd8+wAVM=;
        b=1FbbVmAV6EOiYar/a/h2kG3E447H03AcfArBItnaCdKtZAEXnhhPCnQXgWXuIojdiR
         iEErVsRPGZCErNAQx7iM8d8zplXwNAdQ1U1mnPUhFEvVeRzo0y7M+WJAQBUF6AOwqnTQ
         8/xeQND3rxc0851JA8Lzt618sk1AoMO6OKvgOkZ3ZsoS2xwE6Y2zaKXoMT1jPcEkRXCo
         j/doqB+uYHte+pzapYfDGdL4jJt7fVhdFGHEt9pb7o9sUz2PvXsYrM6ZsVYSoTGfAGf/
         UhcFAfMydOGSG63Co3xrzDMkeWQqppWFRglHTmhRqknlCXUjTyHoUXT8GzcXtqPDJyhc
         zGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cp6P1C3370/qEzONTCo+2tfc2IVRi38B5WDEd8+wAVM=;
        b=ic1cABAtioJ3jKKTDBZfjgsPQ/6xGQbg2SIQMKxqYIx5dB3lljOa3g2CpJ4TiS4N5d
         FFh/gVb7PTa1BuMNwvg9y6F6AuIUpcmynWcZ5qRqNwTq//0o585MtWbC0tnGVF41q7P4
         swoT2KrRjCO4AnmiJbh3Pr3WO3tQ8j79TEXX+9KaaZGQ+N25M3EStRinMYdDDgLfD5ow
         GfYMvIaNZ0MXEKW08cZgwwJ6NySrGhzQI7re7Muj5dbvTPQ1j+AzAMjvJCn+9GJmBRDd
         5sKosDii2rov2LSr4StpNZ4oIZU+bg3o4DHVpot4feVaojhWzj2N5OKOnqUuYniHF44I
         vlCw==
X-Gm-Message-State: AOAM533WhI/m85ivnr/MpHKN4yiHYB05GkjmDvFKX7Z/Qm7dtQSN/I2x
        6oxXUxfPwkOJwu03vHqrhg0QZQ==
X-Google-Smtp-Source: ABdhPJyjObZrmgpltrgq66jUfLtBLJ8hNuvoH7qJX+sFzHdz145zm/KF1/BS81tEivpkQTQeQyeErw==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr1102005wmj.82.1631068934323;
        Tue, 07 Sep 2021 19:42:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j18sm665401wrd.56.2021.09.07.19.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:42:13 -0700 (PDT)
Date:   Tue, 7 Sep 2021 22:42:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
Message-ID: <YTgjA/mwH7wY4oyZ@nand.local>
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
 <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
 <CAPUEspgh0kbm-ro13Xt2-g-hPoBMK2-34iP2GvK_gaa2bGC+GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEspgh0kbm-ro13Xt2-g-hPoBMK2-34iP2GvK_gaa2bGC+GQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 06:35:10PM -0700, Carlo Arenas wrote:
> On Tue, Sep 7, 2021 at 6:10 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > +       if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
> > +               return NULL;
>
> I see this expression matches exactly the logic from 8ef50d9958 which
> is why I presume
> you used it, but the simpler (and logically equivalent[1]) :
>
>   if !((flags & WRITE_REV) || (flags & WRITE_REV_VERIFY))

Even simpler would be:

    if (!(flags & (WRITE_REV | WRITE_REV_VERIFY)))

although with optimization flags other than -O0, it seems that each of
these three produce the same result [1], so I don't think that it
matters much either way ;-).

Thanks,
Taylor

[1]: https://godbolt.org/z/fxxhzEz79
