Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6A1C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 06:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949A361279
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 06:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhGIGO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 02:14:29 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:44743 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhGIGO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 02:14:29 -0400
Received: by mail-ej1-f53.google.com with SMTP id he13so14062517ejc.11
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 23:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnTLimjomCIlKIXC9lmFZjZgN6hoQy0h6Dk47YTE8CQ=;
        b=jRegAuKCCz+MLSao4bQGwYVhnGnBDObNjxpwD9Deh1aB4p+DlErHfvotzMy2G+cER4
         Zj0SW644pZ00t4SMQQ6tcXnylS9l15TNPkIVW0QNJDNo4Aq55rkYVq5OhDH1VI9y4FS6
         S9+/i8jb6L8tpthWO9H+YJT8GK7NvAX1+8zIwe5DYEfBFgGVJO6qpQX/rrfwCKWcjAYM
         oQ1mkE1BYS7l31HlMa+G7esOJmayUEHtrrXSwbjzF0H/0WLX68jB+W5axK172zz0OQ3P
         lcKHBGXsa2Qis+rjVE2gCYO3ragrw553lJjSAo8HrkXMABpH2GlZEmhztobnaYQ/sp9E
         HfPw==
X-Gm-Message-State: AOAM530mqcJ1zvYnwxisoOrG1OKPbsQgEcibcCTV52cCPhBhG/FOb4SO
        cQ8N6B0qVEM6vYFu7oa0TvtYMm7FXLEOGuBoE88=
X-Google-Smtp-Source: ABdhPJw0zUHfreAL02UuSawXawMhDBGLB1V5qrmq+cmFXYNZxuhu5r7vV+QJjiSdb+3rKJmkY8KjQpIi71nNgQga1+g=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr14211609ejb.482.1625811105511;
 Thu, 08 Jul 2021 23:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
 <CAPig+cSsPrQrP9xk8M8H339_NpYqKh1okeo1V-fAJ2zk3QeOjQ@mail.gmail.com> <xmqq7di3jkki.fsf@gitster.g>
In-Reply-To: <xmqq7di3jkki.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Jul 2021 02:11:34 -0400
Message-ID: <CAPig+cQbBPGN+Dcvmy+ZAZeKLpffRrN4-2PNjRHzDHj56axcJg@mail.gmail.com>
Subject: Re: [PATCH] worktree: teach `add` to accept --reason <string> with --lock
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 3:42 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >>  --reason <string>::
> >> +       With `lock` or with `add --lock`, an explanation why the working tree is locked.
> >
> > I realize that you're mimicking the interface of `git worktree lock`
> > which accepts an optional `--reason`, but I'm wondering if the
> > user-experience might be improved by instead allowing `--lock` to
> > accept the reason as an optional argument. For instance:
> >
> >     git worktree add --lock='just because' ...
>
> Thanks for thinking aloud, but I'd prefer the interface as posted,
> simply because there is one less thing for users to remember.  The
> justification to lock is given with the --reason=<why> argument no
> matter how you acquire the lock on a worktree.

My one bit of pushback is that, although the meaning of `--reason` is
plenty clear in the context of `git worktree lock`, it may become
ambiguous in the context of `git worktree add` if worktrees ever grow
additional attributes/features which are also accompanied by
"reasons". That possibility suggests that this particular
reason-giving option of `git worktree add` ought to be named
`--lock-reason`, but `git worktree add --lock --lock-reason=<reason>`
feels clunky and redundant, which is why I was wondering if `git
worktree --lock[=<reason>]` would be a better (and more convenient)
UI.

I'm questioning the UI choice now so we can avoid backpedalling later
on, if it ever comes to that, but perhaps my concern is unfounded.
(Indeed, I haven't been able to come up with cases which would make
`--reason` ambiguous.)
