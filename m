Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F8C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3BF206F6
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 20:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbhAQUX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 15:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbhAQUXX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 15:23:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95045C061573
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 12:22:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id dj23so12720095edb.13
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 12:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=13jE5HPDaITjQDZc3yw8J2dmSJ8mfq8FF8uLI6InQeU=;
        b=TjpUU7P+O0dx/Je3IF+NYypFngYqL76vDEUaNauLvclLWCG0VFzXPQkJxcmuBm5ciu
         qjEraW6W1W+xRAMfe/4FZNmKf8X2WMnE4jFQzRD01FV9IKHb8Ebbmt8UzpwsqQ7tCGED
         505rj5Z2j25yTIeoEDzgpkme8Yaq19DIBRVF4M9+7xfzDDW0p/Ovnr+jQoTbj7+pbTp0
         hv0yUgKejoQNNuVJVwdA4BWRbQyvvZ7cb12PCpX/o8aqTDynq8F9FDGbLWC6Nv4p/ave
         V0kFxl+WT8MfFI3qyy+0002Ahg4YbfGgqY3ET44m6H1miVpb6imuCIkZzRiQy5Ghf6LX
         1VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=13jE5HPDaITjQDZc3yw8J2dmSJ8mfq8FF8uLI6InQeU=;
        b=FgNZUD4qeW62SqmgLixdEq9glvsT0YSMVh3VIhy7kcvyLK2JaL18YOKzKfMvtxueFh
         ZKhu9EZT8VE4d/xXM3vR6Cp5U9n8KegcdCgma9vjhHKUpREdR5NRiVUxDMuStl8hcdbH
         mEr0LTD0lg1J85QnfNMoQ7vDGOg8JRzfxSLIilbm85/cMizawVj2zGSet3W7OgvnlDU+
         zyy8Z0VhvdMWanHpIE6D8Imc0P3OZd4yhqiP/7UPlaILLpAN9Ji8TbZpQ9V03sSadSaM
         jORBJ/l6mAwm9XpO5kieGghAVurPQNaThLM6Mp+sp9etb3Ifs5LIt/3HMOxvME/Y/Phg
         /SOg==
X-Gm-Message-State: AOAM5325k1kjoXzZ68WqVwdlQdhTNcuViZyMQGS1QWy/m1LI1sEnJLBR
        rYNIxT3hcjnPY34Ge5QuqW0YvT7OqVg=
X-Google-Smtp-Source: ABdhPJyszVTbzgA6cvqXwDJGhfjr1jQ2lCi8QGtvF5UlR5BzOT6jrf/tOzasDJoK882lfjkeNyBDyQ==
X-Received: by 2002:a05:6402:30ac:: with SMTP id df12mr17781452edb.175.1610914961174;
        Sun, 17 Jan 2021 12:22:41 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id ce7sm104095ejb.100.2021.01.17.12.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 12:22:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
        <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
        <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
        <xmqq4kjpelza.fsf@gitster.c.googlers.com>
        <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
        <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
        <87k0si5k75.fsf@evledraar.gmail.com> <YADZSsVqyGnArF0n@google.com>
        <87im7w4zqt.fsf@evledraar.gmail.com>
        <YARwrtU9u51s13S0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <YARwrtU9u51s13S0@coredump.intra.peff.net>
Date:   Sun, 17 Jan 2021 21:22:39 +0100
Message-ID: <87wnwb8ga8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 17 2021, Jeff King wrote:

> On Sat, Jan 16, 2021 at 05:23:38PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > [...] especially when that pushback is "I'd like to write a tool to
>> > reverse this thing, because <vague reasons> - and I don't mean that
>> > tool maliciously so that should be OK."
>>=20
>> ... this point in particular seems to be an attempt to summarize my
>> views or motivations.
>>=20
>> I don't see how you could read my E-Mails on the subject (especially
>> what you're replying to,
>> https://lore.kernel.org/git/87k0si5k75.fsf@evledraar.gmail.com/) and
>> think that in any way reflects my views on the matter.
>>=20
>> In lieu of repeating much/any of that I'll just say that that doesn't in
>> any way reflect my views, and from having read all the rest of the
>> message traffic associated with this topic I don't see who else you
>> could be referring to with those comments.
>
> This is sort orthogonal to what you're saying here, and possibly I
> missed this part of the discussion, but...I'm confused about this
> talk of a tool for unblinding the mailmap. Isn't:
>
>   git log --all --format=3D'%aE %ae'
>
> basically that tool already?

Yes, but I belive from brian's mails on the topic[1][2][3] that the
issue at hand is that doing that is just the right level of
inconvienience in the minds of the users who want this feature, and that
e.g. having some/any of:

    git check-mailmap --porcelain --materialize-hashed
    git for-each-mailmap --format=3D"%(authornamefrom:unhashed) %(authorema=
ilfrom:unhashed) %(authornameto)"
    git ask-remote https://github.com/chromium/chromium -- <that for-each-m=
ailmap-command> # (or whatever..)
    <open .mailmap in your $EDITOR and see/edit/save only materialized valu=
es>

Would tip it over the edge into the territory of this
socially-signalled-to-be-private information being too convenient to
extract from the DAG.

1. https://lore.kernel.org/git/X%2FtxB8b3%2FqqbwbmC@camp.crustytoothpaste.n=
et/
2. https://lore.kernel.org/git/YADh2DHDrdAs6Jbj@camp.crustytoothpaste.net/
3. https://lore.kernel.org/git/X9xEnpLeZ4mCjwWF@coredump.intra.peff.net/
