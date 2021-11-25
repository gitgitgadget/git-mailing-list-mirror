Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD42C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 10:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354498AbhKYLBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354491AbhKYK7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 05:59:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA33C06175C
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:55:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so23655756edd.13
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UsWtJ64bpEJXFTtlyE+/5YgBLZVyieDPVPQMOQ3lmmw=;
        b=Kox1VnlwzvpmsORM4xpIQ2SCRcqY5TF5x/AtNk04Sp+qnAUAn4ZrwONNFrsrLLSRs9
         zI4XKS7wpC4CS1Z3pq7yJGhecEQOV4xPS4NGiTpg/O6pxKTsinV79bibVf4xLysEuFI2
         YL47GJQ50R4BSP7KNi+SuToWn8LN4iJvJM15tqw6+BS5ah6ZydJ7KIE66aArKL/Cbslk
         +I9M3PjjYSrLLyap0wyKnT8lFegt0OyqQaBl9JTWMNuypgrYlr/rF+8sf7NQ1jL9opcW
         QguFUVYWb0UQuCZW+qaLGyVukzMM/9QCYkwdt2emMlVSHiBHTTnG4nTaOAm7JhNMdtkC
         zP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UsWtJ64bpEJXFTtlyE+/5YgBLZVyieDPVPQMOQ3lmmw=;
        b=F8xHFZV8WvtsK/BUL3qeoymmtlXijLkwmmCwoCE09yYaZa3JlgdFkLaFL1igG+ISSs
         awx/TOemzFkT8MwI/Yi8OCwqohTejkAp/7tFAF/F9iYZpxPOr5mfUVl5/g/xHbqKNLbz
         1tAdP6zGvAagdHUcBAMjrXb6XoTxyPSd9HdXu4cn4M1b0OquKN5830fxfaokmOTavDSY
         guZoU1HMZsB47bRQLApG9QtnOLt4MhiduymFByzVwUcIKb8Xq/XRIsPdAZCtV4VV+Pk8
         uwa/0rIEo29L//W2JnC+j94Fs+X1y6LiM6Qqm9NgZWYqxiSKI8H40XVRUBSk7GaE644b
         TXZw==
X-Gm-Message-State: AOAM530X+4ZP17qDVp6fIPlKuKS1SltVveNmDSOdq8yw4/Em72TyJhhO
        Ry/WM95oX0VB/woMy+JPUZywfqesOhQ=
X-Google-Smtp-Source: ABdhPJwIFcM+Jz1yUzDk9LmsocjBw1/wxVGTbQVMIOLRs5xLrk3j8bjZG9hYTeMUcuFlju+LJn7nBA==
X-Received: by 2002:a17:907:7d94:: with SMTP id oz20mr29243702ejc.361.1637837699409;
        Thu, 25 Nov 2021 02:54:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dz18sm1732153edb.74.2021.11.25.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:54:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqCP4-0004eU-Ee;
        Thu, 25 Nov 2021 11:54:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
Date:   Thu, 25 Nov 2021 11:44:29 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
Message-ID: <211125.86bl28jyil.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:

> Removing the current working directory causes all subsequent git
> commands run from that directory to get confused and fail with a message
> about being unable to read the current working directory:
>
>     $ git status
>     fatal: Unable to read current working directory: No such file or directory
>
> Non-git commands likely have similar warnings or even errors, e.g.
>
>     $ bash -c 'echo hello'
>     shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
>     hello

Okey, but...

> diff --git a/git.c b/git.c
> index 5ff21be21f3..2c98ab48936 100644
> --- a/git.c
> +++ b/git.c
> @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
>  
>  	trace_command_performance(argv);
>  
> +	startup_info->original_cwd = xgetcwd();
> +
>  	/*
>  	 * "git-xxxx" is the same as "git xxxx", but we obviously:
>  	 *
> diff --git a/setup.c b/setup.c
> index 347d7181ae9..f30657723ea 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -432,6 +432,54 @@ void setup_work_tree(void)
>  	initialized = 1;
>  }
>  
> +static void setup_original_cwd(void)
> +{
> +	struct strbuf tmp = STRBUF_INIT;
> +	const char *worktree = NULL;
> +	int offset = -1;
> +
> +	/*
> +	 * startup_info->original_cwd wass set early on in cmd_main(), unless
> +	 * we're an auxiliary tool like git-remote-http or test-tool.
> +	 */
> +	if (!startup_info->original_cwd)
> +		return;

This really doesn't belong in those places, by calling xgetcwd() so
early you'll be making commands that don't care about RUN_SETUP at all
die. E.g. with this change:

    mkdir x &&
    cd x &&
    rm -rf ../x &&
    git version

Will die.

So as a follow-up to my comment on this v2's 01/09 I think what's also
missing here is something that does that, but instead of "git version"
does it for all of the "while read builtin" list in t0012-help.sh.

There's other cans of worms to be had here, the discussion downthread of
the not-integrated[1] points to some of that.

I.e. how should the various commands like "ls-remote" that can work
with/without a repo behave here? That one happens to die before/after,
but as noted in that thread that's also a bug.

So anything that adds more really early dying in this area should also
think about the greater goals of what we're doing with RUN_SETUP &
related flags. I.e. does the direction make sense?

If this is moved to some soft recording of the getcwd() (and maybe the
$PWD, as in my WIP change?) shouldn't this go into common-main.c? With
git.c's cmd_main() we're excluding the test helpers and things like
git-daemon. Is that intentional?

I'd also think we'd want to do this much earlier if e.g.  thing like the
trace2 setup wanted to call the remove_directory() call.

Per what Glen & mentioned I'm still not sure if I'm on board with that
idea at all, just running with the ball you put in play :) I.e. if we're
modifying all callers, let's make sure we catch all callers.

Perhaps a better approach is to intercept chdir() instead? And anything
that calls chdir() sets some GIT_* variable so we'll pass "here's our
original cwd" down to sub-processes, like we do with "git -c" for
config.

That would presumably save you the effort of in-advance whitelisting
everything like "git version", we can just move to doing this lazily. If
you're a command that does a RUN_SETUP or otherwise needs chdir() we'll
record the original getcwd(), otherwise...

1. https://lore.kernel.org/git/patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com/
