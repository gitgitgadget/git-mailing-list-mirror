Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBEDC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD77208C7
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXvEB4Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHTPA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgHTPAy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 11:00:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5ACC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 08:00:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so1036716plk.13
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CKQ0IqEvxSej0Qu0MXlNM9hw9fI4GlFg1QBxE+Shark=;
        b=EXvEB4Wxni8i61DdJm/E3BYz2V2yHLVzVGHMPpIIObIviF6PLDIsy6RYzyoAEJfI6P
         Nyt1y67eZi3bPI/AXIKfSb0z/NjU/4P6JI/iDl5DERhSU9fm4yDVUXgWWUnmsrhDxaS/
         NeyVtMyLwVco7+I7JPB3rxUkPhwXHHl1eeLtBidqlLqNpKYz2UpeayHEh0sKF/4NXgJV
         9GvNdrCziWdpnIo0fkBOaZEJEFAMs7vHH3daFrzLR02+uEmUUh0oRQjTc53h5XjFBg86
         v/SwSmqS32XNdTRqVAO7mYZcDHMJ5T9jS5MUcCubjJuQ19TMJJK5L35VsgB7jQbbWxmD
         EMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKQ0IqEvxSej0Qu0MXlNM9hw9fI4GlFg1QBxE+Shark=;
        b=WVmJoRfz8d1CR12dVp6dk6hWfX+Sly5N6GQM5s7GJ6KJ2+R4Hs/i7I0TuEVbNllFoC
         MObXmo4iB70YfzO+Ure0jAr76c3ihZ/YfoQRUlH4GBKEhXv7oj8P/GJ0E12x/O08iMDU
         iCOmcGuCOMZaqQx91MPOv8vuuN7MqSOHrnjWruxjX1vJ/F4JQkcHsNvhSSt5a13ddlIZ
         2ctqIXL5CSQNo8vnqiweOLTwavt/1ncaejbnBE7VKXkVp2CTAAMm1ESJf9MSu9e+fo8Z
         YWotccjDS/wNCslwbFO5VB68Q+VeQ6Y9vawJLkUXw6aBCn98JnCWeByLAEXqS9X/pL5Q
         3n8Q==
X-Gm-Message-State: AOAM5302JThl0H2o7QLdVK1WNVlnWVTb81F0umY+BxORLt45/w+EsfpH
        8Bd2qlTfBKiU9t/3Ga5FpDAAQ4jFCen34Q==
X-Google-Smtp-Source: ABdhPJxn4zOR748ED8DQxNWnAZqFTeV4947vQgXPIbPhGkO4nZf142ttnYi96yu5xGSpXgeVBkWF6g==
X-Received: by 2002:a62:e30a:: with SMTP id g10mr2417029pfh.66.1597935651547;
        Thu, 20 Aug 2020 08:00:51 -0700 (PDT)
Received: from localhost ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id x6sm3256762pfd.53.2020.08.20.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:00:50 -0700 (PDT)
Date:   Thu, 20 Aug 2020 22:00:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/7] for-each-repo: run subcommands on configured repos
Message-ID: <20200820150048.GD31084@danh.dev>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <ccb667dc6fa4704171da643158ecd79ed7dd2cd3.1597857412.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb667dc6fa4704171da643158ecd79ed7dd2cd3.1597857412.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-19 17:16:45+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> It can be helpful to store a list of repositories in global or system
> config and then iterate Git commands on that list. Create a new builtin
> that makes this process simple for experts. We will use this builtin to
> run scheduled maintenance on all configured repositories in a future
> change.

Nice, I like this new command.

However, I'm not sure if we could declare this command as plumbing or
porcelain command.

I guess this command is meant more for scripting purpose, hence, it
should be plumbing, thus we need to define clear protocol for this
command, e.g, where it will redirect other command output, error to,
where for-each-repo write its own output/error.

Also, I think it would be nice to declare this is experimental for now.
Like we declared git-switch and git-restore.

-- 
Danh

> 
> The test is very simple, but does highlight that the "--" argument is
> optional.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .gitignore                          |  1 +
>  Documentation/git-for-each-repo.txt | 45 ++++++++++++++++++++++
>  Makefile                            |  1 +
>  builtin.h                           |  1 +
>  builtin/for-each-repo.c             | 58 +++++++++++++++++++++++++++++
>  git.c                               |  1 +
>  t/t0068-for-each-repo.sh            | 30 +++++++++++++++
>  7 files changed, 137 insertions(+)
>  create mode 100644 Documentation/git-for-each-repo.txt
>  create mode 100644 builtin/for-each-repo.c
>  create mode 100755 t/t0068-for-each-repo.sh
> 
> diff --git a/.gitignore b/.gitignore
> index a5808fa30d..5eb2a2be71 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -67,6 +67,7 @@
>  /git-filter-branch
>  /git-fmt-merge-msg
>  /git-for-each-ref
> +/git-for-each-repo
>  /git-format-patch
>  /git-fsck
>  /git-fsck-objects
> diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
> new file mode 100644
> index 0000000000..83b06db410
> --- /dev/null
> +++ b/Documentation/git-for-each-repo.txt
> @@ -0,0 +1,45 @@
> +git-for-each-repo(1)
> +====================
> +
> +NAME
> +----
> +git-for-each-repo - Run a Git command on a list of repositories
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git for-each-repo' --config=<config> [--] <arguments>
> +
> +
> +DESCRIPTION
> +-----------
> +Run a Git commands on a list of repositories. The arguments after the
> +known options or `--` indicator are used as the arguments for the Git
> +command.
> +
> +For example, we could run maintenance on each of a list of repositories
> +stored in a `maintenance.repo` config variable using
> +
> +-------------
> +git for-each-repo --config=maintenance.repo maintenance run
> +-------------
> +
> +This will run `git -C <repo> maintenance run` for each value `<repo>`
> +in the multi-valued config variable `maintenance.repo`.
> +
> +
> +OPTIONS
> +-------
> +--config=<config>::
> +	Use the given config variable as a multi-valued list storing
> +	absolute path names. Iterate on that list of paths to run
> +	the given arguments.
> ++
> +These config values are loaded from system, global, and local Git config,
> +as available. If `git for-each-repo` is run in a directory that is not a
> +Git repository, then only the system and global config is used.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 65f8cfb236..7c588ff036 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1071,6 +1071,7 @@ BUILTIN_OBJS += builtin/fetch-pack.o
>  BUILTIN_OBJS += builtin/fetch.o
>  BUILTIN_OBJS += builtin/fmt-merge-msg.o
>  BUILTIN_OBJS += builtin/for-each-ref.o
> +BUILTIN_OBJS += builtin/for-each-repo.o
>  BUILTIN_OBJS += builtin/fsck.o
>  BUILTIN_OBJS += builtin/gc.o
>  BUILTIN_OBJS += builtin/get-tar-commit-id.o
> diff --git a/builtin.h b/builtin.h
> index 17c1c0ce49..ff7c6e5aa9 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -150,6 +150,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix);
>  int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
>  int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
>  int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
> +int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
>  int cmd_format_patch(int argc, const char **argv, const char *prefix);
>  int cmd_fsck(int argc, const char **argv, const char *prefix);
>  int cmd_gc(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> new file mode 100644
> index 0000000000..5bba623ff1
> --- /dev/null
> +++ b/builtin/for-each-repo.c
> @@ -0,0 +1,58 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "string-list.h"
> +
> +static const char * const for_each_repo_usage[] = {
> +	N_("git for-each-repo --config=<config> <command-args>"),
> +	NULL
> +};
> +
> +static int run_command_on_repo(const char *path,
> +			       void *cbdata)
> +{
> +	int i;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strvec *args = (struct strvec *)cbdata;
> +
> +	child.git_cmd = 1;
> +	strvec_pushl(&child.args, "-C", path, NULL);
> +
> +	for (i = 0; i < args->nr; i++)
> +		strvec_push(&child.args, args->v[i]);
> +
> +	return run_command(&child);
> +}
> +
> +int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
> +{
> +	static const char *config_key = NULL;
> +	int i, result = 0;
> +	const struct string_list *values;
> +	struct strvec args = STRVEC_INIT;
> +
> +	const struct option options[] = {
> +		OPT_STRING(0, "config", &config_key, N_("config"),
> +			   N_("config key storing a list of repository paths")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, for_each_repo_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (!config_key)
> +		die(_("missing --config=<config>"));
> +
> +	for (i = 0; i < argc; i++)
> +		strvec_push(&args, argv[i]);
> +
> +	values = repo_config_get_value_multi(the_repository,
> +					     config_key);
> +
> +	for (i = 0; !result && i < values->nr; i++)
> +		result = run_command_on_repo(values->items[i].string, &args);
> +
> +	return result;
> +}
> diff --git a/git.c b/git.c
> index 24f250d29a..1cab64b5d1 100644
> --- a/git.c
> +++ b/git.c
> @@ -511,6 +511,7 @@ static struct cmd_struct commands[] = {
>  	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
>  	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
>  	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
> +	{ "for-each-repo", cmd_for_each_repo, RUN_SETUP_GENTLY },
>  	{ "format-patch", cmd_format_patch, RUN_SETUP },
>  	{ "fsck", cmd_fsck, RUN_SETUP },
>  	{ "fsck-objects", cmd_fsck, RUN_SETUP },
> diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
> new file mode 100755
> index 0000000000..136b4ec839
> --- /dev/null
> +++ b/t/t0068-for-each-repo.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +test_description='git for-each-repo builtin'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'run based on configured value' '
> +	git init one &&
> +	git init two &&
> +	git init three &&
> +	git -C two commit --allow-empty -m "DID NOT RUN" &&
> +	git config run.key "$TRASH_DIRECTORY/one" &&
> +	git config --add run.key "$TRASH_DIRECTORY/three" &&
> +	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
> +	git -C one log -1 --pretty=format:%s >message &&
> +	grep ran message &&
> +	git -C two log -1 --pretty=format:%s >message &&
> +	! grep ran message &&
> +	git -C three log -1 --pretty=format:%s >message &&
> +	grep ran message &&
> +	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
> +	git -C one log -1 --pretty=format:%s >message &&
> +	grep again message &&
> +	git -C two log -1 --pretty=format:%s >message &&
> +	! grep again message &&
> +	git -C three log -1 --pretty=format:%s >message &&
> +	grep again message
> +'
> +
> +test_done
> -- 
> gitgitgadget
> 

-- 
Danh
