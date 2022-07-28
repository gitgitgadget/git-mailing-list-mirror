Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E3CC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 20:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiG1UJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiG1UJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 16:09:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289BF76447
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 13:09:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id oy13so4983924ejb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=gvkrBYHNayIPAViZRwEFGWVUeMSQClgv/ytmz/jdf8Y=;
        b=ha2ycoJBq0OXyXkh3DPWq3t5sRyHPEYvyRUKKixRk6Ckza2Ip47MY/qDL5o67/7LLg
         M03is3dGMP3NGQDsS8u6FhRVQUyIrLKgOc/LXQh3qXs1GSqxP1dS2pvRwlxlAluQ96LH
         v5tb5qHwKwHEzefivmgaMfT5aCgY39JmRDVy17vsGbFgOoeje9PweOGEGj3t/+kqgKEv
         KDuhWXDrp3lmTh1jkf+doMwvSgZPd/zvsWazLo6y6sJZm4Ag5UHDOP1somAL2/Nhpnlu
         bX2ZZS3vgxZqr1d2MvAlJJq9Pg+w5bh27StyRkYjVstAsYMxk7QgEv+XsTM+vEHNC1Ab
         Qqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gvkrBYHNayIPAViZRwEFGWVUeMSQClgv/ytmz/jdf8Y=;
        b=aiph3clGsyWxPmAu7/u7XmFSVxsCGvWh+uGqStr3rmb5IpQXvclFxQzF/qK7NpG+Q7
         dqadH7TD3yx9cfe+cPfAJyvfBV39zDdCBMxV220SCtPjO9SaIReKamzT2z6ST5T5StS4
         /t0veY+By3oIiJfcrKsve1QlR3s6J2+QEB5Bl1shhTT1G4g4Mxu9RxBl/X/XV0TFIGZE
         3eH+KIw1j98mvOOf71q0ojz4XciUSSkyP6XiLNKqKVKAqWnUhbcEwxcBOceske2m75Eq
         jGQ2NMLW2S2razITSz0KQwZ9uzxVI4upr2229YfB7MGq00vQTx2P2rg2AOJQ4WHALzwo
         02iQ==
X-Gm-Message-State: AJIora+Xjc1/tDGxNCalDDdWeU7Dem68DAq988rSXFmIRK+70kHoSNnq
        JA0z+3n3sHUacAAFcpOdvCM=
X-Google-Smtp-Source: AGRyM1uJ7mGbOxADM5EnF9OldDMbWU7CHqGYYzUj6/ApCf3ExXhzmxXPUEyc25mxy10eoc1BkRnK6A==
X-Received: by 2002:a17:907:a40f:b0:72b:64ee:5b2f with SMTP id sg15-20020a170907a40f00b0072b64ee5b2fmr450136ejc.268.1659038985577;
        Thu, 28 Jul 2022 13:09:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c51a000000b0043bba5ed21csm1228007edq.15.2022.07.28.13.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:09:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH9pH-007Ezu-By;
        Thu, 28 Jul 2022 22:09:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v2] t/t0021: convert the rot13-filter.pl script to C
Date:   Thu, 28 Jul 2022 21:50:41 +0200
References: <cover.1658518769.git.matheus.bernardino@usp.br>
        <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
        <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
Message-ID: <220728.86bkt9j8xk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Johannes Schindelin wrote:

> [...]
> I see why this might have been suggested, but it definitely made it more
> challenging for me to review. You see, it is easy to just fly over a patch
> that simply removes the `PERL` prereq, but it is much harder to jump back
> and forth over all of these removals when the `.c` version of the filter
> is added before them and the `.pl` version is removed after them. So I
> find that it was bad advice, but I do not fault you for following it (we
> all want reviews to just be over already and therefore sometimes pander to
> the reviewers, no matter how much or little sense their feedback makes).
> [...]
> To illustrate my point: it was a bit of a challenge to find the adjustment
> of the "smudge write error at" needle in all of that cruft. It would have
> made my life as a reviewer substantially easier had the patch
> series been organized this way (which I assume you had before the feedback
> you received demanded to squash everything in one hot pile):

If you don't think a suggestion of mine makes sense, I'd appreciate it
if you just replied me directly, instead of sending this sort of comment
to someone else. I find your wording here to be somewhere between snarky
and mean-spirited. I didn't demand anything.

If this was the first time this sort of thing has occurred I wouldn't
say anything about it, but this is far from being the first time.

In any case, if you read more than a few words into
https://lore.kernel.org/git/220723.86pmhwquie.gmgdl@evledraar.gmail.com/
you'll see that I suggested splitting the removal of the PERL prereq
into its own change, which I think would address what you're bringing up
here.

What I was mainly commenting on was that this series could avoid
introducing code in-between the v1 1/2 and 2/2 which is only needed
because of that split-up. I.e. the "exec", and needing to quote those
arguments.

Which I stand by, I think it's much easier to just do a "git show
--word-diff" on this than reason about how that "chain-loading" is
working, and whether the inter-series state is buggy. But again, the
concern you about the associated verbosity is easy to mitigate.

On the point of pandering to reviewers I find it really nitpicky to ask
for changes to change some working O(N^2)) code in a test-tool to O(N
log(N)), or to avoid a few allocations here & there.

If it was a new git built-in, then sure, but I think our collective time
is much better spend by just letting that sort of thing slide when it
comes to test-tools, which are almost always going to be operating on
the relatively tiny set of test data we expose them too.

Unless Matheus is keenly interested on optimizing this code, that is.

> [...]
> This does what we want it to do, but it looks as if it was code translated
> from a language that does not care one bit about allocations to a language
> that cares a lot.

FWIW Perl cares a lot about allocations, the sort of code you're
commenting on here doesn't involve allocations in Perl in the general
case, since it "allocates ahead", similar to how we use alloc_nr() and
strbuf_reset() patterns.

What it doesn't care about is free()-ing memory, which is an orthagonal
thing. But that's just an optimization, the general assumptios in that
if your program ever needs X MB of memory it's likely to need at least
that much again, or it'll exit() and have the OS clean it up.



