Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B003C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129CC2072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbgFWVNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:13:17 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39801 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391145AbgFWUag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:30:36 -0400
Received: by mail-wm1-f45.google.com with SMTP id t194so95003wmt.4
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 13:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i76G29sVIY5ECdLkQZCB+6NrYGplhMZQO2MCn7lGQH8=;
        b=dL3JhpKCJ/lj+e0en+e6WPIEXZoPunilOf51m3M+G+XTiyOSFhSJIOk0/uJOe01wh6
         OX96Jy8WbTxEJysNMojSx8HVTU38pP+hazKZdC+ej1/TNVKApIKk8fy03hpbIU7MNa+6
         0iKRTrL4AM4ENOnJZIAC3svIACgI1ObnVBmPRofRtIema0NbOJ/ZKVBcyR/MhynW9Y8u
         kbCG9V5/4H3v8CLm2yBPqsW1jeDl6QfN7htH26WLTCZlFNGhXaletx8LeCVitw8Z+LD9
         JRMOvlB+2VPm3ueHuqSKsTUd7TABapoyeHRjq9hlSq1eL1lipttiMykdTiXvViZzvmEy
         LSqQ==
X-Gm-Message-State: AOAM532kky4rOz99iFGddFuD0XsOPF89nIOqNxQXil7IG8F2weS3kR3E
        QaeYtAraqoW9dKy58Q2t3hZ/AqnwqNuS6PXhRUapfP/qAtM=
X-Google-Smtp-Source: ABdhPJz2kx7IAs4veJmGpWrSM9oKzqi0L87KbRFH+X+bsEnbkMK6DpndvgJfVilPJk4frOgQKSxE+eSfLqdZyAhNo5M=
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr19275585wml.177.1592944234114;
 Tue, 23 Jun 2020 13:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152505.GI1435482@coredump.intra.peff.net> <CAPig+cTMu3SW5UE59Eva=jh-07hOT8Dz5A5trWyEugKd_2HaKg@mail.gmail.com>
 <20200623183053.GA1444619@coredump.intra.peff.net>
In-Reply-To: <20200623183053.GA1444619@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Jun 2020 16:30:23 -0400
Message-ID: <CAPig+cTFkAOyLG1Sm_p11GgH9Ms87_7zs-7kFbEYZ-uXg1yrYw@mail.gmail.com>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 2:31 PM Jeff King <peff@peff.net> wrote:
> On Tue, Jun 23, 2020 at 01:16:05PM -0400, Eric Sunshine wrote:
> > On Tue, Jun 23, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> > I understand that your intention here is to demonstrate both forms of
> > --seed-anonymized, but I'm slightly concerned that people may
> > interpret this example as meaning that you are not allowed to
> > anonymize the refname when anonymizing a pathname. It might be less
> > ambiguous to avoid the "short form" in the example; people who have
> > read the description of --seed-anonymized will know that the short
> > form can be used without having to see it in an example.
>
> I'm not sure what you'd write, then. You can't mention "mybranch"
> anymore if it was anonymized. Are you suggesting to make the example:
>
>  git rev-list -- foo.c
>
> by itself?

Sorry, I meant to provide an example like this:

    For example, if you have a bug which reproduces with `git rev-list
    sensitive -- secret.c`, you can run:

    $ git fast-export --anonymize --all \
        --seed-anonymized=sensitive:foo \
        --seed-anonymized=secret.c:bar.c \
        >stream

    After importing the stream, you can then run `git rev-list foo --
    bar.c` in the anonymized repository.

> > > +Note that paths and refnames are split into tokens at slash boundaries.
> > > +The command above would anonymize `subdir/foo.c` as something like
> > > +`path123/secret.c`.
> >
> > Confusing. This seems to be saying that anonymizing filenames in
> > subdirectories is pointless because you can't know how the leading
> > directory names will be anonymized. That leaves the reader wondering
> > how to deal with the situation. Does it require using
> > --seed-anonymized for each path component leading up to the filename?
>
> You can do that, but I think it would be simpler to just find "secret.c"
> in the anonymized repo (either in the checkout, or just "git ls-tree
> -r").
>
> > Or can --seed-anonymized take an full pathname (leading directory
> > components and filename) in one shot?
>
> No, it can't. Suggested wording? That's what I was trying to say with
> the above sentence.

Hmm, perhaps your original attempt can be extended slightly to state
it more explicitly?

    Note that paths and refnames are split into tokens at slash
    boundaries. The command above would anonymize `subdir/foo.c` as
    something like `path123/secret.c`; you could then search for
    `secret.c` in the anonymized repository to determine the final
    pathname.

    To make referencing the final pathname simpler, you can seed
    anonymization for each path component; so, if you also anonymize
    `subdir` to `publicdir`, then the final pathname would be
    `publicdir/secret.c`.

This makes me wonder if --seed-anonymized should do its own
tokenization so that --seed-anonymized=subdir/foo:public/bar is
automatically understood as anonymizing "subdir" to "public" _and_
"foo" to "bar". But that potentially gets weird if you say:

    --seed-anonymized=a/b:q/p --seed-anonymized=a/c:y/z

in which case you've given conflicting replacements for "a". (I
suppose it could issue a warning message in that case.)

> > Would it be worthwhile to add a check somewhere after the
> > parse_options() invocation and complain if --seed-anonymized was used
> > without --anonymize? (Or should --seed-anonymized perhaps imply
> > --anonymize?)
>
> I thought about implying, but I have a slight preference to err on the
> side of making things less magical. I don't mind triggering a warning or
> error, but it's not like anything _bad_ happens if you don't say
> --anonymize. It just doesn't do anything, which seems like a perfectly
> logical outcome.

Lack of a warning or error could be kind of bad if the person doesn't
check the fast-export file before sending it out and only discovers
later that:

    git fast-export --seed-anonymized=foo:bar

didn't perform _any_ anonymization at all.
