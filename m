Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FCC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 06:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhL3GlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 01:41:05 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39679 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbhL3GlC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 01:41:02 -0500
Received: by mail-pl1-f175.google.com with SMTP id h6so13754442plf.6
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 22:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JkYjENVWhK2O/eb+tDilLfEfNOq6YA6rDJIRbaWsVM=;
        b=X/yGPNK3oNfMHAD0Zx4tXESVDtPCLre3LINHZKp50ezyzBLtCSs0+ipCJCpFm4+1ON
         mp92ZxEVt54OFnQfZIb+ec42okt3I9MvYWgi9I7NbeVntHGG5LP8llDx3L2zrLYj2/It
         SGYTq1Z6biRr8PpPI0oiYe9gK4wZ7f8Z5NCtlO8N8021VqEh+4oq/ZSljZO4CG8BgOxV
         LWm09oSOcIIR+qC/k2KL/MhmzyC9JurRm3hE0ymbqh2ZEWOq+HVrz4sjwuCpKMBtKqgb
         /swwfymrTPZra5ItJH1BMvsd1BQ73T8jg3RLIISOayiNcmY7XQAxWPeH8QM4FRTO6WEM
         9J8Q==
X-Gm-Message-State: AOAM5305ZYPSFotrc9otU8+hd94tWMsJY6VJnSlNgNKT+43w+RET73md
        1KhEQd7Rjp+RTPv5rxcBCFXAaPGG+djYoIerM+Y=
X-Google-Smtp-Source: ABdhPJxV/XQotn65ULqvs4ZtegUXVznZUBMrpecfoW0JfQWSMZtjWjjkleSk/JDadOXf+5felRKUSynYC4AEfQV8naw=
X-Received: by 2002:a17:90b:783:: with SMTP id l3mr36230452pjz.104.1640846461621;
 Wed, 29 Dec 2021 22:41:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com>
 <CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com> <CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com>
In-Reply-To: <CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 01:40:50 -0500
Message-ID: <CAPig+cRJj4Aa9Nm_yWD0=WGdn9tRmT2PpTwo5yeGZHg2Qz2rgA@mail.gmail.com>
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

On Tue, Dec 28, 2021 at 1:16 PM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Dec 27, 2021 at 11:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > The sparsity of documentation about per-worktree configuration
> > certainly doesn't help, nor the fact that it's fairly near the end of
> > git-worktree.txt, at which point people may have given up reading. We
> > could make it a bit more prominent by mentioning it early in the
> > command description, but it still involves enough fiddly bookkeeping
> > that it likely will continue to be problematic.
>
> Further, it's not clear people even looked at git-worktree.txt at the
> time they learned about extensions.worktreeConfig.  I believe I
> discovered and started using extensions.worktreeConfig from `git
> config --help`, which makes no mention of or even reference to the
> need for any extra steps.  (I didn't see the original mailing list
> discussions around that setting either.)  It never occurred to me in
> the ~3 years since to even look in `git worktree --help` for
> additional guidance around that config setting until this particular
> mailing list thread.

That's an interesting datapoint. At the very least, we probably should
update Documentation/git-config.txt to mention the extra bookkeeping
required when setting `extensions.worktreeConfig=true`.

> > A more general approach might be for the new worktree to copy all the
> > per-worktree configuration from the worktree in which the command was
> > invoked, thus sparsity would be inherited "for free" along with other
> > settings. This has the benefits of not requiring sparse-checkout
> > special-cases in the code and it's easy to document ("the new worktree
> > inherits/copies configuration settings from the worktree in which `git
> > worktree add` was invoked") and easy to understand.
>
> Ooh, this is a good point and I *really* like this simple solution.
> Thanks for pointing it out.

I do wonder, though, if there are traps waiting for us with this
all-inclusive approach. I don't know what sort of worktree-specific
configuration people use, so I do worry a bit that this could be
casting a too-wide net, and that it might in fact be better to only
copy the sparse-checkout settings (as ugly as it is to special-case
that -- but we need to special-case `core.bare` and `core.worktree`
anyhow[1]).

[1]: https://lore.kernel.org/git/CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com/

> Do note, though, that it's more than just config.worktree -- I also
> want the ${GITDIR}/info/sparse-checkout file copied.

Thanks for pointing that out. I'm reasonably (or completely) ignorant
of sparse-checkout since I've never used it nor read the
documentation, and I didn't follow the earlier discussions.

> > I also wondered if adding some sort of `--sparse-checkout=...` option
> > to `git worktree add` would solve this particular dilemma, thus
> > allowing the user to configure custom sparse-checkout for the worktree
> > as it is being created. I also very briefly wondered if this should
> > instead be a feature of the `git sparse-checkout` command itself, such
> > as `git sparse-checkout add-worktree`, but I think that's probably a
> > dead-end in terms of user discoverability, whereas `git worktree add
> > --sparse-checkout=...` is more easily discoverable for people wanting
> > to work with worktrees.
>
> This might be a useful extra capability (we'd probably want to keep
> this flag in sync with git-clone's --sparse flag and whatever
> capabilities grow there), but I don't see it as a solution to this
> problem.  I think the default needs to be copying the existing
> sparsity.  Making users specify cone/non-cone mode and
> sparse-index/non-sparse-index and and several dozen directories by
> hand just doesn't sound reasonable to me.  (We have a case with
> several hundred directories/modules, with various dependencies between
> them.  Users can use a wrapper, `./sparsify --modules $MODULE_A
> $MODULE_B` which figures out the several dozen relevant directories
> and calls sparse-checkout set with those, but of course that wrapper
> won't yet be available in the new worktree until after the new
> worktree has been added.)

Okay.

> An alternative that would be workable, though annoying, is giving the
> user a super-sparse checkout with only files in the toplevel directory
> present (i.e. what you'd get after `git sparse-checkout init --cone`
> or `git clone --sparse ...`), and then making them use the normal
> tools to manually specify the wanted sparsity (which probably requires
> switching back to the previous worktree to run some info commands to
> determine exactly what the sparsity was).

Sounds somewhat painful.

> An increasingly unworkable alternative is the current behavior of
> defaulting to a full checkout in all cases (and forcing users to
> sparsify afterwards).  A full checkout is fine if the user came from
> one (and probably preferable in such a case), but it's increasingly
> problematic for us even with our repo being nowhere near the size of
> the microsoft repos.

It feels unfortunate and a bit dirty to spread around this
special-case knowledge about sparse-checkout to various parts of the
system, but based upon the pain-points you describe, having a new
worktree inherit the sparsity from the originating worktree does sound
(given my limited knowledge of the topic) like it would ease the pain
for users.
