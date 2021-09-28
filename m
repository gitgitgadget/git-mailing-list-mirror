Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967EC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 19:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52E6610FC
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbhI1TnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbhI1TnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 15:43:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D5C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 12:41:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g7so27692723edv.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yhEvu2B/okergTCSxyL8f8Vbvh4ZfhDbZZ+nIYgxZAk=;
        b=gn1OW4H38bh93NKpDrqG2GhA1MTESMLtyyp4Bc1D7QkoMB9uR9hz7sOTbBHmpCRS6H
         hKEpiOZ6iG3VdHP6El1jDEAstJaTPVWKVOg/TtSzYbd32FvMRwjviYWwSXJ1GZqQYkFb
         N3KzFgrLAKeH6p/0VpFYzfZ7Yl11LrI7w3rOP8SEBnDPmA0Q0E0kAETgo0K5m9DrraPC
         r8csJxevAOIXcLS3F6mwvF8GFl77Qfdhht7izsimBo9w7/N8i72b7wlg28W+oeJu2jwN
         IJRYBFic774YgqoSs23vaDvc8e9gbcsgi6Qom3/fWj+bv9FqjyT/GunYShhGN7wSchsm
         DfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yhEvu2B/okergTCSxyL8f8Vbvh4ZfhDbZZ+nIYgxZAk=;
        b=Z5yys1bfL57fl+t6Q/rEpSNt+PL9eN9xg8BQBxK3SwIVW5kHeFLqhQb+g62Yo67I8P
         Z6wQ7dW+GG3GiYtD6D/kGkZtA7pHKCfaPVOfkxOs4CMN3FWWvM/IsWrIeidrGwgoaW3K
         2xyyxudYiky5SmGvWPQ7AN9suANlDFc/kcZV2jx0pvM43KJFr9VF/iCd+r6vbUhE0PKv
         AEKAibv7vme8P6MK55SYgpdYsr5WM4nHoaZ82r181e48T2xFgJhWpIR82mVR5SlL1PvL
         EA7GPT4MUnA05jfyFNaAGjOagOLAaLRpKgURSb6Ccfs2RV9CYQUe/jXDYCMBTA36V9m6
         9WjQ==
X-Gm-Message-State: AOAM531OTOSPOyXaL4+9PH4EYhMtymjBEJM2ly/sFxIoLw1Ou9gulxVZ
        wiVmssqtn7YNzAZ4Is/emsI=
X-Google-Smtp-Source: ABdhPJywLx2IyCNS0hWFq5/6hX/Kp+DMZ/O5Xl3oodHu6RcPqC+m8990nD7OZwrE2LsEUqp4PRNC9g==
X-Received: by 2002:a50:cd9d:: with SMTP id p29mr9684632edi.30.1632858093427;
        Tue, 28 Sep 2021 12:41:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12sm35707ejk.63.2021.09.28.12.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:41:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Date:   Tue, 28 Sep 2021 21:28:25 +0200
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net> <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net> <xmqqo88eq8um.fsf@gitster.g>
 <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
 <87lf3hzhkr.fsf@evledraar.gmail.com>
 <YVJkx2HMf9WlPx6G@coredump.intra.peff.net>
 <878rzhz9yw.fsf@evledraar.gmail.com>
 <YVKrRooSIN7OeLy9@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVKrRooSIN7OeLy9@coredump.intra.peff.net>
Message-ID: <87bl4cwkr8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Jeff King wrote:

> On Tue, Sep 28, 2021 at 04:42:51AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > A perhaps more subtle but less awkward to type version is to just
>> > require two arguments, like:
>> >
>> >   git --config <key> <value> ...
>>=20
>> I suppose --config would work like that, you can'd to it with "-c". I
>> think it's more confusing to have a "-c" and "--config" which unlike
>> most other things don't follow the obvious long and short option names
>> working the same way.
>
> Yeah, probably "--config-pair" or something might be less confusing.
> Anyway...

*nod*

>> > but I'd just as soon continue to leave it un-implemented if nobody has
>> > actually needed it in practice.
>>=20
>> *nod*. I do think it's bad design to introduce an "env" inclusion
>> feature that relies on "=3D" though while we don't have something like
>> that, i.e.
>>=20
>> I think we should probably not add that --config-{key,value}, but
>> avoiding the arbitrary limitation of not being able to specify certain
>> config keys seems prudent in that case, and since the "=3D" v.s. ":" is
>> only an aesthetic preference I think being able to compose things
>> without limitations wins out.
>
> I don't really agree with that. Whatever syntax we use now, we'll be
> stuck with forever. It seems a shame to predicate that choice only on
> the "-c doesn't support =3D" thing that nobody has actually run across in
> practice (and I don't think is something people will run into with
> this).

Yeah, anyway. I don't care much either way, and not enough to drive this
forward. I.e. it seemed like an easy thing to hack up, but if anyone
else is interested in driving it forward...

>> We do have the "=3D" key limitation now, but I don't think it's there for
>> any key we currently define, except things like "url.<base>.insteadOf"
>> if the "<base> has a "=3D" in it (and maybe just that one).
>
> It's really a potential problem for any 3-level config key. So urls,
> branch names, remote names, various tool names, filter/diff drivers,
> existing includeIf conditions. This might be the first one where we
> really _encourage_ the use of "=3D" signs, but it still strikes me as
> weird that you'd want to do so on the command-line in practice.

Just for future reference:

I think given the discussion in the thread, and particularly if we're
going to have some regex syntax for these keys that the artificial
straitjacket of putting this all in one config key is something we
should just do away with.

I.e. I'm not proposing a *specific* schema other than noting that
there's no law that forces us to take say Junio's (in
https://lore.kernel.org/git/xmqqo88eq8um.fsf@gitster.g/):

        [includeIf "env:PATH ~=3D \"(:|^)/usr/bin(:|$)\""]

Over say:

    [includeCondition]
        type =3D envRegex
        envVariable =3D PATH
        envRegex =3D "(:|^)/usr/bin(:|$)"
        path =3D ~/.gitconfig.d/env-stuff.cfg

Or whatever, i.e. the state machine of seeing an "includeCondition" in
the config's event parser, and then erroring unless the next N config
keys satisfy some mandatory minimum set of config keys is rather simple.

We could then make any such syntax optional for existing constructs,
i.e. you could write:

    [includeIf "gitdir:/path/to/group/"]
    path =3D /path/to/foo.inc

As:

    [includeCondition]
        type =3D gitdir
        path =3D /path/to/foo.inc
        gitdirPath =3D /path/to/group/

Or something. And say add "includeCondition.negated =3D true" to that for
a "!=3D" match.

The shorthand syntax could then be omitted for anything new if it's
deemed too gnarly to represent it all in one key.

The key names & schema is something I came up with offhand, please don't
read too much into it. The point is that we don't need to make it all
one key.

That approach also fits nicely in with the rest of the config framework,
i.e. you can incrementally edit things using "git config" options, and
we could add a "--type regex" or whatever which we could then
set/validate say the "includeCondition.envRegex" key with.
