Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360DC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A5261181
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhI1ALV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbhI1ALV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:11:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4CCC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:09:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so76057932edt.7
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ccScANJjC4Uvq5PE8fW+LY24CIwzpGdNm0SXgQjjZ4I=;
        b=jJm/wQOD/IOou1BL7kQBNqdpPUTfmi53N6xp8iaI/VoIN552E16pC+isqJ8ifHTTM3
         rRKErBDWGuGMVS3CJ33O6SvSf8QUrZaMxh5OY22ckKcxGqigboLbE+LY+rBKxtNBQG4+
         gz4suJxOOcm7192TuGw/933qo2E8aAoXuEOalPxg+1XAEylKtPdlwXo8h30dNC5jjOHV
         wj4ihzJDX4zmRDllFIAPYAlqX1g55S0ZqZLEJDeBJfRT1k3OakkZaXzqMzlLVJKN9v3D
         TS04OleS/dDjmVE1V4vCeifqk1bkx+EoiP92ozighPV8tzAn4RpcD+AYcGhpkUw9YvQl
         vTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ccScANJjC4Uvq5PE8fW+LY24CIwzpGdNm0SXgQjjZ4I=;
        b=KyyqiWtCNUnKV9YAeXAj+iSa+R83xZbo7btlu7K7X6jR5Q4G8WXS6tUyVf1AciWm/1
         w3x5sOcemikssfYt9LHLzV1xfk825+FJsiyguVywyVd/8c554ufa2EcCPSYyKz9oCo+m
         fZ2/hcENnqpZAsLrDsde2R4vDkjvaJA+VHCkORWiANzgW4AYZSCmGzgRJBovobrk18QM
         fumo+qy0WytjBj0NqapUR9rsienbwmVWVY/x1YSrpSUtvf1jy4129Roq3MXCJ6Q7CK1f
         4U1/6Jgt7lIgHq3/CP7DEkaKPG1JpZbkjp3y8hRUfoycJbTo4DCY3gjEsQjSIUKOBL68
         mQlg==
X-Gm-Message-State: AOAM533WoaNCbSTVGoHjhuuXdvMZJXdFPPffgXENs/IVlbpVeTP1JExU
        KSf8/VVGUrzgn5kdTbnUUN0nOGc2ownhlw==
X-Google-Smtp-Source: ABdhPJwKLBoqQB8jugLeklexjaJb1mItrVKAuvi+69WKI+nP53GIlGgdXbWQ/Jk/Zsrd5mzVdXZSIw==
X-Received: by 2002:a17:906:1b07:: with SMTP id o7mr3401720ejg.28.1632787781073;
        Mon, 27 Sep 2021 17:09:41 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cn8sm11254034edb.77.2021.09.27.17.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 17:09:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Date:   Tue, 28 Sep 2021 01:52:26 +0200
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net> <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net> <xmqqo88eq8um.fsf@gitster.g>
 <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
Message-ID: <87lf3hzhkr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Jeff King wrote:

> On Mon, Sep 27, 2021 at 09:30:41AM -0700, Junio C Hamano wrote:
>
>> >> This asserts what? FOO=3D" bar"?
>> >
>> > Whoops, that should have been "envIs", asserting that $FOO contains
>> > "bar".
>>=20
>> Oh, "can we check with a literal with leading whitespace?" was what
>> my question was about ;-)
>
> My assumption was that nobody would really care about doing so. It is
> true that it's less flexible, though (and is a decision we can't easily
> take back later).

Yeah, I think nobody really cares about stripspace() or not for this
sort of feature.

I do think having implicit and explicit complexity like that makes it
harder to document, implement and understand for users though. I.e. is
"env:FOO =3D=3D bar" the same as "env:FOO =3D=3Dbar" etc., what whitespace
exactly is accepted etc.

>> > As I said, I think it matters more with the infix operators, as:
>> >
>> >   [includeIf "env:FOO =3D=3D bar"]
>> >
>> > is more readable than:
>> >
>> >   [includeIf "env:FOO=3D=3Dbar"]
>>=20
>> Sure, but at that point, we'd probably want some quoting mechanism
>> for the literal to be compared, e.g.
>>=20
>> 	[includeIf "env:PATH ~=3D \"(:|^)/usr/bin(:|$)\""]
>
> Ick. The extra quoting of the internal double-quotes is pretty horrid to
> look at. Also, how does one match a double-quote in the value? \\\"?
>
> If it were optional, that would make the common cases easy (no dq, no
> whitespace), and the hard ones possible.

An implicit assumption of mine in the simpler positive-match-only
version (which I should have made clear) is that anyone who needs this
sort of complexity can just arrange to wrap their "git" in a function,
or do this sort of thing in their ~/.bashrc, i.e. just:

    if code_of_arbitrary_complexity
    then
        export GIT_DO_XYZ_INCLUDES=3D1
    fi

Then in your config:

    includeIf.envBool:GIT_DO_XYZ_INCLUDES.path=3D~/.gitconfig.d/xyz.cfg

And having written that out I think the best thing to do is probably to
have a version that only does the envExists and envBool version (or just
envBool), and skip envIs and envMatch entirely.

In the case of env:PATH we're just setting users up for some buggy or
unexpected interaction with something that would be better done either
via a gitdir include, or if they really need $PATH they can just wrap
"git" in a function that sets a boolean inclusion variable.

That would get us out of having to support emergent behavior where some
git tool invoked via run_command() or something chdir's somewhere as an
implementation detail, and such an env:PATH match means we'd need to
support that, or potentially break existing user config.

Or, since we might not be invoked via a shell, the same issue with a
$PATH being "stale" from the POV of a user who's wondering why say a
command like:

    # status in the "t" subdirectory
    git -C t <cmd> <question>

Doesn't have the "right" $PWD, which we might not have as some future
shortcut in <cmd> decided not to bother chdir()-ing to answer the user's
<question>.

> I think this is getting into a bit of a digression, though. I'm willing
> to defer to =C3=86var, who is doing the actual work, and I don't know if =
he
> has found any of this compelling. ;)
>
>> > But I do think:
>> >
>> >   [includeIf "envIs:FOO:bar"]
>> >
>> > is harder to read than even:
>> >
>> >   [includeIf "envIs:FOO: bar"]
>>=20
>> Hmph, that's quite subjective, I am afraid.  When I see the latter
>> in the configuration file, "do I have to have a single space before
>> 'bar' in the value of $FOO" would be the first question that would
>> come to my mind.
>
> I think it's just the mashed-up colons that I find ugly in the first
> one. But I agree the latter isn't that nice either, and introduces the
> ambiguity you describe.

FWIW I hacked up a --config-key --config-value pairing so you could set
keys with "=3D" in them on the command-line, I'm not sure I like the
interface, but it gets rid of that ":" v.s. "=3D" edge case:
https://github.com/avar/git/commit/a86053df48b

>> With an understanding that our syntax is so limited that we cannot
>> even write '=3D' and need to resort to Is: instead, I'd actually find
>> that the former less confusing than the latter.
>
> That I think is the most interesting question: is the "=3D" actually
> out-of-bounds? I tend to think not, based on our responses earlier in
> the thread.
