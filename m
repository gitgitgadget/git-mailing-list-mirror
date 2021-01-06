Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62BBC433E9
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1FA2065E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbhAFSS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 13:18:59 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:44748 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFSS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 13:18:58 -0500
Received: by mail-ej1-f46.google.com with SMTP id w1so6199669ejf.11
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 10:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DYpyar0HHLXxWK//sA68ciItRqdSbMH9eJtYchh7kY=;
        b=KsE/gcae9Jk7DcP8Lzwvn1pMt5EftTPtblw33Li2NAISjw9p1NQJAbmNf563qsyywU
         eQQpJ6RUL8iOOOCB3QqOTCfdd07lzFALh6ZnoWv6Y92qZjxv55/YQmk8lXZZanEphoD7
         bja2KMs5RZOdc6Ld2P5A1MRdIyJZW5ChgfoQa3yPBEqMTDquhJHPP2GHLTXK8hz+xm7o
         MiBmTyQCzrCSxWAKDHHSnxUH01EktQigKTcCd+w9oPQNa6eDluejty0zx86rj3gi2HIS
         hW40g31BL3yUepENo6pjuzAKl0C5K9wQ5y9Ifx4CCYbNEZy4DdXG7LNfbBrvhtb2pn15
         m6pA==
X-Gm-Message-State: AOAM533M83WBVAUBXsQtvlbH9rMorfABZzNhACLGIcgG0s0D3b/JP/c4
        4gRfhTV9wTDmBdfy3gdPE0p7nWDgiBUUQrA0hFWDUZ2Z+ps=
X-Google-Smtp-Source: ABdhPJx5CKqZOWRW0qTVsH/RUSujj2137GYBk54PWG0iI68DNx8lcjZ7LESc8n3AArB4Mt/xsqIfAUpKeAXRABnf03E=
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr3601891ejb.202.1609957096418;
 Wed, 06 Jan 2021 10:18:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
 <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com> <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
 <63e618bd-a60e-0692-6489-06b4b0504895@gmail.com>
In-Reply-To: <63e618bd-a60e-0692-6489-06b4b0504895@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 13:18:05 -0500
Message-ID: <CAPig+cRCpgrhypq-0n5skiHYVXC9RrLDgC9vyi2k83p=6JuYcw@mail.gmail.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 6:54 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 1/5/2021 11:20 PM, Eric Sunshine wrote:
> > Is the behavior implemented by this patch desirable? That is, if the
> > user mistypes the name of the configuration variable, would it be
> > better to let the user know about the problem by returning an error
> > code rather than succeeding silently? Or do you foresee people
> > intentionally running the command against an empty config variable?
>
> As mentioned in the message, this is the situation the background
> maintenance would see if a user used 'git maintenance unregister' on
> all of their repos or removed the 'maintenance.repo' config values
> from their global config. I think it would be better to not start
> failing the background commands.
>
> Even outside of that context, we have no way to specify an "existing
> but empty" multi-valued config value over a non-existing config
> value. I'd rather prefer the interpretation "I succeeded in doing
> nothing" instead of "I think you made a mistake, because there's
> nothing to do."
>
> Could we meet in the middle and print a warning to stderr?
>
>         warning(_("supplied config key '%s' has no values"));
>
> That would present a useful message to users running this command
> manually (or constructing automation) without breaking scripts
> that parse the output.

I don't know. My knee-jerk response is that such a warning could get
annoying quickly if this is used mostly in an automated environment,
and an empty config value is likely to come up in practice. In that
case, I'm somewhat negative on adding the warning. (I could perhaps
see a --dry-run or --verbose mode issuing the above warning, but
that's outside the scope of this series.)

> > Is the API of this command ideal? It feels odd to force the user to
> > specify required input via a command-line option rather than just as a
> > positional argument. In other words, since the config variable name is
> > mandatory, an alternative invocation format would be:
> >
> >     git for-each-repo <config-var> <cmd>
> >
> > Or do you foresee future enhancements expanding the ways in which the
> > repo list can be specified (such as from a file or stdin or directly
> > via the command-line), in which case the `--config` option makes
> > sense.
>
> I believe some voice interest in specifying a list of repositories
> by providing a directory instead of a config value. That would
> require scanning the immediate subdirectories to see if they are Git
> repos.
>
> A --stdin option would also be a good addition, if desired.
>
> Since this command was intended for automation, not end-users, it
> seemed that future-proofing the arguments in this way would be a good
> idea. We want to remain flexible for future additions without
> breaking compatibility.

Fair enough.
