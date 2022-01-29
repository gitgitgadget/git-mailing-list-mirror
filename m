Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3953C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 07:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiA2HLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiA2HLW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 02:11:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1977C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 23:11:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c24so14818959edy.4
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wkTE8FoJIeBUGhT2opj1kH+zl24SVeFuCe1u/8InToA=;
        b=JCaCaGzHMQvqpwzl90vi5vu9A2fIIlZ4nc8Iiul/JGhaC5AmeAEK8l1OQvchGJ5nAv
         +YUhcNwD97aIc4ziGiac/AyAZ0bbVLlhLmS76Wi4LmM1hlfYvC+aG3ejMKJF0eY6Ayg6
         xGFJANS6xW/jrlNoS1kLPW0wrXFUc0eniIDb5qX3xhNOTP/kQrw3hBZfpO7jPfvdtnXs
         z7uFSUQepEHEh5pGkhEYUCj1p28clZLHHSBKRIaulbAmkpOZiZJwP6OXtDuekezC9t2u
         5kNRu0lNUovVVJ9mdjQcGULzgpFINSX8YgjEPYPj8Ob/scLD84houHqxi6p3zsFDkt7n
         /qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wkTE8FoJIeBUGhT2opj1kH+zl24SVeFuCe1u/8InToA=;
        b=wsXv+RCjIyIcB8cYktaYKsoX3TxCED3SyYdEiEI+F1CNiIPGfTjPdGJYs6sCoY2GiS
         Lwzd8pEUPlnzMNvKO4wlhKhnxYgi7g+946FnWH9cb8pzxu78oxtNjl3N9YOrrhAWSkrE
         eXuU0eY31SDwv6c8l3jj7spdbzR2Mv2QyhLV5cLbkYVIIJsWgg/Ts0W1VH2Z2MD+ObPN
         Mh1/WD8yMxDsLdRLJUX0Go1K8sMrm1b6hMCQyHn714RWzB1IJW4byU3t5R4MoUcr6LsG
         wdaMX8AemhDsSvQ5cIPplSUve0+HCE953Nw1BgGekCjPgxu3cv7xgxdr1mO0pmB1rO+m
         lQcg==
X-Gm-Message-State: AOAM5329Jlz6KsaQIxaIAqT4Hxk3odi5ZoBc8qnUasxJk3T0Tp+Dmzv7
        bt/VmTYA3xatXYBAQ8ln39bBFZnhz1udHJEZ
X-Google-Smtp-Source: ABdhPJwQJRjIWH5KDeW10juiwaw9tJRF9o8wusz3sNo/EX0XNdJP/LK6ypWItHlKSyoU30Y9AHNvOg==
X-Received: by 2002:a05:6402:4415:: with SMTP id y21mr11591263eda.162.1643440280234;
        Fri, 28 Jan 2022 23:11:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cz6sm8712213edb.4.2022.01.28.23.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 23:11:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDhtH-003lj4-6N;
        Sat, 29 Jan 2022 08:11:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Turn `git bisect` into a full built-in.
Date:   Sat, 29 Jan 2022 08:09:28 +0100
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <1c0bd8a326f482d1a6c485b7f93f510268dade20.1643328752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1c0bd8a326f482d1a6c485b7f93f510268dade20.1643328752.git.gitgitgadget@gmail.com>
Message-ID: <220129.86h79naueg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Now that the shell script hands off to the `bisect--helper` to do
> _anything_ (except to show the help), it is but a tiny step to let the
> helper implement the actual `git bisect` command instead.
>
> This retires `git-bisect.sh`, concluding a multi-year journey that many
> hands helped with, in particular Pranit Bauna, Tanushree Tumane and
> Miriam Rubio.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile                               |  3 +--
>  builtin.h                              |  2 +-
>  builtin/{bisect--helper.c => bisect.c} |  2 +-
>  git-bisect.sh                          | 37 --------------------------
>  git.c                                  |  2 +-
>  5 files changed, 4 insertions(+), 42 deletions(-)
>  rename builtin/{bisect--helper.c => bisect.c} (99%)
>  delete mode 100755 git-bisect.sh
>
> diff --git a/Makefile b/Makefile
> index 5580859afdb..ce2eabeca58 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -595,7 +595,6 @@ THIRD_PARTY_SOURCES =
>  # interactive shell sessions without exporting it.
>  unexport CDPATH
>  
> -SCRIPT_SH += git-bisect.sh
>  SCRIPT_SH += git-difftool--helper.sh
>  SCRIPT_SH += git-filter-branch.sh
>  SCRIPT_SH += git-merge-octopus.sh
> @@ -1064,7 +1063,7 @@ BUILTIN_OBJS += builtin/am.o
>  BUILTIN_OBJS += builtin/annotate.o
>  BUILTIN_OBJS += builtin/apply.o
>  BUILTIN_OBJS += builtin/archive.o
> -BUILTIN_OBJS += builtin/bisect--helper.o
> +BUILTIN_OBJS += builtin/bisect.o
>  BUILTIN_OBJS += builtin/blame.o
>  BUILTIN_OBJS += builtin/branch.o
>  BUILTIN_OBJS += builtin/bugreport.o
> diff --git a/builtin.h b/builtin.h
> index 8a58743ed63..b5567ea3a9d 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -116,7 +116,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
>  int cmd_annotate(int argc, const char **argv, const char *prefix);
>  int cmd_apply(int argc, const char **argv, const char *prefix);
>  int cmd_archive(int argc, const char **argv, const char *prefix);
> -int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
> +int cmd_bisect(int argc, const char **argv, const char *prefix);
>  int cmd_blame(int argc, const char **argv, const char *prefix);
>  int cmd_branch(int argc, const char **argv, const char *prefix);
>  int cmd_bugreport(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/bisect--helper.c b/builtin/bisect.c
> similarity index 99%
> rename from builtin/bisect--helper.c
> rename to builtin/bisect.c
> index 009c919a989..189aca9dd22 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect.c
> @@ -1182,7 +1182,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>  	}
>  }
>  
> -int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
> +int cmd_bisect(int argc, const char **argv, const char *prefix)
>  {
>  	int res = 0;
>  	struct option options[] = {
> diff --git a/git-bisect.sh b/git-bisect.sh
> deleted file mode 100755
> index 028d39cd9ce..00000000000
> --- a/git-bisect.sh
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -#!/bin/sh
> -
> -USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
> -LONG_USAGE='git bisect help
> -	print this long help message.
> -git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
> -		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
> -	reset bisect state and start bisection.
> -git bisect (bad|new) [<rev>]
> -	mark <rev> a known-bad revision/
> -		a revision after change in a given property.
> -git bisect (good|old) [<rev>...]
> -	mark <rev>... known-good revisions/
> -		revisions before change in a given property.
> -git bisect terms [--term-good | --term-bad]
> -	show the terms used for old and new commits (default: bad, good)
> -git bisect skip [(<rev>|<range>)...]
> -	mark <rev>... untestable revisions.
> -git bisect next
> -	find next bisection to test and check it out.
> -git bisect reset [<commit>]
> -	finish bisection search and go back to commit.
> -git bisect (visualize|view)
> -	show bisect status in gitk.
> -git bisect replay <logfile>
> -	replay bisection log.
> -git bisect log
> -	show bisect log.
> -git bisect run <cmd>...
> -	use <cmd>... to automatically bisect.
> -
> -Please use "git help bisect" to get the full man page.'
> -
> -OPTIONS_SPEC=
> -. git-sh-setup
> -
> -exec git bisect--helper "$@"
> diff --git a/git.c b/git.c
> index edda922ce6d..a8500132a28 100644
> --- a/git.c
> +++ b/git.c
> @@ -490,7 +490,7 @@ static struct cmd_struct commands[] = {
>  	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
>  	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
> -	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
> +	{ "bisect", cmd_bisect, RUN_SETUP },
>  	{ "blame", cmd_blame, RUN_SETUP },
>  	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
>  	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },

This should really be squashed into 07/11, and I think shows an unstated
reason for why you probably ditched parse_options.

I.e. you've stuck the descriptions of the command into what we'd in
parse_options() put after a "" item. See builtin/blame.c for such a use.

So having this squashed would really make it clear how the "-h" output
is different after this series (which is OK), and what strings are
re-used or not etc.
