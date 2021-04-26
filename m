Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CC9C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48C961027
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhDZO2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZO2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:28:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF24C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:28:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ja3so8853317ejc.9
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dTynSBenkJNBqPYqI2dZ2KmB6tVLa6NHIRDouDorvHQ=;
        b=f2ZF0XHDU4EfV+Ma53UZNNg0FoaMRQfITAhUyFlRRisilqSY2WvIZ/qeynhVN8wkrU
         JY5fqtMRvVxWGiuCQmJRcBUzF+P0inKZtegGqY4XL0M0hlfYJlcDRmxuFe52Xh8Sv9li
         NXnddQ7MPffQlHuQDqQ3AdO1h/Ca/3VSrWWRzdpdM0ycMdQShm8Nhy1cCjC6XYfJXH3g
         H/RqXW9hIR0dY7KQgT70WhU17To0pDxfTxO2uEcDDINV9GVnT3qXujruyIOqy9OqA5hP
         tvCUCE/Gj9bTbhWL0a44JlGvKwChTcLMdetLuPBBrc/fj8HsrzrJl8CNka2KT1nu/YhJ
         Yhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dTynSBenkJNBqPYqI2dZ2KmB6tVLa6NHIRDouDorvHQ=;
        b=Ma0lqIpF9xyt0pc87cOa4AcI4E8Z2B7QRaqXAi7q83KDY6JMMMTDkr7vtmCPCzIjWO
         TDhtLOAiGQOr6tGv4/vl+QHwiiKcttuvMvpjK4jSj5szOTeaVAixzFFnNQ2d2p4Xc2Oo
         GxAXN4Ydo95Vf/Gu4KqbhPfx/9mwk4AnCeTbylBnH0fcGKiBIgLzwC8266edKTmf3MsT
         VYJbcHsASEFP/uh7ExJ6pdwpkksE7TEPEMD8XDqWcp8bMKP5HezxeXUWhnABisZPpyK1
         J62bWX++tU+IHx6V0zxqWMx/k5KycLn7xYaVe+pKbmrqz+F0hS5wUjk/wr1tJRSN+7W0
         ZLFQ==
X-Gm-Message-State: AOAM531MbdmbpW/LGJKSf1coI5VJRyCGUv+9P40k2+JoUbV3MK8CBmfi
        y0We+qzVAPmLt9W1Yya7ZbkzPV2y/Zk=
X-Google-Smtp-Source: ABdhPJwEIa4nyXOSXPzFlA5zpg3DlVz4jcPjT6tFTs/LsZ7W3OdBnDRSPvMaUw198xW3F15CFHjcTQ==
X-Received: by 2002:a17:906:170f:: with SMTP id c15mr18741685eje.358.1619447285182;
        Mon, 26 Apr 2021 07:28:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hd30sm11257471ejc.59.2021.04.26.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 07:28:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
Date:   Mon, 26 Apr 2021 15:23:11 +0200
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
        <871ree8eto.fsf@evledraar.gmail.com>
        <CAFQ2z_Pco4KhhE7S_8zBZ7hCwOH=DnxHoKE8zus7REdQaXCZiQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAFQ2z_Pco4KhhE7S_8zBZ7hCwOH=DnxHoKE8zus7REdQaXCZiQ@mail.gmail.com>
Message-ID: <87lf953yto.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Han-Wen Nienhuys wrote:

> On Thu, Jan 21, 2021 at 4:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I've been chasing down some edge cases in refs.c as part of another WIP
>> series I have and found that for this particular "errno" stuff we don't
>> have any test coverage. And with master & hanwen/reftable if I apply:
>>
>>     -                       errno =3D EINVAL;
> ..
>> All tests pass on both.
> ..
>> That I can remove error checking/handling from this place means existing
>> general logic was faithfully copied without checking that we have a test
>> for it, or adding one.
>
> I think that is an unfair characterization. The API documentation of
> read_raw_ref_fn says that implementations should return EINVAL for
> certain cases, so that's what I did. The point of having a documented
> internal API is that one doesn't have to double check what is behind
> the API.

I'm only meaning to point out that the behavior being relied on here
doesn't have any tests.

I agree that whether or not we should have any tests at all is a matter
of opinion and circumstance. I don't think in general that someone using
some random internal API needs to be checking what is and isn't tested
in that API.

I do think in this case that it's worth digging a bit further. The APIs
in question are using EINVAL and EISDIR to pass up errors that are had a
1:1 mapping into the FS historically.

Are we really better off faking those up, or is some of that perhaps not
used at all? Maybe we'd find that this level of abstraction isn't what
we need, and it could actually be much simpler.

My main goal here is not to keep creating some infinite amount of work
for you, but to try to help this along into some shape that's better
reviewable & land-able.

It seems to me that a good way to get there is to seek some systematic
ways of focusing review onto various edge cases of this series. I.e. to
begin with having GIT_TEST_REFTABLE pass as noted elsewhere, and in this
case calling attention to some of the underlying assumptions behind this
series.

One of the hardest things I've found about trying to review this has
been closing the gap between things that exist in your mind and commit
messages / code.

E.g. in this case sure, you can be of the opinion that since the point
of an internal API is to provide an interface we can simply assume it's
OK and working as intended.

I don't think given the history and use of this code that that's an
assumption I'd be as comfortable making, but anyway. Getting back on
point, I do think whatever opinion anyone is of on that subject having
something like this in the commit message (and other applicable commits
etc.) would be *very* valuable:

    In functions such as git_reftable_read_raw_ref() (and ????, are
    there more?) we're diligently emulating the documented behavior and
    return values of the refs file backend. According to "make gcov" we
    can see we don't have coverage for this, in particular the behavior
    of EINVAL etc.

I.e. per [1] once if and when we have GIT_TEST_REFTABLE passing surely
one of the best way to garner feedback on the rest is to discover those
parts (using "make gcov", after running with/without
GIT_TEST_REFTABLE=3D[true|false]) where we still have outstanding blind
spots between the tests and code.

1. https://lore.kernel.org/git/87lf9b3mth.fsf@evledraar.gmail.com/
