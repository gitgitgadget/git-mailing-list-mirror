Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC11C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D3D206B8
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skE1PCYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDEPKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:10:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34540 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEPKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:10:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id c195so5962411wme.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2gVQXdCU6crf1uLIn7JaLNGdhIK7Jbuqe4AE2bSf4HI=;
        b=skE1PCYedoSpuu1lQRUYkEBWdaeFbFsdP+hUzZzttCWys8Jx3IscFcxO4oSL1ZV/wl
         3YL7NotUBl3XloQZu96mKYN03150sV6evyXRDOayeJA1PdTg+1FrySoSI7iyGU8nWyW4
         gifu+yRPeyMNOTK+FQATdzVxf+0zCPiSEpVWDiJENtXiqPNKWY7v5YDqBggzU6fgv/5d
         mu3CvLepKekOeVKF/amdarVa2jr4BlOKT1ylKYQaaczQu+EOnAaFi44bCwEjZZTqr9ab
         JSTX6GoOAFB2ZL+z6y37DtYj3QJSCpseo60NAqWF4Hx1W9LmF7derVlFWQ1MKJPl4Sv5
         mdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2gVQXdCU6crf1uLIn7JaLNGdhIK7Jbuqe4AE2bSf4HI=;
        b=HJMBjqSRcBChdVr1vjj/6573STmEngQKvbf1+/axdmf9eB8I7MnsjYTJyyUpPkM1fa
         7uKcE+rumn6vgfBIVd1k0yfNY+VeVZ9WV2XcJy8ROc83P6S/GBLvtUVbck0kGYZ3YX45
         /LpL55HbQX2/basqGXd6fyZ64tO0MSYm4PE7+pIDVVnyxR0YQlYzJAy71KV11p6Eoxxo
         02N05MRT4PEmmrUgOUzpTt46Sng+mUOsVJhbVed+DQEr1nZRKBBtKBgy2VnY6OvAtNr7
         4uYOxcgPnSkQwJ5rJdwAwsEySJ61Dy3Zmonn9vhTzTsNHzagl1iE/2XlJrmY0atXymF/
         zXrA==
X-Gm-Message-State: AGi0PuacxixgaqTg8LYEp1T6sN07QlvfOFTH9z88FK0pD8trxV9Vy6dC
        T2F2Fft1ZXlPOds82WH2m/g=
X-Google-Smtp-Source: APiQypK8V368LkvstE4f20scwQzwHi5wORy9eS6mtiTQUKpfGWJifwUq3GKHWXgz3dlJ4MzfjoRLqg==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr19123113wma.51.1586099402788;
        Sun, 05 Apr 2020 08:10:02 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v7sm5732717wmg.3.2020.04.05.08.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 08:10:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com>
Date:   Sun, 5 Apr 2020 16:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git run-job' command will be used to execute a short-lived set
> of maintenance activities by a background job manager. The intention
> is to perform small batches of work that reduce the foreground time
> taken by repository maintenance such as 'git gc --auto'.
> 
> This change does the absolute minimum to create the builtin and show
> the usage output.
> 
> Provide an explicit warning that this command is experimental. The
> set of jobs may change, and each job could alter its behavior in
> future versions.
> 
> RFC QUESTION: This builtin is based on the background maintenance in
> Scalar. Specifically, this builtin is based on the "scalar run <job>"
> command [1] [2]. My default thought was to make this a "git run <job>"
> command to maximize similarity. However, it seems like "git run" is
> too generic. Or, am I being overly verbose for no reason?

Having read through this series I wondered if we wanted a single git 
command such as 'git maintenance' (suggestions of better names welcome) 
and then 'git run-job' could become 'git maintenance run', 'git 
job-runner' would become another subcommand (run-jobs or schedule-jobs?) 
and the 'git please-run-maintenance-on-this-repo' you mentioned in you 
email to Junio could become 'git maintenance init' (or maybe setup)

Best Wishes

Phillip

> [1] https://github.com/microsoft/scalar/blob/master/docs/advanced.md#run-maintenance-in-the-foreground
> [2] https://github.com/microsoft/scalar/blob/master/Scalar/CommandLine/RunVerb.cs
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   .gitignore                    |  1 +
>   Documentation/git-run-job.txt | 36 +++++++++++++++++++++++++++++++++++
>   Makefile                      |  1 +
>   builtin.h                     |  1 +
>   builtin/run-job.c             | 28 +++++++++++++++++++++++++++
>   command-list.txt              |  1 +
>   git.c                         |  1 +
>   t/t7900-run-job.sh            | 15 +++++++++++++++
>   8 files changed, 84 insertions(+)
>   create mode 100644 Documentation/git-run-job.txt
>   create mode 100644 builtin/run-job.c
>   create mode 100755 t/t7900-run-job.sh
> 
> diff --git a/.gitignore b/.gitignore
> index 188bd1c3de1..5dea9d3b96b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -144,6 +144,7 @@
>   /git-rev-parse
>   /git-revert
>   /git-rm
> +/git-run-job
>   /git-send-email
>   /git-send-pack
>   /git-serve
> diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
> new file mode 100644
> index 00000000000..0627b3ed259
> --- /dev/null
> +++ b/Documentation/git-run-job.txt
> @@ -0,0 +1,36 @@
> +git-run-job(1)
> +==============
> +
> +NAME
> +----
> +git-run-job - Run a maintenance job. Intended for background operation.
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git run-job <job-name>'
> +
> +
> +DESCRIPTION
> +-----------
> +
> +Run a maintenance job on the current repository. This is available as a
> +command for a few reasons. First, the background job feature can launch
> +these commands on a schedule and each process will completely clear its
> +memory when complete. Second, an expert user could create their own job
> +schedule by running these jobs themselves.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE SET OF AVAILABLE JOBS OR THEIR EXACT
> +BEHAVIOR MAY BE ALTERED IN THE FUTURE.
> +
> +
> +JOBS
> +----
> +
> +TBD
> +
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index ef1ff2228f0..f5f9c4d9e94 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1125,6 +1125,7 @@ BUILTIN_OBJS += builtin/rev-list.o
>   BUILTIN_OBJS += builtin/rev-parse.o
>   BUILTIN_OBJS += builtin/revert.o
>   BUILTIN_OBJS += builtin/rm.o
> +BUILTIN_OBJS += builtin/run-job.o
>   BUILTIN_OBJS += builtin/send-pack.o
>   BUILTIN_OBJS += builtin/shortlog.o
>   BUILTIN_OBJS += builtin/show-branch.o
> diff --git a/builtin.h b/builtin.h
> index 2b25a80cde3..3e0ddaaf67f 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -220,6 +220,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix);
>   int cmd_rev_parse(int argc, const char **argv, const char *prefix);
>   int cmd_revert(int argc, const char **argv, const char *prefix);
>   int cmd_rm(int argc, const char **argv, const char *prefix);
> +int cmd_run_job(int argc, const char **argv, const char *prefix);
>   int cmd_send_pack(int argc, const char **argv, const char *prefix);
>   int cmd_shortlog(int argc, const char **argv, const char *prefix);
>   int cmd_show(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/run-job.c b/builtin/run-job.c
> new file mode 100644
> index 00000000000..2c78d053aa4
> --- /dev/null
> +++ b/builtin/run-job.c
> @@ -0,0 +1,28 @@
> +#include "builtin.h"
> +#include "config.h"
> +#include "parse-options.h"
> +
> +static char const * const builtin_run_job_usage[] = {
> +	N_("git run-job"),
> +	NULL
> +};
> +
> +int cmd_run_job(int argc, const char **argv, const char *prefix)
> +{
> +	static struct option builtin_run_job_options[] = {
> +		OPT_END(),
> +	};
> +
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(builtin_run_job_usage,
> +				   builtin_run_job_options);
> +
> +	git_config(git_default_config, NULL);
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_run_job_options,
> +			     builtin_run_job_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	usage_with_options(builtin_run_job_usage,
> +			   builtin_run_job_options);
> +}
> diff --git a/command-list.txt b/command-list.txt
> index 20878946558..1cd2b415e46 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -156,6 +156,7 @@ git-revert                              mainporcelain
>   git-rev-list                            plumbinginterrogators
>   git-rev-parse                           plumbinginterrogators
>   git-rm                                  mainporcelain           worktree
> +git-run-job                             plumbingmanipulators
>   git-send-email                          foreignscminterface             complete
>   git-send-pack                           synchingrepositories
>   git-shell                               synchelpers
> diff --git a/git.c b/git.c
> index b07198fe036..db5a43c8687 100644
> --- a/git.c
> +++ b/git.c
> @@ -566,6 +566,7 @@ static struct cmd_struct commands[] = {
>   	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
>   	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
>   	{ "rm", cmd_rm, RUN_SETUP },
> +	{ "run-job", cmd_run_job, RUN_SETUP },
>   	{ "send-pack", cmd_send_pack, RUN_SETUP },
>   	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
>   	{ "show", cmd_show, RUN_SETUP },
> diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
> new file mode 100755
> index 00000000000..1eac80b7ed3
> --- /dev/null
> +++ b/t/t7900-run-job.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +test_description='git run-job
> +
> +Testing the background jobs, in the foreground
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'help text' '
> +	test_must_fail git run-job -h 2>err &&
> +	test_i18ngrep "usage: git run-job" err
> +'
> +
> +test_done
> 
