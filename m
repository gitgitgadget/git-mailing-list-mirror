Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E728AC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 19:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FE261164
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFTTwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFTTwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 15:52:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C4C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 12:49:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hz1so2527142ejc.1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mfTrp7rLoR7aFrHepWFWPbS10wOqpZs9dU77mhiveXY=;
        b=aHLiJTtBZCVHBST7jMsXdPp0/da3VVzY6m1T5Vu7d3ugBDqcbqknQXrFFkNI/RcyVs
         QDWcEt3pmgnZLCtyowvKI2WtjnHqEnEMt2DYu0ayL4EgwvlizNoTMAn5lRF8NJUIpxtc
         fau/t0IfkGR7b042Xty7WBlDmeUx7QL5AXLjI02y4B/EohG7gegd53wCxKiz/koNsuda
         Jk4ArfUyeWZPitLBbNpRBMit6Q9AmpB0ykZ+zATP0fgQd5xhRtvkrH7+YnNIVgIHaDcJ
         8TTzqi3KZChCew63OO8LhfWqmgNKwgjHEA9rTmGplyzFoJa/Ngx3LXoRpoNfVn3qF4QU
         vW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mfTrp7rLoR7aFrHepWFWPbS10wOqpZs9dU77mhiveXY=;
        b=FEfKjcICi1lIuRGc4HHejj6ElB2Kcvk8onOm/73ehyQjb3ukUEpwC/B7uGr8dPGtbB
         nu1ke1zMzSgWVWEko3QQi1Bf1lYEo4CKyloFEtyiNk4TXy7FRcz6DmLn5Hq18QeTrVHc
         nb4PiqBJIU1j/K/X+A2xEQaIVI9nJEbF/h5Qf/XbKC9fUSNToWYG4KUsSzKDYyFlPiGh
         lpFCU3pZWghJW2DjSf7EKvWtod1bK7DbvHd/kfKO+O8uRyMUInC/dRVsni201h9WWR48
         1ibyguvlafSJW8sQtXW3kYHxzFk+ECfroTKSR0xvoMVvi9//MM3ipXpRnn3CdPcg0NEi
         oSFQ==
X-Gm-Message-State: AOAM531xElseKmHfLgk+qm3oX3mvh4Wai9h122l5MxI/IfAi5Zz7U2yo
        Bsc6OBbde8MU1lyB9x2ZWG6G1pegRm4=
X-Google-Smtp-Source: ABdhPJxUnzuNjUIZXW6iOU3fyzuT2iV4SdDanz0YDPgwKbQF4PaD+K/SRLcCYOQKVP7hjlpcvPzRKQ==
X-Received: by 2002:a17:906:8c1:: with SMTP id o1mr20527131eje.530.1624218598194;
        Sun, 20 Jun 2021 12:49:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n13sm3860673ejk.97.2021.06.20.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 12:49:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Date:   Sun, 20 Jun 2021 21:30:59 +0200
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
        <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
        <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
        <YMfLO9CT+iIDR3OA@google.com> <87lf7bzbrk.fsf@evledraar.gmail.com>
        <YM0alLP5U81D+ZI0@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YM0alLP5U81D+ZI0@google.com>
Message-ID: <87im2848pn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 18 2021, Emily Shaffer wrote:

> On Tue, Jun 15, 2021 at 11:36:26AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > Overall, I think I like the direction your reroll is going - I've need=
ed
>> > some time to process it. Hopefully I'll be able to get through all or
>> > most of the series this week, but there's a lot going on here, too. I'=
ll
>> > do what I can. Thanks for the help.
>>=20
>> Yeah, will reply to any qusetions etc; and as noted above my initial
>> goal here was "hey, what about this approach", so if you wanted to pick
>> this up & run with it...
>>=20
>> This particular version of the series is at github.com/avar/git.git's
>> es-avar/config-based-hooks-3 b.t.w.
>
> Have finished scanning through the rest of the series, and I think I
> understand your goal a little better - you are not saying "let me take
> over and drive this part of the feature set", which is what I thought
> initially. Instead, you seem to be saying "let's chop it up this way
> instead".

Yes, 30-some patches that both refactor and introduce new behavior are
harder to reason about.

I've also had suggestions about the end-state, but I think whatever we
arrive at doing the scaffolding first without behavior changes makes
sense.

> I don't dislike the reorganization, but I do still wonder whether it's
> a setback to the progress the original series had made. I guess it is
> hard to know - I had thought the original series was pretty much ready
> to go in, therefore making "what if we ordered it this way" moot. But it
> seems that you disagree.

I'm still not sure if I disagree, well, I'm 95% sure I disagree with
some of the end-state, but you never replied to my questions about that:
https://lore.kernel.org/git/87mtv8fww3.fsf@evledaraar.gmail.com/ &
https://lore.kernel.org/git/87lf80l1m6.fsf@evledraar.gmail.com/; So I
don't know for sure, maybe there's things I missed there.

I think since Junio picked up the "base" version of this and it looks
like we're going that way first that's not something we need to discuss
now if you'd like to punt it, but I'd really like to get that cleared up
post-base topic.

In brief summary:

I'm 100% with you on hooks being driven by config, that they aren't is
in hindsight a historical wart. Ditto the parallel execution etc. (which
I'd suggested in an earlier iteration). That's all great.

Where you lose me is the need for having "git hook" be an administrative
interface for it, particularly (as noted in the linked E-Mail) since the
need for that over simply using "git config", or a trivial "git config"
wrapper seems to be fallout from other arbitrary design choices.

I.e. that all the config for a hook needing to be discovered by a
two-pass iteration over the config space (or keeping state), as opposed
to a "hookcfg.<name>.*" (or whatever) prefix.

Maybe that makes sense in the eventual end-state, your series has the
equivalent of "WIP, more will be added later" around that "git hook"
command; but not having the full overview of that I think we can make
simpler inroads into getting us all of the practical featureset we want,
without regretting our choices in command & config interfaces later.

> Anyway, I do hear also that you don't have interest in driving this
> subset to completion, and that's fine. Correct me if I'm wrong.

I submitted a v3 of this (which I forgot to label as such in the
subject) at
https://lore.kernel.org/git/cover-00.27-0000000000-20210617T101216Z-avarab@=
gmail.com/;
given the timing our E-Mails may have crossed.

But no, I will drive this subset to completion. What I meant with the
"run with it" comment and the earlier reply on v1 of my "base" version
here: https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/

... is that I'd be happier if I managed to just convince you that the
more piecemeal approach is better, and something you'd want to pick up &
drive going forward.

I.e. it's still >95% your code, just re-arranged and split into subsets
of your patches. I really did not mean to "steal" it, it's just
something I hacked up one day to see if the more incremental approach
I'd been suggesting (and felt you were either ignoring or were too busy
to address) was something that could work.
