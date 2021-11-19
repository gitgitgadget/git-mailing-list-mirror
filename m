Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00DFC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3290610D1
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhKSRKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhKSRKU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:10:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233ACC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 09:07:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so45412618edb.8
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1dxYA/FmpkbCaVjVZ/1Am0fepcyViW9ZyZT2dENPlKA=;
        b=nk0nZvbZhulU87oW6qEm4dLEs5ih4UIZf24/WEAF2XXprkV2LxWyrfMnhI6n8knc0T
         QAugXO7MFj5AZxGrN/RTSgYWFPXZrhdeuvmSsyM7cjGkRmzS/0pGNDfKBhtjtGIT+m1r
         SAqNvNqrjjkGPN9D7dorT9vBn8YEsk6u83Ax0NHq7OyRckt7WcfNzV5DBMbRvp3r7jU/
         n0QEtzlIZA13Q5z1RMjWPgq5RDWzkmso+ryi32UhU9c/vbM6vpnU592JJdrxADS4ptkT
         Oo/Zwevb67kbWUNj8gxnlRb2R9xM0RFHVWl7KnjTbbIX3NrepBT+hM4DiUeJfi6ozBUq
         NWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1dxYA/FmpkbCaVjVZ/1Am0fepcyViW9ZyZT2dENPlKA=;
        b=oQa6VowXQN5bTn1YTgN47FjlWGG7mTTInVUcWx1FHge/zyrHAIoW3yiVsEHugV+snt
         axZgnfPdxILgXblCIEiH2h1dWKgDDXZ829f0U9xxDynXcrCGkubEDLZg0oooqUxQOpOM
         GpL7l7ebXZh6ZmSYbNxFjvckGU2acWBQGQ43CiqGV5WltJU1p5H+G/RltxeQepZmlLWQ
         Rv8pYJHAmnmbdwdvd51RmqP5JljpSqCSszBvvNhsz/8n9L3gpdPNIPStaXpH2G68gMbP
         5AphBtycH6RAHINhEYncPSlW/1lk0HXUVF6+wS8+P6I0ke/tHqbrtD+dpVAKpsjsWaT8
         IAIw==
X-Gm-Message-State: AOAM5336IsxUDkuh+UOQVHVbIctm2G5nTgXUy305NaU5q+VSnN1dhIm7
        FMwkMSenNtFDyGQyouKQCho=
X-Google-Smtp-Source: ABdhPJyKzQMiYaUI2aX6g2uLjZa7vZQTsDn7QTl7Mfr7aIq6thYcEGee+MsfHKDiEOGWd+1dI9bJIw==
X-Received: by 2002:a17:906:730b:: with SMTP id di11mr9808901ejc.97.1637341636443;
        Fri, 19 Nov 2021 09:07:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs8sm211938ejc.53.2021.11.19.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:07:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mo7M3-000mez-3d;
        Fri, 19 Nov 2021 18:07:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] Makefile: fix parallel build race
Date:   Fri, 19 Nov 2021 17:48:32 +0100
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
        <YZR0djZbRUicXcQm@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
        <211118.86tuga5o68.gmgdl@evledraar.gmail.com>
        <YZWqK38NRjD7aPOG@danh.dev>
        <211119.86ilwo4o8c.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111191625002.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111191625002.63@tvgsbejvaqbjf.bet>
Message-ID: <211119.86h7c82hx8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Johannes Schindelin wrote:

> On Fri, 19 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I think getting it working on non-Windows if we're going to keep it
>> (which looks to be the case) would be very useful.
>
> The idea to extend the CMake to more than just Windows is contrary to what
> Junio said in
> https://lore.kernel.org/git/xmqq1rmcm6md.fsf@gitster.c.googlers.com/:
>
> 	Let's not worry about cross-platform and instead stick to Windows
> 	and nothing else for now to expedite the process.  As long as it
> 	is advertised as such, nobody would complain that it does not work
> 	on Linux or macOS.

That's quoted in the <211119.86ee7c4n8r.gmgdl@evledraar.gmail.com>
you're replying to. No need to repeat it.

> If that is not enough to tone down opposing opinions (the opinion of the
> Git maintainer is more important, after all, it's his maintenance burden
> so he gets to decide), you can also look at this statement from
> https://lore.kernel.org/git/xmqq8sikblv2.fsf@gitster.c.googlers.com/:
>
> 	I already said that I feel that engineering burden to divert
> 	resources for CMake support would be unacceptably high.

There's some back & forth in that thread, I do think a fair summary of
it is that the proponents of CMakeLists.txt, including yourself, assured
reviewers that having the cmake component wouldn't place a maintenance
burden on anyone not using it.

Including yourself at:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejva=
qbjf.bet/:

    When it comes to new Makefile knobs, I do agree that it would place an
    unacceptable burden on contributors if we expected them to add the same
    knob to CMakeLists.txt. But we already don't do that for our autoconf
    support, so why would we expect it for CMake?
=20=20=20=20
    When it comes to adding new, and/or removing, files, I fail to see the
    problem. It is dead easy to keep the Makefile and CMakeLists.txt in sync
    when it comes to lists of files.

The "that it" here refers to "slow our existing developers down by
forcing them to become familiar with CMake", which you quote below.

> The only reason we have CMake in addition to the Makefile (and the
> autoconf-based) setup is that CMake makes it possible to build Git on
> Windows in the development environment with which the majority of the
> developers on Windows are familiar: Visual Studio.
>
> If it weren't for those developers, for who it would be a ridiculous
> suggestion to "just go download GNU make", we would not have the CMake
> based build at all.

I'm happy it works for those developers, and don't mind at all that
they're choosing to run a propriterary stack while developing a free
software project, I'd just prefer not to be forced to do that because
our CI has a hard dependency on it.

We can argue about the trade-offs here, but I think it's clearly
hyperbole to say that would be a ridiculous suggestion when it was the
status quo until 2020.

I'm specifically pointing out that the issue with the hard dependency of
CI on this "contrib" component.

I'd think of all people you'd be in vehement agreement with me on that
point, after all our back & forth on the contrib/scalar topic, and that
things "contrib" must be decoupled and "optional" in a way that this
cmake integration clearly isn't.

> And I am still agreeing with what Junio further said in the second mail I
> linked above:
>
> 	[...] it is unclear why it would be beneficial to slow our
> 	existing developers down by forcing them to become familiar with
> 	CMake.
>
> So now we are discussing to extend the CMake build to allow Linux and
> macOS developers to use it, to, for little to no benefit. We are very much
> in the situation where we are slowed down by discussing something as
> non-essential as extending our CMake support beyond Windows, while patches
> that are provably much more beneficial to a lot more people are left
> under-reviewed.
>
> Even worse: reviewers who _could_ provide high-quality reviews for those
> patches (which takes a lot of time and diligence), but are as much pressed
> for time as I am and therefore have to choose wisely how to spend their
> time, are _actively_ distracted from spending their time more wisely.
>
> Can't we please focus on more relevant things again? Pretty please?

We have out-of-tree patches to make this thing work outside of Windows
authored by Phillip, and it sonuds like =C4=90o=C3=A0n would find it useful=
 too.

As for myself I really don't care to interact with this cmake component
at all, but if we're not going to drop the CI hard dependency on it I'd
find being able to test it on a free OS locally to be vastly
preferrable.

In any case, I'm not submitting patches in that direction. But I don't
see a reason to discourage other people from collaborating on topics
they may find useful, as you're doing here.
