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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C9C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1826C61413
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhGAWeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhGAWen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:34:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDAC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:32:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c17so12950356ejk.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z8WOsBlNRj0Wi0f4+Whggu7DR+fupyxOgTUxRWmtxCU=;
        b=P0MCpmHTiTgR7teIjw1XvHNW/5yvnhL+O44xdN8NbXNXXJCtuN0+6OYdWKWmrnUpdb
         xbhFQqJDP/wlgdzddyriBJlR9RChPwzblKT38iXLIHI2G+VPOmkzeukKMEcqIeTiMDTy
         6uyXvFwetrGbkjPwEH62dvi63DVqhpvOWoeYxunZFY8KqDn1nEcOTPsL7k/0jpdbT3EI
         AaX+kVbTdiCwg7n2TJqhFSRmkR6vMlUv5Qy9gHYO8zEEpcH8HKP6yE9ETL+a3mp0vP+G
         yMmNwqRIjJl/oX+FiB8YmBu5gxVUP47GlY3cMGn7RaLe33IWLN+iSP3FzzrcmPVXPQOz
         xAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z8WOsBlNRj0Wi0f4+Whggu7DR+fupyxOgTUxRWmtxCU=;
        b=ZkP890Lo8EL0NmBkz0LNY/gi3frctbbm20VQVAMA0vte713G7HIfOxwg3bIMe7pZ+M
         Vg0mMRAuwZrCRlv23t2jjIBPPgRCos6LEQjEJqyLf21IBeseILxBLSPq31oNAetwH/f8
         tOpKdpMOVu1Z5VoZjnajzKDjR+P5S3iKvvccmPQLFl3MpWCq6oiTJZxYGOzC5mgHDaq/
         HWQ4wd86GlcMsVQCYs5OF2KZjCFEpt1EF2Ap9eW9f/BrhfVfyqcXhgdmCgb0+DB8b8LF
         RmH4hCwlEaRiOqjIQ4PHXBIkV+ZZ4b1PrLmA+haEYkR5XS0ZhCAbR0oDE4cQkHZHXxHv
         3jkg==
X-Gm-Message-State: AOAM5331ixIHz4/LbvPRBC7iJhGPo844pKoMHKbD0mnDzmXxXyXVQwTI
        Gvfn1V47k3pKp17E9/2FKR7yuvDYtxwr9w==
X-Google-Smtp-Source: ABdhPJwG/abU3bip4QXJEtHekiIaPL8je707JikW+/mq2tDs708qr+2htYl1YD9luA4Lf8Fs059Mdw==
X-Received: by 2002:a17:906:9745:: with SMTP id o5mr2247352ejy.344.1625178730571;
        Thu, 01 Jul 2021 15:32:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q22sm479996edv.51.2021.07.01.15.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:32:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 03/34] fsmonitor--daemon: update fsmonitor documentation
Date:   Fri, 02 Jul 2021 00:31:57 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <86413bfe34722dcd5c846cf7326340473471773c.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <86413bfe34722dcd5c846cf7326340473471773c.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <874kddd5sm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
> pointers to `Watchman` to mention the new built-in `fsmonitor--daemon`.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/config/core.txt      | 56 ++++++++++++++++++++++--------
>  Documentation/git-update-index.txt | 27 +++++++-------
>  Documentation/githooks.txt         |  3 +-
>  3 files changed, 59 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index c04f62a54a1..4f6e519bc02 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -62,22 +62,50 @@ core.protectNTFS::
>  	Defaults to `true` on Windows, and `false` elsewhere.
>  
>  core.fsmonitor::
> -	If set, the value of this variable is used as a command which
> -	will identify all files that may have changed since the
> -	requested date/time. This information is used to speed up git by
> -	avoiding unnecessary processing of files that have not changed.
> -	See the "fsmonitor-watchman" section of linkgit:githooks[5].
> +	If set, this variable contains the pathname of the "fsmonitor"
> +	hook command.
> ++
> +This hook command is used to identify all files that may have changed
> +since the requested date/time. This information is used to speed up
> +git by avoiding unnecessary scanning of files that have not changed.
> ++
> +See the "fsmonitor-watchman" section of linkgit:githooks[5].
> ++
> +Note: The value of this config setting is ignored if the
> +built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
>  
>  core.fsmonitorHookVersion::
> -	Sets the version of hook that is to be used when calling fsmonitor.
> -	There are currently versions 1 and 2. When this is not set,
> -	version 2 will be tried first and if it fails then version 1
> -	will be tried. Version 1 uses a timestamp as input to determine
> -	which files have changes since that time but some monitors
> -	like watchman have race conditions when used with a timestamp.
> -	Version 2 uses an opaque string so that the monitor can return
> -	something that can be used to determine what files have changed
> -	without race conditions.
> +	Sets the protocol version to be used when invoking the
> +	"fsmonitor" hook.
> ++
> +There are currently versions 1 and 2. When this is not set,
> +version 2 will be tried first and if it fails then version 1
> +will be tried. Version 1 uses a timestamp as input to determine
> +which files have changes since that time but some monitors
> +like Watchman have race conditions when used with a timestamp.
> +Version 2 uses an opaque string so that the monitor can return
> +something that can be used to determine what files have changed
> +without race conditions.
> ++
> +Note: The value of this config setting is ignored if the
> +built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
> +
> +core.useBuiltinFSMonitor::
> +	If set to true, enable the built-in file system monitor
> +	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
> ++
> +Like hook-based file system monitors, the built-in file system monitor
> +can speed up Git commands that need to refresh the Git index
> +(e.g. `git status`) in a working directory with many files.  The
> +built-in monitor eliminates the need to install and maintain an
> +external third-party tool.
> ++
> +The built-in file system monitor is currently available only on a
> +limited set of supported platforms.  Currently, this includes Windows
> +and MacOS.
> ++
> +Note: if this config setting is set to `true`, the values of
> +`core.fsmonitor` and `core.fsmonitorHookVersion` are ignored.
>  
>  core.trustctime::
>  	If false, the ctime differences between the index and the
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 2853f168d97..c7c31b3fcf9 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -498,7 +498,9 @@ FILE SYSTEM MONITOR
>  This feature is intended to speed up git operations for repos that have
>  large working directories.
>  
> -It enables git to work together with a file system monitor (see the
> +It enables git to work together with a file system monitor (see
> +linkgit:git-fsmonitor--daemon[1]
> +and the
>  "fsmonitor-watchman" section of linkgit:githooks[5]) that can
>  inform it as to what files have been modified. This enables git to avoid
>  having to lstat() every file to find modified files.
> @@ -508,17 +510,18 @@ performance by avoiding the cost of scanning the entire working directory
>  looking for new files.
>  
>  If you want to enable (or disable) this feature, it is easier to use
> -the `core.fsmonitor` configuration variable (see
> -linkgit:git-config[1]) than using the `--fsmonitor` option to
> -`git update-index` in each repository, especially if you want to do so
> -across all repositories you use, because you can set the configuration
> -variable in your `$HOME/.gitconfig` just once and have it affect all
> -repositories you touch.
> -
> -When the `core.fsmonitor` configuration variable is changed, the
> -file system monitor is added to or removed from the index the next time
> -a command reads the index. When `--[no-]fsmonitor` are used, the file
> -system monitor is immediately added to or removed from the index.
> +the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
> +variable (see linkgit:git-config[1]) than using the `--fsmonitor`
> +option to `git update-index` in each repository, especially if you
> +want to do so across all repositories you use, because you can set the
> +configuration variable in your `$HOME/.gitconfig` just once and have
> +it affect all repositories you touch.
> +
> +When the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
> +variable is changed, the file system monitor is added to or removed
> +from the index the next time a command reads the index. When
> +`--[no-]fsmonitor` are used, the file system monitor is immediately
> +added to or removed from the index.
>  
>  CONFIGURATION
>  -------------
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index b51959ff941..b7d5e926f7b 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -593,7 +593,8 @@ fsmonitor-watchman
>  
>  This hook is invoked when the configuration option `core.fsmonitor` is
>  set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
> -depending on the version of the hook to use.
> +depending on the version of the hook to use, unless overridden via
> +`core.useBuiltinFSMonitor` (see linkgit:git-config[1]).
>  
>  Version 1 takes two arguments, a version (1) and the time in elapsed
>  nanoseconds since midnight, January 1, 1970.

Ditto the comment on 02/34, mostly docs for things that don't exist
until in later patches.
