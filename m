Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD62C60F9D
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhIVQY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:24:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56345 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhIVQY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 12:24:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 611AFFD2E5;
        Wed, 22 Sep 2021 12:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uQfxUmNaqpk9L1hIY2LJMuvEIGGvo6E6aK7M6U
        +/f+U=; b=GHooiTEwhWipqf56igfjnhLkZg9Imq/phfh76tiMl9mT7XNyYJx588
        mOiyGQqeiQJcO+SSuoSY2v4knQRLlYiGMv7KP7IWUS7UHW6fL7CAlVSP+DYHNmnu
        yDelKFdjVI3kkiSzo0J63NBRBuNmTG1DqqiIfq9T2GzxCjKfrNrWc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 568F0FD2E4;
        Wed, 22 Sep 2021 12:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4193FD2E3;
        Wed, 22 Sep 2021 12:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
References: <cover.1631980949.git.me@ttaylorr.com>
        <xmqqr1dj9c0b.fsf@gitster.g> <YUj/h3xucy4JR7B1@nand.local>
Date:   Wed, 22 Sep 2021 09:22:53 -0700
In-Reply-To: <YUj/h3xucy4JR7B1@nand.local> (Taylor Blau's message of "Mon, 20
        Sep 2021 17:39:19 -0400")
Message-ID: <xmqqa6k48tr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5737F74A-1BC1-11EC-B361-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Subject: [PATCH] builtin/multi-pack-index.c: disable top-level --[no-]progress
>
> In a similar spirit as the previous patch, let sub-commands which
> support showing or hiding a progress meter handle parsing the
> `--progress` or `--no-progress` option, but do not expose it as an
> option to the top-level `multi-pack-index` builtin.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

Hmph, so a few older releases accepts --progress at a wrong point on
the command line but going forward we will correct it?

OK.  Then I buy the mention of "as the _previous_ patch" above ;-)

Thanks.

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
> --
> 2.33.0.96.g73915697e6
