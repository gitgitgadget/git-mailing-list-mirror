Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8BC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B828B610C7
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhFVQIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFVQIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:08:52 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA3C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:06:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s17so1489659oij.0
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KtwzU/7X8G52bTt7FC+YIvwfXw8tgHKitp75rMOGy0=;
        b=ouFmhZYnuQrI56dJPTGrLo/zfBoADaFZ4P4+A+dBA+6RBKrKTEJnS2H9Ys5TEBWjde
         gesRoZ9Hm3QjLih65yfuJxn0u8D93N5wuJl9El5NAQBW7EfhJXjlW8nOq9vYK2pB6KaO
         ZGcLbUm0BN7iDqgOCGoW+4kZjo0k9JQKtfxDWvPitz2WgwN5NkPL+W4At49U8I60BBTr
         w7uUchbDqiEobLAdjkoE7bWhGC4ABjL5BVvxdIKhL3QUNxlYLxc0ejAKyC9hd7+z0r8C
         dp+H+VF2iYmQvAoPhYAtxG9tT2oQTqFoA+BWR8QQngTvZTVUit2hnRTINQMx9Ne7ugpN
         myig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KtwzU/7X8G52bTt7FC+YIvwfXw8tgHKitp75rMOGy0=;
        b=BQSDZrXxRV4zl4NEGJfOBVxvIgq90xNhyF+ntCfL3H2bwl/eFmymZSg5Y6J6CjYvva
         KMSjypfagdGSgcE3igZpaocWtbTqK3UHHY9iBR0DJamwpheQYYOAoPS5YmUS8jL+MIOI
         Lc61txk+TuXCDjTeU0GEqyAVYpNXbfzOwx+0V6AkQpYehWnOKa8Xl8jiOV4FfZmp82Jg
         hKt38HkIfcg3m8DGsIestHFjYbSjLpThJc2Ec0DpOxvMp2OS8LI9wgC9KQNk6OmxTnaL
         nclgnLC5q6vuqAzrWmG6foBo7SC7U6YWQOpG00eZ3sVuTPyuWKHh2VBsxxFvscAWfpeN
         phvw==
X-Gm-Message-State: AOAM5301+t47ETauYnY7UhwGjrlb74Mq1ztTcq7PlUKt85QJX/Tfr4dY
        Me12TUDTEI4QV+7lT6fKYI8LKjG3NGt/dfnHXtk=
X-Google-Smtp-Source: ABdhPJwd/hYXff+z8RhmLs/iEB+WJi8WSnFjX8B7MR+n/3sMe2fRwwrGyzGBIX8OPIK172wSiwr1yKGWLshI+aNUUS0=
X-Received: by 2002:aca:330a:: with SMTP id z10mr3812440oiz.31.1624377995020;
 Tue, 22 Jun 2021 09:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohp6+jW2C0ewfYEp3rrwbKSqGVa94LRgQDcKJvYmiANuA@mail.gmail.com>
In-Reply-To: <CAPMMpohp6+jW2C0ewfYEp3rrwbKSqGVa94LRgQDcKJvYmiANuA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jun 2021 09:06:23 -0700
Message-ID: <CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com>
Subject: Re: Untracked Cache and --untracked-files=all
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 2:25 AM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi folks,
>
> I'm hoping for a little help understanding *intent* around a
> particular code comment in dir.c, and reaching out to the whole list

Oh, boy, dir.c.  We should probably put a simple warning at the top of
the file, something like "Abandon all hope, all ye who enter here".

> because someone (Junio?) said they consider any mail that *doesn't*
> copy the list to be spam anyway, and the original author of the
> comment in question (Duy Nguyen) is no longer active on git.
>
> Context:
> I am trying to explore how to get "--untracked-files=all" to play nice
> with the untracked cache, so that windows users using tooling that
> sets "--untracked-files=all" can benefit from the same
> orders-of-magnitude git status performance improvements as commandline
> users.
>
> There is a "naive" approach to this (store the untracked cache in the
> index file with whatever dir flags were specified/used in the
> recursive walk, and ignore/rewrite that cached data every time the
> flags change), and there is presumably a more "comprehensive" approach
> (store all the information required in the untracked cache to be able
> to satisfy requests with either set of flags - even if this is a
> little more expensive on first run).
>
> The main disadvantage of the "naive" approach is that is every time
> you flip-flop between "git status" and "git status -u", the untracked
> cache is ignored, a recursive directory walk ensues, and the untracked
> cache is rewritten to the index file for the next time you rerun,
> hopefully with the same flags. However, I would think in most
> situations flip-flopping will be less common - more commonly you're
> using a tool or workflow that ends up running the same command(s)
> repeatedly... At least, that's my thesis. I would put this "store the
> untracked cache every time dir flags change" behavior behind a config
> switch, anyway.
>
> This "naive" approach *is* rather easy to achieve - you just need to
> recreate a new "untracked" structure inside
> dir.c#validate_untracked_cache() if you find a mismatch of flags (and
> make other small fixes to store the correct flags in that new
> "untracked" structure).
>
> The one thing that sticks out after making these changes is a code
> comment first introduced in 2015 by Duy Nguyen in ccad261f, explaining
> *why* we refuse to use the untracked cache with "-uall":
> > * See treat_directory(), case index_nonexistent. Without
> > * this flag, we may need to also cache .git file content
> > * for the resolve_gitlink_ref() call, which we don't.
>
> I've seen this comment many times over the past few months, and I've
> previously always interpreted it as a "correctness" concern.
>
> Looking at the original code in question, however (as of ccad261f,
> dir.c#treat_directory(), "resolve_gitlink_ref" call), I don't
> understand how correctness could be impacted.
>
> Fast-forward 6 years and all this code has been substantially
> overhauled by several folks over the years (most recently and majorly
> Elijah Newren), and the "resolve_gitlink_ref()" call is long-gone.

I didn't remember removing any resolve_gitlink_ref() calls, but a
quick search (`git log -Sresolve_gitlink_ref -p -- dir.c`) suggests it
was removed by b22827045e0b (dir: do not traverse repositories with no
commits, 2019-04-09).  A brief look at that commit message certainly
suggests things have changed in a way that _might_ make the original
comment irrelevant.

> Does this look familiar to anyone? Is there any remaining obvious
> reason to be wary of storing the untracked cache structure produced
> with '-uall'?

Untracked cache is its own beast.  I fought with it a bunch, but it's
been a while.  (See e.g.
https://lore.kernel.org/git/CABPp-BEWhavmtDi-ahT+QMWtD6Fe-Ey7cn_82nbetWEQJL=hRA@mail.gmail.com/)

I can say that untracked traversal had all sorts of weirdness and
breakage, which could have made untracked cache harder to make right
and consistent particularly with -uall.  See for example 8d92fb292706
(dir: replace exponential algorithm with a linear one, 2020-04-01) and
perhaps aa6e1b21e5de (dir: avoid unnecessary traversal into ignored
directory, 2021-05-12).  In particular, the exponential traversal
(paths at depth N might be traversed 2^N times) from the former commit
combined with the fact that later traversals often returned a
different status for a path than the first traversal certainly could
have caused some additional weirdness for the untracked cache.

It may be that some combination of Kyle's removal of the
resolve_gitlink_ref() and my removal of the exponential traversal of
untracked paths make your idea safe...but this is dir.c and
untracked-cache, so who really knows?


Not sure if that helps, but I hope one or two pointers I provided are
somehow meaningful to you.

Elijah
