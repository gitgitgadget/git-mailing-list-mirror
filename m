Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A1C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75DC61029
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 08:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhDSI0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDSI0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 04:26:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A0EC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 01:26:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x4so39628876edd.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Eg3eYYo5PX7inpyNjy3+951HNVIsxL0BcATHUCwfcdQ=;
        b=lBmdg6BfL2VygA2XTtIT7UWXKchFjleOCSgESu0oZ5xx+9i5/76/BrCct+FixYDXTr
         FK8jKQG2nv8cdPa6bxPvpjSHdf7GDpXSn7bNTMasYKixgUJtax+gcjbtV25LQ1TbdScr
         aFP/DTYNzRZYdo95fvEems4DqwTDo3rQkOI5gJ3QHfRWEzcS/rgN7/UBRN3X3l1qeGOh
         GabIBPaCZZxzMFNybY0tPMvRB1eO60ZkU5ZgX+C2ANeVJ83xERGUDevhDTzragKFIFVf
         MkMI1Mn+dnwmCi4bvRbz341mA5s211U+BspPWdR2MZoh+PkEC8IeK47FEeGqzXyEbblv
         sfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Eg3eYYo5PX7inpyNjy3+951HNVIsxL0BcATHUCwfcdQ=;
        b=SnO7xt8iZfulj0u7OW4Hi3KfgvThMxTz/gK54fY/oSPnvXqHGRWXWQYsecKjs3yTaR
         RmzDWxSMog2Z7bOTOqJA8woM7N8WwBvntLVE323F4AmCuI3lK+de/i3xkLjMld9RrDR6
         9IYpn80fH4b9BH1l0wLQbx24cqINLoqPK0jcBv6vbpdQxNJe9Wy9N6XwcpS18fsuxr+z
         LmGgTZnuij/fnfq65pRaP1eA8x1aIrDLWO0R89RxPunYUMuI3PNFSR4R4OzWafsTczXD
         ZecCulP54P8BK5K56Mp00VMrgcF3CiMhB5q/YjaZVW14fJV68G9709CbT+7l3lTtNLwV
         jIrw==
X-Gm-Message-State: AOAM531rcMj9pjgTirv2aU7Bxr27s2o+h4WFFKC8B2Fq3xTFGo5C/Fwy
        NAIi75WMoLmSNHSm1ORNaNQ=
X-Google-Smtp-Source: ABdhPJw7RV9Y/Fn/v7vCuAm8pZUZzUB2hqVzN0Ne6/3Bx1BXeU9HNh0WSrHYle8UZwmWLTeqmfGf+w==
X-Received: by 2002:a05:6402:2d1:: with SMTP id b17mr6916880edx.144.1618820780204;
        Mon, 19 Apr 2021 01:26:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id 16sm9925216ejw.0.2021.04.19.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:26:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
Date:   Mon, 19 Apr 2021 10:26:18 +0200
Message-ID: <87czuq4r4l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Sebastian Schuberth wrote:

> On Sun, Apr 18, 2021 at 10:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> And thank you for participating in the discussion. I think it's
>> especially valuable to get a viewpoint like yours, i.e. someone who (per
>> this E-Mail below) gave up in frustration with the current development
>> flow.
>
> To be fair, Git's contribution flow isn't the only reason why I chose
> to stop contributing. Another reason is the very lengthy and tedious
> discussions that too often spark from rather small changes.
>
> Also, I wouldn't say I "gave up in frustration". It was a mostly
> unemotional decision on which of the many OSS projects I contribute to
> my rare spare time is spent best.
>
>> I think it's important not to conflate tooling issues with social
>> issues. It's not that we e.g. couldn't whip up a quick script to
>
> I'm not sure I agree completely here, because some tools make it
> easier to overcome social issues than others.

Indeed, to clarify I'm not dismissing that. E.g. is an easier UX or
other "prodding" going to result in better collaboration? Maybe. I'm
just pointing out that it may not mostly/entirely be a tooling issue.

>> Rather it's that it's a volunteer project and people work on what
>> they're interested in.
>
> Exactly. That's why I believe tooling should allow people to subscribe
> to changes in code areas they're interested in, rather than a
> contributor having to know which subsystem maintainer to put in CC
> (e.g. for gitk changes). At least at the time when I contributed it
> was sometimes hard to move things forward if you didn't reach out to
> the right people.
>
>> So maybe having assigned reviewers would help move things along. But I
>> wonder if it wouldn't also lead down the rut of PRs/MRs languishing for
>> months, because the reviewers just want to spend their time in some
>> other way.
>
> Having default assignees for reviews / code owners / however you want
> to call it does not mean that only these people should review, or that
> something cannot be merged without their review. It just makes it more
> clear who's opinion would be the best to get, and who should execute a
> "word of command" if things do not move forward.
>
>> I.e. the design of many of these tools in this regard assumes you have a
>> workforce, not the cat-herding problem of volunteers working on whatever
>> strikes their fancy.
>
> E.g. GitHub makes the distinction between "reviewers" for a PR and
> "assignees" for a PR, and the former can be configured from a
> CODEOWNERS file[...]

CODEOWNERS and default assignment etc. is something that tends to
over-assign things, which is fine for a workforce you're paying, but
it's important to realize that the practice in the git project is to put
the onus on the submitter of the change to manually find who they should
CC.

Because it's not a problem you can really solve automatically without
the a trade-off of feeding potentially uninterested parties a bunch of
patches they're not interested in, which could be another thing that
makes them give up contributing.

So for example I've got a lot of code in git I consider that I "own" in
the sense that I'm responsible for creating it, have been involved in
past design discussions about it etc.

But very little of that cleanly maps to a file as the CODEOWNERS
workflow expects. E.g. there's parts of grep.c that I'd definitely like
to be CC'd on, but others not. Even a "git blame" of the specific lines
you're touching isn't always what you want.

Having used CODEOWNERS in a corporate setting I think it's most useful
for e.g. when you have a monorepo with different subdirectories that do
(at least mostly) map o different teams or peope, think drivers/usb/* or
arch/s390/*.

>> I think characterizing E-Mail as a "legacy" workflow isn't accurate. All
>
> I admit it was a deliberately provocative choice of words, well
> knowing it's not reflecting the current state, to underline how I'm
> feeling about the workflow. E-mail is great. Also plain text e-mail is
> great (I've configured all my client to only send plain text), but
> please, not for sending around code patches.
>
> If you send around code patches by mail instead of directly working on
> Git repos plus some UI, that feels to me like serializing a data class
> instance to JSON, printing the JSON string to paper, taking that sheet
> of paper to another PC with a scanner, using OCR to scan it into a
> JSON string, and then deserialize it again to a new data class
> instance, when you could have just a REST API to push the data from on
> PC to the other.

That's not inherent with the E-Mail workflow, e.g. Linus on the LKML
also pulls from remotes.

It does ensure that e.g. if someone submits patches and then deletes
their GitHub account the patches are still on the ML.

>> of these proposed alternatives involve moving away from something that's
>> a distributed system today (E-Mail infrastructure, local clients), to
>> what's essentially some website run by a centralized entity, in some
>> cases proprietary.
>
> That's a good point, I admit I haven't thought of that. Probably
> because I also don't care much. So *does* it really matter? What
> exactly concerns you about a "centralized entity"? Is it the technical
> aspect of a single point of failure, or the political / social aspect
> of being dependent on someone you do not want to get influenced by? I
> guess it's a bit of both.

To begin with if we'd have used the bugtracker solution from the
beginning we'd probably be talking about moving away from Bugzilla
now. I.e. using those things means your data becomes entangled with the
their opinionated data models.

> While these concerns could probably be addressed somewhat e.g. by
> multiple independently operated Gerrit servers that are kept in sync,
> I was curious and quickly search for more fitting "truly
> decentralized" solutions, and came across radicle [1]. Just FYI.

That's interesting, but I haven't looked into that tool. Browsing their
documentation earlier many of the links were 404s.

>> So really basic things that are comparatively trivial with E-Mail
>> (e.g. "I think the search sucks, try another client") run up against a
>> brick wall with those tools.
>
> Not necessarily. As many of these tools have (REST) APIs, also
> different API clients exist that you could try.

API use that usually (always?) requires an account/EULA with some entity
holding the data, and as a practical concern getting all the data is
usually some huge number of API requests.

>> And to e.g. as one good example to use (as is the common convention on
>> this list) git-range-diff to display a diff to the "last rebased
>> revision" would mean some long feature cycle in those tools, if they're
>> even interested in implementing such a thing at all.
>
> AFAIK Gerrit can already do that.

Sure, FWIW the point was that you needed Gerrit to implement that, and
to suggest what if they weren't interested. Would you need to maintain a
forked Gerrit?

Not to say that's a dealbreaker, just trying to bridge the understanding
of why some people prefer the E-Mail workflow.

Anyway, as before don't take any of the above as arguing, FWIW I
wouldn't mind using one of these websites overall if it helped
development velocity in the project.

Ultimately those things are up to Junio though, which these discussions
always come down to.

I just wanted to help bridge the gap between the distributed E-Mail v.s
centralized website flow.

