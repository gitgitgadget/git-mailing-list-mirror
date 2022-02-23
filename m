Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF554C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbiBWWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWWFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:05:04 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C164D9F9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:04:36 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C59A11F904;
        Wed, 23 Feb 2022 17:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VUs5deiQy6rY
        nrCT2C+nAHWgXRstnQN68aCfiiKEWIU=; b=bYeIXAgKt4Qd5honXuizLdZYL0Jc
        MPeYwYyaRm02yK9+LG3/CSQYKbM3/cPryWtogZggWr0WeiADNstwXDwLgtesCoI9
        8dyTga4TYQuHhcvCeYo6ulx+DrQCTQQeYsmdaXquTzUBdLML8i0K1mPUlYNmcZNI
        PhllfxNrz6tYwaY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9400511F903;
        Wed, 23 Feb 2022 17:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0381311F902;
        Wed, 23 Feb 2022 17:04:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 5/9] help: note the option name on option
 incompatibility
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-5.9-e5c49089106-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 14:04:33 -0800
In-Reply-To: <patch-v2-5.9-e5c49089106-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:48
        +0100")
Message-ID: <xmqq7d9ls0i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95F384DE-94F4-11EC-96BA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the errors added in d35d03cf93e (help: simplify by moving to
> OPT_CMDMODE(), 2021-09-22) to quote the offending option at the user
> when invoked as e.g.:
>
>     git help --guides garbage
>
> Now instead of:
>
>     fatal: this option doesn't take any other arguments
>
> We'll emit:
>
>     fatal: the '--guides' option doesn't take any non-option arguments

Very good.

> Let's also rename the function, as it will be extended to do other
> checks that aren't "no extra argc" in a subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/help.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index d387131dd83..1c1581ef850 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -574,11 +574,12 @@ static const char *check_git_cmd(const char* cmd)
>  	return cmd;
>  }
> =20
> -static void no_extra_argc(int argc)
> +static void opt_mode_usage(int argc, const char *opt_mode)
>  {
>  	if (argc)
> -		usage_msg_opt(_("this option doesn't take any other arguments"),
> -			      builtin_help_usage, builtin_help_options);
> +		usage_msg_optf(_("the '%s' option doesn't take any non-option argume=
nts"),
> +			       builtin_help_usage, builtin_help_options,
> +			       opt_mode);
>  }
> =20
>  int cmd_help(int argc, const char **argv, const char *prefix)
> @@ -604,20 +605,20 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
>  		printf("%s\n", _(git_more_info_string));
>  		break;
>  	case HELP_ACTION_GUIDES:
> -		no_extra_argc(argc);
> +		opt_mode_usage(argc, "--guides");
>  		list_guides_help();
>  		printf("%s\n", _(git_more_info_string));
>  		return 0;
>  	case HELP_ACTION_CONFIG_FOR_COMPLETION:
> -		no_extra_argc(argc);
> +		opt_mode_usage(argc, "--config-for-completion");
>  		list_config_help(SHOW_CONFIG_VARS);
>  		return 0;
>  	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
> -		no_extra_argc(argc);
> +		opt_mode_usage(argc, "--config-sections-for-completion");
>  		list_config_help(SHOW_CONFIG_SECTIONS);
>  		return 0;
>  	case HELP_ACTION_CONFIG:
> -		no_extra_argc(argc);
> +		opt_mode_usage(argc, "--config");
>  		setup_pager();
>  		list_config_help(SHOW_CONFIG_HUMAN);
>  		printf("\n%s\n", _("'git help config' for more information"));
