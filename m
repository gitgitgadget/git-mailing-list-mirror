Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A8C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BDF61166
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhINX6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhINX6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:58:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32DC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 16:57:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i21so2171346ejd.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LR0t4cVqrWZGoVK5cAEo9vBTQiGSv7cyTE8XnyyeUuE=;
        b=azL3tIRD2Z9lIbLpdRmfwg/BBzIQ/V9/XZJfjukjfgBYOhf9kbHjBK9EewLmWlWDmG
         mx51cz47gQag2Hyd9Ow6/rIvIHS5DB8vLpbsXxfrWtrfPMK2RDKew6jNzGUipu2D4X7R
         FceR+IXIkIuEfG0PfeHtleSIRGKqsjjjvrWVaSN2/E7UZBkiLudVSGuKbHgKEe8eP8Np
         kCvlr8GUEjgFkuQXQdAHjAFlhGezdZrgOs1HXt0X4B7BUvA0fmIK3cab8wyIZtoUwbq9
         r+JhxU47iTdEAO4kAP+0z0MBpjnoxcnmIuiZcyBQAEjI8kydk1l1T65sTVDrzFoDceQm
         3/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LR0t4cVqrWZGoVK5cAEo9vBTQiGSv7cyTE8XnyyeUuE=;
        b=30NxUeIpmfYPwQdCONvChH+aHqnZMO5oSWzE3uzKqj+ci860O6M91MFnJ198V/sB7V
         6PbSjZeM7FXz6WK42dH5RVokCi1Dt99EUpxmz4gjtPCIIarV/bjgW1OxnGn3SWlx+07F
         9mgPNIO5KZqOCVz5x9Kty9YT6PVWwXWabdFRE+2qOR8ld9dGhftpElVHC9p3tu2G6q9d
         6v24UppEdNn0mIeZ4M4DtvWICKYJCJlJFGkbvk4x+ExDAgghDPAlznbtYz45fkWEjSHI
         xszvP74bM5p3Tgn6R7UAJ76t9Gmpb8Dm+mIucGQo2Ns/FGSZAASLIfLlyGe/yuZCkkAo
         36Dw==
X-Gm-Message-State: AOAM530aM81qnsaOUJ2MU/JiAV1Tnx3jA0rbryQrybfLOlP7SGMSBdxF
        HPPVcgeDIhc1pKa29TKyGhCdYNRO2zQ=
X-Google-Smtp-Source: ABdhPJwfQDBu8DQ/Zxyd7sbznT5VUMrtYuTOUKdNUFbr0zuloGM/d+u/NWaAs8Y8nSr8B6CHXN2YXQ==
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr21435720eji.177.1631663849184;
        Tue, 14 Sep 2021 16:57:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm5459164ejo.60.2021.09.14.16.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:57:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Date:   Wed, 15 Sep 2021 01:56:00 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com> <87sfyb8ihg.fsf@evledraar.gmail.com>
 <YTzejKyYvqZu4v16@nand.local> <YUDwB0W6IpWWcU81@coredump.intra.peff.net>
 <YUExaCwMwjfd5h7S@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUExaCwMwjfd5h7S@nand.local>
Message-ID: <87a6keoglz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Taylor Blau wrote:

> On Tue, Sep 14, 2021 at 02:55:03PM -0400, Jeff King wrote:
>> On Sat, Sep 11, 2021 at 12:51:24PM -0400, Taylor Blau wrote:
>>
>> > > >> +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
>> > > >> +		oid_to_hex(oid));
>> > > >
>> > > > Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
>> > > > "+OID\n"? Lends itself more naturally to extension, use with the likes
>> > > > of string_list_split() etc.
>> > >
>> > > Actually, even better a format like:
>> > >
>> > >     "OID[\t+]\n"
>> > >
>> > > Or
>> > >
>> > >     "OID[\tpreferred=1]\n"
>> >
>> > Sure, but I admit that I'm a little torn on this suggestion. I don't
>> > want to be naive and say that we're never going to change this format
>> > and paint ourselves into a corner.
>> >
>> > On the other hand, changing it does seem extremely unlikely to me, and
>> > this tab-delimited thing feels like overkill compared to how simple the
>> > '+' format is.
>> >
>> > So, I don't know. It's certainly easy enough to change now before we
>> > lock it in, so I guess we should.
>>
>> I'm not sure I really see the point of making this infinitely
>> extensible. This is mostly an internal interface between two Git
>> programs. Sure, it's exposed to the user in the sense that they can use
>> --refs-snapshot themselves. But if some writer wants to add a "foo"
>> flag, do they really want to be able to do it in a way that they're
>> _syntactically_ compatible with the older versions of Git, yet have no
>> clue if their option was actually recognized and accepted?
>
> I like this perspective, and tend to agree.
>
> (I'm basically repeating what you're saying but) it seems to me that
> trying to make the interface of `--refs-snapshot` compatible across
> versions of Git is stretching what we consider to be our compatibility
> guarantee given that:
>
>   - the interface is basically expected to be private between `repack`
>     and `multi-pack-index`, and
>
>   - an infinitely-extensible version of `--refs-snapshot` would still
>     have no way to tell the caller whether or not those new flags were
>     accepted
>
> So I tend to agree the existing format works fine and we shouldn't spend
> a ton of time trying to over-engineer a solution.
>
> (FWIW, the `+` vs `-` thing is intentional; `--stdin-packs` uses `-` to
> _exclude_ packs, but `+` here means "this one is special" not "exclude
> this ref").

The suggestion I had offhand was just meant as an offhand "interesting,
maybe easier like...", i.e. if you found it easier to split on \t, or
check the hash size in the loop or whatever.

I agree that this doesn't matter and should just be left to whatever
you've got a taste for, thanks. This thread became more of a digression
than I thought...
