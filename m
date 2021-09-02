Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEF2C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C15160BD3
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbhIBOfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbhIBOe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:34:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5FC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 07:34:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bt14so4892862ejb.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QVr31sCP6x7VyZ8xflhjDOMHzzs2zqJ+cUHT0d03exI=;
        b=mta8XByHbGVW7yApophEuSwZHy0RhKh5QmdCW3fIh6m4FCw7XhwKCz699oihVr0RQL
         1Ri4dNQQ4vatl/kR0GQr4HqH+E2t6UT6ZtuCkZS7z+7TzuabigcEzvcbg1fnEl/VgP1M
         eCpcnAaDAt5+keGWGwhtsohGCWGZsFlaBgumYVmRsVa5oSSqQXopOuFZYHLXAF3J4xAE
         57gLWoqlrPuH/t2qATRXx2C+ovX2BPoStRAdomyOIoe8vPWBECW2KgbQ1hzL+J5jST+q
         CvrHuj8DZli2bxelBgkiTvvH2n+1b5slZ1LXHDsV6PAhUyy7U2IqXW18/iEnuQFlwoKB
         Rigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QVr31sCP6x7VyZ8xflhjDOMHzzs2zqJ+cUHT0d03exI=;
        b=CusWdOjoR0YD1I71gKh7vNsCwdflekG9LRWbmTvHdxHpTMd7ft/MRwoV8glfDyvYBo
         tOkAWV1OfVERv7lsCR2F9ZSQ704ng68XIFTfwf6vzpky/HAqIJeYXUD1ry2B1hMfnR1n
         1W+Sd3mIWD/QPAD8v+s26tTYVPwbrvd+CUbbgESsYQWi2iSWZJDttyYX7eDvEoNCW8XJ
         0vCI3QE57zPNDv26qqpxufdVz17TRW6wfihNN5JkXAA0aWhREEF+j6QjwwD4HvTElfz9
         55ysStkVWhIqC7ksRTLaDIqBlGjTn3wxeBVKp1OayAB0ZydwtMwRuBVD+RsfrE+vA+oN
         nK0Q==
X-Gm-Message-State: AOAM531MjKwOAmhzxUaAerf8ZnVQXHeio3YTKVZsLd7EnMZxHIF+BZbH
        hUWWvnKKB9KriIkbr8sDIpQ=
X-Google-Smtp-Source: ABdhPJzMCSerETVfX4F3IsouISvjmnLEnn2SAoWUgnVUfSK0/kBBbeRtV+ZLhWH60iQ1EOhh9yGDIw==
X-Received: by 2002:a17:906:504:: with SMTP id j4mr3963037eja.245.1630593239928;
        Thu, 02 Sep 2021 07:33:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l7sm1509122edb.26.2021.09.02.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:33:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Thu, 02 Sep 2021 16:28:16 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
Message-ID: <87pmtr9hd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This option was deprecated in favor of `--rebase-merges` some time ago,
> and now we retire it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore                     |    1 -
>  Documentation/git-rebase.txt   |   51 --
>  Makefile                       |    2 -
>  builtin/rebase.c               |  133 +---
>  git-rebase--preserve-merges.sh | 1057 --------------------------------
>  5 files changed, 6 insertions(+), 1238 deletions(-)
>  delete mode 100644 git-rebase--preserve-merges.sh
>
> diff --git a/.gitignore b/.gitignore
> index 311841f9bed..98d6275b20d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -125,7 +125,6 @@
>  /git-range-diff
>  /git-read-tree
>  /git-rebase
> -/git-rebase--preserve-merges
>  /git-receive-pack
>  /git-reflog
>  /git-remote
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 55af6fd24e2..1382dc6f005 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -525,29 +525,12 @@ i.e. commits that would be excluded by linkgit:git-log[1]'s
>  the `rebase-cousins` mode is turned on, such commits are instead rebased
>  onto `<upstream>` (or `<onto>`, if specified).
>  +
> -The `--rebase-merges` mode is similar in spirit to the deprecated
> -`--preserve-merges` but works with interactive rebases,
> -where commits can be reordered, inserted and dropped at will.
> -+
>  It is currently only possible to recreate the merge commits using the
>  `recursive` merge strategy; Different merge strategies can be used only via
>  explicit `exec git merge -s <strategy> [...]` commands.
>  +
>  See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>  
> --p::
> ---preserve-merges::
> -	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
> -	instead of flattening the history by replaying commits a merge commit
> -	introduces. Merge conflict resolutions or manual amendments to merge
> -	commits are not preserved.
> -+
> -This uses the `--interactive` machinery internally, but combining it
> -with the `--interactive` option explicitly is generally not a good
> -idea unless you know what you are doing (see BUGS below).
> -+
> -See also INCOMPATIBLE OPTIONS below.
> -

I wonder if we should leave some variant of this in, just as a last
resort to help users who have some ancient version / finger memory &
wonder why it doesn't work, something like;

-p::
--preserve-merges:
	These options were used by the long-deprecated and now removed
	"rebase merges" backend. The `--rebase-merges` option is the
	similar in spirit replacement mode.

Also, per your ea8b7be1476 (git svn: stop using `rebase
--preserve-merges`, 2019-11-22) the use in "git svn" couldn't really be
directly compared to this, but there we usurped the "-p" flag for
--rebase-merges. Perhaps we could/should do the same here (eventually,
doesn't need to be in this series).
