Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EDCC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbhKVQxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbhKVQxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:53:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AE8C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:49:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so79801290edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tqdMoWk2/2wOk6JKpJZj3Xv7+BEXUgKKdoyl9dU0uSM=;
        b=fe9y1vPDiMKCwQ492p7vt+l5Vf2ZEa7wPkkOqyuLV0J4u3WB8facOirGyITkANbpxJ
         1gnAqB5cYvHYOFGVw1cmzUU+TOUs1FvmwERxNC8WGPTaw2pjsC/BwZdNd1uGYcMX4jxf
         iLUTzT0sGoJSy2jlAsVPLpfmc4P0mfwn7KIWSN7K3t+xmcxOCC+ib4IrmIXethHNdA1F
         12OAFPxFUJfecEXNsUeAEnZVSRGhT/La7wJqr0SL6+4ZLF5+OsOMffV0JWWbpuTactBF
         Qk8op1IA/X8AaUu+66Ky6OdehFN6O/IjPxQuic/atx7c4EoACjOaiplmvyTxrTJ/1rc2
         NkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tqdMoWk2/2wOk6JKpJZj3Xv7+BEXUgKKdoyl9dU0uSM=;
        b=yFYVOT+oh31quaVH0c0UUjLFh+v85M7PXRgupyEWwgeY1ztSw11F6UIGAEPSsSFd5a
         7I1foZxr7fIMkc0PeB7fQpOuMErG2araaHnReowbOMrP3f4NXq9ryYrPlnEGsTyXhLKL
         Rutl0nxsbiLaO8e6Zr0cJiE5I77sL3SPkcsrv05WNWzhKzs8ARW8c515F/Hz0wPfx/XN
         qoDFVtUGdCDAzN3s6dlhgXT4Uc45GnboVQIK9yUFUkNfQApt4Nam1jq8UocnwJQrWHpK
         c/GwctlokCANTHQ+0braZSHBQ8hFiI9cvEwEu+L7LVa/zFYeoS5OCW6x9PbabvURgG0i
         Bvbw==
X-Gm-Message-State: AOAM531bw9GXsM9vLKzZwJSh47JLiMXI9OQEVhICcoHglRJ+DIrsGEB3
        QkCOadTyUMsJOJZorObjiiI=
X-Google-Smtp-Source: ABdhPJxazpQR7kDUSGi3So4l8k9MrbJwRhpqSmz7zkWmFtmyW+61G7h2gTKcADbceTAh7iUscD+sbw==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr67771868edd.377.1637599796431;
        Mon, 22 Nov 2021 08:49:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hp3sm4014540ejc.61.2021.11.22.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:49:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpCVu-0017Ri-O8;
        Mon, 22 Nov 2021 17:49:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v8 00/17] Upstreaming the Scalar command
Date:   Mon, 22 Nov 2021 17:36:03 +0100
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
 <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
 <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
Message-ID: <211122.865yskyw25.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Johannes Schindelin wrote:

> Hi Elijah,
>
> On Sat, 20 Nov 2021, Elijah Newren wrote:
>
>> On Fri, Nov 19, 2021 at 3:03 PM Johannes Schindelin via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> >
>> > tl;dr: This series contributes the core part of the Scalar command to
>> > the Git project. This command provides an opinionated way to create
>> > and configure Git repositories with a focus on very large
>> > repositories.
>>
>> I thought after
>> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110062241150.395@tvgsbejvaqbjf.bet/
>> that you'd update merge.renames to true on what is now patch 7.  Did
>> you end up changing your mind, or was this overlooked?
>
> Oops! Thank you so much for the reminder.
>
> Will fix. I do not plan on sending out a new iteration for a few more days
> because I do not want to send lots of patches to the list right now,
> reviewer bandwidth seems to be stretched quite a bit already.

Bandwidth which is further stretched by continuing to send updates to
this topic while ignoring outstanding feedback.

I.e. "seen" being broken now due to a merger of this topic and another
topic of mine, which as noted in [1] is really just revealing an
existing breakage in this topic, which I sent you an unresponded-to
patch to fix almost a month ago.

>> Other than that, this round looks good to me.  (I have no opinion on
>> the build system integration, other than that I like it being optional
>> and not installed by default.)
>
> Yes, I very much wanted to keep this optional and as well-encapsulated as
> possible for the moment. (Hence the way it integrates with Git's build
> process.)
>
> Thank you for chiming in!

Whatever disagreement we have about the particulars of how scalar lands
in-tree is one thing, and I'd be the first to admit that some of the
stuff I've been suggesting is just my opinion.

But I've also been pointing out in reviews of this series (all/most of
which you've ignored) that there's specific things that are
categorically broken in this series, and clearly not working as you
intend them to work. And you're simply ignoring those reports.

One of those is that your topic here changes CI in in a way that you
clearly didn't intend, and which is an emergent unintended effect of how
you're approaching this scalar integration.

I.e. the compile-only CI targets now doing tests as a result, which is
broken, and the combination of that and my CI topic revealed that
breakage.

Anyway, as noted in [2] I was hoping to leave this whole scalar thing
behind, since I got tired of those reports/suggestions being
ignored. I'm only replying here again because it's clear that you don't
understand some of the things this scalar topic breaks/changes, and the
only reason you wouldn't understand that is because you've been ignoring
specific reports/patches-on top that address those breakages.

1. https://lore.kernel.org/git/211122.86ee78yxts.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211110.86czn8hyis.gmgdl@evledraar.gmail.com/
