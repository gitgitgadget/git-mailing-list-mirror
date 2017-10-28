Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257682055E
	for <e@80x24.org>; Sat, 28 Oct 2017 22:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdJ1WgP (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 18:36:15 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54336 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdJ1WgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 18:36:14 -0400
Received: by mail-wm0-f44.google.com with SMTP id r68so9609363wmr.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AkM/tOuJKvvXClRpyG21TGaxp6vMOBkipp3n0RT3GaE=;
        b=L5BXNkYBPWL8ktgidE62fc7SDA3XS/N+UChsVUPNH0hcaBe4qdCTlVPe5PHVz7d8ZK
         23s/wjMje5l/HPPBhDg1QBsg7kpBcfDBXaT0xOFSKupOTBF9VopT7Z3+ExCzH6YAtEae
         Wc6nUPFWcoQi/0CFQeavtthWPnUhbn/Tmlffpz6dQn9A6mm/qPTuVmfkveK/Cav7r0ea
         W/Qh4/bHMwqRo8UdLUTXJLMDFxeyaywOSn5aX/Mtqh34y2E2GoDeJ3F17/4F4E67w5Qx
         bDxeJJEohO+COQBXiM7p/swrOZsQpqmJ/OJdQQUobXaLCNlUr23VMKFZdrUlFzNNBqrV
         Zn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AkM/tOuJKvvXClRpyG21TGaxp6vMOBkipp3n0RT3GaE=;
        b=J29sQMB70yiFlSIq3UzENJOI6mjMlhKd26IHkFQ+lQ8kEqAb+YlphYoYb7+qpmBytD
         gmrfUIb4J0ITpqCLaWGuW6BfpLMmSpO3STOwuD7YpMG2zeyhOPI8RgSQMc17Jg+NCFEU
         gGO3JTDeVkDuH8U0+ojnYi4D4teKiLmgQ4bjEFEwPGGhjNqpIpxi/NwfW2wFhJeNLxkJ
         XuYfppiBg1kE+b7i6syh8LiwRbZD6hP6a4KcpghjtOEC+8FYBn4RbSBg+pbQWMJ9F5p7
         PLmmlF0QEk/+xP41axolOjDyB9tlRZ5f1UfYNDTD4Wmv8xCDr5DbA16nUE5jH0y02f91
         VwNg==
X-Gm-Message-State: AMCzsaVqpO/s7vaOeM6ew6HXzUA71UMHlEheJmx3/oVbwnDuQjPeKfS+
        VdTcWXJL2t+Qj4KwXiznAQU8Y32y6JcCEYOZU8Q=
X-Google-Smtp-Source: ABhQp+S+3FMIwhcYdoirXrJ509SDNcLwpW3rnoXbrxNVT0E5//uQzq31sE0lmbk3rk24EQmKc1ggl48lk3wXBRozbDo=
X-Received: by 10.80.217.15 with SMTP id t15mr6104319edj.217.1509230173540;
 Sat, 28 Oct 2017 15:36:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Sat, 28 Oct 2017 15:35:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
References: <20171028000152.2760-1-jacob.e.keller@intel.com> <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 28 Oct 2017 15:35:52 -0700
Message-ID: <CA+P7+xqvHCi_aARgr0nXs7U_-P42vf8eiY7zPpG_0bp5GxokXQ@mail.gmail.com>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 9:00 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Fri, 27 Oct 2017, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> I noticed a failure with git rebase interactive mode which causes "exec"
>> commands to be run with GIT_DIR set. When GIT_DIR is in the environment,
>> then any command which results in running a git command in
>> a subdirectory will fail because GIT_DIR=".git".
>>
>> This unfortunately breaks one of my project's Makefiles, which uses
>> git-describe to find the version information, but does so from within
>> a sub directory.
>>
>> I'm in the process of running a bisect to find where this got
>> introduced, but I suspect it's part of the rebase--helper changes that
>> happened a while ago.
>
> A safe assumption. I do not know how the shell code managed that GIT_DIR
> reset, though:
>
> -- snip from v2.12.0's git-rebase--interactive.sh --
>         x|"exec")
>                 read -r command rest < "$todo"
>                 mark_action_done
>                 eval_gettextln "Executing: \$rest"
>                 "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
> -- snap --
>

>
> *However*, your test still fails with this, as
>

Yea I'm not surprised the test failed, I was in a hurry at the end of
the workday when I spotted it, but wanted to get something on the
mailing list before I left.

> - your added test tries to remove the directory with -ff instead of -rf
>
> - it tries to run `git rebase --abort` afterwards, which fails with my fix
>   because there is no rebase in progress
>
> - instead of `cd subdir && ...`, it calls `>cd subdir && ...`, which
>   causes it to abort with a "subdir: not fonud"
>
<snip>
>
> I only had time to write these two patches, and to verify that t3404
> passes now, but not that anything else passes, neither to write a proper
> commit message.
>
> Maybe you can take it from there?
>

Yep, thanks for spotting the fix!

Thanks,
Jake

> Ciao,
> Dscho
