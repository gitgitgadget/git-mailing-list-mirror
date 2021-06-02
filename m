Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6BBC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363B6613B4
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 09:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFBJbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBJbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 05:31:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080DDC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 02:29:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ce15so2855284ejb.4
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=t4TCWXLAW+74/9Tt6OyvzH3wib3s3nARqNpxPseGgJc=;
        b=QU0v3ha8XrN+SHTKKxEesX2B1Nd4pscyxKt89PdrjXVSeFSMlr0KhAYk/PddQAqD6J
         V2en3wGcW45S9Gv7e/OZzRG8wLFYxUSYybn/chis0xJXOg5EBvEnfpvQexsBu02M9KZf
         qFG35hoEP702OEx82PL7EHcUnTF/Zu8dcOfNkOPjUHj95Hn0T6M6Jm1PKoSF9+yZ9M2D
         WUej7bemMBkRmCyMMbBgXJ1rTqiaSZ6URNzY88bDjOU9i5kFb87cly+0dtwQlTXYnyMT
         x2ovjw2MiGlpbtRybI0QqedS7C+01l7a7cplbd+HoYBrlQteEW4zknS7ztOTOs6fqg4f
         br0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=t4TCWXLAW+74/9Tt6OyvzH3wib3s3nARqNpxPseGgJc=;
        b=p9Wr8tZDZYuMjKbpV9dgYSyOhRSer6WNp9nbGcIGN3j9F34ODzk+/TkOwx+oHpoBwj
         hrmYmYJr6wew3A/w6yCdodLBVAJ6DxZ8v2l4cHsCI2ujSTtTc35efyCj9lrdsqOmQzy/
         3OVnnDhMCxTXdqaAU/AYDp7YIludyZP/W5XQ0qBWqwNDLIJVznjhGHGoB2RRIoXOvp+W
         11fv29iviwUgPFjRNuXiFT/6r2YpvCj5dwS6uLaPDoj+Cv61yhNBymAOS3SJl9tBzQNr
         lPEYzIUVwa05Uc1u2sTGqH1YMT2f5BL/XPSiKjkeY/37VsupT7JKNpzvHBCA0UM5INzm
         MlLw==
X-Gm-Message-State: AOAM531r/VduMf2M7ATKZM0nEkB7kQMZT6i3vaMD0Ho9Erl05YOYv+Dx
        J0t6F4+86QW0vOovoosSWDqpTbhmC+g=
X-Google-Smtp-Source: ABdhPJxBfws2TGtYbeHy5SLTON5FB8GcnuV0VsXMm0EJtg4tBDc5fPeB49kGyxhIY+8LSOQM4Dc8Fw==
X-Received: by 2002:a17:906:4d04:: with SMTP id r4mr14838471eju.76.1622626157842;
        Wed, 02 Jun 2021 02:29:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nc26sm2594693ejc.106.2021.06.02.02.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:29:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Date:   Wed, 02 Jun 2021 09:56:02 +0200
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLZ5H2Muh39Q4M5T@google.com>
Message-ID: <87y2bs7gyc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Emily Shaffer wrote:

> On Fri, May 28, 2021 at 02:11:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> After suggesting[1] an another round that the config-based-hook
>> topic[2] should take a more incremental approach to reach its end goal
>> I thought I'd try hacking that up.
>>=20
>> So this is a proposed restart of that topic which if the consensus
>> favors it should replace it, and the config-based hooks topic should
>> be rebased on top of this.
>
> I'm not entirely sure what you're trying to achieve by sending this
> series.

I'm trying to convince you and others that an approach where we split up
the refactoring part of your large series from the behavior changes +
new behaviors it introduces is a better approach in getting us to your
currently proposed (or some small variation thereof) desired end-state.

I think the opening line of your reply doesn't bode for the "convince
you" part of that, maybe I'll do better on the "and others" front :)

I'm a bit surprised at what seems to be some hostility or annoyance that
I submitted this as a set of patches. That's ultimately something that
saves everyone involved time (well, except me by coming up with said
patches). To borrow some words:

    "Talk is cheap. Show me the code." =E2=80=95 Linus Torvalds.

If I give you feedback suggesting that maybe we should reorganize this
thing to split out refactorings from behavior changes I'm asking you to
do extra work. Ultimately neither I, you nor anyone else can really know
if such a proposed effort is going to be better until it happens.

When you get feedback in the form of restructured patches we skip past
all that. We know it compiles, passes tests, and we can more concretely
evaluate the proposal with diff, range-diff etc.

> It was my impression that the existing config-based-hooks topic
> was close to being ready to submit anyway (since Junio mentioned
> submitting it a couple revisions ago); rather than churning by reviewing
> a different 31-patch topic, and then re-rolling and re-reviewing a
> (reduced) config hook topic, wouldn't it be easier on everyone's time to
> do a final incremental review on the existing topic and then start in on
> bugfixes/feature patches afterwards?

I think it's fair to say that nobody's read your code in its current
state more thoroughly than I have at this point, but still, going back
to it and paging through it even now a couple of days after reading the
whole thing line-by-line I find myself getting lost again.

That's because the whole structure of it is to conflate changing
existing behavior with the introduction of new behavior. This makes
things *much harder* for reviewers, because they need to be on toes
about regressions *and* evaluating the function/viability/sanity of new
proposed semantics.

I very much would like to see some approximation (sans my outstanding
comments, more on that below) of your topic land sooner than later.

I think this approach gets us there faster, not slower. How long it
takes to review something isn't about the number of patches, it can be
harder to review a 10 patch series than a 100 patch series. It's mainly
about structuring things in such a way as to make it readable to other
people.

If you've followed any of my own topics you'll probably correctly form
the opinion that that the last few paragraphs at best amount to throwing
some rather large pebbles from a glass house, which you'd be right about
:)

It's can be really hard to see how/where to split things when you're the
author of the code. It's really hard in the "theory of mind" sense of
things to explain an idea to someone who doesn't have the information
you have.

Still, I do think there's a near-universal rules of thumb that the
structure of your series thoroughly runs afoul of, i.e. changing
existing behavior at the same time as introducing new behavior. We
should split such changes up whenever possible. This alternate approach
shows that's it's possible.

> their would have been nice to see a more clear discussion of patch
> organization sometime much sooner in the past year and a half since the
> project was proposed[3], like maybe in the few iterations of the design
> doc which included a rollout plan in July of last year[4]. To me, it
> seems late to be overhauling the direction like this, especially after I
> asked for opinions and approval on the direction before I started work
> in earnest.

We've had some version of this series going back to at least May last
year, and none of it has landed on "master" or "next" yet. To me that's
more reason, not less, for it benefiting from a more incremental
approach.

But yes, I also wish I'd submitted this much earlier. Sorry I didn't
have time to review in this detail until now. I think Felipe's
downthread "never too late" comments apply here though[=C3=86.1]

I've had outstanding significant feedback on the
"function/viability/sanity of new proposed semantics" part of this
almost 3 months ago that you still haven't addressed in any way[=C3=86.2]
except this comment[=C3=86.3] around a month ago on v8 (which I took to mean
that you would). So the lateness of us discussing this is at least
partially a two-way street.

There was also the "why do we need strbuf here?" feedback[=C3=86.4] around =
the
same time from me, and as shown in the diff between our two versions
things like your run_hooks_opt_init_async() being better done as a
"struct ... =3D *_INIT" idiom.

Small issues, but especially the latter to me suggests that your v9 is
too big a chunk for reviewers to consider. I daresay if this was a
smaller series there's no way that wouldn't have been pointed out
already, ditto your "git hook run" introducing an "--env" which never
gets used etc.

> Anyway, I'd personally rather spend effort getting the existing series
> the last few yards to the finish line than to head most of the way back
> to the start.

I think I've made a good argument above for why this takes you a step
forward, not backwards, I'm hoping despite this initial reply that
you'll come to agree on that.

In any case, writing code is hard, but splitting it up like I've done
here is rather easily done. It took me about a day with waiting for
"rebase -i --exec=3D'make test'" equivalent, and that's from being mostly
unfamiliar with the code in question beforehand.

If this alternate series were to go in ahead of yours that doesn't land
you back on square one, you still have a version you could relatively
easily rebase on top. The patches here are mostly smaller versions (no
hook config changes) of corresponding patches of yours.

If anything I don't see how it doesn't make things much easier for you,
if you do get around to replying to my outstanding feedback in [=C3=86.1]
that'll involve rebasing/commit message rewording of patches that now
conflate significant refactoring and behavior changes.

You'll instead cleanly have just the behavior changes, which at that
point will be both easier to justify in a briefer commit message, and
easier for others to review.

>> 1. https://lore.kernel.org/git/87lf80l1m6.fsf@evledraar.gmail.com/
>> 2. https://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@goog=
le.com/
> 3. https://lore.kernel.org/git/20191116011125.GG22855@google.com/
> 4. https://lore.kernel.org/git/20200728222455.3023400-1-emilyshaffer@goog=
le.com/

=C3=86.1. https://lore.kernel.org/git/60b71788c0e6d_67d0208d4@natae.notmuch/
=C3=86.2. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
=C3=86.3. https://lore.kernel.org/git/YJBdbi50Hz+ekOtt@google.com/
=C3=86.4. https://lore.kernel.org/git/87pn04g0r1.fsf@evledraar.gmail.com/
