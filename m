Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64351F462
	for <e@80x24.org>; Mon,  3 Jun 2019 08:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFCIoy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 04:44:54 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43596 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFCIoy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 04:44:54 -0400
Received: by mail-lf1-f44.google.com with SMTP id d7so3389806lfb.10
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 01:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e5hpxW6nG7Ht+w0I9JLNK++uE9RmZWzcut8GekVtLLg=;
        b=dHRVp2q5WoAc5l02VH7FmR77pCwKlX5pclF17Bclv5Cd6FCNkvqnVhYGISgU71IYSO
         0C9fSRvVLQQXyAEq8EsoJ4ZM9iEkpSWpRayMAsT84Ekn08UjkSHCGLn3zGU0iFuRE//+
         QSske13ohhhf6Z9VvUNB74+HEzyraqbDl4GuO1NRU8z5aSik6jM8cbUty9yBi7d1rS4l
         fN25nmSsfwB8fBH4Kvj7frmWbJ38kd807RcnvO5G8XB3pJvTgvIySvaZJyrP/vrAWmDG
         //CGCUY46874xdxxitv3TNZk5W+4tFKE5vP1UnVY+6KfHJHwwRlWPHMcRxXUOXU4xNdJ
         2VDg==
X-Gm-Message-State: APjAAAXycnfiXE51qHmodFAPn8q7s+F9gtpIlJXaRHKb3/flpyqWllWz
        ROCOVeT+oJNYJFflMKXUt5s858uAE/3BOPeN1B4qZhaa
X-Google-Smtp-Source: APXvYqxBNqDWsJmeN+JwImmiJfnN153j2Fxy9teqFrO3uL79S12Urea1EfQdqhzEaQoCpPW6BLjIrtytaoSWU//ZYtc=
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr13062164lfm.87.1559551490943;
 Mon, 03 Jun 2019 01:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <670f44c0ac554f2faec5a6112376b015@MSSMAILP06.ads.hel.kko.ch>
 <xmqqtvxvxefx.fsf@gitster.mtv.corp.google.com> <CAGe7hXBPWvjaKZtz-Zn1az0HrCx=OpxGsghVJhLOBKMu3NJ2zA@mail.gmail.com>
In-Reply-To: <CAGe7hXBPWvjaKZtz-Zn1az0HrCx=OpxGsghVJhLOBKMu3NJ2zA@mail.gmail.com>
From:   David Eisner <david.eisner@oriel.oxon.org>
Date:   Mon, 3 Jun 2019 09:44:39 +0100
Message-ID: <CAGe7hXCqC9hYc3brekqcT4A5O4muzAL=7RzHjviSusMMY5qc_Q@mail.gmail.com>
Subject: Fwd: [Feature- Request] Option to commit after checking out branch
 command is made
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

Interesting discussion.

Though it's a pretty distant memory now, this "forgot to commit"
scenario was really frequent for me when I started using git. Then I'd
run commit and forget that it's split (from an outsider's perspective)
into add and then commit. I like the design of git, trees, index, etc.
now that I get it, but being kicked from one command to another with
an error message which may or may not tell me which command I should
have used is not fun.

Surely if it's an interactive "commit/stash/cancel" prompt, it could
default to cancel for non-interactive settings. If you're running a
script interactively that just does "git commit" and ignores the
output, the prompt would be fine. If you're running a script in a
non-interactive way, piping the command within the script, even just
to logs, etc. the prompt will not appear, just like with log or diff,
which do not use a pager in non-interactive contexts.

Generally, I think that prompting by default instead of warning and
quitting is a really good way to go. It more gently initiates the new
user, while still giving the option to quit and deal with the issue
another way. Seasoned users should be able to disable individual
prompts or all using options. Scripting should be a secondary
consideration for porcelain, because you can build more reliable
scripts by either using porcelain or being more explicit with
arguments and options. For example, in a script, it would be better to
specify the remote and branches for a push, rather than using
defaults.

Autostash/autocommit options would be great, if they also have "git
config checkout.autostash/autocommit" and --no-autostash/autocommit
and are set to prompt by default, or perhaps one autostash option that
can be set to false/stash/commit/prompt.

Yes, you could do this with scripting over the top of the existing
commands, but the best experience for new users should be available
out of the box, not by writing scripts.

On Thu, 16 Nov 2017 at 01:07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ninivaggi Mattia <mattia.ninivaggi@helsana.ch> writes:
>
> > 1. I checkout a branch, without having commited first
> >     > git checkout dev
> > 2. I get this error message:
> >     > error: Your local changes to the following files would be overwritten by checkout:
> >     > // List of files
> >     > // ..
> >     > //
> >     > Please commit your changes or stash them before you switch branches.
> >
> > But I would rather prefer a scenario like this:
> > ...
> > 1. I checkout a branch, without having commited first
> >     > git checkout dev
> > 2. I get a message like this:
> >     > Your local changes to the following files would be overwritten by checkout:
> >     > // List of files
> >     > // ..
> >     > //
> >     > Would you want to commit first? (y/n))
> >
> > IF y --> prompt for commit message and commit automatically
>
> I do not think you want to do this for a few reasons.
>
>  * The "please commit or stash" is merely a suggestion whose primary
>    purpose is to silence clueless newbies who would have complained
>    "Git said 'error: ... overwritten by checkout' and I do not know
>    what to do next; the error message is so unhelpful" otherwise.
>    Majority of the time when I see this message, it is because I
>    forgot that I was in the middle of doing something (meaning: I am
>    far from finished with the changes I was working on), and I would
>    not be ready to commit.  I'd rather keep working to get the work
>    into a more reasonable shape before committing, or stash the
>    changes first if the task I wanted to do on that "dev" branch is
>    more urgent and what I was in the middle of doing is lower
>    priority.
>
>    Because of this, I would expect many users (including the ones
>    who are right now newbies but will have gained experience to
>    become experts in the future) to appreciate "stash before switch"
>    a lot more than "commit first before switch".
>
>  * People write scripts that use "git checkout" to switch branches,
>    and they rely on the command to fail in this situation, instead
>    of going interactive and gets stuck waiting for an input (which
>    may never come).  Because of this, the updated behaviour you
>    propose must never be the default, and at least must be protected
>    behind a flag, something like "git checkout --autostash dev" (or
>    "--autocommit", if you insist).  With that, you could do
>
>         [alias]
>                 co = checkout --autostash
>
>    and train your fingers to say "git co dev".
>
> Of course, you can have a "git-co" script on your $PATH, which runs
> "git checkout $1", lets it fail just like it does now, and then does
> "git commit", if you really want the behaviour.  Again, you can then
> use "git co dev" and you do not have to worry about breaking
> people's scripts that depends on "git checkout" to fail without
> going interactive.
