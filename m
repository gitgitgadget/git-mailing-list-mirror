Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C389C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiBWWT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBWWT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:19:57 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03331A3BC
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:19:24 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE25E11FB42;
        Wed, 23 Feb 2022 17:19:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ctM+Er6bEhPn
        c8b2O33B+7yzmoAM6bVXwcH4i/RvxLA=; b=D8/ih+nY9RgDqcu9zbVy4ojfoN+2
        qYMg6uRu4nhIS70AHWEXYNw3mhOqsXxA34Zi5ik+aFwJl0WgaEVkrtuX7MpxI/Eh
        d26W8EZ83Ob4mWyN8xgCUI2cBHOJWAEhxHZZHubUgQdhzneONuRTczefuHtlN8vS
        fSqHvMmFkx7i6D4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E657A11FB41;
        Wed, 23 Feb 2022 17:19:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58C9011FB40;
        Wed, 23 Feb 2022 17:19:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 8/9] help: add --no-[external-commands|aliases] for
 use with --all
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-8.9-c81c0cbbcdb-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 14:19:22 -0800
In-Reply-To: <patch-v2-8.9-c81c0cbbcdb-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:51
        +0100")
Message-ID: <xmqqo82xql91.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A772963A-94F6-11EC-BF45-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add the ability to only emit git's own usage information under
> --all. This also allows us to extend the "test_section_spacing" tests
> added in a preceding commit to test "git help --all"
> output.

Makes sense.

> +static int show_external_commands =3D -1;
> +static int show_aliases =3D -1;
>  static struct option builtin_help_options[] =3D {
>  	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands")=
,
>  		    HELP_ACTION_ALL),
> +	OPT_BOOL(0, "external-commands", &show_external_commands,
> +		 N_("show external commands in --all")),
> +	OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all")),
>  	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude gui=
des")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMA=
T_MAN),
>  	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"=
),
> @@ -75,7 +80,7 @@ static struct option builtin_help_options[] =3D {
>  };
> =20
>  static const char * const builtin_help_usage[] =3D {
> -	N_("git help [-a|--all] [--[no-]verbose]]"),
> +	N_("git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] =
[--[no-]aliases]"),
>  	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
>  	N_("git help [-g|--guides]"),
>  	N_("git help [-c|--config]"),
> @@ -620,12 +625,19 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
>  			builtin_help_usage, 0);
>  	parsed_help_format =3D help_format;
> =20
> +	if (cmd_mode !=3D HELP_ACTION_ALL &&
> +	    (show_external_commands >=3D 0 ||
> +	     show_aliases >=3D 0))
> +		usage_msg_opt(_("the '--no-[external-commands|aliases]' options can =
only be used with '--all'"),
> +			      builtin_help_usage, builtin_help_options);

Nice attention to a small detail.

>  	switch (cmd_mode) {
>  	case HELP_ACTION_ALL:
>  		opt_mode_usage(argc, "--all", help_format);
>  		if (verbose) {
>  			setup_pager();
> -			list_all_cmds_help();
> +			list_all_cmds_help(show_external_commands,
> +					   show_aliases);
>  			return 0;
>  		}
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
> diff --git a/help.c b/help.c
> index 004117347ee..45a21e7e35c 100644
> --- a/help.c
> +++ b/help.c
> @@ -476,15 +476,17 @@ static void list_all_cmds_help_aliases(int longes=
t)
>  	string_list_clear(&alias_list, 1);
>  }
> =20
> -void list_all_cmds_help(void)
> +void list_all_cmds_help(int show_external_commands, int show_aliases)
>  {
>  	int longest;
> =20
>  	puts(_("See 'git help <command>' to read about a specific subcommand"=
));
>  	print_cmd_by_category(main_categories, &longest);
> =20
> -	list_all_cmds_help_external_commands();
> -	list_all_cmds_help_aliases(longest);
> +	if (show_external_commands)
> +		list_all_cmds_help_external_commands();
> +	if (show_aliases)
> +		list_all_cmds_help_aliases(longest);
>  }

OK.  Quite straight-forward after the earlier split.

