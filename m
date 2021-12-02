Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577BC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 16:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359784AbhLBQ5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359780AbhLBQ5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 11:57:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F2C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 08:54:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v1so699879edx.2
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W/NRYgCdKojgg8L83jffssXZEOKfGrpG3bkRKSWHhWI=;
        b=aQZKje/gjX2yHVU6LRQ2IqPmSXw8rGnxkTn+oTH+NP9YxnTFYNfAGa2APGnlm/FL1x
         n5gUIktbwcDyU/BBfiETSLGwYz4pkUiJfpEwc9811pQSjfUYZY1MxxrYpzdrJBZOwuoK
         byPSizD9WIskNZsV46waLA54wUjtToNLJEHc/8Zxubhd6cU5psmXhJdoVDr2jfeZ+8jj
         4hy4DtXOKto3CYeSZHrk5BmNd5UZxtA7I3awUzVukisSasrCqoE9Eaf7E2JLYNOq3JSq
         BbqdL/VPh9TSi6W1S1qpj3TRuXvMcPl7xwGO6s3IL/kqFsAFIeX9lFOHmq9IbFxmBO94
         /SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W/NRYgCdKojgg8L83jffssXZEOKfGrpG3bkRKSWHhWI=;
        b=28QPvEMP96Kx9zcFr2JBVQmiVk5GkJArHB51/W9fmg2sjgumW6Jl7PLydCxenTVkwa
         1BzSCgnOm5NmQUsbVs+i7nv+gZ+/JKlh6qEeq+dFtJRLqdTVvgVIwJPvtn+b/aeZhGjP
         uslduVTSCShxpVHzZeY8D8MP+AP8oOfVxeJB4VRD3Oarti6QAYUfDJw3Idrgrr/jHXuR
         lZXe5QlB2cPeBzuCj7cf+PyHr0QI0TvB9W9Fyod5qNobuwIS8tmT04EAT6+OJJ2dWinC
         df3JlznTmMntFUB1gh8uWCswszKFMuT6kcsZfXoIoqi1RKC5qSlj4fPzB6vfNFSaEBKs
         qnFw==
X-Gm-Message-State: AOAM5308TyM+P9ZvumSpOA3wHf1LBIWIO/x9eLnGSKtiRM73Ls2HbNAf
        dgA7J+A5q1RwQ902lY7GZXbVRmhPOcrGrCHTiXapJtMipaE=
X-Google-Smtp-Source: ABdhPJyXNXelYwVvaVyz1Uoz37XMyRL6Myd29DMspD4bCqEYIqzpCzm1MlZuCLaABk0inKXSwXErdoqxOfUIcJ0iNZo=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr19380051edu.186.1638464064326;
 Thu, 02 Dec 2021 08:54:24 -0800 (PST)
MIME-Version: 1.0
References: <YYFEE/2g3SiM04zx@hades.panopticon> <YYFJEASSimMhEsYz@coredump.intra.peff.net>
 <YaEh+k2q+9LoLXNh@hades.panopticon> <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
 <YaFViM1tTTAc48ZG@coredump.intra.peff.net> <Yajlf6e2aRIpTBqB@hades.panopticon>
In-Reply-To: <Yajlf6e2aRIpTBqB@hades.panopticon>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Dec 2021 08:54:12 -0800
Message-ID: <CABPp-BFn8kKh1zQqwRSX1+06eNwgAZLfsg9g5LkHepHeZ2ip+Q@mail.gmail.com>
Subject: Re: pull.rebase config option broken in 2.33.1
To:     Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 2, 2021 at 7:27 AM Dmitry Marakasov <amdmi3@amdmi3.ru> wrote:
>
> * Jeff King (peff@peff.net) wrote:
>
> > > > > > After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> > > > > > no longer works: `git pull` no longer tries to rebase (however manual
> > > > > > `git pull --rebase` works fine):
> > > > > >
> > > > > > % git config pull.rebase
> > > > > > true
> > > > > > % git pull
> > > > > > fatal: Not possible to fast-forward, aborting.
> > > > > > % git pull --rebase
> > > > > > Successfully rebased and updated refs/heads/local-fixes.
> > > > > > % git pull
> > > > > > fatal: Not possible to fast-forward, aborting.
> > > > > > % grep -C1 rebase .git/config
> > > > > > [pull]
> > > > > >       rebase = true
> > > > > > [rebase]
> > > > > >       autostash = true
> > > > > >
> > > > > > After downgrade to 2.33.0:
> > > > > >
> > > > > > % git pull
> > > > > > Current branch local-fixes is up to date.
> > > > >
> > > > > This looks like the same bug discussed in:
> > > > >
> > > > >   https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/
> > > > >
> > > > > There's a fix in that thread. It's currently in "next", but didn't quite
> > > > > make the cutoff for the upcoming v2.34.0.
> > > >
> > > > For the record, the problem is still present in 2.34.1
> > >
> > > In the bug I linked (and what got fixed in 2.34.1), the issue is that
> > > when the local branch is ahead of the remote, we don't say "up to date",
> > > but complain about fast-forwards.
> > >
> > > It's hard to tell from the output above, but it looks like you have a
> > > case where there are new commits both locally and on the remote? In
> > > which case a rebase would work just fine.
> > >
> > > But why are we complaining about "not possible to fast-forward"? Testing
> > > locally with something like:
> > >
> > > -- >8 --
> > > git init repo
> > > cd repo
> > >
> > > commit() {
> > >     echo $1 >$1
> > >     git add $1
> > >     git commit -m $1
> > > }
> > >
> > > git checkout -b local
> > > commit base
> > > commit local
> > >
> > > git checkout -b remote HEAD^
> > > commit remote
> > >
> > > git checkout local
> > > git config pull.rebase true
> > > git pull . remote
> > > -- >8 --
> > >
> > > shows that we do rebase. If I set:
> > >
> > >   git config pull.ff only
> > >
> > > then we start complaining. And that behavior did change in 2.33.1, but
> > > I'm not sure it's wrong. We have two conflicting config options, and the
> > > precedence for which one we pick switched.
> > >
> > > Do you have that option set in your config? Try:
> > >
> > >   git config --show-origin --show-scope --get-regexp 'pull\..*'
>
> Yes, I have both `pull.ff=only` and `pull.rebase` set, but these
> come from different configs:
>
>   % git config --show-origin --show-scope --get-regexp 'pull\..*'
>   global  file:/home/marakasov/.gitconfig pull.ff only
>   local   file:.git/config    pull.rebase true
>
> IMO the setup is perfectly legal, as I want to disable merge on pull
> in any case, and I also want rebase for a specific repo. So the
> problem is then in how these options override (not) each other.
>
> The following change in repo's config fixes this issue for me:
>
>    [pull]
>   +    ff = yes

ff is a tri-state -- false, true, or only.  yes is equivalent to true
and means "allow but do not require fast forward updates".

>        rebase = true
>
> But IMO it still needs to be fixed in git, as the cause of this
> problem is quite unobvious and it does not feel right that local
> repo config should be aware of global config and include explicit
> overrides not really realated to the local repo config, for the
> latter to work as expected.

If you had pull.ff=only and pull.rebase=true in your local config, it
would also error out.  Thus, it makes sense that having pull.ff=only
in global config and pull.rebase=true in local config should error
out.  The scope at which you get the variables doesn't matter, other
than that if you set the same variable in both, clearly local should
override global.

> It looks like it could be fixed by either making `pull.rebase` on
> repo level override `pull.ff` on global level

Scopes can only matter when the same config option is set in both
local and global config.  By the time we get to the program logic
trying to interpret options, there is no notion of which scope the
config came from.

> , or reorganizing the
> options so no override is required, for example by introducing e.g.
> `pull.merge=off` instead of `pull.ff=only`. This way having both
> `pull.merge=off` and `pull.rebase=true` will not contradict each
> other and will not require any cross-variable override logic.

Your suggestion to add a third variable to the mix would increase the
worries of cross-variable override logic, not decrease it.  For
example, what if pull.merge=true and pull.rebase=true?  It'd be better
if we could go back in time and have a single pull.mode instead of
having two options; adding a third would be going in the wrong
direction.

Anyway, both merges and rebases are capable of fast-forward updates.
pull.ff=only corresponds to the --ff-only command line option,
documented in git-pull as "Only update to the new history if there is
no divergent local history."  Thus, that setting is incompatible with
reconciling divergent changes, which means that neither merging nor
rebasing should proceed.

If you usually want to avoid merges & rebases, but in one repo you
want to have rebases, then in addition to setting pull.rebase=true
you'll also need to override pull.ff by setting it to true (or
equivalently to 'yes' as you did) in your local config as well.
