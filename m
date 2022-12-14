Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE3C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiLNUYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiLNUXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:23:53 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954952D1CA
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:11:59 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id z9so7117723ilu.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zAb++WNi36Yl6LMWnwRy2D3Saa+vm5YFu/7GVV2bSB4=;
        b=kcwQULyY1njxWVBDP7hhkRWMAQ2gsZKitTVZaeXA6q+nIeo1vs2ICjz2cleSgC2OCf
         2kGE7ziE40HBugkh9bIKm21ejkf6z2JZUY0IZszE15AighJOyK37iO51myu1yluQbuLy
         k0AitAxu293Kl9KbSOknbQGazyrk4J56HyHjigD8VR4aY9tnNwpvtwsKltPUUPprqBHY
         9zmZjP2YI5kxDppHFEiDTcjy7yR10Ljnryt6O8KSRRoJtQ68H0gdjs1XoaDfPq+LxmLo
         HS5JvEdom64KHjaOO7afuVN8NdvAllHsBPDiYZ1OqQYpLD6l7aeymChQNuJzoAozMpSM
         NGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAb++WNi36Yl6LMWnwRy2D3Saa+vm5YFu/7GVV2bSB4=;
        b=yhrg6ml9JrEzlUvbSnFzlXrXL/arhzIj3JXrZ4cBsQC+sYjoMJGcvjKFlVXyInQt5c
         05WJ85wHx+1KivqUm8chesZUgxsG5c96tq//ILDwkYRulc/diVI0KeMC4smIQAgD8k3o
         Ud4GY4Yr+pBn90cgVEUnO6Fgq/AUSqx9ypmF7vUe9mUkpElI2a6D2rGdtQbUO8v6Sv+R
         GQNMHc7WUflQwVm76KKP0HAdXgl4ir8wZzw+iYPDYAKv6g7B+ZKQ/T7dyRTCyRYNQ/v4
         Dwt9humCpc39hL5d+XCPuatyTbdawIEeI6aBDKY3t3xFg8cBjzF6SLnaKgrLMdwId9W/
         ZsXw==
X-Gm-Message-State: ANoB5pn6CCN13idQ0TsjlIA0Z4e1pQfoF8rAJwmZ1hQ8AIzzhjZmx62B
        IRa+c5mQM8MQafzUij6E8bIgaw==
X-Google-Smtp-Source: AA0mqf41JpaiEmTZyOZGo0lNyQeNduu7QIFvgAHjASpl90FRnQGZY0m81wgzmT6aFc2axYIPBSSNJw==
X-Received: by 2002:a92:b12:0:b0:304:ac6d:c2bd with SMTP id b18-20020a920b12000000b00304ac6dc2bdmr9570632ilf.11.1671048718918;
        Wed, 14 Dec 2022 12:11:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s2-20020a02cf22000000b00356738a2aa2sm2017466jar.55.2022.12.14.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:11:58 -0800 (PST)
Date:   Wed, 14 Dec 2022 15:11:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <Y5ouDcvjCaRlCGJf@nand.local>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <Y5GLWe4Kdaz+T5P8@coredump.intra.peff.net>
 <221208.86o7se6ou1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221208.86o7se6ou1.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 01:35:04PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> The "cruft pack" facility does many different things, and my
> >> understanding of it is that GitHub's not using it only as an end-run
> >> around potential corruption issues, but that some not yet in tree
> >> patches on top of it allow more aggressive "gc" without the fear of
> >> corruption.
> >
> > I don't think cruft packs themselves help against corruption that much.
> > For many years, GitHub used "repack -k" to just never expire objects.
> > What cruft packs help with is:
> >
> >   1. They keep cruft objects out of the main pack, which reduces the
> >      costs of lookups and bitmaps for the main pack.

Peff isn't wrong here, but there is a big caveat which is that this is
only true when using a single pack bitmap. Single pack bitmaps are
guaranteed to have reachability closure over their objects, but writing
a MIDX bitmap after generating the MIDX does not afford us the same
guarantees.

So if you have a cruft pack which contains some unreachable object X,
which is made reachable by some other object that *is* reachable from
some reference, *and that* object is included in one of the MIDX's
packs, then we won't have reachability closure unless we also bitmap the
cruft pack, too.

So even though it helps a lot with bitmapping in the single-pack case,
in practice it doesn't make a significant difference with multi-pack
bitmaps.

> >   2. When you _do_ choose to expire, you can do so without worrying
> >      about accidentally exploding all of those old objects into loose
> >      ones (which is not wrong from a correctness point of view, but can
> >      have some amazingly bad performance characteristics).
> >
> > I think the bits you're thinking of on top are in v2.39. The "repack
> > --expire-to" option lets you write objects that _would_ be deleted into
> > a cruft pack, which can serve as a backup (but managing that is out of
> > scope for repack itself, so you have to roll your own strategy there).
>
> Yes, that's what I was referring to.

Yes, we use the `--expire-to` option when doing a pruning GC to move the
expired objects out of the repo to some "../backup.git" location. The
out-of-tree tools that Ævar is speculating is basically running
`cat-file --batch` in the backup repo, feeding it the list of missing
objects, and then writing those objects (back) into the GC'd repository.

> I think I had feedback on that series saying that if held correctly this
> would also nicely solve that long-time race. Maybe I'm just
> misremembering, but I (mis?)recalled that Taylor indicated that it was
> being used like that at GitHub.

It (the above) doesn't solve the race, but it does make it easier to
recover from a corrupt repository when we lose that race.

Thanks,
Taylor
