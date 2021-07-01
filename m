Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD154C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D976140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhGAWdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhGAWdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:33:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A0C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:30:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h2so10614883edt.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XyTm/KPpmagUkGPxM1VQFWqAetXAnxHM+nkSnS2qmNQ=;
        b=Bc19h7C7YN7SIWgUTFI5buCdUjHIyBGW44gAceNZEkQca8fHOym2ig3al5FMXEknt2
         AaATu8tx+TBP2sUQ/g/t80GovClYzWGQvom4m8HHTUZ0ECF1Y1C4MQqGyIcnwAoO7la9
         BfKM8VFbD8UC10Nu5CByWsjHWluwHFVljcK9Ed2MLSKZL6qppIKGQPqUt68FM1uEPVMe
         UIc7UO5AxEZF+hV/tb2q3mxI+Srfc5BZt5XL7/Qaqr0zmifbf/yIkI8051pQrn1Mzlp1
         pXguS1ufpl/wdSBhPDL0YIfhpC7cJz72x5SgcL8n7eReB4Ae2dVRnGR3kJvJWRhQWK6r
         OOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XyTm/KPpmagUkGPxM1VQFWqAetXAnxHM+nkSnS2qmNQ=;
        b=BkY1yEwIN4eUymzFelVAZDPj35fvo7JZCQQHI4+H7lO8PgSHiC7Sfw9/iUJVxAIbHD
         HIHLYIpN5/A3f5mh1GfpLx7Ns2opsIvpQw7jMM6hlyAK64Um+KRRPBcHY2HxAAiMF4aK
         Qi+JRlBSTB2pnI4Z4bDXA6uH5EphxhKPmYCoAY3Smou9plqCDP1tAJgptMaEfdNaga6V
         KZeuU8yGAvgEUpz6ZSLxiKxFIUm+hrpLuEJfhRyL4O/6DvrMtt2bEdFXHIIp5rG0YS2n
         SbQj417ng9aoLLisEgi/eWvQX7ey/munTdKs6YmLjK1a7s2V1o6qMSbowJl4iqOiC47H
         cofg==
X-Gm-Message-State: AOAM533jwbSv9EHSVg7MnbeUEeMpB0wrJG22oj+oQ/FDtDAwiH1JryZ+
        vXfVHndiHxgu2I6qIecyCrazywo7xpH4fA==
X-Google-Smtp-Source: ABdhPJxYWA53vOxx4mnhYplb5CcoX1GtRh6EYU1ZcM362kV8I6sxMdhyHydTnCHoOfNYeGMl8ygMHw==
X-Received: by 2002:a05:6402:158c:: with SMTP id c12mr2601844edv.335.1625178645290;
        Thu, 01 Jul 2021 15:30:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a11sm455351eds.96.2021.07.01.15.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:30:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 02/34] fsmonitor--daemon: man page
Date:   Fri, 02 Jul 2021 00:29:02 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <877di9d5uz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create a manual page describing the `git fsmonitor--daemon` feature.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/git-fsmonitor--daemon.txt
>
> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
> new file mode 100644
> index 00000000000..154e7684daa
> --- /dev/null
> +++ b/Documentation/git-fsmonitor--daemon.txt
> @@ -0,0 +1,75 @@
> +git-fsmonitor--daemon(1)
> +========================
> +
> +NAME
> +----
> +git-fsmonitor--daemon - A Built-in File System Monitor
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git fsmonitor--daemon' start
> +'git fsmonitor--daemon' run
> +'git fsmonitor--daemon' stop
> +'git fsmonitor--daemon' status
> +
> +DESCRIPTION
> +-----------
> +
> +A daemon to watch the working directory for file and directory
> +changes using platform-specific file system notification facilities.
> +
> +This daemon communicates directly with commands like `git status`
> +using the link:technical/api-simple-ipc.html[simple IPC] interface
> +instead of the slower linkgit:githooks[5] interface.
> +
> +This daemon is built into Git so that no third-party tools are
> +required.
> +
> +OPTIONS
> +-------
> +
> +start::
> +	Starts a daemon in the background.
> +
> +run::
> +	Runs a daemon in the foreground.
> +
> +stop::
> +	Stops the daemon running in the current working
> +	directory, if present.
> +
> +status::
> +	Exits with zero status if a daemon is watching the
> +	current working directory.
> +
> +REMARKS
> +-------
> +
> +This daemon is a long running process used to watch a single working
> +directory and maintain a list of the recently changed files and
> +directories.  Performance of commands such as `git status` can be
> +increased if they just ask for a summary of changes to the working
> +directory and can avoid scanning the disk.
> +
> +When `core.useBuiltinFSMonitor` is set to `true` (see
> +linkgit:git-config[1]) commands, such as `git status`, will ask the
> +daemon for changes and automatically start it (if necessary).
> +
> +For more information see the "File System Monitor" section in
> +linkgit:git-update-index[1].
> +
> +CAVEATS
> +-------
> +
> +The fsmonitor daemon does not currently know about submodules and does
> +not know to filter out file system events that happen within a
> +submodule.  If fsmonitor daemon is watching a super repo and a file is
> +modified within the working directory of a submodule, it will report
> +the change (as happening against the super repo).  However, the client
> +will properly ignore these extra events, so performance may be affected
> +but it will not cause an incorrect result.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

Later in the series we incrementally add features to the daemon, so this
is describing a state that doesn't exist yet at this point.

I think it would be better to start with a stup here and add
documentation as we add features, e.g. the patch tha adds "start" should
add that to the synopsis + options etc.

See the outstanding ab/config-based-hooks-base for a small example of
that.
