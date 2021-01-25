Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A4C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106AC2255F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbhAYUWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbhAYUWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 15:22:02 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFAFC061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 12:21:21 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n7so2519303qkc.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 12:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZYnGFR0IH5g5CQeYaDxJQwxw7BAgIuhW4P7ctt+zrZQ=;
        b=T/bLO+kwf+0siEMl/p8kMFqsfE8Yr5l74V/1r/pgA88Zw5ZOPji5x1ZMtnBBpF3RFw
         uB33vuQbroirTiBlgkuHIZVkmDWfQHnbGUPRBmz5W6dEmLD4r6V0EinBkQa1GrbLN42h
         sd11+qy0Cu4xIgTnD4URwGDip0BaFwm+XrhOJ4HD/LoUK9WfWor/0zpBvQLSHquc/sSP
         3PDL/NT98p2GNJ1lJeabcgyRgatXhXIREZAD02OADf3IUvDRR3BToF4SQiUoLHYoN7UG
         buq/04vIhJWK8shlSW65sIQfVdAppTjK62wxFi/FWB1bZy+Xem4R6lNIpdNgC975O/iK
         4haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYnGFR0IH5g5CQeYaDxJQwxw7BAgIuhW4P7ctt+zrZQ=;
        b=cIVeHKDI4vMSOG8J8W0RfWPDH8bcZWQ85cmhlymhChaKesCNXAF3eFI+eoyedSgVl1
         PE7Tszaf6+bMqa/xWqTajfdlkj1sLqDBQR50ijrEfxp/vdxg57WYs7OHynVBe6NyaOBl
         KNUSerorB6bQsAlPLMZBfhI11xMKgV2PzIhhXT2mrwxGoZh9QnAttphqZT6jkGiV5s/i
         MyG+CiBzMcSKYCXnHPN8FbB5r+yaRY1erXGnjDIdPvmmf26x8buqzTd6qG2dULhnGE4o
         MUYtwc/Of5rrS6gt0Z/c9mfBeT3JRyiPy58SYopUYH9TQqVG2caPVu+3ZWTrl71sMJ0d
         CrAw==
X-Gm-Message-State: AOAM531S6gFETbnNO5j/dm+Kotef0mPXAMpw2mrYC5BtNafODEQ/n1aH
        eytCA+oXGci8SIpKlLRjDVHCWw==
X-Google-Smtp-Source: ABdhPJxGeFJBNKBh+v1sartbi+UAVhr5lENmZ8x4UA7hi1vKvbEBytI0QUpI/5BC5oarB4H+uNPYhA==
X-Received: by 2002:a05:620a:b07:: with SMTP id t7mr2568822qkg.287.1611606081208;
        Mon, 25 Jan 2021 12:21:21 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id a23sm4009191qth.9.2021.01.25.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:21:20 -0800 (PST)
Date:   Mon, 25 Jan 2021 15:21:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 4/8] builtin/pack-objects.c: respect
 'pack.writeReverseIndex'
Message-ID: <YA8oPcvS0n8pUmcB@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <68bde3ea972f5b3753d7e9063d0490c67c74709b.1610576805.git.me@ttaylorr.com>
 <YAtmb7wXQse76kJi@coredump.intra.peff.net>
 <YAto/ndOVfKSkizS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAto/ndOVfKSkizS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 07:08:30PM -0500, Jeff King wrote:
> On Fri, Jan 22, 2021 at 06:57:35PM -0500, Jeff King wrote:
>
> > > +	if (!strcmp(k, "pack.writereverseindex")) {
> > > +		if (git_config_bool(k, v))
> > > +			pack_idx_opts.flags |= WRITE_REV;
> > > +		else
> > > +			pack_idx_opts.flags &= ~WRITE_REV;
> > > +		return 0;
> > > +	}
> >
> > This turned out delightfully simple. And I guess this is the "why is
> > WRITE_REV" caller I asked about from patch 2. It is
> > finish_tmp_packfile() where the magic happens. That unconditionally
> > calls write_rev_file(), but it's a noop if WRITE_REV isn't specified.
> >
> > Makes sense.
>
> Oh, one subtlety here: this is in pack-objects itself, _not_ in
> git-repack. This has bit us before with options like
> repack.writebitmaps, which was originally pack.writebitmaps and
> introduced all sorts of awkwardness (because pack-objects serves many
> other purposes besides repacks).

I'd think that we'd want a single option to control whether or not
reverse indexes are written to disk. I briefly considered (and I believe
that you and I even discussed) having options to control this behavior
per command, but it got out of hand quickly.

And that might have been OK, but I don't think the complexity was even
warranted, because really on-disk reverse indexes are an all-or-nothing
thing. That is: either you want to have revindexes accompanying .packs,
or you don't. IOW, it doesn't matter whether those packs were pushed to
us, or generated during repack, or from another pack-objects or what
have you.

Thanks,
Taylor
