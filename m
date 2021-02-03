Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD871C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D7664F8C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhBCRiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:38:18 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44858 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBCRiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:38:16 -0500
Received: by mail-ed1-f51.google.com with SMTP id r22so542016edo.11
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 09:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPFYZtSSFBTaM3bIy5dv2IrW71AG/WLkRIubAP6BROI=;
        b=qhM+qTGMR5+PRzWEtYi4MCUUyiZVI3bqQd94UJbMdM2mQIybiXfJPghtFHeVXaCFNk
         sKtJQhdr+4OZqdiClhSSizb+3q9uXa1eyv7M+Ge3uGw5fJaPZ86h+PCljk21tUUcebY4
         6qdwOyRDp3AHhbYq+Gh33AjP3wnZEfucbBwxkVMynNsmhBVyVDDDGLBk8znPANd6Ioia
         ZqWUGvM7njkkoiLAc1HGcKlxhpWDu/wXWyLBVxIVp+xUQwklKyld/7K7+zl4Xbm5SN+9
         CVHUXCAL0qPFYt6obTpdjGwv6vsE0AXwd/rUKkwnsa17PmeXJf6z4Cnj9K5Dmy0R1Zzw
         46MQ==
X-Gm-Message-State: AOAM531cmCxrDsPC0F0TuZ5zfPe3mtZmFAOeqIwK8ubFIC+XAvwsaprI
        zLJ1PVLRKj1B07+3mAXciJCZygsF93VA+cA9p3A=
X-Google-Smtp-Source: ABdhPJxQ8aWY963pJ+7C+WqioNNu2aDgjqGigTjhMiBWl3IvMTLWltK2xXBjJGwitMhkxkyR4pcWB2kovkhAN0jDdHw=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr4133909edu.163.1612373854174;
 Wed, 03 Feb 2021 09:37:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com> <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com> <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <YBoBBie2t1EhcLAN@google.com> <6dc1520f-8130-75e1-6617-67b54cb03933@gmail.com>
 <YBrCli7AR/XrB3Pr@nand.local>
In-Reply-To: <YBrCli7AR/XrB3Pr@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Feb 2021 12:37:21 -0500
Message-ID: <CAPig+cTMcNjJVyTb1mio+Pof46G3fXxurrtMiwO4h8DWi8Eu2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before commit_graph_data_at()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 10:55 AM Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Feb 02, 2021 at 10:07:32PM -0500, Derrick Stolee wrote:
> > 'clear' is probably fine. I was thinking it might be good to have
> > an option to the 'write' subcommand to clear the existing data, but
> > it's probably better as separate steps.
>
> Wouldn't 'git commit-graph write --split=replace --reachable' do the
> same thing? I know that you changed some of the spots where we load an
> existing commit graph, so my claim might be out-of-date, but I'm pretty
> sure that this would get you out of a broken state.
>
> Thinking aloud, I'm not totally sure that we should be exposing "git
> commit-graph clear" to users. The only time that you'd want to run this
> is if you were trying to remove a corrupted commit-graph, so I'd rather
> see guidance on how to do that safely show up in
> Documentation/git-commit-graph.txt.

Throwing one more idea into the mix, git-worktree recently got a
`repair` subcommand. Even though it presently repairs a small set of
problems, the subcommand name is intentionally generic so as to
provide room for growth. One could imagine `git commit-graph repair`
being added to provide a user-friendly mechanism for recovering from
commit-graph damage.
