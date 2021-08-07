Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F60C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6CA610FB
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhHGGNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 02:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhHGGNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 02:13:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA495C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 23:13:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a8001b029017700de3903so14201807pjn.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=6+keQlNTs0PVycQ9jRo2n+kpkAQlUHufcd9SFG+Kuh0=;
        b=O6D+Ni+ntmohrUG+yNYiJmdncaR1A/sRaX1q0eAomJOfkwA470Bv5A1VXHzILol1p4
         0R7YmeLsdvn1dzpl8WDNQIPTNECugwoNe37yXiEwh2lW88R2/7LFw2xHspRPRZ9CQdXN
         jeacrVCbHt6v7er45s8+N72XzfZW5Lz1ZZLUnwKmI/UtrEytMFguF0HdNt4XkNl3el19
         7lREV2DziaIvzuN0SNVu2MGqWQzt0xk8X5JXwLGYbWtduVWI+aefz2nHoVSmu1xCLI+Y
         soU6bilvIsoFEP/KGlGPEJXPss7oe25XhqfSqvU+OGyygP5lJlXM3He+12W2jRDYJ/bu
         y00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=6+keQlNTs0PVycQ9jRo2n+kpkAQlUHufcd9SFG+Kuh0=;
        b=CtA5TrfnLKhBnmGN60nCr7Q0VomMf/OwjTBGuj/fwItz/xu3oMDeVpfikt+VDPci7/
         e0vAIXGJotncTxKOxemquv8bKUYVbsns+34L9e0Oue+qibiNJUzA7i6G505oxWDnPuQY
         SXCkeJbxZ0zy4pqndK2/C91fBXzvp75iVb1pVkqcKpiSoXYrSIUsrvGGE63VUdm4/jMl
         U6FUeN1kuW9V3yCJ0xglOgJoBJQc5j3+kMociZDoCJsF6lrbLGdJyQwLFosARptzWSrh
         2B6WI6T+DU63KLntrxccaYF0As9h5pQqb6p+12Xji6xDXUKR5/GAdj+ZrbSBo11Emg/Q
         uZvQ==
X-Gm-Message-State: AOAM533U9y3wFyPG+tY3ks6a2fryGyrokrA7TnJqziEpR/mih/wqlICB
        QtaufaLUMh/3ZoXGv8SLMb4=
X-Google-Smtp-Source: ABdhPJy3aqTu+pg4YrKgiC1t08KTql9/hD+PlkfJpjTzLBiLDrR2zGUePkpdsmJBlaRUVEOVGUG0IQ==
X-Received: by 2002:a17:902:ce92:b029:12c:798a:6d36 with SMTP id f18-20020a170902ce92b029012c798a6d36mr124657plg.36.1628316802209;
        Fri, 06 Aug 2021 23:13:22 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id l11sm14126431pjg.22.2021.08.06.23.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 23:13:21 -0700 (PDT)
References: <20210806140431.92018-1-raykar.ath@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH v4] submodule--helper: introduce add-config
 subcommand
In-reply-to: <20210806140431.92018-1-raykar.ath@gmail.com>
Message-ID: <m2mtptu6is.fsf@gmail.com>
Date:   Sat, 07 Aug 2021 11:43:15 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


It looks like I forgot send this as a reply to my v3, so I'll link that
series here instead:

https://lore.kernel.org/git/20210801063352.50813-1-raykar.ath@gmail.com/

And to fetch these changes:
git fetch https://github.com/tfidfwastaken/git.git submodule-helper-add-con=
fig-4

Atharva Raykar <raykar.ath@gmail.com> writes:

> Add a new "add-config" subcommand to `git submodule--helper` with the
> goal of converting part of the shell code in git-submodule.sh related to
> `git submodule add` into C code. This new subcommand sets the
> configuration variables of a newly added submodule, by registering the
> url in local git config, as well as the submodule name and path in the
> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
> the submodule path has not already been covered by any pathspec
> specified in 'submodule.active'.
>
> This is meant to be a faithful conversion from shell to C, although we
> add comments to areas that could be improved in future patches, after
> the conversion has settled.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>
> Changes since v3:
> Address style nit.
>
> Range-diff against v3:
> 1:  be520ad028 ! 1:  b3df2a5e6c submodule--helper: introduce add-config s=
ubcommand
>     @@ builtin/submodule--helper.c: static int add_clone(int argc, const =
char **argv, c
>      +	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_d=
ata->repo))
>      +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
>      +
>     -+	if (add_data->branch)
>     ++	if (add_data->branch) {
>      +		if (config_submodule_in_gitmodules(add_data->sm_name,
>      +						   "branch", add_data->branch))
>      +			die(_("Failed to register submodule '%s'"), add_data->sm_path);
>     ++	}
>      +
>      +	add_gitmodules.git_cmd =3D 1;
>      +	strvec_pushl(&add_gitmodules.args,
>
>  builtin/submodule--helper.c | 129 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  28 +-------
>  submodule.c                 |   5 ++
>  3 files changed, 135 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 862053c9f2..abf1ec2000 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2936,6 +2936,134 @@ static int add_clone(int argc, const char **argv,=
 const char *prefix)
>  	return 0;
>  }
>
> +static int config_submodule_in_gitmodules(const char *name, const char *=
var, const char *value)
> +{
> +	char *key;
> +	int ret;
> +
> +	if (!is_writing_gitmodules_ok())
> +		die(_("please make sure that the .gitmodules file is in the working tr=
ee"));
> +
> +	key =3D xstrfmt("submodule.%s.%s", name, var);
> +	ret =3D config_set_in_gitmodules_file_gently(key, value);
> +	free(key);
> +
> +	return ret;
> +}
> +
> +static void configure_added_submodule(struct add_data *add_data)
> +{
> +	char *key;
> +	char *val =3D NULL;
> +	struct child_process add_submod =3D CHILD_PROCESS_INIT;
> +	struct child_process add_gitmodules =3D CHILD_PROCESS_INIT;
> +
> +	key =3D xstrfmt("submodule.%s.url", add_data->sm_name);
> +	git_config_set_gently(key, add_data->realrepo);
> +	free(key);
> +
> +	add_submod.git_cmd =3D 1;
> +	strvec_pushl(&add_submod.args, "add",
> +		     "--no-warn-embedded-repo", NULL);
> +	if (add_data->force)
> +		strvec_push(&add_submod.args, "--force");
> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
> +
> +	if (run_command(&add_submod))
> +		die(_("Failed to add submodule '%s'"), add_data->sm_path);
> +
> +	if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data-=
>sm_path) ||
> +	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->=
repo))
> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +
> +	if (add_data->branch) {
> +		if (config_submodule_in_gitmodules(add_data->sm_name,
> +						   "branch", add_data->branch))
> +			die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +	}
> +
> +	add_gitmodules.git_cmd =3D 1;
> +	strvec_pushl(&add_gitmodules.args,
> +		     "add", "--force", "--", ".gitmodules", NULL);
> +
> +	if (run_command(&add_gitmodules))
> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +
> +	/*
> +	 * NEEDSWORK: In a multi-working-tree world this needs to be
> +	 * set in the per-worktree config.
> +	 */
> +	/*
> +	 * NEEDSWORK: In the longer run, we need to get rid of this
> +	 * pattern of querying "submodule.active" before calling
> +	 * is_submodule_active(), since that function needs to find
> +	 * out the value of "submodule.active" again anyway.
> +	 */
> +	if (!git_config_get_string("submodule.active", &val) && val) {
> +		/*
> +		 * If the submodule being added isn't already covered by the
> +		 * current configured pathspec, set the submodule's active flag
> +		 */
> +		if (!is_submodule_active(the_repository, add_data->sm_path)) {
> +			key =3D xstrfmt("submodule.%s.active", add_data->sm_name);
> +			git_config_set_gently(key, "true");
> +			free(key);
> +		}
> +	} else {
> +		key =3D xstrfmt("submodule.%s.active", add_data->sm_name);
> +		git_config_set_gently(key, "true");
> +		free(key);
> +	}
> +}
> +
> +static int add_config(int argc, const char **argv, const char *prefix)
> +{
> +	int force =3D 0;
> +	struct add_data add_data =3D ADD_DATA_INIT;
> +
> +	struct option options[] =3D {
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
> +		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule pat=
h"),
> +			   PARSE_OPT_NOCOMPLETE),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] =3D {
> +		N_("git submodule--helper add-config "
> +		   "[--force|-f] [--branch|-b <branch>] "
> +		   "--url <url> --resolved-url <resolved-url> "
> +		   "--path <path> --name <name>"),
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (argc)
> +		usage_with_options(usage, options);
> +
> +	add_data.force =3D !!force;
> +	configure_added_submodule(&add_data);
> +
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>
>  struct cmd_struct {
> @@ -2949,6 +3077,7 @@ static struct cmd_struct commands[] =3D {
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
>  	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force=
"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_pr=
efix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$=
reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
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
> +	git submodule--helper add-config ${force:+--force} ${branch:+--branch "=
$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name=
 "$sm_name"
>  }
>
>  #
> diff --git a/submodule.c b/submodule.c
> index 0b1d9c1dde..8577667773 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -237,6 +237,11 @@ int option_parse_recurse_submodules_worktree_updater=
(const struct option *opt,
>  /*
>   * Determine if a submodule has been initialized at a given 'path'
>   */
> +/*
> + * NEEDSWORK: Emit a warning if submodule.active exists, but is valueles=
s,
> + * ie, the config looks like: "[submodule] active\n".
> + * Since that is an invalid pathspec, we should inform the user.
> + */
>  int is_submodule_active(struct repository *repo, const char *path)
>  {
>  	int ret =3D 0;


--
---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
