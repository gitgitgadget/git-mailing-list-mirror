Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B435C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 07:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhL1HdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 02:33:14 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:37861 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhL1HdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 02:33:13 -0500
Received: by mail-pf1-f173.google.com with SMTP id 8so15522300pfo.4
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 23:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMlsubZ3JVVXEjWz87WL/5maDgEluuTpe6MelTWaANY=;
        b=qFmmrD0zkSLMizus0fDZtQfDdMheqTFV2oq4mRLRSEpvg0jcbijnJLnihJ4CAatEAF
         VArrGaAgA0BM8UYldWbhul7Pm/u1srNwIWi8Lyr9N0x5b3rEpGbx3FfdRVtF+MwpT9r/
         jfymTLFrHWiVokgs7yQO8VPPS9EA6gEXPGHmpmWQq/HPEN6wdD0gz6+rmV5IP0vfQFKy
         73GNkLZDmiZS0pbwaDsVGbMHC9sQ8ZAoMiTZjq4PDkmgXroJ2PFXd3xoxHJmsURHzH+J
         /ri9V/VZdb4jr+MFRIdDID3XkMV9SsLB3uTgHdqyXXa4DBqGH2Yax3MSDoKFeCaGloke
         abrQ==
X-Gm-Message-State: AOAM5333eUSjo3+lmN/DFH12dRBLRSl8/dvasyh2lcpbjHEG6+bGc73D
        dnvSptJfqopXVKQfAX6nRR2q4Bele0D6Fkj9UQw=
X-Google-Smtp-Source: ABdhPJw80rM4cdT3DzuhlQZBnWkqVRVqkZniFWbWKOQDcDzXOR3O8KDqg8EtO24ATomj/5bJjr+Fm5MX7pRNslgGRVk=
X-Received: by 2002:a63:3e41:: with SMTP id l62mr13835963pga.139.1640676793134;
 Mon, 27 Dec 2021 23:33:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com> <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com>
In-Reply-To: <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Dec 2021 02:33:02 -0500
Message-ID: <CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 2:35 PM Elijah Newren <newren@gmail.com> wrote:
> On Sun, Dec 26, 2021 at 11:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Your example indeed leads to a broken state because it doesn't follow
> > the instructions given by git-worktree.txt for enabling
> > `extensions.worktreeConfig`, which involves additional bookkeeping
> > operations beyond merely setting that config variable.
>
> These are instructions which neither Stolee nor I was aware of prior
> to your pointing it out.  [...]
> I'd suspect that Stolee and I are actually _more_ likely to be aware
> of relevant documentation than the average Git user, so if we missed
> it, I suspect many of them will. [...]

I wasn't originally aware of the bookkeeping instructions either. In
fact, for a good while, I wasn't even aware that Duy had implemented
per-worktree configuration or that there was such a thing. I either
must have been entirely off-list during the implementation or was not
in a position to follow changes to the project at the time. I only
became aware of per-worktree configuration at some point in the last
two or three years when someone asked some question on the list
related to the feature and I ended up diving into the documentation,
the source code, and the patches themselves in order to understand it
fully -- because I think I didn't understand it merely from reading
the documentation which is rather sparse (no pun intended). And I had
forgotten enough about it since then that I had to re-research it when
Sean raised the issue on the list a few days back in relation to
sparse-checkout.

> So, I don't think relying on folks to read this particular piece of
> documentation is a reliable course of action...at least not without
> some changes to make it much more likely to be noticed.

The sparsity of documentation about per-worktree configuration
certainly doesn't help, nor the fact that it's fairly near the end of
git-worktree.txt, at which point people may have given up reading. We
could make it a bit more prominent by mentioning it early in the
command description, but it still involves enough fiddly bookkeeping
that it likely will continue to be problematic.

Making per-worktree configuration the default does seem like the best
long-term solution. Doing so should make all these problems go away. I
don't know what Duy's plans were, nor whether he had some migration
strategy planned.

> > I vaguely recall some mention of this not long ago on the list but
> > didn't follow the discussion at all. Do you have pointers or a
> > summary?
>
> For the microsoft repositories, sparse-checkouts are needed because a
> full checkout is unmanageable (millions of files to check out
> otherwise).  For other repositories, full checkouts might technically
> be manageable, but are annoyingly slow and users may only want to work
> with sparse checkouts (and for some of these, due to various
> mono-repoization efforts, the repository is growing towards a size
> where manageability of full checkouts is decreasing).
>
> The fact that `git worktree add` does a full checkout is quite
> painful...possibility to the point of making worktrees useless for
> some users.  I think `git worktree add` should copy the sparsity of
> the worktree from which it was invoked.

Okay, I do recall reading a message in which you proposed this, though
I didn't understand the reasoning for the suggestion since I wasn't
following the discussion. The explanation you provide here makes the
proposal understandable.

>   * using --no-checkout as a proxy: This means no files checked out
> and no index file.  The lack of an index file makes it appear that
> everything was manually deleted (with the deletion staged).  Also, if
> the project is using some kind of <sparsity-wrapper-script> (e.g. for
> determining dependencies between directories so that appropriate
> 'modules' can be specified and transformed into a list of directories
> passed to sparse-checkout), then the sparsity-wrapper-script isn't
> available to them to invoke.  If users try to check out just the
> wrapper file, then an index will be created and have just one entry
> and we kind of cement the fact that all other files look like they
> were intended to be deleted.  Also, even if the user runs `git
> sparse-checkout init --cone`, you don't actually don't transform this
> no-checkout into a sparse checkout because sparse-checkout doesn't
> want to undo your staged deletions.  Despite the fact that I'm very
> familiar with all the implementation internals, it was not obvious to
> me all the necessary additional commands needed for users to get a
> sparse checkout while making use of --no-checkout.  Users stand little
> chance of figuring the necessary command invocations out without a
> huge amount of effort (and they've given up and come to me before
> asking for help, and my first response turned out to be incomplete in
> various cases...).

You've clearly put much more thought into this than I have (since I
only just read this), so I'm not likely to have any meaningful input,
but I'll write down a few thoughts/questions which popped into my head
while reading what you wrote. Perhaps they've already been discussed
elsewhere, so feel free to ignore (and they may not be worth
responding to anyhow).

When you say "copy the sparsity of the worktree from which it was
invoked", do you mean that literally, such that it special-cases it
and only copies sparse-checkout information? An alternative would be
to allow the user to specify -- via the shared configuration
(.git/config) -- exactly which config keys get inherited/copied over
by `git worktree add`. Such a solution would avoid special-casing
sparse-checkout and could be useful in the future for other commands
which might need such functionality, though this approach may be
overengineered.

A more general approach might be for the new worktree to copy all the
per-worktree configuration from the worktree in which the command was
invoked, thus sparsity would be inherited "for free" along with other
settings. This has the benefits of not requiring sparse-checkout
special-cases in the code and it's easy to document ("the new worktree
inherits/copies configuration settings from the worktree in which `git
worktree add` was invoked") and easy to understand.

I also wondered if adding some sort of `--sparse-checkout=...` option
to `git worktree add` would solve this particular dilemma, thus
allowing the user to configure custom sparse-checkout for the worktree
as it is being created. I also very briefly wondered if this should
instead be a feature of the `git sparse-checkout` command itself, such
as `git sparse-checkout add-worktree`, but I think that's probably a
dead-end in terms of user discoverability, whereas `git worktree add
--sparse-checkout=...` is more easily discoverable for people wanting
to work with worktrees.
