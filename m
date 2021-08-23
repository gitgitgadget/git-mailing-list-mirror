Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1DC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B95611EF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhHWKXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhHWKXE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:23:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49698C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:22:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q17so3548576edv.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZLzSRDFfi01Qc1cvxksY8jouUzvLVgX3QoHKP8MwkbE=;
        b=aes+gzv4ujBYjXu+FBEwumwSm58tD9TUfBAueDDHAUdTx6DJahHHSbf0EGObef6wKr
         xsJ072RGtMOJ2F1wWfCqc9JMLrvfKcBOKQqT0Ig44SSn67Q3TfR2MFkj28eRRYzP1pXV
         TcHjwICDd6Zi7GuIHNkLR3GWFkBXgO8OnPxD6nGkoCPOjdgg1xsDUmlgKRKYIEXfx68H
         hsncJl+jVfIrxZ/COHxyDHWqfvkc1Z6oulg39KU/rK1954uCvGh8PEK67Ei70aODEQV8
         un5+/HNsKytEl2bRzKitqYprwO5Dwq11uBaz+aLu5D9b1a2zwgok82BvJJKVWt0cHnp5
         jyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZLzSRDFfi01Qc1cvxksY8jouUzvLVgX3QoHKP8MwkbE=;
        b=EbT+IvO6SscfyfRIzQ7zr2nkSQYEx/kYspbe5YeWUDu06GRkkJwgtaVzTfNAYFWKym
         YZhlOFK92hUSnVHjdTdf5Y9fhGuoCkPLcFx7KxJXaxwwC+gMCw8RWnAfAA2N34TO5Knu
         7rEzCmE6b52XhFVVo7x3VPOE0/T840CvSKb2Zufb/zUuhaadOWFVbzjXHcCYS0ODJY0O
         BnyOTijeH8V+kxs0yANRN+duPPiIoFh85d0cZTM/HQgao6e/XRHLB0MHbR8YlP5Rra5R
         zyJqNlhzBRVFbQLx2YH4WFrSbjmGBM40Gx6HbKaW/xeIvLBaKNeOYAeBqKcQYYRhB+Ft
         hXFA==
X-Gm-Message-State: AOAM533NI8MGlsRacTjKp+GeCe46HZgYXeycj6qmu8NbiuZIXlvdLrz2
        D4hFiNqbdVJ/U0DgDgMKy9o=
X-Google-Smtp-Source: ABdhPJxEzkq+sDEQbNnPW9+3Ck6U83aHKlrIWTJvSs5HWIXsRtixmnyxqfMhbp7PR96r/QMrgzTsMg==
X-Received: by 2002:aa7:d916:: with SMTP id a22mr36318509edr.158.1629714140914;
        Mon, 23 Aug 2021 03:22:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t16sm4034325ejj.54.2021.08.23.03.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:22:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Giving priority to the reftable topic    (was Re: What's
 cooking in git.git (Aug 2021, #06; Mon, 16))
Date:   Mon, 23 Aug 2021 12:21:30 +0200
References: <xmqqv945ng61.fsf@gitster.g> <xmqqtujkwsu0.fsf@gitster.g>
 <CACBZZX41gwo=pv_4fn2VcLz0Qq7Av-CWsnNXfXSuzmwZnu-Q3w@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CACBZZX41gwo=pv_4fn2VcLz0Qq7Av-CWsnNXfXSuzmwZnu-Q3w@mail.gmail.com>
Message-ID: <87y28sfokk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 20 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Aug 20, 2021, 08:09 Junio C Hamano <gitster@pobox.com> wrote:
>
>  Junio C Hamano <gitster@pobox.com> writes:
>
>  > * hn/reftable (2021-08-16) 25 commits
>  >  - t1404: annotate test cases with REFFILES
>  >  ...
>  >  - hash.h: provide constants for the hash IDs
>  >
>  >  The "reftable" backend for the refs API.
>
>  As discussed in the thread that leads to [*1*], this topic has been
>  blocked by the "clean-up errno use in the refs subsystem" topic for
>  too long.  I think it deserves to have its own chance to be looked
>  at by more eyes.
>
>  I've reverted the three topics around "errno" out of 'next', while
>  rebasing them into a single strand of pearls, and queued them near
>  the tip of 'seen'.  The hn/reftable topic is merged into 'seen'=20
>  earlier then these "errno" topics.
>
>  'seen' that has this topic, without merging known CI breakers (the
>  three "errno" topics are known to break when they are with the
>  hn/reftable topic, and the "builtin fsmonitor" also breaks CI),
>  passes the usual tests [*2*], except for the "pedantic" test we
>  recently added [*3*].
>
>  The breakage flagged by the compiler are all:
>
>          char *fn =3D get_tmp_template(__FUNCTION__);
>
>  where the code expects that __FUNCTION__ is unconditionally
>  available.
>
>  With that problem fixed (which I would imagine should be easier than
>  brain surgery), we should be able to move the topic lower in 'seen',
>  hopefully touching 'next' soon to give it a wider exposure.
>
>  And when hn/reftable gets stable enough, the "errno clean-up" topic
>  can perhaps be rebased on top of it to work better together.
>
>  Thanks.
>
> (In the Gmail app, so this'll probably not make the list, sorry, feel fre=
e to quote it)
>
> I've been on vacation for a couple of weeks, am back Monday.
>
> I haven't been able to look at these breakages in detail but it looked li=
ke there was a fix-up plus a logic error in reftable in combination with it=
 with
> the now dead NULL parameter, perhaps something else I missed. I've only s=
kimmed the list.
>
> I had a subsequent fixup topic ready on top to remove that parameter, can=
 include in in a reroll. Then the segfault will be caught at compile time v=
ia a
> signature check.
>
> As I noted on list before we can do it with reftable first if you'd like,=
 but I don't think the end result will be easier to review or should be fast
> tracked. We'll have the same questions about how reftable uses those ref =
APIs, but will need to review it against a basis that has more API action a=
t a
> distance.
>
> So if you're willing to give me a few days I think d can sort it out to e=
veryone's satisfaction with the refs API fixes first, if not I'll try to re=
view
> the reftable topic again, but will probably use a local merger of it and =
my topics as the basis for that.

I should have a re-roll of these topics ready soon, but aside from the
broken-ness of my "base" topics I don't see how the reftable topic is
anywhere near ready for "next" per my
https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/; whether
it's based on my "base" topics or not.

>  [Reference]
>
>  *1* https://lore.kernel.org/git/xmqqbl5syhiu.fsf@gitster.g/
>
>  *2* https://github.com/git/git/actions/runs/1148914175
>
>  *3* https://github.com/git/git/runs/3377289487?check_suite_focus=3Dtrue#=
step:5:639

