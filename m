Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D40C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIZQ1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiIZQ0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:26:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E397DF75
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:15:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dv25so14742864ejb.12
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=ndq2rVVaMKoulFlsTD9934ss502lCjyAgkA+Cz9fvR4=;
        b=BE8B+emRMcR52F3c0UJw69gSNGOsSbDJgTZaWGbteURfdtt9JD2GVbD0Fk7GYGhl66
         joRns4QznZI9ITsKAgy4WjIKELcM5hToGGv9E+ESA42OFqLGDOP/CROgbkx0GlVLB8Bs
         7lkFsTDrdUpeySoah0fVgU/n+FGk3C3WLMsq8VdU7UpDd74bNasGddQE9vQkGYU9rMdJ
         2Y9kiH9IflfHJZebhIsaFoXHrCViVoSm9sFGVdapJ8MEsocqPWXUza15/Eyas+8OpV25
         cMvct3jWUyBk7lqr4Bk3oq967WvIFPxq4Ew4R2SoDVgEJAWf8PC/FXIh5oyy6LOqmUhH
         5hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ndq2rVVaMKoulFlsTD9934ss502lCjyAgkA+Cz9fvR4=;
        b=pXran0CGgQWHOiQQ11Zmw3NxeBJBtB+NcafS1ttfOlQHF4O1m2f74+sfJ58teBkhP3
         DB4xUF/RR1iwdHZTMKl9oiOX8qb7f5HyDs+gNwMq+Y4PrsmHEF9rf3jfg1ke4N0soXP6
         RBRvxem8+CuMKGAjP6qMjwUOPyBvy6eoVSlNtKNFD0b+wIpT1wboY9uCqeathQSwnTcX
         L5GXnwNHIR4CTw14eTvOZxDooYW6k/ify8xlLvo2kUR+pmRpnrsKA4FuMMRFXfiT7CrC
         sYelrhpDoFZsY8WECVPP4Gm3nTeNifKMU+z0SoI2Fuy1m1kdJAzBwytwq4/XI/wpQQqZ
         0gUQ==
X-Gm-Message-State: ACrzQf3u5HaILQmBL5TjVwNiUWOcR/mnfRcO9JgMc8zfwCJGboMErcib
        I5R1VZLvSdiYXHx0sTSUVUM=
X-Google-Smtp-Source: AMsMyM5KPIjB47VlnPlsemMsRkcTX9jpdemr/HJwI/Z+MfCOGRGvDy1uuX7wXScGl4zmXXzXDpYZUw==
X-Received: by 2002:a17:907:2721:b0:77c:29f9:2c84 with SMTP id d1-20020a170907272100b0077c29f92c84mr19092228ejl.721.1664205325071;
        Mon, 26 Sep 2022 08:15:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gc35-20020a1709072b2300b0077ab3ca93efsm8315930ejc.223.2022.09.26.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:15:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocppL-0009xB-15;
        Mon, 26 Sep 2022 17:15:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v12 6/6] fsmonitor: add documentation for allowRemote
 and socketDir options
Date:   Mon, 26 Sep 2022 17:11:03 +0200
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <b375b0ac798a673301a09903dcdfb22bedda7393.1664048782.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <b375b0ac798a673301a09903dcdfb22bedda7393.1664048782.git.gitgitgadget@gmail.com>
Message-ID: <220926.864jwu181g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
> Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
> system support for 'fsmonitor.socketDir'.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  Documentation/git-fsmonitor--daemon.txt | 48 +++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
> index cc142fb8612..6ad3e518ae0 100644
> --- a/Documentation/git-fsmonitor--daemon.txt
> +++ b/Documentation/git-fsmonitor--daemon.txt
> @@ -3,7 +3,7 @@ git-fsmonitor{litdd}daemon(1)
>  
>  NAME
>  ----
> -git-fsmonitor--daemon - A Built-in File System Monitor
> +git-fsmonitor--daemon - A Built-in Filesystem Monitor

We have ~400 uses of "filesystem" in-tree, but ~100 for "file system". I
don't mind the change per-se, but this looks like an odd "while at it"
change.

Skmming your series your 1/6 even uses "file system" in the commit message :)

>  A daemon to watch the working directory for file and directory
> -changes using platform-specific file system notification facilities.
> +changes using platform-specific filesystem notification facilities.

More while-at-it...

>  
>  This daemon communicates directly with commands like `git status`
>  using the link:technical/api-simple-ipc.html[simple IPC] interface
> @@ -63,13 +63,55 @@ CAVEATS
>  -------
>  
>  The fsmonitor daemon does not currently know about submodules and does
> -not know to filter out file system events that happen within a
> +not know to filter out filesystem events that happen within a

...and here...

>  submodule.  If fsmonitor daemon is watching a super repo and a file is
>  modified within the working directory of a submodule, it will report
>  the change (as happening against the super repo).  However, the client
>  will properly ignore these extra events, so performance may be affected
>  but it will not cause an incorrect result.

But here we get to the real meat of this change...

> +By default, the fsmonitor daemon refuses to work against network-mounted
> +repositories; this may be overridden by setting `fsmonitor.allowRemote` to
> +`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
> +correctly with all network-mounted repositories and such use is considered
> +experimental.
> +
> +On Mac OS, the inter-process communication (IPC) between various Git
> +commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
> +special type of file -- which is supported by native Mac OS filesystems,
> +but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
> +may or may not have the needed support; the fsmonitor daemon is not guaranteed
> +to work with these filesystems and such use is considered experimental.
> +
> +By default, the socket is created in the `.git` directory, however, if the
> +`.git` directory is on a network-mounted filesystem, it will be instead be
> +created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
> +network-mounted filesystem in which case you must set the configuration
> +variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
> +filesystem in which to create the socket file.
> +
> +If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
> +is on a native Mac OS file filesystem the fsmonitor daemon will report an
> +error that will cause the daemon and the currently running command to exit.

From skimming this looks reasonable.

> +CONFIGURATION
> +-------------
> +
> +When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
> +the fsmonitor daemon will pay attention to the following configuration
> +variables:
> +
> +`fsmonitor.allowRemote`::
> +	By default, the daemon refuses to work against network-mounted
> +	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
> +	this behavior.
> +
> +`fsmonitor.socketDir`::
> +    This Mac OS-specific option, if set, specifies the directory in
> +    which to create the Unix domain socket used for communication
> +    between fsmonitor and various Git commands. The directory must
> +    reside on a native Mac OS filesystem as discussed above.
> +

But here we should instead create Documentation/config/fsmonitor.txt,
and include it here. See my recent 7a54d740451 (Merge branch
'ab/dedup-config-and-command-docs', 2022-09-14) which made it so for
many commands.

By doing it like this "git config" is no longer the canonical reference
for all config, which it mostly was pre-7a54d740451, then was again
post-7a54d740451, and now we'd have this exception...
