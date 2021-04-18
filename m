Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC1C433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 20:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550E2610C8
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 20:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhDRUyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRUyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 16:54:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE57C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 13:54:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w18so38353802edc.0
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JmHCJo1aYilkWk2jDLoIv8gkiT3fvoJh4F6bcMDsqpM=;
        b=kQtbfWBjcTnBrAEzYdoZUv0wbr5hi4kQT9xUW+2W1hIgnZMFqAVafnaHR8pnunQP+O
         TOrLTs2YgQCIta2Sf8vGiIwBVnN/aPVa+fPNaJJZDYaQtGrCSKSe33t2zWg5lOZTGpuU
         EKNnij7rmlNToXbH2oGPcTpDUpRH8W8OPc3fEtLApX23rELf3ETuaDn2yyc/G3Kbfnm1
         2dG/1sirat9oO7fS5chdp1/9K1IVZGg+0cfwbBsLMGGDdXOSHZRCcjZJ1ZuGbhnYnPOM
         XKNdTGXRs+3PWAAIeybQeDEtRiVZ++XVwnlDLoZ1/j8ICeQP3sPyO8o5KHVpZpu+QzNB
         J2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JmHCJo1aYilkWk2jDLoIv8gkiT3fvoJh4F6bcMDsqpM=;
        b=AS/lq3pnynBbUq/hbmJNZb9DbLrXEJ1zUx4HxOrUVOCQbaq8rFQRBEHieOv60lICmx
         NWTVZ65O9Vzcquu5GBMNixbVdbwwjxEW6x+f10L2dki+AMY6IkO8GNP8R/wdiMnKuZYI
         EC4aJ8WD73VkGyl0V4vrXcEpgrKklqF5J2h9KiGkTg7Ph9F+3/LSKhNpXkwSibOgYkhs
         DOMhK1EBzg/uZeK66wrRC7moRP0HqNaOkgqIRQjl8X0C6P8H7gr8q5FkJtKDkeRYH86j
         WEgkHIvnjHxI84f7FM2zRRPs3SJ1aVqGI5/79GQLELFnQKNvMTs/YywS7S4Pt27wXW5b
         GjvA==
X-Gm-Message-State: AOAM530Vcx/6X7kkIP2J7hOm+mswPeCOWiG63yNClqYSO1adpU1Ak+Un
        ilnFd9ydQOMnOGUX6uljwW7MNu2SW+g=
X-Google-Smtp-Source: ABdhPJwdEpp6xnxl1G/LewoE3CFFnTki4dzk53YwmWiSlapyg8TDqAwhwrtMqNLjIh0wMT1QDRh2+A==
X-Received: by 2002:a05:6402:22a4:: with SMTP id cx4mr16062706edb.232.1618779260074;
        Sun, 18 Apr 2021 13:54:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d18sm11260088edv.1.2021.04.18.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 13:54:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org, patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
Date:   Sun, 18 Apr 2021 22:54:18 +0200
Message-ID: <87fszn48lh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 18 2021, Sebastian Schuberth wrote:

> On 2021-04-14 08:13, Jonathan Nieder wrote:
>
>> Those four are important in my everyday life.  Questions:
>
> Thanks for bringing up these questions in a dedicated format. I'll
> take this as an opportunity to share my thoughts on this topic, which
> have accompanied me for quite a while.

And thank you for participating in the discussion. I think it's
especially valuable to get a viewpoint like yours, i.e. someone who (per
this E-Mail below) gave up in frustration with the current development
flow.

The below isn't meant as a retort, but to hopefully clarify things a
bit.

>>   1. What pain points in the patch flow for git.git are important to
>>      you?
>
> Well, it's email-based. As a result it's error prone to things like
> formatting / quoting issues, putting the right people it CC, etc.
>
> I have always wondered why Git core development does not start to make
> use of the Git ecosystem that we have by now, esp. in the form of
> review tools / platforms like GitHub (via pull-requests), GitLab (via 
> merge-requests), or Gerrit (via patches). From these, Gerrit would IMO
> be the best fit for Git, due to its capability to cope well with 
> rebase-workflows. Those tools avoid things like formatting / quoting
> issues completely, and shift the responsibility of assigning reviewers 
> from the contributor to the tool, where people can subscribe to code
> changes or code ownership can be defined and automatically taken into 
> account.

I think it's important not to conflate tooling issues with social
issues. It's not that we e.g. couldn't whip up a quick script to
round-robin randomly assign reviewers on the basis of topics Junio has
picked up, which is basically the function of some of these "open a MR
end get on the review train" tools.

Rather it's that it's a volunteer project and people work on what
they're interested in.

So maybe having assigned reviewers would help move things along. But I
wonder if it wouldn't also lead down the rut of PRs/MRs languishing for
months, because the reviewers just want to spend their time in some
other way.

I.e. the design of many of these tools in this regard assumes you have a
workforce, not the cat-herding problem of volunteers working on whatever
strikes their fancy.

> Sure, I get that that the contribution workflow to Git core has
> historically grown, but what concerns me is that the efforts to
> "bridge" the contribution workflow to the "modern world" seem to go
> into the wrong direction: Tools like submitgit [1], gitgitgadget [2]
> and now patchwork [3] were created / are considered for use to allow
> the legacy email path workflow to remain, but also allow more "GUI
> minded" people to contribute. While this has worked quite well for
> some time, and esp. gitgitgadget [2] seems to haven gotten popular, I
> wonder whether it's now the time to "swap the default", and make a
> patch / contribution tool with a GUI the standard, and bridge the
> legacy workflow by using / creating tooling that makes it convenient
> to use those modern tools from the CLI, instead of the opposite.

I think characterizing E-Mail as a "legacy" workflow isn't accurate. All
of these proposed alternatives involve moving away from something that's
a distributed system today (E-Mail infrastructure, local clients), to
what's essentially some website run by a centralized entity, in some
cases proprietary.

Even in cases where the tool itself isn't proprietary (e.g. GitLab
instead of GitHub) using GitHub/GitLab/Gerrit/Atlassian Bitbucket
etc. means having some centralized infrastructure somewhere holding a
bunch of data only the operator of that infrastructure can realistically
access.

So really basic things that are comparatively trivial with E-Mail
(e.g. "I think the search sucks, try another client") run up against a
brick wall with those tools.

And to e.g. as one good example to use (as is the common convention on
this list) git-range-diff to display a diff to the "last rebased
revision" would mean some long feature cycle in those tools, if they're
even interested in implementing such a thing at all.

Because we're E-Mail based that's just something some people started
using (well, it was called "tbdiff" then), some others picked it up etc.

Which is not to say that one can't argue that on balance using those
tools isn't better overall, I'm just responding to the characterization
of E-Mail based development as "legacy", or something those tools
supersede. I think it's better to think of them as orthagonal ways to
reach similar aims.
