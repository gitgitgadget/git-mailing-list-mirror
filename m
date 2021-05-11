Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8FC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25D5617C9
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhEKR6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhEKR6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:58:30 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F05C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:57:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso18252387otn.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AA629up3OuCUjWrSLMz/tl+WjzSXI/lpDn24WUl6M4o=;
        b=N0O28gP7Zi+hDUudeP0f0w9rfXLDvPIzFPihIMq4KJ0C7WSHi33C67IxzJFxTz975T
         hm4zOQgelGkGSrt9TxHmLg/mPXMx6B4UwqCdbmWyFjcgYfl+xhzVofR9vlAPLF1DtaAB
         kcQjHSatflEERsK/haSIULT4BxHDDehw9h6x7lG40Qbl0R248uSH54DZIDz/yhWd9ttL
         TxfzF8w2z2dQm7M//f86uZj2Xfwiq7t0WNbKcvivfnrOXAPcVFX2dqIhkqiknlMWzz9w
         nQqI6gsu7kQZ+0fOU6FsIM5pcM2NLklcEgipGAZZELBJ+1RvG+ff1ohf22oFP4hU12NW
         6S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA629up3OuCUjWrSLMz/tl+WjzSXI/lpDn24WUl6M4o=;
        b=bqwMRhL442tEekyHXSsgu399de1461KpcfPCOTvCPo2twCm0RTJvS2uDQQ5rqOJgbf
         WyQeydXtoKI1hd8gKY2qi7hfWh1qvHR9i9jklBcP49enSXdyFVpG+eGOpCcvmJoNdGFU
         cAuzE96hBcwYKa0lt4MX1MdDIzUUbmARrpN0U4ZjMB9+EjV6GO6hljqt9JOAYFgA8L5K
         NMy8zoVc8SSEZDcCqtZI6g9iLlKlIofhG741hM06v1e3pUddAi2ArFf7JdjSCtc8Z5M4
         1B7yZZdWa39mm/JbqzyG3i3o1AYIVRB8VSsylrfZeXgsacTBj5OQTXIHfvS7glY0RB6d
         77hQ==
X-Gm-Message-State: AOAM530UtKbJBhCtQ3Kra42oHIiOsY42pGjc3yuE/NxyvXR0GrymukDS
        Ec5yR+10yiLGcz1drug1gI84ZcYbVwfZntMf5k4=
X-Google-Smtp-Source: ABdhPJwepdZDwK4OIl1HvsrWNPxx/y94JroqhtgzbTBVS/fJM7qKlP6yae6pRPTqy3//xwC08TxbEk0X9PKxIZqmR8A=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr19895254otj.345.1620755843459;
 Tue, 11 May 2021 10:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com> <66ffc7f02d08f3f07cb3cb2605b113a630f1e127.1620503945.git.gitgitgadget@gmail.com>
 <xmqq35uvrvfv.fsf@gitster.g>
In-Reply-To: <xmqq35uvrvfv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 10:57:12 -0700
Message-ID: <CABPp-BE6-qH6NPf4-g5MiWwTsX=58vFGEOY4dTA2sY=zfyaEMg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] dir: avoid unnecessary traversal into ignored directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 10:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Some sidenotes about possible confusion with dir.c:
>
> Thanks for working on untangling this mess ;-)
>
> > * "ignored" often refers to an untracked ignore", i.e. a file which is
> >   not tracked which matches one of the ignore/exclusion rules.  But you
> >   can also have a "tracked ignore", a tracked file that happens to match
> >   one of the ignore/exclusion rules and which dir.c has to worry about
> >   since "git ls-files -c -i" is supposed to list them.
>
> OK.  This is to find a pattern in .gitignore that is too broad
> (i.e. if the path were to be added as a new thing today, it would
> require "add -f"), right?  The combination of "-i -c" does make
> sense for that purpose.
>
> > * The dir code often uses "ignored" and "excluded" interchangeably,
> >   which you need to keep in mind while reading the code.
>
> True.  In tree .gitignore files are to hold exclude patterns, and
> per repository personal exclude file is called $GIT_DIR/info/exclude
> which is confusing.
>
> > Sadly, though,
> >   it can get very confusing since ignore rules can have exclusions, as
> >   in the last of the following .gitignore rules:
> >       .gitignore
> >       *~
> >       *.log
> >       !settings.log
> >   In the last entry above, (pathspec->items[3].magic & PATHSPEC_EXCLUDE)
> >   will be true due the the '!' negating the rule.  Someone might refer
> >   to this as "excluded".
>
> That one I've never heard of.  As far as I am concerned, that is a
> negative exclude pattern.

Oops, I was mixing up negative exclude patterns and negative (or
excluded) pathspecs.  So "exclude" can refer to "ignored" files, or be
used in "PATHSPEC_EXCLUDE" for excluded pathspecs.

...and there's another way it's used.  "exclude" can also be used to
refer to "exclude" patterns, meaning the patterns that .gitignore (and
related files) use.  However, .git/info/sparse-checkout re-used these
same rulesets, but then used them to determine path *inclusion*.  At
my request, Stolee mostly fixed that up in 65edd96aec ("treewide:
rename 'exclude' methods to 'pattern'", 2019-09-03) but you can still
occasionally find a code comment referring to an "exclude" pattern
that might actually be used by the sparse-checkout stuff as an
inclusion rule.

And then we have a myriad of other variables and comments with "excl"
in their name that might be derived from any of the above three...and
it's sometimes difficult for me to remember which one of the concepts
such a derived variable or comment might be referring to.

*sigh*

> I do wish we started the project with .gitignore files and
> $GIT_DIR/info/ignore both of which holds ignore patterns and
> negative ignore patterns from day one, but the boat sailed
> long time ago.
