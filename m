Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B752C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A89361103
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhDUTLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhDUTLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 15:11:45 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36CC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:11:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so3399022otq.9
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yZXayrovqqeJmoKGiSzgRhDjWbnu+sQZUw4ziAECXg=;
        b=Ty2Me5WY4uoj1cIPzf2/wQcLl9k3pti46u1PTLOcks2qLHou14VzQ6BP7IQDjYQGN3
         I75heRWZxabVhP0bA44PozUHEg+cP3D7mNDDl072r7hYqsVQ3UE99nSx5wVXcTw6vAdf
         MZhZIB8nGlkO9MvFjiZUmPkfuRntQtwYwfoBy1c13FDYxNGakdCuq3QfKqU3U0JWLq4U
         3oEUUzvYb3N2muqRM+IqVRkpySBhitC3bUuh8F27sWREpsUp0MXWmC8vZta14QJe8jcJ
         0txmJCmgVJwRq+nNlJYWRxhY+IdLRC//EeOq3BDhEPUUYX/lE0hIhq5hH40QLv/petvN
         2qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yZXayrovqqeJmoKGiSzgRhDjWbnu+sQZUw4ziAECXg=;
        b=Yrw66v6hXmn5s3S/3bQohifz2J34V7+4Hhx8iGlg3Je+fEN5wKtpZZTuG5s8ydZdc8
         p4Gv/KqasZCvOO7Xotu15maxt0DsB3xJpf6TbHd9jvjSPt9ov5IIluFz7ln4WSHcUPou
         Zaco95IexhLFm+nrAawQB1kZfwGuiMyBe/gKxZTEbij/Slx8A2CgKzxDCfz5uamGsh2i
         wNGMqZxWk7j6wY265V6TJBySWeV6PhBmDMUUdnIX32klRL9mZSmVzUc/+Xl4j3M/A7Ye
         YW9vTwE8aabFYeuLRtPSF+9rSzxHNDLjZ2eUFRsruXI+LEw61AoZAChwi5U2R5IRNshU
         CNqQ==
X-Gm-Message-State: AOAM5300906W8x+V12rYp3ghi3dl/xMpBrMsBqHNhRbjFuXKVUzh4YLN
        y0DbklX+dmE6Tv0qwIdkj6SXaWVz6v7/ktHTJk0=
X-Google-Smtp-Source: ABdhPJxsQPShqYtc5xtH7Ur0jJ23CaCL6Y1ZYfNQLyGAj8XzRV+dwi9EXyp0itYtF1vc371Ft0m+MihYjw6krVO8Yc0=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr18729985oto.162.1619032270183;
 Wed, 21 Apr 2021 12:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
 <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com> <CAHd-oW76_8D_wu7dixX+2i7-_M3Je=JGk3JonL18yeA5PRrsRg@mail.gmail.com>
In-Reply-To: <CAHd-oW76_8D_wu7dixX+2i7-_M3Je=JGk3JonL18yeA5PRrsRg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 12:10:58 -0700
Message-ID: <CABPp-BG5uSUHy6bQ7xEWSQ8VAy0GCqX0P670HfcopZPUwAfQcw@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 11:55 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Wed, Apr 21, 2021 at 2:27 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 4/20/2021 7:00 PM, Elijah Newren wrote:
> > > On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> >
> > >> diff --git a/read-cache.c b/read-cache.c
> > >> index 29ffa9ac5db9..6308234b4838 100644
> > >> --- a/read-cache.c
> > >> +++ b/read-cache.c
> > >> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> > >>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
> > >>                         continue;
> > >>
> > >> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> > >> +                       continue;
> > >> +
> > >
> > > I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> > > !ignore_skip_worktree and why it'd be desirable to refresh
> > > skip-worktree entries.  However, this is tangential to your patch and
> > > has apparently been around since 2009 (in particular, from 56cac48c35
> > > ("ie_match_stat(): do not ignore skip-worktree bit with
> > > CE_MATCH_IGNORE_VALID", 2009-12-14)).
> >
> > I did some more digging on this part here. There has been movement in
> > this space!
> >
> > The thing that triggers this ignore_skip_worktree variable inside
> > refresh_index() is now the REFRESH_IGNORE_SKIP_WORKTREE flag which was
> > introduced recently and is set only by builtin/add.c:refresh(), by
> > Matheus: a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
> > 2021-04-08).
> >
> > This means that we can (for now) keep the behavior the same by adding
> >
> >         if (ignore_skip_worktree)
> >                 ensure_full_index(istate);
> >
> > before the loop.
>
> Hmm, I don't think we need to expand the index here.
> ignore_skip_worktree makes the loop below ignore entries with the
> skip_worktree bit set. Since sparse dirs also have this bit set, we
> will already get the behavior we want :)
>
> However, I think we will need to expand the index at
> `find_pathspecs_matching_against_index()` in order to find and warn
> about the pathspecs that have matches among skip_worktree entries...
>
> > This prevents the expansion during 'git status', but
> > requires modification before we are ready for 'git add' to work
> > correctly. Specifically, 'git add' currently warns only when adding
> > something that exactly matches a tracked file with SKIP_WORKTREE. It
> > does _not_ warn when adding something that is untracked but would have
> > the SKIP_WORKTREE bit if it was tracked. We will need to add that
> > extra warning if we want to avoid expanding during 'git add'.
>
> Hmm, I see :( I was trying to think if it would be possible to do the
> pathspec matching (for the warning) without having to expand the
> index, but then there are the untracked files... If the user gives
> "a/*/c" and we have "a/b/" as a sparse dir, we don't know if "a/b/c"
> is a skip_worktree entry or an untracked file without expanding the
> index...

I thought Stolee's series added something that could allow us to check
that e.g. "a/b/c" corresponded to an entry under the sparse directory
"a/b/" and thus is a would-be-sparse entry.  Can we use that?

> > Alternatively, we can decide to change the behavior here and send an
> > error() and return failure if they try to add something that would
> > live within a sparse-directory entry.
>
> I think this behavior would be tricky to replicate on non-sparse-index
> sparse-checkouts, if we were to do that. We would have to pathspec
> match each untracked file against the sparsity patterns, perhaps?

By way of analogy, don't we have to pay the cost of pathspec matching
each tree entry against the sparsity patterns when doing a checkout
before putting those entries into the index?  Since "git add" is
trying to put new entries into the index, doesn't it make sense for it
to pay the same cost for the untracked paths it is about to place
there?

Sure, that can be expensive for non-cone mode, but that's the price
users pay for using sparse-checkouts and not using cone mode, and they
pay it every time they try to update the index with some new checkout.
I think "git add" should be treated similarly as another way to update
the index -- especially since users will get confused (and have gotten
confused) by subsequent commands if we don't do those checks.
