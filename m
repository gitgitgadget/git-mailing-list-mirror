Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55FC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 03:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiF3DKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3DKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 23:10:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8DDE98
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 20:10:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c65so24757749edf.4
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fz6/kFU7ki+Y+t7wyXqIlkREwXps2HuvrsoLINa3Fg=;
        b=fTQLAKv1NgZbQpF6AWILgVOeVma92agGl86oMOKgAG3A3yIEQbVQZ3aUrSMGQP9cil
         SAX6Kfs4Hrc0XIGv/JKhTwVjPL1NGbl2DvREiHqTNeGJPr1KHQesASnGBmxvkiUhbS3Y
         LIL2//m3mJqlmauBNGdAXtyv111EpiLZd3Qd0fzrm6U2yBFuiD4zhaB9LLRdmSHVHIMP
         bc90api84avKnhztIL4VlMTFmE1YZR7FXoxITmJ19UXspO9veIV5gHOkBPTkPjIR3kH3
         f0CdcL6ktNU1KWzf1c9V4IcnL+xiiEvBhtX3SuIwnuxaPgHVmldkyPZ/XZ9nzSlX0+7f
         w7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fz6/kFU7ki+Y+t7wyXqIlkREwXps2HuvrsoLINa3Fg=;
        b=BBHmXxr/L83cojHWmz5uqhSAIuhcsF48hoN/oaLqqUAYEHUifmOEqebWS6k5HDX3t9
         FvQgq/pTU0II3AtBqyE0pcGRK/kktHVrzZ9rlVVdM7rrjKgpu2Sb49jm7Eh3tLxjNZk6
         mht87HEAOdNXPMjDtBqFDOtrOoHNAWEH4xOLnzvFEEuZWfKsFsUXiRD3OUk5xi3FGxl6
         6AQnUAnbSfV1jruLP/HgCxEjQMlBWLwbZsY+mPmfXj4AtxQyExZSG/Xe1INMnMm9YecF
         5wpInZL0XxU6gUZxFZz0vHhMjjAK58MsdQzYiTTTqSZyJw5/sQLs/6sOkpMUZK+fsH+A
         edww==
X-Gm-Message-State: AJIora+x/7QNzZPOIjHtXBA7A+P08jlj6DLvKXd8OZxwayhdQMGYtX2y
        XzflKAj/1FOs3yS1qkDuzHGOfkIPcM/Ef/Q1L9iv436BAWc=
X-Google-Smtp-Source: AGRyM1twDjizrrPhZQrM7klbhcCyg70tbYeqNQxuJinbUnuePNJdT/pSPo4ZQCwjr9heF6V7y0KXdm8E7wJInuQ95gA=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr8405112ede.323.1656558623907; Wed, 29
 Jun 2022 20:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
In-Reply-To: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 20:10:12 -0700
Message-ID: <CABPp-BFzGBDqyh0rQK+PULjW14ewoF0AV6OiN9_Zt=dLW+rW+g@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Dian Xu <dianxudev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 12:50 PM Dian Xu <dianxudev@gmail.com> wrote:
>
> Dear Git developers,
>
> Reporting Issue:
>               'git add' hangs in a large repo which has
> sparse-checkout file with large number of patterns in it
>
> Found in:
>               Git 2.34.3. Issue occurs after 'audit for interaction
> with sparse-index' was introduced in add.c
>
> Reproduction steps:
>               1. Clone a repo which has e.g. 2 million plus files
>               2. Enable sparse checkout by: git config core.sparsecheckout true
>               3. Create a .git/info/sparse-checkout file with a large
> number of patterns, e.g. 16k plus lines

Did you run `git read-tree -mu HEAD` or even `git sparse-checkout
reapply` after step 3 and before step 4?  If not, you've left the
working tree out-of-sync with the specified sparsity paths and should
fix that before running step 4.

>               4. Run 'git add', which will hang

Alternatively to the above, if you really want to add a file and
ignore the fact that it might be outside the sparsity patterns (and
risk it later randomly disappearing with checkout/rebase/merge/etc.
commands), then you can use `git add --sparse $FILENAME`.

> Investigations:
>               1. Stack trace:
>                        add.c: cmd_add
>                   -> add.c: prune_directory
>                   -> pathspec.c: add_pathspec_matches_against_index
>                   -> dir.c: path_in_sparse_checkout_1
>               2. In Git 2.33.3, the loop at pathspec.c line 42 runs
> fast, even when istate->cache_nr is at 2 million
>               3. Since Git 2.34.3, the newly introduced 'audit for
> interaction with sparse-index' (dir.c line 1459:
> path_in_sparse_checkout_1) decides to loop through 2 million files and
> match each one of them against the sparse-checkout patterns
>               4. This hits the O(n^2) problem thus causes 'git add' to
> hang (or ~1.5 hours to finish)
>
> Please help us take a look at this issue and let us know if you need
> more information.

I'm also curious if you can use --cone mode in sparse-checkout.  The
O(N*M) behavior of sparse checkouts in non-cone mode is pretty
fundamental, and we may need to add additional paths checking the
sparsity patterns (i.e. more O(N*M) codepaths) to fix various
user-observed bugs.  Usage of --cone mode drops all of these to a
linear cost.
