Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947DC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789BA611C0
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhI1Czl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhI1Czk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:55:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC5C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:54:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b26so28941024edt.0
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OV+osTD9s28fyH6ldrsy8r52yWu4YOJpoVtSmiugbDc=;
        b=gMrtI2Zn8rP/7K7r7/yTc+Q/tSghIqSL2nZb1ZTqteI5Uq9bEDXHovL79t/lPZ7t60
         qxUCihw6NckhQqNjIRCaqVou3ck2tAKSa4k3cUiJ9fzCGskJQJEviT7J6076e3itcT1m
         SXfwhYGsYcXkpd/qvjMunOtoxKtNQL8HR+eB79/46Nr0asfgLjuyeNENrfyJjLxMg0y9
         q+P7nEZX3pG7wOuJwAu3bMPxN7pmPL3OVLmwqq/vngMoEBzSdWGeRfmGhfjRERIGM94F
         hJd7HVdOKYzsttHsbQIi34YbdxaTmSzHzsZtibcApwOtyug74nm2MYRND/nHR8naFCPK
         84Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OV+osTD9s28fyH6ldrsy8r52yWu4YOJpoVtSmiugbDc=;
        b=vnup3l8gLazlWLn9b44JXUDvPm8azlwWlCbnObWdscx0t2Ih64u2nVIwWNMWbJiPf2
         8qxVS3beIieryIK6hMumAMIqt1qPzDjxRB0bNkuWnTDUKkvVkmgcYuso8Bf1tZjxOXIH
         rEB0f7TPe/Spbo9AeNMnCr0AqoTR0XJbobZpMefjUVvRFAdDXtGV5/aivudn7o70Zgue
         PdCfm6O0hzvPpM4ukqTJld5ZQzuKgAhGtitoShCfN++bP3qSt1/4rc0MRlFskGhYD7tF
         MNZVSz45h1I8b0rD8U/45/4ZMQxWu0iJI9ninw83+Wgx2rKNvoKPzI1OfiPnJcsYtX4z
         aw6g==
X-Gm-Message-State: AOAM531Nd2s8sBiQVjsO7rgVmpRKpVDhGsaqtlo1Z1Gj888saTlIRFrk
        lphlza79E0NfBV39XyM0ScA=
X-Google-Smtp-Source: ABdhPJxaffftyWV3GLLbQ+p5JSM+Xr/7HlPvJPmNNLYE9bJ2vngoVkl2jQRnzN+vb7ohY7LE9kFGFQ==
X-Received: by 2002:aa7:d303:: with SMTP id p3mr4821354edq.174.1632797640268;
        Mon, 27 Sep 2021 19:54:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o15sm9599948ejj.10.2021.09.27.19.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:53:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Date:   Tue, 28 Sep 2021 04:42:51 +0200
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net> <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net> <xmqqo88eq8um.fsf@gitster.g>
 <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
 <87lf3hzhkr.fsf@evledraar.gmail.com>
 <YVJkx2HMf9WlPx6G@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVJkx2HMf9WlPx6G@coredump.intra.peff.net>
Message-ID: <878rzhz9yw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Jeff King wrote:

> On Tue, Sep 28, 2021 at 01:52:26AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> An implicit assumption of mine in the simpler positive-match-only
>> version (which I should have made clear) is that anyone who needs this
>> sort of complexity can just arrange to wrap their "git" in a function,
>> or do this sort of thing in their ~/.bashrc, i.e. just:
>>=20
>>     if code_of_arbitrary_complexity
>>     then
>>         export GIT_DO_XYZ_INCLUDES=3D1
>>     fi
>>=20
>> Then in your config:
>>=20
>>     includeIf.envBool:GIT_DO_XYZ_INCLUDES.path=3D~/.gitconfig.d/xyz.cfg
>>=20
>> And having written that out I think the best thing to do is probably to
>> have a version that only does the envExists and envBool version (or just
>> envBool), and skip envIs and envMatch entirely.
>
> I'm not sure I agree. If you are willing to wrap git, then you can just
> add:
>
>   git -c include.path=3D~/.gitconfig.d/xyz.cfg
>
> to the command-line in the first place. Or if you're willing to use our
> undocumented interface, you can even do it in your .bashrc:
>
>   if code_of_arbitrary_complexity
>   then
>           GIT_CONFIG_PARAMETERS=3D"'include.path'=3D'~/.gitconfig.d/xyz.c=
fg'"
>   fi

Sort of, that'll give you unconditional inclusion, but won't e.g. handle
a case where the env include only runs in some .git/config, or depending
on other inclusion (e.g. in ~/dev/git, but only if XYZ env var).

But yeah, it won't handle all potential cases. I figured for this sort
of thing it was better to start small and see if the provided interface
was enough..

> The value of this env matching is that it is done at run-time without
> wrapping, and can meaningfully inspect the state of the world. E.g., the
> $TERM thing that started this thread.

Yeah, maybe we should have at least an ifStrEQ, whatever we call it...

>> In the case of env:PATH we're just setting users up for some buggy or
>> unexpected interaction with something that would be better done either
>> via a gitdir include, or if they really need $PATH they can just wrap
>> "git" in a function that sets a boolean inclusion variable.
>
> Yes, I have trouble imagining why any matching on env:PATH would be
> useful (or $PWD, since we have the much less confusing gitdir
> conditional). Which isn't to say I want to forbid it, but just because
> people can shoot themselves in the foot with complexity doesn't mean
> that "envIs" is a bad thing when it's not misused.

I'm biased by past on-list discussions where existing behavior, no
matter if unintentional or emergent can be really hard to fix once
established.

>> > I think it's just the mashed-up colons that I find ugly in the first
>> > one. But I agree the latter isn't that nice either, and introduces the
>> > ambiguity you describe.
>>=20
>> FWIW I hacked up a --config-key --config-value pairing so you could set
>> keys with "=3D" in them on the command-line, I'm not sure I like the
>> interface, but it gets rid of that ":" v.s. "=3D" edge case:
>> https://github.com/avar/git/commit/a86053df48b
>
> Yeah, we talked about that a while ago, but nobody liked the interface
> enough to actually code it (and as far as I know, it's really
> theoretical; nobody has actually wanted to set such an option from the
> command-line yet, and we have the --config-env stuff for people who want
> to robustly pass along arbitrary keys).
>
> A perhaps more subtle but less awkward to type version is to just
> require two arguments, like:
>
>   git --config <key> <value> ...

I suppose --config would work like that, you can'd to it with "-c". I
think it's more confusing to have a "-c" and "--config" which unlike
most other things don't follow the obvious long and short option names
working the same way.

> but I'd just as soon continue to leave it un-implemented if nobody has
> actually needed it in practice.

*nod*. I do think it's bad design to introduce an "env" inclusion
feature that relies on "=3D" though while we don't have something like
that, i.e.

I think we should probably not add that --config-{key,value}, but
avoiding the arbitrary limitation of not being able to specify certain
config keys seems prudent in that case, and since the "=3D" v.s. ":" is
only an aesthetic preference I think being able to compose things
without limitations wins out.

We do have the "=3D" key limitation now, but I don't think it's there for
any key we currently define, except things like "url.<base>.insteadOf"
if the "<base> has a "=3D" in it (and maybe just that one).
