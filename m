Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B7CC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 15:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbiFCPZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 11:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245481AbiFCPZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 11:25:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786C38BEC
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 08:25:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30c1b401711so86068087b3.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HBb7MpZuOLCFqhYN8DF8C+NMbrGbwkBBHivIk9WbhQM=;
        b=K1h5wvdnSBWnP8XWmKqYtA/sVWYknCMImPHfbeq4bn4d7gPxz4H6Ewv2GuPH4p8OTF
         O8jbRjQ8/YWp9Mp+bd8D7WHjWVIGUvMPhceEyRtjo758swGRTUMnx/FAF1604obP5Dc/
         TFwF9utpWN0RyTUu7IJW7DLzHx6Nzn0xFygfVwgna1B8SJHZVdfPr6EPTNjInaHE1K5A
         5QnIzt2PCWGDScQEI7V477PfDXaPo0pqsAp5GGsi2r/tvDonD8xhJjc0HvEqu6IcANVG
         q2ZGmzjXvb3CP9w24nVJDcCsoJ49+yODui6w0ieYzmQcpnSdIuc90U5S9Nehw2lEgLgU
         cY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HBb7MpZuOLCFqhYN8DF8C+NMbrGbwkBBHivIk9WbhQM=;
        b=EEuU3BgSLXnjvMW5DaMOmEj2aBcqhVUXbHMSGguqRLcOUq8hxdzhPSCv+hFCQhuLm2
         Gnrov+7m9hcGackEatQlqTKpPcpPaIxtDyjRYI8WdFplNe+gn71UUtliL8uSiiMMZ06K
         wWbxhtxjKSy0NYUKl3wgwlyZ8y5pftnZYqDNfPa/Ck/VOWZ4wD+F3LPRvUUTl/F+fuY8
         TyD0x4pZFHhiYTGBUImIJ2A/GT8mntrUSxKyTh8bXpQoFzaXSNrgufekZijA7jiPSvRE
         ZaL7XvJB1dde0MW2BjjvA+J25FwIDtTyRiK/99zGLFDQwHvfZibxh+9SkkzvhPNMhStG
         Owkg==
X-Gm-Message-State: AOAM530iGY4YMTvlwXvqPVA000YvTNADDKwhPSLnCyzHzTTfk2OubChr
        CWtiASsBAE2Ry+UA61dDKK6Xr3bKT7E8dVqcGHeSmw==
X-Google-Smtp-Source: ABdhPJzcJCcGbt61Aey0SJbEK0TwpIcTEASThPwG8Aq+IVrlosDeTQPOLqHMCIhXurichxPoFYwI0QOpf1u8Q4avYpY=
X-Received: by 2002:a81:558c:0:b0:30f:bbf2:b19c with SMTP id
 j134-20020a81558c000000b0030fbbf2b19cmr12152103ywb.291.1654269935780; Fri, 03
 Jun 2022 08:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid> <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email> <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <20220530115339.3torgv5c2zw75okg@carbon> <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
 <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
In-Reply-To: <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 3 Jun 2022 08:25:24 -0700
Message-ID: <CAJoAoZmPOOp41KF=V4EhUopu+P8=UW55bkUJm6ZYiKziprtWug@mail.gmail.com>
Subject: Re: About GIT Internals
To:     Aman <amanmatreja@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Konstantin Khomoutov <kostix@bswap.ru>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 3, 2022 at 5:21 AM Aman <amanmatreja@gmail.com> wrote:
>
> Hello everyone. I sent out an email here last week, asking for a list
> of resources, so I could better understand the workings and design of
> git. I really appreciate everyone, who gave the links and their
> advice.
>
> I have been reading about GIT for some time now, and have looked at
> almost all of the resources plus some others. I think I could say, I
> now have a decent conceptual understanding of how GIT  works
> internally.
>
> (Also, I understood the chapter about git I read in the book I am
> reading, Architecture of Open Source Applications: Volume 2, which I
> didn't understand at all, the reason I started this thread). Although
> there must definitely be a lot of details and subtle things I may not
> understand yet (like branches are nothing but pointers to commits,
> wow! btw)
>
> Now, continuing this discussion, and talking about the implementation
> and engineering side of things, I wanted to ask another question and
> hence wanted some advice.
>
> Though I may understand the internal design and high-level
> implementation of GIT, I really want to know how it's implemented and
> was made, which means reading the SOURCE CODE.
>
> 1. I don't know how absurd of a quest this is, please enlighten me.

It's a lot :) But I don't think that should discourage you.

> 2. How do I do it? Where do I start? It's such a BIG repository - and
> I am not guessing it's going to be easy.

I would start actually with "Documentation/MyFirstContribution.txt"
and "Documentation/MyFirstRevisionWalk.txt" - but I am biased towards
those documents. ;) The other subtle hint I would give is that the
entry point for almost every command is at a function called
"cmd_cmdname()", so for example "git status" is at "cmd_status()",
usually somewhere in 'builtin/'.

> 3. Would someone advise, perhaps, to have a look at an older version
> of the source code? rather than the latest one, for some reason.

Some other piece of the developer documentation (maybe
"SubmittingPatches"?) suggests that you start from the initial commit
and understand that part first. I personally don't find this exercise
very useful anymore as Git has grown quite a lot since then (and is
even primarily in a different language, although we still have some
bash scripts here and there).

> Again, I would really appreciate it if someone could give their
> thoughts on this.

In your journeys, also watch out for some libraries in common, like
calls from "run-command.h" or "parse-opt.h", to help you understand
how we make stuff work more or less consistently across the codebase,
or libraries like "strbuf.h" and "string-list.h" to understand some of
the things that we do to make working with C a little less fraught.

>
> Thank you,
>
> Regards,
> Aman
>
>
> On Mon, May 30, 2022 at 7:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > On Mon, May 30 2022, Konstantin Khomoutov wrote:
> >
> > > On Mon, May 30, 2022 at 09:49:57AM +0000, Kerry, Richard wrote:
> > >
> > > [...]
> > >> > > 1. I haven't had the experience of working with other (perhaps e=
ven
> > >> > > older) version control systems, like subversion. So when referin=
g to
> > >> > > the "control" aspect,
> > >> >
> > >> > The "control" aspect was from whoever was the 'manager' that limit=
ed
> > >> > access to the version system (i.e. acting like a museum curator), =
and deciding
> > >> > if your masterpiece was worthy of inclusion as a significant examp=
le of your
> > >> > craft, whether that was an engineering drawing or some software co=
de.
> > >>
> > >> I'm not sure I get that idea.  I worked using server-based Version C=
ontrol
> > >> systems from the mid 80s until about 5 years ago when the team moved=
 from
> > >> Subversion to Git.  There was never a "curator" who controlled what =
went
> > >> into VC.  You did your work, developed files, and committed when you=
 thought
> > >> it necessary.  When a build was to be done there would then be some
> > >> consideration of what from VC would go into the build. That is all s=
till
> > >> there nowadays using a distributed system (ie Git).  Those doing Ope=
n source
> > >> work might operate a bit differently, as there is of necessity distr=
ibution
> > >> of control of what gets into a release. But those of us who are deve=
loping
> > >> proprietary software are still going through the same sort of releas=
e
> > >> process.  And that's even if there isn't actually a separate person =
actively
> > >> manipulating the contents of a release, it's just up to you to do wh=
at's
> > >> necessary (actually there are others involved in dividing what will =
be in,
> > >> but in our case they don't actively manipulate a repository).
> > >
> > > I think, the "inversion of control" brought in by DVCS-es about a bit
> > > differet set of things.
> >
> > Re the "I'm not sure I get that idea" from Richard I think his point
> > stands that some of the stories we carry around about the VCS v.s. DVCS
> > in free/open source software was more particular to how things were don=
e
> > in those online communities, and not really about the implicit
> > constraints of centralized VCS per-se.
> >
> > Partly those two mix: It was quite common for free software projects no=
t
> > to have any public VCS (usually CVS) access at all, some did, but it wa=
s
> > quite a hassle to set up, and not part of your "normal" workflow (as
> > opposed setting up a hoster git repository, which everyone uses) that
> > many just didn't do it.
> >
> > > I would say it is connected to F/OSS and the way most projects have b=
een
> > > hosted before the DVCS-es over: usually each project had a single rep=
ository
> > > (say, on Sourceforge or elsewhere), and it was "truly central" in the=
 sense
> > > that if anyone were to decide to work on that project, they would nee=
d to
> > > contact whoever were in charge of that project and ask them to set up
> > > permissions allowing commits - may be not to "the trunk", but anyway =
the
> > > commit access was required because in centralized VCS commits are mad=
e on the
> > > server side.
> >
> > We may have tried this in different eras, but from what I recall it was
> > a crapshoot whether there was any public VCS access at all. Some
> > projects were quite good about it, and sourceforge managed to push that
> > to more of them early on by making anonymous CVS access something you
> > could get by default.
> >
> > But a lot of projects simply didn't have it at all, you'll still find
> > some of them today, i.e. various bits of "infrastructure" code that the
> > maintainers are (presumably) still manually managing with zip snapshots
> > and manually applied patches.
> >
> > > (Of course, there were projects where you could mail your patchset to=
 a
> > > maintainer, but maintaining such patchset was not convenient: you wou=
ld either
> > > need to host your own fully private VCS or use a tool like Quilt [1].
> > > Also note that certain high-profile projects such as Linux and Git us=
e mailing
> > > lists for submission and review of patch series; this workflow coexis=
ts with
> > > the concept of DVCS just fine.)
> >
> > I'd add though that this isn't really "co-existing" with DVSC so much a=
s
> > using patches on a ML as an indirect transport protocol for "git push".
> >
> > I.e. if you contributed to some similar projects "back in the day" you
> > could expect to effectively send your patche into a black-hole until th=
e
> > next release, the maintainer would apply them locally, you wouldn't be
> > able to pull them back down via the DVCS.
> >
> > Perhaps there would be development releases, but those could be weeks o=
r
> > even months apart, and a "real" release might be once every 1-2 years.
> >
> > Whereas both Junio and Linus (and other linux maintainers) publish thei=
r
> > version of the patches they do integrate fairly quickly.
> >
> > > [...] it also has possible
> > > downsides; one of a more visible is that when an original project bec=
omes
> > > dormant for some reason, its users might have hard time understanding=
 which
> > > one of competing forks to switch to, and there are cases when multipl=
e
> > > competing forks implement different features and bugfixes, in paralle=
l.
> > > One of the guys behind Subversion expressed his concerns about this b=
ack then
> > > wgen Git was in its relative infancy [2].
> > >
> > >  1. https://en.wikipedia.org/wiki/Quilt_(software)
> > >  2. http://blog.red-bean.com/sussman/?p=3D20
> >
> > It's interesting that this aspect of what proponents of centralized VCS
> > were fearful of when it came to DVCS turned out to be the exact
> > opposite:
> >
> >     Notice what this user is now able to do: he wants to to crawl off
> >     into a cave, work for weeks on a complex feature by himself, then
> >     present it as a polished result to the main codebase. And this is
> >     exactly the sort of behavior that I think is bad for open source
> >     communities.
> >
> > I.e. lowering the cost to publish early and often has had the effect
> > that people are less likely to "crawl off into a cave" and work on
> > something for a long time without syncing up with other parallel
> > development.
