Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF0C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 20:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE3661242
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFEUin (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 16:38:43 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:34772 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhFEUim (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 16:38:42 -0400
Received: by mail-ej1-f45.google.com with SMTP id g8so19936800ejx.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=n3oVeDlAcs4Qtqh8Zc+lqQBwCM6Wuvx1B7jhFuxPdjU=;
        b=nnmHIly8yIY8jwoUPiGchLH3Krbid5wrstXeQO3dkcacJStnv2mOEbhLFS5CID7TA1
         3wBm38G1PjswgEwwZKvjnG6zUS1RGkVjtxzY7BLb/mDvOy2zbyXu/YSHYLSs/hqWrUAH
         lK6Y308bdyVTXnyj19/bUqOcJOjE5RuZPvfcWolUHy7M/j0WnnHQIhlYx7LmfPayGLZm
         cw3iT8ks+Unj5N3g6nmnUlR6th5Tuzyrqf/G2zac0x1y/ebaCrvqTABh6dkLxHQskOcJ
         lZbxzJL+5/I6W6yma5El+TepJ00EnlG6qWK/7zZyjGLGv7qt9zxOv51flx6EqKawMBVh
         Hl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=n3oVeDlAcs4Qtqh8Zc+lqQBwCM6Wuvx1B7jhFuxPdjU=;
        b=Yl8mejgs2YQaE8wAXrkD1eadH84ycdxOnHFALcWPu13+u0F8iwabFTo10ubOel1KPx
         GASLdYB4JJ3E31pMmXU3FB1U8hKJ/fo3glby4BdcTqXal9NVElDug9545qqVvgrlMEJu
         88c+INPLncg8c1Vde4A7YSmmgDLGLNOcXw5PQniF1RwvaDdU1tP2OGppx1O7tlc5Nz/2
         HxQBcAY1Xfezu7ONLMg47kMOguRfyk8xfcU3czW5YmwiX86req948BRxqwRxLowrOm/X
         2j2Oal319h6p2ZNMufML+VHqkbqr7XBs27pvzUiN5oKN65YqKDWikGhJFvKT7RJc0Dtk
         45qw==
X-Gm-Message-State: AOAM531TEWGyDBBJUb7phH0uHsTvMx2UuqW5/OP2sVcDb2pL6Ngf3aXT
        RhqmUHVXQ19UZ17qz5uq02GS8JoZH2A=
X-Google-Smtp-Source: ABdhPJwoyG3CPFrsTOsE/0Zy6/d7FSVYSdC1sEkOJcKC6BLJ2g67X5aGN+kpWShr+1lL56Fh3cGBsQ==
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr10311790ejy.395.1622925353399;
        Sat, 05 Jun 2021 13:35:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o21sm3847710ejg.49.2021.06.05.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:35:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make -v useful
Date:   Sat, 05 Jun 2021 22:18:14 +0200
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210605011339.2202-1-felipe.contreras@gmail.com>
Message-ID: <87czt059sn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 04 2021, Felipe Contreras wrote:

> Currently `git branch -v` shows something like "[ahead 10]", but ahead
> of what?
>
> We git experts know ahead of what, but not what that what is set to. Just
> like "[@{upstream}: ahead 10]" would not be particularly useful to
> anyone that doesn't know, or remembers, what @{upstream} is set to.
>
> On the other hand "[master: ahead 10]" is perfectly clear to anyone.
>
> This confusion only gets worse when you see "[ahead 10, behind 100]". Is
> it master? Is it next? Is it
> john/experimental-feature-i-based-my-branch-on?
>
> Inevitably most users will need to know what @{upstream} is.
>
> So let's make `git branch -v` output what is most useful:
>
>   [master]
>
> Before:
>
>   * fc/branch/sane-colors b2489a3735 [ahead 1] branch: make -v useful
>
> After:
>
>   * fc/branch/sane-colors b2489a3735 [master] branch: make -v useful
>

Having applied this patch I find the description a bit confusing. The
example led me to believe that you'd stripped the remote name, so the
common case of "origin/master" would become "master", but instead the
example is from a "fc/branch/sane-colors" branch where your "remote
tracking branch" is actually tracking your *local* master, i.e. "remote
= ."?

Disambiguating that is one of the reasons we prefix with the remote
name, but I'd say it makes for a confusing example in a commit message,
and also if instead of saying:

    branch: make -v useful

It said e.g.:

    branch: reverse the priority of what -v and -vv show

Or something similar to note that it's not "useful" now, but an
opinionated change about what we should show on verbosity level 1 and 2.

In any case, this proposed patch is missing a doc update, in
git-branch.txt we say both:

    When in list mode, show sha1 and commit subject line for each head,
    along with relationship to upstream branch (if any). If given twice,
    print the path of the linked worktree (if any) and the name of the
    upstream branch, as well (see also git remote show <remote>).

And later, for the --track option:

    When creating a new branch, set up branch.<name>.remote and
    branch.<name>.merge configuration entries to mark the start-point
    branch as "upstream" from the new branch. This configuration will
    tell git to show the relationship between the two branches in git
    status and git branch -v.

Both of those need to be updated, and I think the commit messages should
discuss whether we break this promise of having consistent output
between "status" and "branch -v" now.

As for the proposal, I don't use "branch -v" all that much much, so I
don't have strong knee-jerk feelings on it, but just considering it now
I'd think that the current default is a fundamentally better
approximation of what most users would like as a default.

I.e. I think it's fair to say that to the extent that most users have
topic branches they're part of some pull-request workflow where they're
always tracking the one upstream they always care about, usually
origin/master.

The -v output showing the ahead/behind relationship to that branch
without naming it is thus the best use of the limited space we have, and
with a bit more verbosity under -vv we'd show the (usually the same for
all of those) upstream name.

Whereas you are presumably tracking origin/master for some, building on
your own topic (or other people's topics) for another etc., I think that
workflow is much rarer outside of linux.git and git.git, and even for
those most people usually track origin/master with most of their topics.

> An additional benefit is that `git branch -v` is slightly faster: 30ms
> vs. 60ms on my system.

110ms v.s. 5000ms on my system. Lots of old uncleaned-up topics.

For what it's worth I remember some past discussion where it was
discussed to have some human-readable cut-off so instead of saying:

    ahead 2, behind 38741

We'd just fall back on saying "behind lots" once your number of behind
reached some limit (which could dynamically compute as a heuristic based
on repo size, just like the abbrev length)..
