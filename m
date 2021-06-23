Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E172C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C749610F7
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWSWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 14:21:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D7C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:19:42 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d19so4323688oic.7
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=m+mKiHvQuZKxi+W/FPOXfD0o2Ee/QBTFH/IwNPuKTQk=;
        b=E9B+CmaeYwTAPifMrvJ+2kWpbR9GIuPcUqO5z6Z3MJ/9U5k5D9jvT8nwh+btjUqdrj
         Gm/Y8Tm7+VZcmlrJTb6sbTgGdS+6DoEDOC4S0Iy7ytEdJes/QbmRt9hRAMJaJiOhmlQZ
         YVUelMiRs3YaE7xNu5NGKhyzg57Eyhf+DlqQDSEP9RDw9c2MHR5j4rK7TmNG4ZYfizEP
         PI9MOp+zZdkHlziYHgW3Zt0dsMvnKaRT0ZuS/FXyOpvffzTzCTY6RIB0FgO6o6e4kUjT
         pCabF1QL/JleFJWtB++DYucZPdYYpGiLy+dy8BD1/W9MA4jjaSTOH8GGDmb7m8LD5nAC
         VU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=m+mKiHvQuZKxi+W/FPOXfD0o2Ee/QBTFH/IwNPuKTQk=;
        b=tsOtI2IYyOXCzX83uZ94elwz9Wrgx0QD9WIyF9fvBGPGLwGJretjaIdqFSEC9bhLNh
         XhB1thBMk3jeVBUBE1gzp79sLusTOhjy9UH6Fh1n2VkjrdTobkep6Wyny9tMx6vrNsmt
         xD0WYzFy/ljadXmQvFdyKGsq85WWLUXETi8hl34YOOYQhP3zcwjZ4P6Z5wI7cvkz25L7
         hykq1hQTas2yuf1ixHynzh6sdAN+c56wNrLkbgQch0aZ9OUE1A7i7fpsCUw9acQDhgx9
         BdpiTkf/3vrxUlTP+wZ6y9SyCp3gQKRGnK3lgApTgjDYDll4hfSk1mVEH98KEFXarqp/
         +KZg==
X-Gm-Message-State: AOAM532XVmX5nmrSFacR8Rtt7o5doZEPAzVaWFUuQvVN4RnfkTeaLFPq
        VhOOC7UpLz/R1LH/0K1xYMY=
X-Google-Smtp-Source: ABdhPJxENO2+LXUUTx9UcF0iSyAgY/Z55/URt4RZ5Y7IOi116WFJUzvdcDneYLKFFom+Vf9gDURRFA==
X-Received: by 2002:aca:5cc1:: with SMTP id q184mr4243702oib.135.1624472381406;
        Wed, 23 Jun 2021 11:19:41 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y7sm129363oti.80.2021.06.23.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:19:40 -0700 (PDT)
Date:   Wed, 23 Jun 2021 13:19:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <60d37b3b77aeb_378720834@natae.notmuch>
In-Reply-To: <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <60d289c84fadf_312208dc@natae.notmuch>
 <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Jun 22, 2021 at 6:09 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> ...
> > > You're not alone, Alex; I objected to that part as well.  (See e.g.
> > > https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com/
> > > and various other emails in that thread, ending with "agree to
> > > disagree" later).  I still object to it as I did then.
> >
> > You made your disagreement known in [1], I responded to it with a
> > devastating argument in [2], and you immediately withtdrew from the
> > discussion in [3] without engaging my argument at all.
> 
> I didn't find anything new or persuasive in your rehashing of your
> arguments.

The fact that you don't find something persuasive doesn't mean there
wasn't anything persuasive.

Moreover, the argument was completely new.

> I had stated my disagreement twice already, and having us both repeat
> our arguments does no one any good, so I just stated we can agree to
> disagree.

I did not repeat my argument, I made a completely new argument.

> > > I'm curious whether it'll just be resubmitted again multiple times,
> > > eventually with a cover letter that repeats something along the lines
> > > of "these are the non-controversial changes from last-year series
> > > which...don't have any reason not to be merged."
> >
> > The fact that **one** person was not 100% on board with a change doesn't
> > make it controversial.
> 
> This is a disconcerting response.

Why? That's the definition of the word "controversial". In order for X
to be controversial a substantive amount of people need to have opposing
views.

The fact that a few people deny the roundness of the Earth doesn't make
that idea "controversial".

Similarly, the fact that one person disagrees with X doesn't make X
controversial.

> I also find your characterization of the old thread disappointing; I
> clearly cared enough to state my objection in three separate emails,
> so it's more than just "not 100% on board".

I said "change", not "thread".

And, you were on board with 23 out of 24 lines of the patch. So you were
96% on board. That's just a mathematical fact.

> And Junio referred to the analogy in your "devastating argument" as
> "irrelevant", so it's not clear you convinced others either.

Junio is not infallible. The fact that Junio said X was irrelevant
doesn't mean X was irrelevant.

And in this particular case he was wrong, as I explained in [1], because
he equated apples (regulations) to oranges (policy).

To be specific: this is a false equivalence fallacy.

When I pointed out that fallacy he didn't bother to reply [2].

> > You made the conscious choice to withdraw from the discussion
> > immediately, so just like a person who abandons an election cycle and
> > decides not to vote, you are leving the future of the matter in the
> > hands of others.
> 
> This is quite a disappointing argument.  If this position were to be
> accepted broadly within the project, it would suggest scorched-earth
> last-man standing tactics -- just arguing until the other side runs
> out of energy.  If that was used to determine our forward strategy,
> it'd result in a massive waste of energy, people feeling drained and
> losing motivation to contribute, some people just deciding to leave
> the project, and a myriad of other negative outcomes.

This is how progress is achieved in all areas of society, from public
debates, to trials, to elections.

You can't just stand up and leave when the debate is only 25% complete,
and then expect to win it.

Either you care enough see it through, or you don't.

Even in sports, and in video games, completing the match is the bare
minimum to win.

Unlike in a video game, the fact that you left the debate doesn't
necessarily mean you lost, but you definitely did not win it.

> In fact, occurrences of such behavior has already had such outcomes.

That's your opinion, my opinion is the exact opposite.

The reason people have left the project is because even though they
care, and they stay for 100% of the race, if some bigwig who only said
"I disagree" and left having only participated in 10% of the debate, the
debate is over, always in favor of the incumbents.

This is not a fair marketplace of ideas where the best ideas win, it's
not a meritocracy, and discourages anyone who is not already part of the
big club.

> Rehashing the same arguments repeatedly damages the discourse within
> the project as well as the project itself.  There's no point in doing
> so.

All philosophers would disagree with you.

There are some debates that have lasted for millennia and still continue
today. Many arguments for free will are repeated exactly the same, but
some are slightly different, and merit a new look. As long as we don't
solve this debate, it will continue, and everyone that cares sees value
in it.

Similarly, until "git pull" does something sensible by default (which
isn't the case now), these debates will continue, and there's value in
them.

Perhaps if other people didn't stand up and left in the middle of the
debate in 2013 we would have solved the issue back then and we wouldn't
be here.

But here we are yet again, and if people continue ignoring arguments and
leaving the debate before it's even 10% done, we will be here again in
2022, 2024, and probably more.

Especially if they straight-up reject patches that according to
themselves are 96% perfectly fine.

Cheers.

[1] https://lore.kernel.org/git/CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqpn3lbhxn.fsf@gitster.c.googlers.com/

-- 
Felipe Contreras
