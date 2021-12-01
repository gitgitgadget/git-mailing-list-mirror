Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ED6C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353822AbhLAXoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353809AbhLAXoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:44:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A5C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 15:40:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so42679796edq.7
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sj6dBpZ1Ese7MTiCz/OTi2irSkXhf9Cj0ZbXg0XEans=;
        b=BksMr6EaiWEEwh2eGd1yl9STMjTP6a6cOsV6AGJR43wSvKbGhXBw+VmSKrTHmZTOmf
         IXFBVlQjGXXZiPe9ggygUvMrZwfdNNu/cZ1Lkts5E4TrnA3/WCsW1ZIccoeu0fSec9BP
         Kl6R1cUeZfFKJrKDR7s3w/sA1bqVf7dKJlr0XaUReqmZUOTVm3cOCVuG/3B9BgUasgeU
         TAzCIssT+bSRf9PIeutQ+UtY7XCetA6E+PChq1un0/rZF2U6pj5dZgDihs95KfJeeG+/
         8U6IkaI4Adh85JcUc/xucpBq0y+KjPRPrCDlYThW/E2j1Y6aimDIKZScutGlzwt2WcQO
         8uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sj6dBpZ1Ese7MTiCz/OTi2irSkXhf9Cj0ZbXg0XEans=;
        b=eVN1Ah79ca3tXSXELHn7hjt81W+m4P3P37CuqQGE34udBf+f0gh/5r4m8fhrMeh0mN
         wgWoETQiWLX1a3dMRQL4UrUUj+xWUUfdc8ghasa8aPprVR0/Yid0c0y3vJebjouKxjPX
         sbKy3FQFuBoO1j+jrcL3AsMa+tRuL6tF2GqN4u6xEqvbdGBGGSOsIyH3XgfVAknjxugh
         //7+qzfoZYzRTs7HdhjdGnq62OpPXWLIjSfYxmQ6zjg2KW8f8MTs9zpgbXei6hABtrWT
         3fXVAHDsEfV1jBIvr7TS/SdVg1ubXXEnnAp3ZOS561Hdq/vGAtvh8KJjJh8qo+gc3WjE
         meaw==
X-Gm-Message-State: AOAM532mqOYJ4iCHkwFSr4f1cG/WPMPgSObsVImE99BVoyaEbrf35OoM
        vbHxBYQoiQNuuCNEDZ/Geh3nTL/b7Naz7C1G2t0=
X-Google-Smtp-Source: ABdhPJxq6J+mC8RjA51bLcn22jbGjHwiWNkUQVVOnMC4hlYIoHotmObvYKEL/+AnJfZtE/W7cyJfO8vsQlzcz4tXnXQ=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr6998007ejh.172.1638402047421;
 Wed, 01 Dec 2021 15:40:47 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com>
 <9c7afd37-9940-e6e7-da41-8a44840defb3@gmail.com>
In-Reply-To: <9c7afd37-9940-e6e7-da41-8a44840defb3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Dec 2021 15:40:35 -0800
Message-ID: <CABPp-BHSPQMUw8a6E7Kz+7L6NuD8c9GrHdTMf_rBzQR+2VGs-Q@mail.gmail.com>
Subject: Re: 2.34 regression (and workaround): deleting untracked files both
 outside *and inside* desired sparsity cone
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 11:19 AM Derrick Stolee <stolee@gmail.com> wrote:
>
...
> We use the sparse-checkout builtin. From the Scalar patch series,
> you can see that we don't call "git clone" at all, but instead
> "scalar clone" does a lot with "git init" and works from there by
> setting config and fetching at the correct time.

Ah, thanks for the correction.  I had seen that, but forgotten.

...
> > == Long term proposal ==
> >
> > Make `set` do both the work of `init` and `set`.
> >
> > This means:
> >   * `set` gains the ability to parse both --cone and --sparse-index
> > (in addition to --stdin, etc.)
> >   * If the sparse-index is not initialized, `set` does the
> > initialization work of `init`.
> >   * Modify the `init` documentation to mark it as deprecated,
> > mentioning the 2-3 bugs above as reasons why.
> >   * We could effectively just turn `git sparse-checkout init ...` into
> > an alias for `git sparse-checkout set ...`, since init's parameters
> > would be a subset of those that `set` accepts.  However, the latter
> > might interact badly with allowing a user to toggle sparse-index on
> > and off in the middle of a sparse-checkout...so maybe we need
> > something more?  Alternatively, we could leave `init` as-is and just
> > consider it set in concrete, possibly risking it becoming
> > non-functional in a future upgrade.  Hmm...
>
> I think this is a good plan. Making 'init' the same as 'set' with
> no paths makes sense to me.

Cool, I'll get to work on it.

> We would want to be careful now that
> "--option" could be interpreted as a path to recommend using
>
>   git sparse-checkout set <options> -- <path1> ... <pathN>

Makes sense.  However, wasn't this already an issue when you added
`--stdin` as an option for the `set` command?

> While you are here, I would be interested in making 'git clone
> --sparse' default to cone mode. Or, should it be 'git clone
> --sparse=cone' or something? Not making it default to cone mode
> is a big regret of mine.

I agree it'd be much nicer to have it default to cone mode, and the
big warning in git-sparse-checkout.txt might permit us to do so.  A
few related questions:

* Should we document how to change from cone mode to non-cone mode?
We have --sparse-index, --no-sparse-index, and --cone flags, but no
--no-cone one.  Should we?  (Do these flags belong somewhere other
than `init` since it's toggling some other flag while already using a
sparse-checkout?)

* Should we clean up the wording in clone's --sparse option?  In particular:

--sparse::
Initialize the sparse-checkout file so the working
directory starts with only the files in the root
of the repository. The sparse-checkout file can be
modified to grow the working directory as needed.

This wording seems to suggest direct editing of
.git/info/sparse-checkout, and might confuse users.  Perhaps the last
sentence could change "sparse-checkout file can be modified" ->
"sparse-checkout command can be used" or something like that?
