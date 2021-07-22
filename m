Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C021C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637BD61287
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhGVMsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhGVMsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:48:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EABC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:28:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso4317846pjb.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uJNo49L1mjyhTEBFbjZEs69YLFW/XfQlppHXKDwcJLk=;
        b=sTwZNuj6pXSbreaNQ0TBTDOZPIda/9jnARzc2XEjmQfEFv1wg5fS603dGCrCXKyR6j
         8cdMGQqxRYApqeDd2glazC2Gsg1Ccuetc2fmJtIGyS7LKJ96Bk3WQ+jhmGfP8MND5mBp
         AfDOJa7nvKRnBPt4cNOAslW0F5JTjgz1p+jYi+MvomD9pcomyldG7O81o1HRGdku0RdC
         rJo4mWApQqGZ23koFkT/ApXXBFx7Jb2mzIXcza/E82vej0wdEIsDv39OrPJ+U16ciUFr
         sqxJp6pIUvPi+YH0y7yzix3CDNQ69NFhfBkJIfJUvyC/bTeEj39xgxzgyX/jMFaGb8zg
         Qh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uJNo49L1mjyhTEBFbjZEs69YLFW/XfQlppHXKDwcJLk=;
        b=QmhAqHS3UIgTpddV8I5P1Oe11R7oqEiv7retmZko6/xqWqGUpcNngJnEXtVjZU9bJY
         nSvCA4b5Vetv1wbxMa9ShPW7cNxhtfII9hLY7N0Icwny3aCEaAKO2YkcczVq1eJbLfKX
         yTEPsAclVdtGKoqRSspSjktHAeW/90LJhMoZ937jvqyqrbEvLfjoYr/HVhu3yioA0H9L
         X21Mj7dkDELSa0UtcxxTUvjacca5+Z8u/2NijByTi1b1cFvxtw8aljykJykzqGFvcHSi
         ZSIePuBlcwjZt+PJPN89N43KXNAGQtYHymRlpoehb9C07g5boAlMBAUklp8gEt+zXNrg
         ks8g==
X-Gm-Message-State: AOAM5338bLj5/riiHQ1QcVxSl6Lxgyxmrkj2A3hAHHQePxaJQpe0Mt40
        BxuVSvc7tCNkTQHO4YDywkg=
X-Google-Smtp-Source: ABdhPJxA9rUUy+YSLEeD99/Ke6XOudpMchsAswLhtvEsq6xn7mNdkUoY03oeWLIHND27ZIDarbnDPg==
X-Received: by 2002:a17:90b:a0d:: with SMTP id gg13mr24017280pjb.199.1626960526067;
        Thu, 22 Jul 2021 06:28:46 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id c24sm30472698pfn.86.2021.07.22.06.28.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:28:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <87sg06tvab.fsf@evledraar.gmail.com>
Date:   Thu, 22 Jul 2021 18:58:38 +0530
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DEF3E9A-C6FA-4402-8182-D4E618CF2CCC@gmail.com>
References: <20210722112143.97944-1-raykar.ath@gmail.com>
 <87sg06tvab.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-Jul-2021, at 17:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Thu, Jul 22 2021, Atharva Raykar wrote:
>=20
>> +static void config_submodule_in_gitmodules(const char *name, const =
char *var, const char *value)
>> +{
>> +	char *key;
>> +
>> +	if (!is_writing_gitmodules_ok())
>> +		die(_("please make sure that the .gitmodules file is in =
the working tree"));
>> +
>> +	key =3D xstrfmt("submodule.%s.%s", name, var);
>> +	config_set_in_gitmodules_file_gently(key, value);
>> +	free(key);
>> +}
>=20
> Just a small point not per-se to do with this patch, but aren't all
> callers of config_set_in_gitmodules_file_gently() wanting to prefix
> thigs with "submodule."? Looks like its API could be simplified a bit
> with that xstrfmt() and free() inside that function.

Yes, you are right, all the callers prefix with "submodule.". Changing
the API to what you suggested, would require some special handling in
'submodule--helper:module_config()', which will be dead code after the
whole series is done, so probably a better time to change it would be
during the cleanup after the conversion.

>> +static void configure_added_submodule(struct add_data *add_data)
>> +{
>> +	char *key, *submod_pathspec =3D NULL;
>> +	struct child_process add_submod =3D CHILD_PROCESS_INIT;
>> +	struct child_process add_gitmodules =3D CHILD_PROCESS_INIT;
>> +	int pathspec_key_exists, activate =3D 0;
>=20
> Usual style is to have different variables on different lines, unless
> they're closely related (like "int i, j"), so "char *key;\n char
> *submod[...]" in this case.

Okay.

>> +
>> +	key =3D xstrfmt("submodule.%s.url", add_data->sm_name);
>> +	git_config_set_gently(key, add_data->realrepo);
>> +	free(key);
>> +
>> +	add_submod.git_cmd =3D 1;
>> +	strvec_pushl(&add_submod.args, "add",
>> +		     "--no-warn-embedded-repo", NULL);
>> +	if (add_data->force)
>> +		strvec_push(&add_submod.args, "--force");
>> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
>> +
>> +	if (run_command(&add_submod))
>> +		die(_("Failed to add submodule '%s'"), =
add_data->sm_path);
>> +
>> +	config_submodule_in_gitmodules(add_data->sm_name, "path", =
add_data->sm_path);
>> +	config_submodule_in_gitmodules(add_data->sm_name, "url", =
add_data->repo);
>> +	if (add_data->branch)
>> +		config_submodule_in_gitmodules(add_data->sm_name,
>> +					       "branch", =
add_data->branch);
>> +
>> +	add_gitmodules.git_cmd =3D 1;
>> +	strvec_pushl(&add_gitmodules.args,
>> +		     "add", "--force", "--", ".gitmodules", NULL);
>> +
>> +	if (run_command(&add_gitmodules))
>> +		die(_("Failed to register submodule '%s'"), =
add_data->sm_path);
>=20
> Looks good at a glance.
>=20
>> +	/*
>> +	 * NEEDSWORK: In a multi-working-tree world this needs to be
>> +	 * set in the per-worktree config.
>> +	 */
>=20
> So should we have a failing test for that scenario, or...? (Update: =
but
> read ahead...)
>=20
>> +static int add_config(int argc, const char **argv, const char =
*prefix)
>> +{
>> +	int force =3D 0;
>> +	struct add_data add_data =3D ADD_DATA_INIT;
>> +
>> +	struct option options[] =3D {
>> +		OPT_STRING('b', "branch", &add_data.branch,
>> +			   N_("branch"),
>> +			   N_("branch of repository to store in "
>> +			      "the submodule configuration")),
>> +		OPT_STRING(0, "url", &add_data.repo,
>> +			   N_("string"),
>> +			   N_("url to clone submodule from")),
>> +		OPT_STRING(0, "resolved-url", &add_data.realrepo,
>> +			   N_("string"),
>> +			   N_("url to clone the submodule from, after it =
has "
>> +			      "been dereferenced relative to parent's =
url, "
>> +			      "in the case where <url> is a relative =
url")),
>> +		OPT_STRING(0, "path", &add_data.sm_path,
>> +			   N_("path"),
>> +			   N_("where the new submodule will be cloned =
to")),
>> +		OPT_STRING(0, "name", &add_data.sm_name,
>> +			   N_("string"),
>> +			   N_("name of the new submodule")),
>> +		OPT__FORCE(&force, N_("allow adding an otherwise ignored =
submodule path"),
>> +			   PARSE_OPT_NOCOMPLETE),
>> +		OPT_END()
>> +	};
>> +
>> +	const char *const usage[] =3D {
>> +		N_("git submodule--helper add-config "
>> +		   "[--force|-f] [--branch|-b <branch>] "
>> +		   "--url <url> --resolved-url <resolved-url> "
>> +		   "--path <path> --name <name>"),
>> +		NULL
>> +	};
>=20
> I'd say consider adding this as a "static" earlier in the file, but =
it's
> an established pattern in this file, so let's keep it.
>=20
>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>=20
> It's fine to omit it for a helper, but we're being non-pedantic about
> checking mandatory options here. Would do it in a "real" built-in, but
> for internal use it's fine.
>=20
>> +	if (argc !=3D 0)
>=20
> Style: if (!argc)

Will fix.

>> +		usage_with_options(usage, options);
>> +
>> +	add_data.force =3D !!force;
>> +	configure_added_submodule(&add_data);
>> +
>> +	return 0;
>> +}
>> +
>> #define SUPPORT_SUPER_PREFIX (1<<0)
>>=20
>> struct cmd_struct {
>> @@ -2949,6 +3073,7 @@ static struct cmd_struct commands[] =3D {
>> 	{"name", module_name, 0},
>> 	{"clone", module_clone, 0},
>> 	{"add-clone", add_clone, 0},
>> +	{"add-config", add_config, 0},
>> 	{"update-module-mode", module_update_module_mode, 0},
>> 	{"update-clone", update_clone, 0},
>> 	{"ensure-core-worktree", ensure_core_worktree, 0},
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 053daf3724..f713cb113c 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -242,33 +242,7 @@ cmd_add()
>> 	fi
>>=20
>> 	git submodule--helper add-clone ${GIT_QUIET:+--quiet} =
${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch =
"$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" =
--url "$realrepo" ${reference:+"$reference"} =
${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
>> -	git config submodule."$sm_name".url "$realrepo"
>> -
>> -	git add --no-warn-embedded-repo $force "$sm_path" ||
>> -	die "fatal: $(eval_gettext "Failed to add submodule =
'\$sm_path'")"
>> -
>> -	git submodule--helper config submodule."$sm_name".path =
"$sm_path" &&
>> -	git submodule--helper config submodule."$sm_name".url "$repo" &&
>> -	if test -n "$branch"
>> -	then
>> -		git submodule--helper config submodule."$sm_name".branch =
"$branch"
>> -	fi &&
>> -	git add --force .gitmodules ||
>> -	die "fatal: $(eval_gettext "Failed to register submodule =
'\$sm_path'")"
>> -
>> -	# NEEDSWORK: In a multi-working-tree world, this needs to be
>> -	# set in the per-worktree config.
>=20
> Ah, this is the NEEDSWORK comment, just copied to the C code...
>=20
>> -	if git config --get submodule.active >/dev/null
>> -	then
>> -		# If the submodule being adding isn't already covered by =
the
>> -		# current configured pathspec, set the submodule's =
active flag
>> -		if ! git submodule--helper is-active "$sm_path"
>> -		then
>> -			git config submodule."$sm_name".active "true"
>> -		fi
>> -	else
>> -		git config submodule."$sm_name".active "true"
>> -	fi
>> +	git submodule--helper add-config ${force:+--force} =
${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" =
--path "$sm_path" --name "$sm_name"
>> }
>>=20
>=20
> Very nice to have this simplified.
>=20
> Would be good to split this very long line across multiple lines
> though...

I followed the established pattern of not splitting the lines from the
previous conversions ('submodule--helper update-clone' being the
exception in that file).

In this case, I felt it should be fine because a follow-up series that
completes the full conversion will get rid of that line entirely.

