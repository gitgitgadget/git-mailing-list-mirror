Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A383C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiF3WcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF3WcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5244F1B9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:32:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id n15so1572870qvh.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cxv72Jd+UVe/dM+KKLt2k5CqsX/AhQBl0MVXjO88Eb4=;
        b=qRVJ9glx2femW8/BUEHewHC6Hxuw4g3HoDtax5baxpKd+/lkBDcZ5jo9FyQcbp0LaI
         kNkh4oBtjAuWaFINLNN/1touzsoUCzeYQcqustOKcFvNWYaXPWG9dyrWLUqKQxXRs6hp
         jg+Yr51AFvCPnojeRbZ4wQC4px/2FGG8+U1IhkX3X7wRfHRffsoUfa2URz3zdafnIYvI
         HulQmqwFeMUDxeuvZxGSqe38w5xynOk/K66WM0z1JLTMmY12TYTRB2f6C+R3Z5qP3jq5
         xzfYE4BX+FXglSV4Cfa7IM0WUkf8Ie2D3yWLdQwti3L1tmNTzPnFVXEpQpzd5jFlnwo6
         oMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxv72Jd+UVe/dM+KKLt2k5CqsX/AhQBl0MVXjO88Eb4=;
        b=uGwQpByaXuL4jwyA7grTqVlrSJ6V4dPtqVBvRprQK/RafqvuU+1fGQ2FVofStrzo0q
         DJQ4SmQ5v0dR/pfIZd+Q1Y6sFIS2Y/bMjmC5t3TppiD3rXFdPPjXzgLTq8FHy0PWj1i7
         jqPwwIJcvRV3R79zE2vXKtSsDyoQpHiLC3nhNpmP5vJL/zm85bt57DOYHWmT9spk2e5h
         4cXZKMeWWRmfuPdeQrBLlrdXcwknlH8k6vMFXZ3e+sLCqQGpJMXNO59JjrqmLvt8FfR7
         NxUwjRxJclgz4N0DVIZLE/U3wTxuTbadtByOefz1sqTlKYMWvUHFgSWO7GnpN8XXr7nI
         mF7g==
X-Gm-Message-State: AJIora/6kdf20EUSQexuxyhYJMNcefNMyZH/8W+8Gv1vddqGUl397EMd
        BmTAcHK4rF/qfcdHohxFSCEUOA==
X-Google-Smtp-Source: AGRyM1trfVkuGWJXnMAA27YhCJixt+mjygtUfgyH/2cMyyE/D4A9BurJcqx0zHgNFE5b32WDM4/G9A==
X-Received: by 2002:ac8:7e87:0:b0:318:21ef:8fd9 with SMTP id w7-20020ac87e87000000b0031821ef8fd9mr9469466qtj.608.1656628332730;
        Thu, 30 Jun 2022 15:32:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a401000b006a6a7b4e7besm18210022qko.109.2022.06.30.15.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:32:12 -0700 (PDT)
Date:   Thu, 30 Jun 2022 18:32:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6 1/5] Documentation/git-config.txt: add SCOPES section
Message-ID: <Yr4ka485NzadFTto@nand.local>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <ee9619f6ec0608f399fc924cfe9254df5e7bc431.1656612839.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee9619f6ec0608f399fc924cfe9254df5e7bc431.1656612839.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 06:13:55PM +0000, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
>
> In a subsequent commit, we will introduce "protected configuration",
> which is easiest to describe in terms of configuration scopes (i.e. it's
> the union of the 'system', 'global', and 'command' scopes). This
> description is fine for ML discussions, but it's inadequate for end
> users because we don't provide a good description of "configuration
> scopes" in the public docs.
>
> 145d59f482 (config: add '--show-scope' to print the scope of a config
> value, 2020-02-10) introduced the word "scope" to our public docs, but
> that only enumerates the scopes and assumes the user can figure out
> those values mean.

Thanks, I think that "scope" is an appropriate term here. When I
originally read this patch, I was thinking that "origin" would be more
appropriate, since I was recalling the `--show-origin` option to `git
config`. But that shows the file name, and `--show-scope` is a separate
option entirely.

The latter is definitely more appropriate here, so I think this choice
of naming is good and makes sense.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 9376e39aef2..f93d437b898 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -297,8 +297,8 @@ The default is to use a pager.
>  FILES
>  -----
>
> -If not set explicitly with `--file`, there are four files where
> -'git config' will search for configuration options:
> +By default, 'git config' will read configuration options from multiple
> +files:
>
>  $(prefix)/etc/gitconfig::
>  	System-wide configuration file.
> @@ -322,27 +322,63 @@ $GIT_DIR/config.worktree::
>  	This is optional and is only searched when
>  	`extensions.worktreeConfig` is present in $GIT_DIR/config.
>
> -If no further options are given, all reading options will read all of these
> -files that are available. If the global or the system-wide configuration
> -file are not available they will be ignored. If the repository configuration
> -file is not available or readable, 'git config' will exit with a non-zero
> -error code. However, in neither case will an error message be issued.
> +You may also provide additional configuration parameters when running any
> +git command by using the `-c` option. See linkgit:git[1] for details.
> +
> +Options will be read from all of these files that are available. If the
> +global or the system-wide configuration file are not available they will be
> +ignored. If the repository configuration file is not available or readable,
> +'git config' will exit with a non-zero error code. However, in neither case
> +will an error message be issued.

Nit: the last sentence is a little awkwardly worded. Perhaps just:
"Note that neither case produces an error message".

> -All writing options will per default write to the repository specific
> +By default, options are only written to the repository specific
>  configuration file. Note that this also affects options like `--replace-all`

Should we mention that this is the same as the "local" scope below?

>  and `--unset`. *'git config' will only ever change one file at a time*.
>
> -You can override these rules using the `--global`, `--system`,
> -`--local`, `--worktree`, and `--file` command-line options; see
> -<<OPTIONS>> above.
> +You can change the way options are read/written by specifying the path to a
> +file (`--file`), or by specifying a configuration scope (`--system`,
> +`--global`, `--local`, `--worktree`); see <<OPTIONS>> above.

I think this paragraph could be slightly more descriptive about what
`--file` does while still linking out to <<OPTIONS>> above for more
detailed information. In the pre-image, we say:

    If not set explicitly with `--file`, there are four files will `git
    config will search`.

So I wonder if something more descriptive in this section might be:

    You can limit which configuration sources are read to or written
    from by specifying the path of a file with the `--file` option, or
    by specifying a scope with `--system`, `--global`, `--local`, or
    `--worktree`. For more, see <<OPTIONS>> above.

I don't think that's so different form what you wrote, but I think it's
a little clearer particularly what `--file` does (instead of "change the
way options are read/written" it "limit[s] which configuration sources
are read to or written from").

> +
> +SCOPES
> +------
> +
> +Each configuration source falls within a configuration scope. The scopes
> +are:
> +
> +system::
> +	$(prefix)/etc/gitconfig
> +
> +global::
> +	$XDG_CONFIG_HOME/git/config
> ++
> +~/.gitconfig
> +
> +local::
> +	$GIT_DIR/config
> +
> +worktree::
> +	$GIT_DIR/config.worktree
> +
> +command::
> +	environment variables
> ++
> +the `-c` option
> +
> +With the exception of 'command', each scope corresponds to a command line
> +option - `--system`, `--global`, `--local`, `--worktree`.

I think a colon after "option" is more appropriate than a single "-"
dash character, but this is definitely a trivial matter that I have no
strong opinion on.

One thing that this reminds me of (which I don't think is worth taking
up here, but perhaps in a future series, or as #leftoverbits) would be
promoting these scopes behind a single option. Back in the day, you
could ask for values out of `git config` by specifying their type with
`--int`, `--bool`, or similar. In e3e042b185 (Merge branch
'tb/config-type', 2018-05-08), we changed to
`--type=<int|bool|color|etc>`, which unified things and made it clearer
which options were grouped together by a single concept.

I think a similar change would make sense here, that is to replace
`--system`, `--global` (and so on) with `--scope=system`,
`--scope=global`, etc.

But that's not material to this series, and just something to think
about for later on if you end up thinking it's a good idea.

> +
> +When reading options, specifying a scope will only read options from the
> +files within that scope. When writing options, specifying a scope will write
> +to the files within that scope (instead of the repository specific
> +configuration file). See <<OPTIONS>> above for a complete description.
>
> +Most configuration options are respected regardless of the scope it is
> +defined in, but some options are only respected in certain scopes. See the
> +option's documentation for the full details.

I assume "the option's" is referring to whichever configuration variable
we're talking about. So it may be clearer to say "See the *respective*
option's documentation for more information" or similar.

Thanks,
Taylor
