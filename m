Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB36C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 09:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiEXJOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiEXJOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 05:14:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A18E182
        for <git@vger.kernel.org>; Tue, 24 May 2022 02:14:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n23so22297298edy.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LJStFzpMZDO9T5yvRFLO/jTT84ivQYv1GYJX6W/SIAA=;
        b=LawYbxHPN+Lae8qa6547qqoSr/grAvXlCcZ65osiZ6EB0UcpED7FlsMaKm5KAyODYI
         2Q9BdTWS4Fnvhh4dKdH/aKCtnptHyYgpZAh14sAJiGYvFUnxLbdhPg31C/NKLH2zV4M1
         bROnp7jFWqCG7Df7jrnjYqnwl+KQMxRpRipW/iB1m6iTD8JhN/+Tu837OHIqSfY+Dn0Y
         sE2s/bsuaYUveFmJP69mh+S2keizZNDputp0DdXCZN3S/2TpffipIjZBJ3Tj7JSCFVSy
         3fCoBHrKJWYsBlWbAjHuNDfd1IzbiXgmOFVX46xXgX+Ed8j89DLfuzplckb2XvKMapPq
         wVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LJStFzpMZDO9T5yvRFLO/jTT84ivQYv1GYJX6W/SIAA=;
        b=hrdgHKKMLUFilNTowvIxWC4gVA5oLkn+rcU8el8B4D82KwZm7s255wZuj9YU/U+s6p
         jBuA/OKgUsFf/R3xbHGwMfcaTzTs0+ihQgrvB71Sg9tPnPQ7VRp8vNP4QU3+rqWBvyPj
         9BB5tT3eNdjlXdwtTT0zUdcgC9OhrctpPtnr+aubzdsA7wSwXPgU6HdHjR7wBvwMvgfZ
         Vn656Upij7q9RJ8sCh9hg/TgZoPtmTeIgn4OT8s+J+7K6ONXG5eCmuiZOdOWl46oxyxV
         ggc2ZRtd/VLy7jlvfykjfYf9EBxk3JL+s8PgD6O9PBh9q8hvQvMBhGuEGYJeaxJmFApa
         mgOQ==
X-Gm-Message-State: AOAM531vrFu6gT4CHd5p6fcbryi3tBsiKH4E0hVOnne4dLNTUYXkieFB
        R+cCjkGHaEUUIA+Vz25aBzc=
X-Google-Smtp-Source: ABdhPJz0J58S8EqDzpRXvK46SxIPRldRwrG5PmHoGge8p+OGns+qHziS2oKCn8qPXGpcqtjwNFt5kQ==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr28049325eda.121.1653383648290;
        Tue, 24 May 2022 02:14:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b006febce7081bsm3505550ejr.163.2022.05.24.02.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 02:14:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntQcB-003BGS-4q;
        Tue, 24 May 2022 11:14:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Tue, 24 May 2022 10:40:43 +0200
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
        <xmqq35h2cwrm.fsf@gitster.g>
        <220523.86ee0kzjix.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2205232040130.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205232040130.352@tvgsbejvaqbjf.bet>
Message-ID: <220524.86y1yrwaw0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 23 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Re selling point & feature comparison: The point of the ab/* variant was
>> to re-roll Johannes's onto a "base" topic that made much of his
>> unnecessary, because the building up of features to emit GitHub markup
>> can be replaced by unrolling things like "make" and "make test" to the
>> top-level.
>>
>> That has its own UX benefits, e.g. you can see at a glance what command
>> was run and what the environment was, and "make" and "make test" are now
>> split up from one monolithic "build and test" step.
>>
>> But the primary intention was not to provide a prettier UX, but to show
>> that this arrangement made sense. I was hoping that Johannes would reply
>> with some variant of "ah, I see what you mean, that does make things
>> simpler!" and run with it, but alas...
>
> I believe that we share the goal to make the Git project more welcoming
> and easier to navigate for new contributors.

Yes, definitely.

> The patch series you wanted me to look at claims to make the CI/PR
> definitions/scripts simpler. As it matters more to contributors how to
> investigate test failures, i.e. what information they are provided about
> the failures, I disagree that that patch series needs to be connected to
> my patch series in any way.

Our two set of patches change different parts of the CI UX, so no. The
set of patches I've been proposing isn't just making CI/PR
definitions/scripts simpler, although it also does that.

So e.g. in your patches you need to massage the CI output to split the
"build" step from the "test" step. As you can see in an earlier RFC
re-roll of them on top of my topic that something you'd get for free:
https://lore.kernel.org/git/RFC-cover-v5-00.10-00000000000-20220421T183001Z=
-avarab@gmail.com/

> Further, the result does not look like a simplification to me. For
> example, I consider it an absolute no-go to remove the remnants of Azure
> Pipelines support. As I had hinted, and as you saw on the git-security
> list, I require this support for embargoed releases. That=E2=80=99s what =
I did
> when working on the patches that made it into v2.35.2. In my book,
> removing such vital (if dormant) code is not a simplification, but a
> Chesterton=E2=80=99s Fence. While we do not need to use Azure Pipelines f=
or our
> regular CI, we definitely need it for embargoed releases. =E2=80=9CSimply=
 revert
> it back=E2=80=9D is not an excuse for removing something that should not =
be
> removed in the first place.

Can you please reply to this 3 month old and still-waiting-on-your-reply
E-Mail on this topic so we can figure out a way forward with this:
https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/

> As another example where I have a different concept of what constitutes
> =E2=80=9Csimple=E2=80=9D: In Git for Windows=E2=80=99 fork, we carry a pa=
tch that integrates the
> `git-subtree` tests into the CI builds. This patch touches two places,
> `ci/run-build-and-tests.sh` and `ci/run-test-slice.sh`. These changes
> would be inherited by any CI definition that uses the scripts in `ci/`.
> With the proposed patches, there are four places to patch, and they are
> all limited to the GitHub workflow definition. Since you asked me for my
> assessment: this is de-DRYing the code, making it more cumbersome instead
> of simpler.

No, you'd still have two places to patch:

 1. The top-level Makefile to have "make test" run those subtree tests
    depending on some flag, i.e. the same as your
    ci/run-build-and-tests.sh.

 2. ci/run-test-slice.sh as before (which is only needed for the
 Windows-specific tests).

Because we'd be having the Makefile drive the logic you could also run
such a "make test" locally, which is something we should have
anyway. E.g. when I build my own git I run the subtree tests, and would
like to eventually make "run contrib tests too" some configurable
option.

So it is exactly the DRY principle. By avoiding making things needlessly
CI-specific we can just control this behavior with flags, both in and
outside CI.

> In other words, I have fundamental objections about the approach and about
> tying it to the patches that improve the output of Git=E2=80=99s CI/PR ru=
ns.

I would too if after my series you needed to patch every place we run
"make test" or whatever to run your subtree tests, but as noted above
that's not the case. So hopefully this addresses that.

More generally: I noted a while ago that if you pointed out issues like
that I'd be happy to address them for you.  Based on this I see
d08496f2c40 (ci: run `contrib/subtree` tests in CI builds, 2021-08-05),
and that would be easy to generalize.

>> In Chrome/Firefox the time to load the page (as in the spinner stops,
>> and we "focus" on the right content) is:
>>
>>     JS: ~60s / ~80s
>>     =C3=86: ~25s / ~18s
>
> My focus is on the experience of occasional and new contributors who need
> to investigate test failures in the CI/PR runs. In this thread, we already
> discussed the balance between speed of loading the page on the one hand
> and how well the reader is guided toward the relevant parts on the other
> hand.

First, your re-roll claims thta it "improves the time to load pages",
but based on the sort of testing I'd done before when I reported the
severe slowness introduced by this topic I can't reproduce that.

So how exactly are you testing the performance of these load times, and
can you share the numbers you have for master, your previous iteration
and this re-roll?

> I disagree with you that the former should be prioritized over the
> latter, on the contrary, guiding the readers along a path to success is
> much more important than optimizing for a quick page load.

I think a better UX is certainly worth some cost to load times, so I'm
not trying to be difficult in saying that this costs us some
milliseconds so it's a no-go.

But really, this is making it so slow that it's borderline unusable.

The main way I use this interface is that I'll get an E-Mail with a
failure report, or see the "X" in the UX and click through to the
failure, then see the logs etc, and hopefully be able to see from that
what's wrong, or how I could begin to reproduce it.

Right now that's fast enough that I'll do that all in one browser
click-through session, but if I'm having to wait *more than a minute*
v.s. the current 10-20 seconds (which is already quite bad)?

Your latest series also seems to either be buggy (or trigger some bug in
GitHub Actions?) where even after that minute you'll see almost nothing
on your screen. So a user who doesn't know the UX would end up waiting
much longer than that.

You seemingly need to know that it's done when it shows you that blank
screen, and trigger a re-render by scrolling up or down, which will show
you your actual failures.

That's not an issue I saw in any iteration of this before this v3.

> Most contributors who chimed in seemed to not mind a longer page load time
> anyway, as long as the result would help them identify quickly what causes
> the test failures.

Wasn't much of that discussion a follow-up to your initial demos of this
topic?

I don't think those were as slow as what I'm pointing out above, which I
think is just because those failures happened to involve much fewer
lines of log. The slowness seems to be at correlated with how many lines
we're dealing with in total.

> Besides, the page load times are only likely to become
> better anyway, as GitHub engineers continuously improve Actions.

Sure, and if this were all magically made better by GH engineers these
concerns would be addressed.

But right now that isn't the case, and we don't know if/when that would
happen, so we need to review these proposed changes on the basis of how
they'd change the current GitHub CI UX overall.
