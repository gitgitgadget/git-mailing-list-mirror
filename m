Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D2C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB8160FF4
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhGVLRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhGVLR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:17:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44AC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:58:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c17so7932709ejk.13
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4dK9einHCLwYawJjS8qHtivTL+40bHHcoSM1IViWM2U=;
        b=FRFxn0wPzM4x9Mx9bSU31rEIc9vOX5Ig/o9jx8QwbMyh5m6VJf1/m8P73SKg6o8eT/
         YWLxdifITLduajtktIoXJpbTRQv7P9K12ObaQ8oEutfrmRJdZ7qXiIrSk8O2nHBq8vPT
         rhRPZLW3ozsTzcTyZXYLzCmDFOAuKIESzgiliG469x5qaAejaXw/BsVs98F33NC1isEj
         NcFYdmYj0Dm4o35eSafP5h6U3JfwzBtr8pl75offngjA7iJ0Wi9u/rRCcODhi3W07u1x
         aJDvrNpm8G9mTLRz1N9D7NkXIHwxxYrtcWzreolJ/wfBIvstWvvD4s3SdyCpQuEHfCT6
         tnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4dK9einHCLwYawJjS8qHtivTL+40bHHcoSM1IViWM2U=;
        b=O36lXEGGYhcCliNCKKZEyuzSQNGc0gW86tdVSUEgK4t/5LugKDNkDfDrG4hkSkCqde
         cbfQwCKIUGXLs4RWaUAboyL1O090ySmFOU7Lc9aY7Vu/vLC1aY4Hs57hDGt9qwlGJUqg
         Ur6lgD34nPBPPNEy/PvNBk2jkFdUUxSuMp3Wu/C0YDjXZdkctadBXjmMPXeqbhO31wvV
         rAcT4xEV6gFBb0erjS/PcLP7pX46pRd9GhZLO+ahefeGlvmyVuLd7HfYsCuIjvw3TKgJ
         vcey/7bX55m4CPxvmugKAUpzuykHVrEPKthN8buZeLE604nnvKx89TWGxVioPwLKahue
         hslg==
X-Gm-Message-State: AOAM530gRJ1V4Ex/2YMqVcbMNVovBrUOLxYWUTILMEwkPamgPrhdLUf1
        AriPAFpEfbakVL97HGebCDqthjDepLTwfQ==
X-Google-Smtp-Source: ABdhPJzj/rz1OYlOUmbXIwIW46VFBUBX6SDgHMb4VMB0+U43Q7GkFaHICIx2gXtNBMKByyRgAIsMBA==
X-Received: by 2002:a17:906:a108:: with SMTP id t8mr42363102ejy.407.1626955081803;
        Thu, 22 Jul 2021 04:58:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a16sm12247270edv.69.2021.07.22.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:58:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
Date:   Thu, 22 Jul 2021 13:50:14 +0200
References: <20210722112143.97944-1-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210722112143.97944-1-raykar.ath@gmail.com>
Message-ID: <87sg06tvab.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Atharva Raykar wrote:

> +static void config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
> +{
> +	char *key;
> +
> +	if (!is_writing_gitmodules_ok())
> +		die(_("please make sure that the .gitmodules file is in the working tree"));
> +
> +	key = xstrfmt("submodule.%s.%s", name, var);
> +	config_set_in_gitmodules_file_gently(key, value);
> +	free(key);
> +}

Just a small point not per-se to do with this patch, but aren't all
callers of config_set_in_gitmodules_file_gently() wanting to prefix
thigs with "submodule."? Looks like its API could be simplified a bit
with that xstrfmt() and free() inside that function.

> +static void configure_added_submodule(struct add_data *add_data)
> +{
> +	char *key, *submod_pathspec = NULL;
> +	struct child_process add_submod = CHILD_PROCESS_INIT;
> +	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
> +	int pathspec_key_exists, activate = 0;

Usual style is to have different variables on different lines, unless
they're closely related (like "int i, j"), so "char *key;\n char
*submod[...]" in this case.

> +
> +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
> +	git_config_set_gently(key, add_data->realrepo);
> +	free(key);
> +
> +	add_submod.git_cmd = 1;
> +	strvec_pushl(&add_submod.args, "add",
> +		     "--no-warn-embedded-repo", NULL);
> +	if (add_data->force)
> +		strvec_push(&add_submod.args, "--force");
> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
> +
> +	if (run_command(&add_submod))
> +		die(_("Failed to add submodule '%s'"), add_data->sm_path);
> +
> +	config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path);
> +	config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo);
> +	if (add_data->branch)
> +		config_submodule_in_gitmodules(add_data->sm_name,
> +					       "branch", add_data->branch);
> +
> +	add_gitmodules.git_cmd = 1;
> +	strvec_pushl(&add_gitmodules.args,
> +		     "add", "--force", "--", ".gitmodules", NULL);
> +
> +	if (run_command(&add_gitmodules))
> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);

Looks good at a glance.

> +	/*
> +	 * NEEDSWORK: In a multi-working-tree world this needs to be
> +	 * set in the per-worktree config.
> +	 */

So should we have a failing test for that scenario, or...? (Update: but
read ahead...)

> +static int add_config(int argc, const char **argv, const char *prefix)
> +{
> +	int force = 0;
> +	struct add_data add_data = ADD_DATA_INIT;
> +
> +	struct option options[] = {
> +		OPT_STRING('b', "branch", &add_data.branch,
> +			   N_("branch"),
> +			   N_("branch of repository to store in "
> +			      "the submodule configuration")),
> +		OPT_STRING(0, "url", &add_data.repo,
> +			   N_("string"),
> +			   N_("url to clone submodule from")),
> +		OPT_STRING(0, "resolved-url", &add_data.realrepo,
> +			   N_("string"),
> +			   N_("url to clone the submodule from, after it has "
> +			      "been dereferenced relative to parent's url, "
> +			      "in the case where <url> is a relative url")),
> +		OPT_STRING(0, "path", &add_data.sm_path,
> +			   N_("path"),
> +			   N_("where the new submodule will be cloned to")),
> +		OPT_STRING(0, "name", &add_data.sm_name,
> +			   N_("string"),
> +			   N_("name of the new submodule")),
> +		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
> +			   PARSE_OPT_NOCOMPLETE),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] = {
> +		N_("git submodule--helper add-config "
> +		   "[--force|-f] [--branch|-b <branch>] "
> +		   "--url <url> --resolved-url <resolved-url> "
> +		   "--path <path> --name <name>"),
> +		NULL
> +	};

I'd say consider adding this as a "static" earlier in the file, but it's
an established pattern in this file, so let's keep it.

> +	argc = parse_options(argc, argv, prefix, options, usage, 0);

It's fine to omit it for a helper, but we're being non-pedantic about
checking mandatory options here. Would do it in a "real" built-in, but
for internal use it's fine.

> +	if (argc != 0)

Style: if (!argc)

> +		usage_with_options(usage, options);
> +
> +	add_data.force = !!force;
> +	configure_added_submodule(&add_data);
> +
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2949,6 +3073,7 @@ static struct cmd_struct commands[] = {
>  	{"name", module_name, 0},
>  	{"clone", module_clone, 0},
>  	{"add-clone", add_clone, 0},
> +	{"add-config", add_config, 0},
>  	{"update-module-mode", module_update_module_mode, 0},
>  	{"update-clone", update_clone, 0},
>  	{"ensure-core-worktree", ensure_core_worktree, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 053daf3724..f713cb113c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -242,33 +242,7 @@ cmd_add()
>  	fi
>  
>  	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
> -	git config submodule."$sm_name".url "$realrepo"
> -
> -	git add --no-warn-embedded-repo $force "$sm_path" ||
> -	die "fatal: $(eval_gettext "Failed to add submodule '\$sm_path'")"
> -
> -	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
> -	git submodule--helper config submodule."$sm_name".url "$repo" &&
> -	if test -n "$branch"
> -	then
> -		git submodule--helper config submodule."$sm_name".branch "$branch"
> -	fi &&
> -	git add --force .gitmodules ||
> -	die "fatal: $(eval_gettext "Failed to register submodule '\$sm_path'")"
> -
> -	# NEEDSWORK: In a multi-working-tree world, this needs to be
> -	# set in the per-worktree config.

Ah, this is the NEEDSWORK comment, just copied to the C code...

> -	if git config --get submodule.active >/dev/null
> -	then
> -		# If the submodule being adding isn't already covered by the
> -		# current configured pathspec, set the submodule's active flag
> -		if ! git submodule--helper is-active "$sm_path"
> -		then
> -			git config submodule."$sm_name".active "true"
> -		fi
> -	else
> -		git config submodule."$sm_name".active "true"
> -	fi
> +	git submodule--helper add-config ${force:+--force} ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name "$sm_name"
>  }
>  

Very nice to have this simplified.

Would be good to split this very long line across multiple lines
though...
