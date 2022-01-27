Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0EEC433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 02:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiA0C65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 21:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiA0C6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 21:58:54 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7369BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 18:58:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so2639352ejc.7
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 18:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SHz1kmIKzOpdKfGs0yoritJqxQLrLag3rM4B2Efn1o8=;
        b=ihOvRKg1AOuzv6ek2DK6zelPvEmq7n/KLPYLtv19W7pUloCbYA4e7sj23H+9zSIiTW
         mkYP7llyZAx8AKjo08lzPtsPuh6AMUMtUINo+wGCi2rK0x3QC+GP7pR/bgZnEa3zqJST
         jAaXkcURnciVbnzorERemjlMyDkwLc90vr9WnB89JVYAVyhuhedtDOA9Guxu3pTSXYth
         En32khw9WPuWzvwIMZozdYW1pbK/SJF0ktctxytGbq6bQ/cYHwVekQGTLFhvWWnHmWhd
         6578P0gfNa2wULsMrrVB40B1KRUOl6LJWCdj1uTl2cnY/888AlKJd0d4yOH34LS3qOe5
         mVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SHz1kmIKzOpdKfGs0yoritJqxQLrLag3rM4B2Efn1o8=;
        b=x/ugAXasNZnNO75S+wK0E9pTOkLJCUEfVdkwHnvSTdlDL02NblADxzdQjU2ZeSmybU
         2Kn9YTLnvFjyOkxIXHdT+77V8TkRHpynyUuMVa+3Hi8QhfaCmv/sAJbh3BqLZJagQ4eR
         0HPavyxyuC50mXKwUqONllG5AkSOR2fBeUfLo7gB3RuF4m5VmEXZNrzq3DDcRfknMSqh
         2xbktUj06mBse29A/ulJbRzbSQXwti7UhJChTKwwgpkeH2j4v3nYdihqL8E5QHTHJguC
         hpd5pTJqU9qQZxEffn1VmFckzDYSsq+TG8vCDqzaTReQMUjTCUyMarIGnRAXI23VgsIT
         dlrw==
X-Gm-Message-State: AOAM531SAbXCtTS7PsYOb7N745OylR5vTmI2jI890cZFzx1pgOebCPit
        UX6/oJYWOX/jpVkf3tSGJvDopraByIz5xw==
X-Google-Smtp-Source: ABdhPJwu6mkhqWIteDxphc/JDZI+QLVAgg4O6TXTNxiaKQpKlnO2gZ/vYJ6phRBXFloY0rZFyQ3UeA==
X-Received: by 2002:a17:907:3f21:: with SMTP id hq33mr1364238ejc.548.1643252332986;
        Wed, 26 Jan 2022 18:58:52 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gg14sm8145009ejb.62.2022.01.26.18.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:58:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCuzr-003G8w-AE;
        Thu, 27 Jan 2022 03:58:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Date:   Thu, 27 Jan 2022 03:55:58 +0100
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
Message-ID: <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git` executable has these two very useful options:
>
> -C <directory>:
> 	switch to the specified directory before performing any actions
>
> -c <key>=<value>:
> 	temporarily configure this setting for the duration of the
> 	specified scalar subcommand
>
> With this commit, we teach the `scalar` executable the same trick.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     scalar: accept -C and -c options
>     
>     This makes the scalar command a bit more handy by offering the same -c
>     <key>=<value> and -C <directory> options as the git command.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1130%2Fdscho%2Fscalar-c-and-C-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1130/dscho/scalar-c-and-C-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1130

I think it would help for context to note that this patch had at least 6
submissions on the ML already as part of early versions of the scalar
series.

Here's the CL of the iteration that ejected it:
https://lore.kernel.org/git/pull.1005.v7.git.1637158762.gitgitgadget@gmail.com/

Where you summarized:
    
     * The patch that adds support for -c <key>=<value> and -C <directory> was
       moved to its own add-on patch series: While it is obvious that those
       options are valuable to have, an open question is whether there are other
       "pre-command" options in git that would be useful, too, and I would like
       to postpone that discussion to that date.

Having been involved in those discussions I can't remember what the
pre-command options you're referring to there are, but it seems "that
date" is probably upon us.
