Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F94BC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A2561164
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFGSDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:03:17 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38859 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGSDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:03:16 -0400
Received: by mail-ot1-f43.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so4005425otk.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FXyHDOyJE79LFZn6b19wM5+VD07Dpa6hISW4ci9o5Wg=;
        b=Ajj/zV97swfNMcpgeQ6nottZElcdpxQqnqU1+StRIkYSdIw1h4v2CqE6QrnwwRAfrn
         ydEkmOk+0X4kJgvLuJxz/K5j5lt09d+tDWmzMCtq8BduIvGNQJDkRUMl6RoWzD8gvyJg
         ngj4D6KaiFJJ38F2SDgVBDTPx8AU0aWqH2DeLj4h9mX5m/0NoyBsJVPs+ByBMaATpz+M
         h6c7UVBnh2DEndZk9BzA5Mkt0/MF84JN/EKIp6LAzuvfjvjCqCy5qTGpzxDdR5eHtrXZ
         128KTsQXQDwjty3802pfrhOQsDzinItnfMQHumyuJu9rtFWwVixl294Jlu+ly0STC2eW
         7wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FXyHDOyJE79LFZn6b19wM5+VD07Dpa6hISW4ci9o5Wg=;
        b=FRHbCqldoa2vAp9NR5pfFOtzWiiREo8qnBJ4VQGQiiJy0ypWMl6mK8Sdcz9qs013ID
         2Zh/jQFkBQnGhwq/XAvhCme3+sA8Si03628rwElcHFHkNDP+KE1ZbuHLavxbvShJD4sm
         Ce5tibw8cQ2XjWsNeeCTkEwZdhkhO4BXf1aKlYAg75Kh9WRgsl23YU3Na4B2uN+vrNEF
         sQUYxzMV2qs+jL7Z6obRUqXkr0fQxgkIgXAh46dghWkt2az0H9+gtoIxx9TX1/8bp1fB
         0yJhevq8TCuTMPGMwEBC9vMLV3UOdhMut5qogzREHJuu4nw9vviHQSY5EiMq2BLt9193
         RZ2g==
X-Gm-Message-State: AOAM533NGTP0Cv3ogJUQjV5SyINnPvtWHU+c5Vc5jBf3SmOgj9Pwuo83
        dVzIxkccvDdXWcwcYV748JE=
X-Google-Smtp-Source: ABdhPJxWv3kuqQWgwlRoszckmN0z1+Rl+STZ7w6azG7qNgEn5RF/Sck691vQutjQuoHK+eCoPAEFKg==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr5148756oto.89.1623088824642;
        Mon, 07 Jun 2021 11:00:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k18sm2636091otj.42.2021.06.07.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:00:24 -0700 (PDT)
Date:   Mon, 07 Jun 2021 13:00:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60be5eb6923de_39c0a20817@natae.notmuch>
In-Reply-To: <87h7i94ola.fsf@evledraar.gmail.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <60be3b2d6e1e6_39c0a20883@natae.notmuch>
 <87h7i94ola.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jun 07 2021, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> >> Disambiguating that is one of the reasons we prefix with the remote
> >> name, but I'd say it makes for a confusing example in a commit messa=
ge,
> >> and also if instead of saying:
> >> =

> >>     branch: make -v useful
> >> =

> >> It said e.g.:
> >> =

> >>     branch: reverse the priority of what -v and -vv show
> >
> > I guess that depends on what you consider this patch is doing, why, a=
nd how.
> >
> > But I have no problem with your version.
> >
> >> Or something similar to note that it's not "useful" now, but an
> >> opinionated change about what we should show on verbosity level 1 an=
d 2.
> >
> > I'm not sure I parsed that correctly, but that's the whole point:
> > verbosity level 1 is not very useful (I'd argue not useful at all).
> =

> Maybe, anyway I meant to suggest saying something approaching "reverse
> the order of the data we consider important" instead of the equivalent
> of "make the data useful".

All right, that transmits the message I want to transmit and is less
abrasive, so that's good.

I've updated the title, and in fact changed the whole commit message.

> >> Whereas you are presumably tracking origin/master for some, building=
 on
> >> your own topic (or other people's topics) for another etc., I think =
that
> >> workflow is much rarer outside of linux.git and git.git, and even fo=
r
> >> those most people usually track origin/master with most of their top=
ics.
> >
> > That's an unsupported assumption.
> >
> > As I showed above, most pople track the branch they push to, not
> > origin/master.
> >
> > Google "git branch -v", and you will find mostly official documentati=
on
> > and man pages.
> >
> > Google "git branch -vv", and you will find mostly blog posts, Stack
> > Overflow questions, and cheat sheets.
> >
> > I think the reason why is obvious.
> =

> Yes, I stand corrected.
> =

> For what it's worth I think one thing to salvage from my ill-informed
> rambling is that I was under that impression because I set
> push.default=3Dupstream.
> =

> But yes, with "simple" being the default and refusing to have
> avar/my-topic have an upstream of origin/master my setup is probably no=
t
> the common case.

This is one of the reasons I force myself to have a .gitconfig as clean
as possible; to try to emulate as much as possible the experience of the
typical git user.

Having used push.default=3Dsimple for many years now, I find it very
suboptimal. Basically I can't trust git to do the right thing, and I
always specify what to push.

I suspect this is what most users do (unless they have setup upstream
like `git push -u`).

For what it's worth, when there's a difference of opinion in the mailing
list sometimes I create polls in reddit to see what the users think, and
I did for this one:

https://www.reddit.com/r/git/comments/nuf3p5/where_do_you_point_your_upst=
ream_branch_to/

At the moment 13 people say they use origin/master, 11 repo/branch, and
11 say they it's the same thing in their case (e.g. origin/dev).
8 people don't know what an upstream branch is.

> I wonder if this should depend on the setting of push.default, or
> whether we can infer anything at all from that setting. After all you
> can set it to whatever and then either manually do "git push <remote>
> <src>:<dst>" (my usual worklow is just "git push origin HEAD"), or
> manually do the "git rebase origin/master" or whatever in the case wher=
e
> your upstream is your own topic branch.

I do have a much better solution that makes everything work for all
configurations, but the patches are not ready yet, and I'm certain will
receive pushback, just like the last time I sent it.

This is the first patch, which I don't think has anything to do with
the rest of the patches, and can very well stand on its own.

Cheers.

-- =

Felipe Contreras=
