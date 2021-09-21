Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B6C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFC261184
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhIUSky (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhIUSkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 14:40:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6DAC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 11:39:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so100271edb.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AXvM5eM+Lyio4VW9zhmWfvovrR2kMfZG6h6DmG8M06s=;
        b=XPkwI3CxOrTXMlBxb0YWMAdHBiGSZ346BeWLhuNRoEvtxTaGX5RXQ+1rCCRHrYvjKz
         92iRlKOAxGgCevYwumxxMiXa/XvmtfJrmy/E/QbH4mrJFDxebgiAZGiYfpHCHcxJIdS5
         0500j8j0DWtEZCgN9BSzF//v/UbDIYZZezWB3KtTmyXEcAWTQCU5BwojcYhKSr7oSULZ
         L5Kn9GLELJ4o9erQT9JBcf2nNCDTOZfESDNNiVTTvfdTyFcaIsb0ykGTD748UO80pn1/
         c5kpOt4Gr7clO9Leq8OegQhz2c9w5fE38Iw93D30IkfRI1PURxOvGrN4MybwHUeZsd0p
         piyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AXvM5eM+Lyio4VW9zhmWfvovrR2kMfZG6h6DmG8M06s=;
        b=XUf3lLGg2YkqpW+baEeDkvZ6QaoVJ/5e1pnx33I1puF1MNCrt6IdaN5x5pvvl5y5Vm
         XBqIHrUL/9LRclrwC2eL1ePYe3pNT39+F/uiW4gGUdSLAxwjShLVy8zRWwHVFnHVENHO
         GAvjYDWHe1vxFGUel/4wdPcLv7ft+VyWmILNalUy+0GlW++B2cvzbMEjPxzaDbyEfdxM
         EiVzCdSWK/tKS2uCeOh+wpjTeZreJUI/1NtbzTUurOxFDA4auheSVSomB6dfChEdXoof
         y7k8dg8P4Iay22EiQkTgyRhCPHTyeze1T4cXUzOnMGsK7SeQ3d1A5t4vVRt3SQX1Dm2N
         i+DQ==
X-Gm-Message-State: AOAM532twhF+xeIZJIDvxZyuCzklUFMKwdMZgcVEq4k4ULV2Iwfg2AJW
        uJHCZD9pO25i86zAWZ0KFJY=
X-Google-Smtp-Source: ABdhPJzUUcyGyoOcnnGPFvnxQ7qrhaB3xLTxhFTqMh8mGHYRIJOKgAbYovDyyIgqpLwakE3R/XX4kQ==
X-Received: by 2002:a05:6402:299:: with SMTP id l25mr36920670edv.343.1632249562607;
        Tue, 21 Sep 2021 11:39:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dj8sm9005152edb.53.2021.09.21.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:39:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, szeder.dev@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
Date:   Tue, 21 Sep 2021 20:19:47 +0200
References: <cover.1631980949.git.me@ttaylorr.com>
 <xmqqr1dj9c0b.fsf@gitster.g> <YUj/h3xucy4JR7B1@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUj/h3xucy4JR7B1@nand.local>
Message-ID: <87zgs593ja.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Taylor Blau wrote:

> On Mon, Sep 20, 2021 at 02:24:04PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > An open question is whether the same should be done for the multi-pack-index
>> > command, whose top-level support for `--[no-]progress` was released in v2.32.0
>> > with 60ca94769c (builtin/multi-pack-index.c: split sub-commands, 2021-03-30).
>>
>> We do not mind too much about "breaking backward compatibility" by
>> removing the mistaken "git multi-pack-index --progress cmd", I would
>> say.  It's not like people would type it once every day and removing
>> the "support" will break their finger-memory.
>
> OK; if we don't mind then we could do something like the following on
> top. But if we're OK to remove the top-level `--progress` option from
> the commit-graph and multi-pack-index builtins at any time, then both
> patches become far less urgent.

I think just taking both this and your commit-graph patches is the right
thing to do at this point. I.e. we almost entirely take:

    git [git-opts] <cmd> [cmd-opts]

Or:

    git [git-opts] <cmd> <subcmd> [subcmd-opts]

And almost never:

    git [git-opts] <cmd> [global-subcmd-opts] <subcmd> [subcmd-opts]

A notable exception is the --object-dir (I think I found out from
Derrick at some point why that was even needed v.s. the top-level
--git-dir, but I can't remember).

I think that fixing th commit-graph regression I introduced is an
obvious thing to do at this point, and likewise with multi-pack-index I
think it's young enough that we can just change it and not live with the
wart forever.

And as a general thing, we really should be marking all new built-ins as
having an experimental interface for the first N releases, to catch and
correct these sorts of issues.

But just as a *general* comment on where our UI should and shouldn't be
headed, I find your [1] an entirely unconvincing reply to [2]. I.e.:

    [...] the [...] issue is that the existing sub-commands of
    commit-graph only happen to both have a sensible interpretation of
    what `--progress` or `--no-progress` means. If we ever added a
    sub-command which didn't have a notion of progress, we would be
    forced to ignore the top-level `--[no-]progress` altogether.

I'd think if anything that's an argument for pursuing the
[global-subcmd-opts] for these sorts of options, i.e.:

 * We're not talking about a --find option or something that's likely to
   have different meanings.

   If using a [global-subcmd-opts] pattern means that we can't have some
   command have a --progress that means something entirely
   different. Then that to me seems like an obvious argument for the
   opposite point, i.e. that oddity should name its option something
   else, just as we're spared the confusion of not having --exec-path or
   whatever behave differently per-command.

 * I really don't see how for an option like --progress that we've got
   en established pattern working the same way across the board, why
   it's an issue that something accepts a --progress and doesn't do
   anything with it yet, or ever.

   We don't insist on our config system being configured to the command
   or subcommand level, I don't see why in terms of implementation or
   ease of user understanding why it would be desirable to treat this
   differently.

   I.e. not everything's a --progress or core.pager, but some things
   are, and having those things be closer to global than not is useful.

Anyway, as I noted let's take both of these patches now. I just wrote
this out mainly for my own future reference. I am interesting in
extending parse_options() and the config system into something that
allows you to all-at-once define commands and subcommands and have
what's now a bunch of duplicated and subtly different code done for you
automatically.

In that scenario I don't see why in terms of both commands and config
why we wouldn't define things in terms of "levels" and always understand
certain things at certain levels, and pass them down. E.g. --exec-path
and --object-format at the first, maybe --progress or
--output-format=json at the second (between a command and subcommand)
level etc.

1. https://lore.kernel.org/git/e41e65ddf77c596a7926e75bfc15f21c075d0f03.1631980949.git.me@ttaylorr.com/
2. https://lore.kernel.org/git/87zgsad6mn.fsf@evledraar.gmail.com/


> --- >8 ---
>
> Subject: [PATCH] builtin/multi-pack-index.c: disable top-level --[no-]progress
>
> In a similar spirit as the previous patch, let sub-commands which
> support showing or hiding a progress meter handle parsing the
> `--progress` or `--no-progress` option, but do not expose it as an
> option to the top-level `multi-pack-index` builtin.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-multi-pack-index.txt |  6 ++---
>  builtin/multi-pack-index.c             | 31 +++++++++++++++++++++-----
>  t/t5319-multi-pack-index.sh            | 12 +++++-----
>  3 files changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index ffd601bc17..5ba4bd5166 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -9,8 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
>  SYNOPSIS
>  --------
>  [verse]
> -'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
> -	[--preferred-pack=<pack>] <subcommand>
> +'git multi-pack-index' [--object-dir=<dir>] <sub-command>
>
>  DESCRIPTION
>  -----------
> @@ -26,7 +25,8 @@ OPTIONS
>
>  --[no-]progress::
>  	Turn progress on/off explicitly. If neither is specified, progress is
> -	shown if standard error is connected to a terminal.
> +	shown if standard error is connected to a terminal. Supported by
> +	sub-commands `write`, `verify`, `expire`, and `repack.
>
>  The following subcommands are available:
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 649aa5f9ab..5f11a3067d 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -52,7 +52,6 @@ static struct opts_multi_pack_index {
>  static struct option common_opts[] = {
>  	OPT_FILENAME(0, "object-dir", &opts.object_dir,
>  	  N_("object directory containing set of packfile and pack-index pairs")),
> -	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
>  	OPT_END(),
>  };
>
> @@ -68,6 +67,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
>  			   N_("preferred-pack"),
>  			   N_("pack for reuse when computing a multi-pack bitmap")),
> +		OPT_BIT(0, "progress", &opts.flags,
> +			N_("force progress reporting"), MIDX_PROGRESS),
>  		OPT_END(),
>  	};
>
> @@ -75,6 +76,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>
>  	trace2_cmd_mode(argv[0]);
>
> +	if (isatty(2))
> +		opts.flags |= MIDX_PROGRESS;
>  	argc = parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_write_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
> @@ -90,10 +93,18 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>
>  static int cmd_multi_pack_index_verify(int argc, const char **argv)
>  {
> -	struct option *options = common_opts;
> +	struct option *options;
> +	static struct option builtin_multi_pack_index_verify_options[] = {
> +		OPT_BIT(0, "progress", &opts.flags,
> +			N_("force progress reporting"), MIDX_PROGRESS),
> +		OPT_END(),
> +	};
> +	options = add_common_options(builtin_multi_pack_index_verify_options);
>
>  	trace2_cmd_mode(argv[0]);
>
> +	if (isatty(2))
> +		opts.flags |= MIDX_PROGRESS;
>  	argc = parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_verify_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
> @@ -106,10 +117,18 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
>
>  static int cmd_multi_pack_index_expire(int argc, const char **argv)
>  {
> -	struct option *options = common_opts;
> +	struct option *options;
> +	static struct option builtin_multi_pack_index_expire_options[] = {
> +		OPT_BIT(0, "progress", &opts.flags,
> +			N_("force progress reporting"), MIDX_PROGRESS),
> +		OPT_END(),
> +	};
> +	options = add_common_options(builtin_multi_pack_index_expire_options);
>
>  	trace2_cmd_mode(argv[0]);
>
> +	if (isatty(2))
> +		opts.flags |= MIDX_PROGRESS;
>  	argc = parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_expire_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
> @@ -126,6 +145,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
>  	static struct option builtin_multi_pack_index_repack_options[] = {
>  		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
>  		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
> +		OPT_BIT(0, "progress", &opts.flags,
> +		  N_("force progress reporting"), MIDX_PROGRESS),
>  		OPT_END(),
>  	};
>
> @@ -133,6 +154,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
>
>  	trace2_cmd_mode(argv[0]);
>
> +	if (isatty(2))
> +		opts.flags |= MIDX_PROGRESS;
>  	argc = parse_options(argc, argv, NULL,
>  			     options,
>  			     builtin_multi_pack_index_repack_usage,
> @@ -154,8 +177,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
>
>  	git_config(git_default_config, NULL);
>
> -	if (isatty(2))
> -		opts.flags |= MIDX_PROGRESS;
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_multi_pack_index_options,
>  			     builtin_multi_pack_index_usage,
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 3d4d9f10c3..86b7de2281 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -174,12 +174,12 @@ test_expect_success 'write progress off for redirected stderr' '
>  '
>
>  test_expect_success 'write force progress on for stderr' '
> -	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress write 2>err &&
> +	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir write --progress 2>err &&
>  	test_file_not_empty err
>  '
>
>  test_expect_success 'write with the --no-progress option' '
> -	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
> +	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir write --no-progress 2>err &&
>  	test_line_count = 0 err
>  '
>
> @@ -429,12 +429,12 @@ test_expect_success 'repack progress off for redirected stderr' '
>  '
>
>  test_expect_success 'repack force progress on for stderr' '
> -	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
> +	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack --progress 2>err &&
>  	test_file_not_empty err
>  '
>
>  test_expect_success 'repack with the --no-progress option' '
> -	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
> +	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack --no-progress 2>err &&
>  	test_line_count = 0 err
>  '
>
> @@ -618,7 +618,7 @@ test_expect_success 'expire progress off for redirected stderr' '
>  test_expect_success 'expire force progress on for stderr' '
>  	(
>  		cd dup &&
> -		GIT_PROGRESS_DELAY=0 git multi-pack-index --progress expire 2>err &&
> +		GIT_PROGRESS_DELAY=0 git multi-pack-index expire --progress 2>err &&
>  		test_file_not_empty err
>  	)
>  '
> @@ -626,7 +626,7 @@ test_expect_success 'expire force progress on for stderr' '
>  test_expect_success 'expire with the --no-progress option' '
>  	(
>  		cd dup &&
> -		GIT_PROGRESS_DELAY=0 git multi-pack-index --no-progress expire 2>err &&
> +		GIT_PROGRESS_DELAY=0 git multi-pack-index expire --no-progress 2>err &&
>  		test_line_count = 0 err
>  	)
>  '

