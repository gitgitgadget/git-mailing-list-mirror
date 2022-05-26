Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2874C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbiEZAM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiEZAMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:12:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A06391
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:12:21 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a15so110229ilq.12
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=89OiuFQnicJwoau4JoQIbZKggYWCNo5Yfy/ttsfgYIY=;
        b=FNnbTIlM5en4q4iTpeYEd6Yf5lThB0FER9V6bAZKtfNlkYSvMgWFFSFRkGb9RVTEPb
         0CHoS3r2YYEUYJ9UqXmJDszHE2gj5PHmiFhSI0Ilp4I3ZUB70kuSxLwTFNaHac15QMl9
         ElBlGjc1Zg7VBFuAwCjZJkXaMJrUfyeXlLobisrNDJpXEWPdJAqcwcajDj6oX8LVvqr7
         eUsV4Jf0ATtdgCaeQ0vZPOsjwxuDHw+wU1sdVNwqAc/M1Wk5MEoa8h4Hs8t1eNxylVik
         UPU5asegSQsIKnQs7Lffo21TIdaB2XNfvB8g3/arCwghV7U4BRQoXe8RDCGGs4FL+0mK
         1VQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=89OiuFQnicJwoau4JoQIbZKggYWCNo5Yfy/ttsfgYIY=;
        b=XVJGxL+ErcYOtgaZJ41ACBgzwoXwCgY1/gWFE/oVBt4OqfbPvpJlNAN+asUS3KjWFC
         /4uqFLwbAOC3QKRKK9IzJePUJ2e82etprW6mDFefurcZwPCR3BUerwuIyNezl0UUBh6K
         bctRNQPfjVSCI/2Pd1C6Sx2J3DYTifNSx8sXPjUWY+wvhytkeImcW/fHa9GMyQMlza2+
         dIKGesZdp36G6Yt6y/NRwb5wVWHDMQTTYBH2SjUro5kZSn2k7ofT/o0RnTIFfvGplQRM
         Wf9oDiFZnVE+ltP1IQ9jVkIkaL2nTYYMa0VxpcJRQJiksRxNfkGrUC5pKLKwXR7L0moP
         FIEg==
X-Gm-Message-State: AOAM530ZLAQtH440D2RqlA9gdxoMnyKHiwsH4Gye5p0W3rRjN1xYfnh5
        XH/lDyHaEgHx50kJjDecdBsMd8kjYJ81pQ==
X-Google-Smtp-Source: ABdhPJynAnBjcEdGlUT+naHNFjWkfIoFYPRUFa1J/LBBNSCA2jqqbh6lkBx3vJsIKUWA1WOzssBQBg==
X-Received: by 2002:a92:d5cf:0:b0:2d1:d9b0:d5b1 with SMTP id d15-20020a92d5cf000000b002d1d9b0d5b1mr3324584ilq.252.1653523940887;
        Wed, 25 May 2022 17:12:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a19-20020a924453000000b002d19523981csm107850ilm.16.2022.05.25.17.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:12:20 -0700 (PDT)
Date:   Wed, 25 May 2022 20:12:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com, 'Jonathan Nieder' <jrnieder@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: adding new 32-bit on-disk (unsigned) timestamp formats (was:
 [PATCH v5 02/17] pack-mtimes: support reading .mtimes files)
Message-ID: <Yo7F4tj8aGMvwM7/@nand.local>
References: <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
 <Yo1bUbys+Fz7g+6h@nand.local>
 <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
 <Yo1zW7ntTuNakpOD@nand.local>
 <220525.86o7zmt0l0.gmgdl@evledraar.gmail.com>
 <32db3720-e9c8-e192-6278-c55855ce1d3e@github.com>
 <Yo6b+8sixGAqMm/x@nand.local>
 <220526.86sfox6tvp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220526.86sfox6tvp.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 02:02:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> > If we really are trying to micro-optimize storage space here I'm willing
> >> > to bet that this is still a bad/premature optimization. There's much
> >> > better ways to store this sort of data in a compact way if that's the
> >> > concern. E.g. you'd store a 64 bit "base" timestamp in the header for
> >> > the first entry, and have smaller (signed) "delta" timestamps storing
> >> > offsets from that "base" timestamp.
> >>
> >> This is a good idea for a v2 format when that is necessary.
> >
> > I agree here.
> >
> > I'm not opposed to such a change (or even being the one to work on it!),
> > but I would encourage us to pursue that change outside of this series,
> > since it can easily be done on top.
> >
> > Of course, if we ever did decide to implement 64-bit mtimes, we would
> > have to maintain support for reading both the 32-bit and 64-bit values.
> > But I think the code is well-equipped to do that, and it could be done
> > on top without significant additional complexity.
>
> Do you mean "on top" in the sense that we'd expect that before the next
> release, so that we wouldn't need to deal with bumping the format, and
> have some phase-out period for the older version etc.
>
> Or that we would need to treat what's landing here as something we'll
> need to support going forward?

My plan is to treat what will hopefully land here as something we're
going to support.

I meant "on top" in the sense that the format implemented here does not
restrict us against making changes (like adding support for wider
records) in the future. IOW, I did not mean to suggest that we should
expect more patches from me in this cycle to deprecate parts of the v1
format.

In other words (again ;-)), I would like to see us ship this format with
the existing 32-bit records.

> I think if a format change is worthwhile doing at all that it's worth
> just doing it now if it's going to be the latter of those, as changing
> file formats before they're in the wild is easy, but after that it's at
> best a bit tedious. E.g. we'll need testing to see how we deal with
> mixed new/old format files etc. etc.

I can understand where you're coming from, though as I noted earlier in
the thread, I don't think changing the format in the manner you suggest
would be that difficult in practice.

But in the meantime, the existing format is useful and works, and I
don't think we should go back to the drawing board for something that we
can do later if we decide to.

Thanks,
Taylor
