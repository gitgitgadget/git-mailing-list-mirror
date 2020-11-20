Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43FC5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8C42222F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgKTGjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 01:39:14 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33911 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgKTGjN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 01:39:13 -0500
Received: by mail-ej1-f68.google.com with SMTP id o9so11414306ejg.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 22:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJo3OOsBM0WbQ8Bp2AT1fiLOnm8Z45g/KBsRbcYzjBI=;
        b=dCr9k+MYZ7CwSCcp/lk3AVfuORlfI/4Dm9iW6MvSkL9Nq4rBGvVl+CEXpqCKpZvtD7
         ll4NZkQx8NL3m4qGILqq0Bh0sn9sNBeiRMhUWVcVfbXeT+t1JpWiN7NkJ4YnqhsZ8rgE
         TDLXOCuO+j3wBZfSr/GOPhI/+4eWrcbZzEaPJeczwbtJv5OYEDjDDloVu1S4PukGiazn
         7Vkhg+bcWPjeEBGMRVE2qjGv3AYBCEg/NQ9eEdk9jKRG760UyHzN8jHkHm6Q8fPm6E4L
         /OHNhAkvWz+BKOW+xMjIiQJuMrbiTjslViJoNymf2ERZYeYBYzAXcDe/yOZcJWYvwoGY
         tWkw==
X-Gm-Message-State: AOAM5338XFD/XjhLwjSHgez0bvtp7ULzNM+VsQ12zmEAcDHnOc57pCqg
        jsYOcdtlhpvUpnws2rmgI6VS4lC8pfzhrAfpVdRjI/Gz8eI=
X-Google-Smtp-Source: ABdhPJyFOmAzzYtlkdppQuEr1uP/yPzU3KMaG+J/SxSLPf0VasCGxat0iLkdGxRcCjv7BxvxzbH/dG+GbyttcHr8Bps=
X-Received: by 2002:a17:906:5587:: with SMTP id y7mr9432001ejp.138.1605854350077;
 Thu, 19 Nov 2020 22:39:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
 <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
 <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com> <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
In-Reply-To: <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Nov 2020 01:38:58 -0500
Message-ID: <CAPig+cS5BUCaFN=MN+7gSTbvskffRdTJOgck6TrRRacxCc_CwA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 12:23 AM Orgad Shaneh <orgads@gmail.com> wrote:
> On Thu, Nov 19, 2020 at 11:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > [...] I wonder if it makes more sense to
> > instead just update documentation to tell hook authors to read
> > explicitly from the console rather than expecting stdin to be
> > available [...]
>
> I have a prepare-commit-msg hook that requires user interaction for
> choosing an issue. This hook must work from the terminal and also
> from GUI applications like IDE.
> [...]
> As I mentioned, I need it to work also when executed from
> GUI applications, so just reading from the console will not work
> in my case. I tried other ways to detect "running from terminal"
> without the tty condition, but couldn't. The environment variables
> are identical when running in a GUI terminal and in the IDE.
>
> Can you suggest an alternative way to determine if I can accept user
> input from the console or not?

Not at present, and I expect that the answer is that any such
mechanism for determining this would be IDE-dependent. (That is,
although your IDE doesn't distinguish itself in any way which your
hook can detect, other IDE's might, but that doesn't help in the
general case.)

What I can say, though, is that the additional information you
supplied in your response should be part of the commit message to help
reviewers and future readers better understand why this change is
wanted. The use-cases presented in the v4 commit message, although
helpful, didn't provide sufficient explanation considering that the
first question which popped into this reviewer's mind was "why not
have the hook read from the console explicitly?". (It is an
unfortunate fact that reviewer time is a limited resource, so many
reviewers on this list don't bother chasing down links like those you
included in the commit message of v1 -- which would have helped
justify the change -- but instead base their reviews only on the
information presented in the commit message itself. In my case, I was
only lightly skimming this series, thus didn't even bother chasing
down those links -- but have done so now for this reply.)

I do find it quite concerning that the way this series handles the
stdin conflict between the hook and `-F -` can break the hook silently
and mysteriously. How confusing for a user to write a hook which works
with `git commit -m msg` and `git commit -F file` but breaks silently
with `git commit -F -`. What is worse is that this breakage may be
outside the user's control. For instance, it is easy to imagine some
IDE passing the commit message to git-commit via stdin (using `-F -`)
rather than via a file (using `-F file`).

At the very least, this change deserves a documentation update, both
to explain that the prepare-commit-msg hook has a valid stdin, and
(importantly) that it won't be able to rely upon stdin in conjunction
with `-F -`. (This also makes me wonder if it would be possible to
signal to the hook whether or not stdin is available. Perhaps this
could be done by passing an additional argument to the hook.)

Finally, I realize that you followed Junio's suggestion for organizing
the series, however, it feels undesirable for patch [1/2] to leave the
command in a somewhat broken state, by which I'm referring to the
indeterminate outcome of the hook and `-F -` competing for stdin; a
situation which is only resolved in [2/2]. To me, a cleaner
organization would be for [1/2] to introduce the underlying mechanism
and support by adding `flags` to run_hook_ve() (and perhaps to
run_commit_hook()) but not to turn on RUN_HOOK_ALLOW_STDIN, and then
have patch [2/2] actually enable RUN_HOOK_ALLOW_STDIN where
appropriate _and_ deal with the `-F -` conflict all at the same time.
(And the commit message should mention the conflict and how it is
handled.)
