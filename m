Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E8C433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 15:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiE3PNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbiE3PMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 11:12:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133A19C758
        for <git@vger.kernel.org>; Mon, 30 May 2022 07:10:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er5so13674911edb.12
        for <git@vger.kernel.org>; Mon, 30 May 2022 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=m8qB24BfqP52I0zgvxNrOLjQFV7+Rq9qYnnfqsIXKss=;
        b=OA2C84HkQwqZuHzCU+1y9F+mEULdG3rls/GJwlYvVlXoCbpV0TqNmPcD6NI/8KrKNu
         oBx/D117gxtpDizPcofx+X00/wjnARDUJ4VuDltUVPkd0xloVVUAnHK7YPovOZ7UKUvA
         ZAr3q2uDbKobeptmsaA6t66fc9meH04XVCZFZ+3iUu8yDnQwf3AkkxG3YPtmtg4vtN+G
         YRSfc9TxnQFk2ThluGYKkIKqRPPEbS/Yy71lAJLRvj1xQPPb0+KTtv+HK1NA80sG3MY/
         PqL9dl1SbrQgUyus1uiMr5uJeKQUynvjuzBWbjQO98nNWuLQQP0cMI2PRGyAgFBeM/l8
         Tasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=m8qB24BfqP52I0zgvxNrOLjQFV7+Rq9qYnnfqsIXKss=;
        b=wDwhazBj8IXaBeKF65Apo+bjk3FFGBYqYzcKGT+Y9XZosYntCt3J8Sj5zvZV/HgXxB
         z3YvGk7pI3zQoq1FynIBr3+j4FabdESIdoRSzfDjF0jOE90t9xIX2MN2l5XhaZu53vBV
         PtYoJd43bk34SONKKXAX9JUaYu+JyYKbB86QIvW1rmBTDvGqJUW76iAXn1suv32mYrt5
         Er1fpU0v1JI6iK53eBkpvZXNaRi+vBAs5M06y4jhJp8hg8ojPZ5/te0PVDO+BP5lUYwE
         TI4Br+HGRVRH+4zG9kc8OkFjU91dKkNkR/nhISdNEXo9WNDVQVqRj5Ha3bhpwvLUfWJy
         Y4DQ==
X-Gm-Message-State: AOAM5304FZooYM4ubsrY9OPSV+KjMAa3omWd3YdajDFoegB9pBM8/1YL
        eZBsN9l0pjeBQx0+lwRx16s=
X-Google-Smtp-Source: ABdhPJwfH1g4aFPKvxj9WecZ8/8c3Yf3A0YQxJKE4JM+Wy0sFbm6aA+5kS66+eq/ZYNpajmAm1DChg==
X-Received: by 2002:a05:6402:4c1:b0:42b:e03f:d940 with SMTP id n1-20020a05640204c100b0042be03fd940mr20728697edw.235.1653919824445;
        Mon, 30 May 2022 07:10:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b006febc1e9fc8sm4099680ejg.47.2022.05.30.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:10:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nvg6A-000gk4-SJ;
        Mon, 30 May 2022 16:10:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        Aman <amanmatreja@gmail.com>, Git List <git@vger.kernel.org>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>
Subject: Re: About GIT Internals
Date:   Mon, 30 May 2022 15:50:54 +0200
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
        <Yo68+kjAeP6tnduW@invalid>
        <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
        <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
        <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
        <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
        <20220530115339.3torgv5c2zw75okg@carbon>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220530115339.3torgv5c2zw75okg@carbon>
Message-ID: <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 30 2022, Konstantin Khomoutov wrote:

> On Mon, May 30, 2022 at 09:49:57AM +0000, Kerry, Richard wrote:
>
> [...]
>> > > 1. I haven't had the experience of working with other (perhaps even
>> > > older) version control systems, like subversion. So when refering to
>> > > the "control" aspect,
>> > 
>> > The "control" aspect was from whoever was the 'manager' that limited
>> > access to the version system (i.e. acting like a museum curator), and deciding
>> > if your masterpiece was worthy of inclusion as a significant example of your
>> > craft, whether that was an engineering drawing or some software code.
>> 
>> I'm not sure I get that idea.  I worked using server-based Version Control
>> systems from the mid 80s until about 5 years ago when the team moved from
>> Subversion to Git.  There was never a "curator" who controlled what went
>> into VC.  You did your work, developed files, and committed when you thought
>> it necessary.  When a build was to be done there would then be some
>> consideration of what from VC would go into the build. That is all still
>> there nowadays using a distributed system (ie Git).  Those doing Open source
>> work might operate a bit differently, as there is of necessity distribution
>> of control of what gets into a release. But those of us who are developing
>> proprietary software are still going through the same sort of release
>> process.  And that's even if there isn't actually a separate person actively
>> manipulating the contents of a release, it's just up to you to do what's
>> necessary (actually there are others involved in dividing what will be in,
>> but in our case they don't actively manipulate a repository).
>
> I think, the "inversion of control" brought in by DVCS-es about a bit
> differet set of things.

Re the "I'm not sure I get that idea" from Richard I think his point
stands that some of the stories we carry around about the VCS v.s. DVCS
in free/open source software was more particular to how things were done
in those online communities, and not really about the implicit
constraints of centralized VCS per-se.

Partly those two mix: It was quite common for free software projects not
to have any public VCS (usually CVS) access at all, some did, but it was
quite a hassle to set up, and not part of your "normal" workflow (as
opposed setting up a hoster git repository, which everyone uses) that
many just didn't do it.

> I would say it is connected to F/OSS and the way most projects have been
> hosted before the DVCS-es over: usually each project had a single repository
> (say, on Sourceforge or elsewhere), and it was "truly central" in the sense
> that if anyone were to decide to work on that project, they would need to
> contact whoever were in charge of that project and ask them to set up
> permissions allowing commits - may be not to "the trunk", but anyway the
> commit access was required because in centralized VCS commits are made on the
> server side.

We may have tried this in different eras, but from what I recall it was
a crapshoot whether there was any public VCS access at all. Some
projects were quite good about it, and sourceforge managed to push that
to more of them early on by making anonymous CVS access something you
could get by default.

But a lot of projects simply didn't have it at all, you'll still find
some of them today, i.e. various bits of "infrastructure" code that the
maintainers are (presumably) still manually managing with zip snapshots
and manually applied patches.

> (Of course, there were projects where you could mail your patchset to a
> maintainer, but maintaining such patchset was not convenient: you would either
> need to host your own fully private VCS or use a tool like Quilt [1].
> Also note that certain high-profile projects such as Linux and Git use mailing
> lists for submission and review of patch series; this workflow coexists with
> the concept of DVCS just fine.)

I'd add though that this isn't really "co-existing" with DVSC so much as
using patches on a ML as an indirect transport protocol for "git push".

I.e. if you contributed to some similar projects "back in the day" you
could expect to effectively send your patche into a black-hole until the
next release, the maintainer would apply them locally, you wouldn't be
able to pull them back down via the DVCS.

Perhaps there would be development releases, but those could be weeks or
even months apart, and a "real" release might be once every 1-2 years.

Whereas both Junio and Linus (and other linux maintainers) publish their
version of the patches they do integrate fairly quickly.

> [...] it also has possible
> downsides; one of a more visible is that when an original project becomes
> dormant for some reason, its users might have hard time understanding which
> one of competing forks to switch to, and there are cases when multiple
> competing forks implement different features and bugfixes, in parallel.
> One of the guys behind Subversion expressed his concerns about this back then
> wgen Git was in its relative infancy [2].
>
>  1. https://en.wikipedia.org/wiki/Quilt_(software)
>  2. http://blog.red-bean.com/sussman/?p=20

It's interesting that this aspect of what proponents of centralized VCS
were fearful of when it came to DVCS turned out to be the exact
opposite:

    Notice what this user is now able to do: he wants to to crawl off
    into a cave, work for weeks on a complex feature by himself, then
    present it as a polished result to the main codebase. And this is
    exactly the sort of behavior that I think is bad for open source
    communities.

I.e. lowering the cost to publish early and often has had the effect
that people are less likely to "crawl off into a cave" and work on
something for a long time without syncing up with other parallel
development.
