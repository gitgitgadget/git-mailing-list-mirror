Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4062C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1512063A
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA+pJhuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbgDBQHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:07:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgDBQHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:07:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so2593667wrx.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJmY1gy87b4iHFEYc+R+yLv1UOQMXF25yVqmFJXW0Ls=;
        b=uA+pJhuT4NTwCAoXfKpzjhozS4VibsqAKisTdQKfNyo+3KqqxAxsPXma63IWwOaAv8
         kdOZAVxxcplacd3K87jx5OtpfyZigOmrm0OqyNURM6u+wH+gPqC9KK28cc1r0zWoqTmS
         HOjddJxtpUp8RSBWsF2MJY0SBP/DMywf/iQjy90kACq/x2S9AffJ6T98VlkwlBt/8Q3o
         Do4LeCF4ElIjU6jGgqbX4v3xkZwCxNVJG9gprbfRNpUolDHhLvilApyJZofpXKBin6r+
         Mm7lWqdJoF5GDMjQ4EtXkm8HGn8K49ix4BH4nsu+khjNJd4M9q0rgOll1MwCqcRTcMSa
         Tc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XJmY1gy87b4iHFEYc+R+yLv1UOQMXF25yVqmFJXW0Ls=;
        b=HiPcLfGbYyzbK6w61FPwVf3COSB6At2KbPp5ZMtQJ67bjVtWX0cZ/eyzBkXprEe5Sb
         TzQOSNy8U7OKQ0VMZeW8k7uUa9zTKeyuH9naqG9so7oZo8ypkeJDN6JCowA9GBT0lJ2+
         rQpmH+06oSBD/+thuqLVxsPh4G4jglkibzCiagLTBocZLpdbyoX3gD3z4rbX6o1F0wVJ
         0F/rtQYH3GZRaoxmm5h1fnYEYXb/31Zhmc+q/UrQONxrxEjow8dZPMjTNq0BYgr+IbKF
         lIyhPev4VO55uORCTxLPY6excvuXnX3fIz1DkrIThQNvScFwvBAajrGji/C0I2TkNdCo
         ylNA==
X-Gm-Message-State: AGi0PuaTTEUfhTIVvIIdOZjZo6aKCVtm+7/F5+2hxzg9iLVvRnsO8xy+
        XiB3PdV8EosC+7Yipp3kbys=
X-Google-Smtp-Source: APiQypKVWWmvllKLegkEHS2E1H2kJkFNkXEI7IfrbGPnSlYzvqrSSDAHMxVzERNkuXO8kD1hYWGVfA==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr4288430wrs.202.1585843621911;
        Thu, 02 Apr 2020 09:07:01 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id h132sm8245371wmf.18.2020.04.02.09.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 09:07:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 19/19] pull: pass --autostash to merge
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <17caf6d66f5ee33e6aef7265ab33dee83f24f05c.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1e0f5aa4-b688-0e77-6646-defb42e7672e@gmail.com>
Date:   Thu, 2 Apr 2020 17:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <17caf6d66f5ee33e6aef7265ab33dee83f24f05c.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> Before, `--autostash` only worked with `git pull --rebase`. However, in
> the last patch, merge learned `--autostash` as well so there's no reason
> why we should have this restriction anymore. Teach pull to pass
> `--autostash` to merge, just like it did for rebase.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   Documentation/git-pull.txt      |  9 -------
>   Documentation/merge-options.txt |  4 +--
>   builtin/pull.c                  |  9 ++++---
>   t/t5520-pull.sh                 | 43 +++++++++++++++++++++++++++------
>   4 files changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index dfb901f8b8..ba3772de9f 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -133,15 +133,6 @@ unless you have read linkgit:git-rebase[1] carefully.
>   --no-rebase::
>   	Override earlier --rebase.
>   
> ---autostash::
> ---no-autostash::
> -	Before starting rebase, stash local modifications away (see
> -	linkgit:git-stash[1]) if needed, and apply the stash entry when
> -	done. `--no-autostash` is useful to override the `rebase.autoStash`
> -	configuration variable (see linkgit:git-config[1]).
> -+
> -This option is only valid when "--rebase" is used.
> -
>   Options related to fetching
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 34493eb58b..ae56cca826 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -155,6 +155,8 @@ ifndef::git-pull[]
>   	Note that not all merge strategies may support progress
>   	reporting.
>   
> +endif::git-pull[]
> +
>   --autostash::
>   --no-autostash::
>   	Automatically create a temporary stash entry before the operation
> @@ -163,8 +165,6 @@ ifndef::git-pull[]
>   	with care: the final stash application after a successful
>   	rebase might result in non-trivial conflicts.
>   
> -endif::git-pull[]
> -

This change means we need a neutral wording for the --autostash 
documentation that works with rebase/merge/pull rather than mentioning a 
specific command

Best Wishes

Phillip

>   --allow-unrelated-histories::
>   	By default, `git merge` command refuses to merge histories
>   	that do not share a common ancestor.  This option can be
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e624d1e00..9beb4841d1 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -163,7 +163,7 @@ static struct option pull_options[] = {
>   		N_("verify that the named commit has a valid GPG signature"),
>   		PARSE_OPT_NOARG),
>   	OPT_BOOL(0, "autostash", &opt_autostash,
> -		N_("automatically stash/stash pop before and after rebase")),
> +		N_("automatically stash/stash pop before and after")),
>   	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
>   		N_("merge strategy to use"),
>   		0),
> @@ -661,6 +661,10 @@ static int run_merge(void)
>   	argv_array_pushv(&args, opt_strategy_opts.argv);
>   	if (opt_gpg_sign)
>   		argv_array_push(&args, opt_gpg_sign);
> +	if (opt_autostash == 0)
> +		argv_array_push(&args, "--no-autostash");
> +	else if (opt_autostash == 1)
> +		argv_array_push(&args, "--autostash");
>   	if (opt_allow_unrelated_histories > 0)
>   		argv_array_push(&args, "--allow-unrelated-histories");
>   
> @@ -908,9 +912,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>   	if (get_oid("HEAD", &orig_head))
>   		oidclr(&orig_head);
>   
> -	if (!opt_rebase && opt_autostash != -1)
> -		die(_("--[no-]autostash option is only valid with --rebase."));
> -
>   	autostash = config_autostash;
>   	if (opt_rebase) {
>   		if (opt_autostash != -1)
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index f610dc14de..37535d63a9 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -28,7 +28,7 @@ test_pull_autostash_fail () {
>   	echo dirty >new_file &&
>   	git add new_file &&
>   	test_must_fail git pull "$@" . copy 2>err &&
> -	test_i18ngrep "uncommitted changes." err
> +	test_i18ngrep "\(uncommitted changes.\)\|\(overwritten by merge:\)" err
>   }
>   
>   test_expect_success setup '
> @@ -404,13 +404,40 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
>   	test_pull_autostash_fail --rebase --no-autostash
>   '
>   
> -for i in --autostash --no-autostash
> -do
> -	test_expect_success "pull $i (without --rebase) is illegal" '
> -		test_must_fail git pull $i . copy 2>err &&
> -		test_i18ngrep "only valid with --rebase" err
> -	'
> -done
> +test_expect_success 'pull succeeds with dirty working directory and merge.autostash set' '
> +	test_config merge.autostash true &&
> +	test_pull_autostash 2
> +'
> +
> +test_expect_success 'pull --autostash & merge.autostash=true' '
> +	test_config merge.autostash true &&
> +	test_pull_autostash 2 --autostash
> +'
> +
> +test_expect_success 'pull --autostash & merge.autostash=false' '
> +	test_config merge.autostash false &&
> +	test_pull_autostash 2 --autostash
> +'
> +
> +test_expect_success 'pull --autostash & merge.autostash unset' '
> +	test_unconfig merge.autostash &&
> +	test_pull_autostash 2 --autostash
> +'
> +
> +test_expect_success 'pull --no-autostash & merge.autostash=true' '
> +	test_config merge.autostash true &&
> +	test_pull_autostash_fail --no-autostash
> +'
> +
> +test_expect_success 'pull --no-autostash & merge.autostash=false' '
> +	test_config merge.autostash false &&
> +	test_pull_autostash_fail --no-autostash
> +'
> +
> +test_expect_success 'pull --no-autostash & merge.autostash unset' '
> +	test_unconfig merge.autostash &&
> +	test_pull_autostash_fail --no-autostash
> +'
>   
>   test_expect_success 'pull.rebase' '
>   	git reset --hard before-rebase &&
> 
