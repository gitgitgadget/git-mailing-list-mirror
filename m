Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C8C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbiEUKQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiEUKQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 06:16:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496361D0D8
        for <git@vger.kernel.org>; Sat, 21 May 2022 03:16:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so19633409ejd.9
        for <git@vger.kernel.org>; Sat, 21 May 2022 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EFmh68wR4+DLj8G3Sb2058MMC1Gz0lTqZsNyOR6g+1I=;
        b=Gj6eWVAvGr2B+tdg+TG3I7TwQOgD0KrMC/0xT0uArGjTorZM2mzMuEINqzfs+be2Oo
         iBB9jfNyz61Uy8cUTRNdhR2FQHXdTkyXdYyRFJ2dfIk/94JkyQpiwUBZ/hi5YLn+Kd2v
         EdbMG+4xLDUq+bGT9B2QM4D4FDuXCst/2uNYB6dbNq3kFFj/sxNf7Yasbsj1hXUDMtGe
         XIX8emRar254htxvppXHvWzM5rGV5yo0HQbjReZCUX1yv0ojLNCVgqwe+yxyLteeaZrD
         faBD4MxI4ic49eZzVfqY94uMQM58wyDWnROoGsrV6W9wHKrIHdjAsH4gX+yF2kTjVecn
         F9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EFmh68wR4+DLj8G3Sb2058MMC1Gz0lTqZsNyOR6g+1I=;
        b=nqLBJHJ4z5IXes6zFh7W2pW4ApqOnipxUBb38+42B0fLYiMawZM5qU1smiQAZwL+rM
         Kt5q1rUVk2T3rm2BPIajSaKiSqdpiYmK63fI5v4NFAKqczqmhDCIntdhYShBrP85Yn08
         9SrONQXj6UcCgJUn3CN7RDvk+yiJukTmI4mhjo/lZXFiWiB2FajK9WM+lFOsY0pc11Ao
         F9UaSb5t3CM3PEz+SUbeg/0GO6w7C7irYb3pote/HTjwIomB3djD4GwVaAcKHdLoTLKG
         w9YKhpthEXnZTMJkpbXmirs4kcxaV4k0jsoOaAiNHDLNViUgQhHy69lWazCIQMqK6Fx2
         TVcQ==
X-Gm-Message-State: AOAM5307YyYUYw9j+UojkYS8S6bii+AiqqClEH0hcHL9g7pqis8HEcJR
        4w6HBcMA/MQlU6FR4wNWP7A=
X-Google-Smtp-Source: ABdhPJxc56D3JAAFYqZDPqI8nCRQs0kOdm83aQL5SQG70tJV9Jy+DoFvN5qdUTOYA8nIqH5yr4pDAg==
X-Received: by 2002:a17:907:9722:b0:6f4:6989:9bc2 with SMTP id jg34-20020a170907972200b006f469899bc2mr12259671ejc.601.1653128163586;
        Sat, 21 May 2022 03:16:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7d742000000b0042617ba638esm5345726eds.24.2022.05.21.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 03:15:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nsM9L-002cHc-B0;
        Sat, 21 May 2022 12:15:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment argument
Date:   Sat, 21 May 2022 11:54:42 +0200
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
        <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
        <xmqqbkvuwxps.fsf@gitster.g>
        <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>
Message-ID: <220521.86leuv199g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 20 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 20 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Wed, May 18 2022, Junio C Hamano wrote:
>>
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >
>> >>> +test_expect_success '`scalar [...] <dir>` errors out when dir is mi=
ssing' '
>> >>> +	! scalar run config cloned 2>err &&
>> >>
>> >> Needs to use test_must_fail, not !
>> >
>> > Good eyes and careful reading are very much appreciated, but in this
>> > case, doesn't such an improvement depend on an update to teach
>> > test_must_fail_acceptable about scalar being whitelisted?
>>
>> Yes, I think so (but haven't tested it just now), but it's a relatively
>> small change to t/test-lib-functions.sh.
>
> Let it be noted that I fully agree with Junio that good eyes and careful
> reading are very much appreciated. And that in this case, that would have
> implied noticing that `test_must_fail` is reserved for Git commands.
>
> Scalar is not (yet?) a Git command.

"test-tool" isn't "git" either, so I think this argument is a
non-starter.

As the documentation for "test_must_fail" notes the distinction is
whether something is "system-supplied". I.e. we're not going to test
whether "grep" segfaults, but we should test our own code to see if it
segfaults.

The scalar code is code we ship and test, so we should use the helper
that doesn't hide a segfault.

I don't understand why you wouldn't think that's the obvious fix here,
adding "scalar" to that whitelist is a one-line fix, and clearly yields
a more useful end result than a test silently hiding segfaults.
