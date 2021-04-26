Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D8C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067EE6101B
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhDZOOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhDZON7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:13:59 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82DC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:13:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id e25so26596441oii.2
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qjqrh5sde1Kp9VV6bF+1N65VXfFSYmEv+nYYdWXg6VQ=;
        b=fvJvslCWkWAKhEeUDMrj4iY/cBblrxY1AFPQkkiX/7HAMwiPlfNtaIuT0+3NUGPZES
         k6/Ft+3sJq0xXFY0W1fYd9fioeLvCCMmoeApX8HL3ElfEMY8mul5oQGPpq/guA7WxrDI
         g5iMA1h/baQnPLSey3or5iNsggPOzoYVcirBgIRdxQ9MfdDV+szAS4jjTTNEg9Ejicci
         ST34W0M02c7iwD6noFhG/3oMD6ClTOt6BJgQQ5Z2+BXCyLCu4uoKrk1DjJJI09/BOJCi
         +ZuRYx9hS1/EaPFB3Wp9zHIz6qcCvwjm9WyAt/t6UgEz++GuOIWRhUr3AvjvkYumiFbL
         dq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qjqrh5sde1Kp9VV6bF+1N65VXfFSYmEv+nYYdWXg6VQ=;
        b=EgOUJ7zgrVzh8C3nkAPYJ9pv/tTo8oyQAF26Ew4YAJGwAHQYVrXYmh6A8o2eDtFrlt
         FIYxLzv7MRN7+LaG83n5p+D908xs5vx7BtNUaKkzjqU5w8nTpR24YQT/j/A6MkpWDAX4
         kwivQ5U+vbpuJmSi70Jjj2HEGXJcflAJUzZs8uCKtGZk6NdE3uiWcCsiXpt1o5Lo8448
         hhrrp60M+jIIM8XgplgaKGmZnJh7+Hov3CYhPnPixNHFoOtNWooEUdWAbFm0ysMMB36I
         LoEh5DDCq/MerJelUP6sSDomtHI7DcPKZEWV24/igAD941lCn8yxVv7eI4n+1YpTx7vL
         TrHw==
X-Gm-Message-State: AOAM532JU+GoUoBeW8D3V7ScPQljX2dER1s10joKQSVDVwwYOkLE73As
        hPqjkV+XTS8Et7hEtWH9UvbU8VBGWZqgHw==
X-Google-Smtp-Source: ABdhPJwIv7mHIHqrDTIScQBu2S6YzTuyB/OIZW8M0ZzLsEA1L1HDCO0Yoz4kgeItoB01g0oMthfgeg==
X-Received: by 2002:aca:a844:: with SMTP id r65mr12418179oie.168.1619446397521;
        Mon, 26 Apr 2021 07:13:17 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:a88b:a43e:fa8a:53dc])
        by smtp.gmail.com with ESMTPSA id z197sm3104603oia.3.2021.04.26.07.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 07:13:16 -0700 (PDT)
Subject: Re: [PATCH 01/23] fsmonitor--daemon: man page and documentation
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <074273330f8d6c656dfec7c8778fad20314c6ad1.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b868522c-f07f-c431-aa2c-14af84015ced@gmail.com>
Date:   Mon, 26 Apr 2021 10:13:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <074273330f8d6c656dfec7c8778fad20314c6ad1.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create a manual page describing the `git fsmonitor--daemon` feature.
> 
> Update references to `core.fsmonitor`, `core.fsmonitorHookVersion` and
> pointers to `watchman` to mention the built-in FSMonitor.

Make sense to add clarity here, since there will be new ways
to interact with a fileystem monitor.
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
> +	Sets the version of hook that is to be used when calling the
> +	FSMonitor hook (as configured via `core.fsmonitor`).
> ++
> +There are currently versions 1 and 2. When this is not set,
> +version 2 will be tried first and if it fails then version 1
> +will be tried. Version 1 uses a timestamp as input to determine
> +which files have changes since that time but some monitors
> +like watchman have race conditions when used with a timestamp.
> +Version 2 uses an opaque string so that the monitor can return
> +something that can be used to determine what files have changed
> +without race conditions.

This initially seemed like a big edit, but you just split the single
paragraph into multiple, with a better leading sentence and a final
statement about the built-in FSMonitor. Good.
> ++
> +Note: FSMonitor hooks (and this config setting) are ignored if the
> +built-in FSMonitor is enabled (see `core.useBuiltinFSMonitor`).
> +
> +core.useBuiltinFSMonitor::
> +	If set to true, enable the built-in filesystem event watcher (for
> +	technical details, see linkgit:git-fsmonitor--daemon[1]).
> ++
> +Like external (hook-based) FSMonitors, the built-in FSMonitor can speed up
> +Git commands that need to refresh the Git index (e.g. `git status`) in a
> +worktree with many files. The built-in FSMonitor facility eliminates the
> +need to install and maintain an external third-party monitoring tool.
> ++
> +The built-in FSMonitor is currently available only on a limited set of
> +supported platforms.

Is there a way for users to know this set of platforms? Can they run
a command to find out? Will 'git fsmonitor--daemon --start' send a
helpful message to assist here? Or, could there be a 'git
fsmonitor--daemon --test' command?

> +Note: if this config setting is set to `true`, any FSMonitor hook
> +configured via `core.fsmonitor` (and possibly `core.fsmonitorHookVersion`)
> +is ignored.
...
> +git-fsmonitor--daemon(1)
> +========================
> +
> +NAME
> +----
> +git-fsmonitor--daemon - Builtin file system monitor daemon
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git fsmonitor--daemon' --start
> +'git fsmonitor--daemon' --run
> +'git fsmonitor--daemon' --stop
> +'git fsmonitor--daemon' --is-running
> +'git fsmonitor--daemon' --is-supported
> +'git fsmonitor--daemon' --query <token>
> +'git fsmonitor--daemon' --query-index
> +'git fsmonitor--daemon' --flush

These arguments with the "--" prefix make it seem like they are
options that could be grouped together, but you really want these
to be verbs within the daemon. What do you think about removing
the "--" prefixes?

> +
> +DESCRIPTION
> +-----------
> +
> +Monitors files and directories in the working directory for changes using
> +platform-specific file system notification facilities.
> +
> +It communicates directly with commands like `git status` using the
> +link:technical/api-simple-ipc.html[simple IPC] interface instead of
> +the slower linkgit:githooks[5] interface.
> +
> +OPTIONS
> +-------

I typically view "OPTIONS" as arguments that can be grouped together,
but you are describing things more like verbs or subcommands. The
most recent example I know about is 'git maintenance <subcommand>',
documented at [1].

[1] https://git-scm.com/docs/git-maintenance#_subcommands

> +
> +--start::
> +	Starts the fsmonitor daemon in the background.
> +
> +--run::
> +	Runs the fsmonitor daemon in the foreground.
> +
> +--stop::
> +	Stops the fsmonitor daemon running for the current working
> +	directory, if present.

I'm noticing "fsmonitor" in lowercase throughout this document. Is
that the intended case for user-facing documentation? I've been 
seeing "FS Monitor", "filesystem monitor", or even "File System
Monitor" in other places.

> +--is-running::
> +	Exits with zero status if the fsmonitor daemon is watching the
> +	current working directory.

Another potential name for this verb is "status".

> +--is-supported::
> +	Exits with zero status if the fsmonitor daemon feature is supported
> +	on this platform.

Ah, here is an indicator of whether the platform is supported. Please
include details for this command in the earlier documentation. I'll
check later to see if a message is also sent over 'stderr', which
would be helpful. Documenting the exit status is good for third-party
tools that might use this.

> +--query <token>::
> +	Connects to the fsmonitor daemon (starting it if necessary) and
> +	requests the list of changed files and directories since the
> +	given token.
> +	This is intended for testing purposes.
> +
> +--query-index::
> +	Read the current `<token>` from the File System Monitor index
> +	extension (if present) and use it to query the fsmonitor daemon.
> +	This is intended for testing purposes.

These two could be grouped as "query [--token=X|--index]", especially
because they are for testing purposes.

> +
> +--flush::
> +	Force the fsmonitor daemon to flush its in-memory cache and
> +	re-sync with the file system.
> +	This is intended for testing purposes.

Do you see benefits to these being available in the CLI? Could these
be better served as a test helper?

> +REMARKS
> +-------
> +The fsmonitor daemon is a long running process that will watch a single
> +working directory.  Commands, such as `git status`, should automatically
> +start it (if necessary) when `core.useBuiltinFSMonitor` is set to `true`
> +(see linkgit:git-config[1]).
> +
> +Configure the built-in FSMonitor via `core.useBuiltinFSMonitor` in each
> +working directory separately, or globally via `git config --global
> +core.useBuiltinFSMonitor true`.
> +
> +Tokens are opaque strings.  They are used by the fsmonitor daemon to
> +mark a point in time and the associated internal state.  Callers should
> +make no assumptions about the content of the token.  In particular,
> +the should not assume that it is a timestamp.
> +
> +Query commands send a request-token to the daemon and it responds with
> +a summary of the changes that have occurred since that token was
> +created.  The daemon also returns a response-token that the client can
> +use in a future query.
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
> +should properly ignore these extra events, so performance may be affected
> +but it should not cause an incorrect result.

There are several uses of the word "should" where I think "will" is a
more appropriate word. That is, unless we do not actually have confidence
in this behavior.

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
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index b51959ff9418..b7d5e926f7b0 100644
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

These are good connections to make.

Since the documentation for the fsmonitor--daemon is so deep, this
patch might be served well to split into two: one that just documents
the daemon, and another that updates existing documentation to point
to the new file.

This does provide a good basis for me to investigate during the rest
of the review.

Thanks,
-Stolee
