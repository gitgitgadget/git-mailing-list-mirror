Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78416C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhL1Q6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:37 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:51904 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhL1Q6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:58:36 -0500
Received: by mail-pj1-f54.google.com with SMTP id v16so16397949pjn.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyL4LT1t83GjHRZqrMSkKcsehuJ5L1QnEUSJzueclC0=;
        b=J2XXQi65DPNScvRzr3rlPOA3/l549fb1Nar0Pme9g2abjWyTcBZ34/2NBlekZVQPlU
         pWH69pDFPbn2FQk0A396CFP3Ec718MnZZrxZAtoGZjtGHZDCpeeB8t/6YCCzRSTvk0cV
         vYDAT1FTnC6lB32gjUiIj7o3Ku5ULCXZFu9Z+03z2KgbVBvHhWsXN5+YQZhO4/04huVh
         oH2QL7tlM29Pyhv9DGS+iKvwFPOHB7hpj6mWetn7jTiiMqwgdLbQ2FCVRQdyJHn/ZX+I
         J3IU43Eg8mkQMRKSYTLUF49SEuduryriFDf8aWllTApdbAQ/ysWHbS1tGShrWPS1CzP9
         664w==
X-Gm-Message-State: AOAM531MK4wj9mn2+7I52x5vWbAp/BggtX54LiBCQJMXDIpq6wOjRWwE
        Wy71frM/8aVcEUwc9Pnz/BFnZrYpgQ/F/LB0pVg=
X-Google-Smtp-Source: ABdhPJyJ5/JSaMa8IW4pmu2mQD+he7WJe5YJRcfLHXwqr31zt3QSWv/n/VUGoeIka9PPLtSBZUYBR5UCj4MHRmru89s=
X-Received: by 2002:a17:902:8346:b0:148:997d:f60b with SMTP id
 z6-20020a170902834600b00148997df60bmr22672405pln.64.1640710716018; Tue, 28
 Dec 2021 08:58:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
 <CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com> <53f3531d-29ee-f16e-1d60-21ca7b4a3fbd@gmail.com>
In-Reply-To: <53f3531d-29ee-f16e-1d60-21ca7b4a3fbd@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Dec 2021 11:58:25 -0500
Message-ID: <CAPig+cT76vv08wjM7ryopXxFsg15Cy9Ax3tYNsERM9D_gJCYbw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 10:03 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/21/2021 7:45 PM, Eric Sunshine wrote:
> > It would be a good idea to drop the final sentence since there is no
> > such thing as a bare worktree (either conceptually or practically),
> > and end the first sentence at "case": i.e. "... stops that special
> > case."
>
> Bare worktrees don't exist, that is correct. But if one existed it
> would be a directory where you could operate as if it is a bare repo,
> but it has its own HEAD different from the base repo's HEAD. Not sure
> why one would want it.

I'm not following. I also still don't know what "base repo" is or
where two HEADs would arise.

> >> +       char *base_config_file = xstrfmt("%s/config", r->commondir);
> >> +       char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> >
> > Per path.c:strbuf_worktree_gitdir(), this use of `r->commondir` is
> > correct. Good.
> >
> > Can we use more meaningful variable names? It's not at all clear what
> > "base" means in this context (I don't think it has any analog in Git
> > terminology). Perhaps name these `shared_config` and `repo_config`,
> > respectively.
>
> 'repo_config' is too generic, because I want the worktree config for
> the "original" repo. I chose to call that the "base" repo and its
> worktree config. Shared_config is a good name, though.

There seems to be some terminology confusion or conflict at play here.
We're dealing with only a single repository and zero or more
worktrees, so I'm still having trouble understanding your references
to "original repo" and "base repo", which seem to indicate multiple
repositories.

> >> +       /*
> >> +        * If the base repository is bare, then we need to move core.bare=true
> >> +        * out of the base config file and into the base repository's
> >> +        * config.worktree file.
> >> +        */
> >
> > Here, too, it's not clear what "base" means. I think you want to say
> > that it needs to "move `core.bare` from the shared config to the
> > repo-specific config".
>
> Yes, but specific to the original/root/bare repo. I'm open to preferences
> here, but "repo" isn't specific enough.

There's only a single repository, so this should be clear, however,
there appears to be some terminology mismatch. I'll enumerate a few
items in an effort to clarify how I'm using the terminology...

    .git/ -- the repository residing within the main worktree

    bare.git/ -- a bare repository

    .git/config -- configuration shared by the repository and all worktrees

    bare.git/config -- configuration shared by the repository and all worktrees

    .git/config.worktree -- configuration specific to the main worktree

    bare.git/config.worktree -- configuration specific to the bare repository

    .git/worktrees/<id>/config -- configuration specific to worktree <id>

    bare.git/worktrees/<id>/config -- configuration specific to worktree <id>

> > However, there is a much more _severe_ problem with this
> > implementation: it is incomplete. As documented in git-worktree.txt
> > (and mentioned several times during this discussion), this utility
> > function _must_ relocate both `core.bare` _and_ `core.worktree` (if
> > they exist) from .git/config to .git/config.worktree. This
> > implementation neglects to relocate `core.worktree`, which can leave
> > things in quite a broken state (just as neglecting to relocate
> > `core.bare` can).
>
> It took me a long time to actually understand the purpose of
> core.worktree, since it seems in conflict with the 'git worktree'
> feature. Indeed, it is special-cased the same way core.bare is, so
> this relocation is required.

Indeed, the situation is unfortunately confusing in this area.
`core.worktree` predates multiple-worktree support (i.e.
`git-worktree`) by quite a long time and is a mechanism for allowing
the repository (.git/) to exist at a distinct location from the
worktree (by which I mean "main worktree" since there was no such
thing as a "linked worktree" at a time). `git-worktree` generalized
the concept by making multiple worktrees first-class citizens, but
`core.worktree` and GIT_WORKTREE still need to be supported for
backward compatibility even though they conflict (or can conflict)
rather badly with multiple-worktrees.
