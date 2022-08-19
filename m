Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F7C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 19:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351192AbiHSTIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351128AbiHSTIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398034A818
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:08:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so553756wms.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=Xztz3L6JgeJCXy/lFwh51JlQoc1ZsKBbvA76z/zL8kE=;
        b=EJTiHVMlHrEsFY1GNyxtMkachRDSkkQg++Ttn/YOXQVB6XzZwi9Oo3o56t8MQqmwdU
         qqWO0exF6sypeSQzjSX5ANHf2cUuPcteaT+Y/MfRG73XgYnGbRY9G8U5pdIssq9HOHgy
         ENr9stjK077OyaXPdVhVt/kvcztq8iy44Kxkljh6BMto8DD5XuQfhAx9KGdMSUGLcnx8
         pSugG6iAcacpYaiLFtYQD0y8ryuNhc3Vqe8/C5SAmzBcNcAi8JAgJIKISoNe6XjsmQlo
         0VqlA3HOIWDzeLndKBCz/Hm/dW6dVaTYSiEBcNDvVEN7ZAUL6KUac7ZYmkLh6b8MIQK4
         4yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Xztz3L6JgeJCXy/lFwh51JlQoc1ZsKBbvA76z/zL8kE=;
        b=G/kLvqiS8S1tyUVK0/tJRX8IJgtWOjEgsZiByQaNpwA8ShVU9iPu52a/+Z22bb/xT7
         rxyWf4Jtmi1ci02Dshp//7CkbfxflsZFF2toM/QgGyVkYSWHGmLQSNSScS3vojYkj0zI
         mhzf30UTscfJ4qLw0rnRAVys/Tm+8EaxeVVNiJ/HKlGt9FAztcoY4hpaYzs9TVG+pay8
         7bbPpa4dHMNNjCuCmIIkimoldbhLaVA/Plbs0NS6kfCzIc0N57Nlg+kQxKvOV6Mlozj9
         v6xZfGd8PUikBVdOvcLVRn5DEqvjHPLSEYxuBYaJ0pb6cMlVY4HbgZPjSynbZQQwl9r0
         HVeQ==
X-Gm-Message-State: ACgBeo2LKOh+a3EiIX+AlHYEqtGlxsWT+E8MTAfjIKQi2YGorP9zTVMI
        265xKYiqkKr0fz3XA3aJFieas8foXo6MwQ==
X-Google-Smtp-Source: AA6agR5nS/OZArNtFq4gJVS57/7JoTRmFN7lYe//n1BpoFlEgxKVrPtIrgGJMtHffDghIbYfq82EQw==
X-Received: by 2002:a05:600c:3d0f:b0:3a5:eece:c061 with SMTP id bh15-20020a05600c3d0f00b003a5eecec061mr5592519wmb.74.1660936107681;
        Fri, 19 Aug 2022 12:08:27 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id r6-20020adfdc86000000b0021e13efa17esm4832720wrj.70.2022.08.19.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:08:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP7M1-000s8K-2o;
        Fri, 19 Aug 2022 21:08:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/20] builtin/stash.c: let parse-options parse
 subcommands
Date:   Fri, 19 Aug 2022 21:06:32 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-20-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-20-szeder.dev@gmail.com>
Message-ID: <220819.86czcw59w6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> 'git stash' parses its subcommands with a long list of if-else if
> statements.  parse-options has just learned to parse subcommands, so
> let's use that facility instead, with the benefits of shorter code,
> and listing subcommands for Bash completion.
>
> Note that the push_stash() function implementing the 'push' subcommand
> accepts an extra flag parameter to indicate whether push was assumed,
> so add a wrapper function with the standard subcommand function
> signature.
>
> Note also that this change "hides" the '-h' option in 'git stash push
> -h' from the parse_option() call in cmd_stash(), as it comes after the
> subcommand.  Consequently, from now on it will emit the usage of the
> 'push' subcommand instead of the usage of 'git stash'.  We had a
> failing test for this case, which can now be flipped to expect
> success.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/stash.c  | 53 ++++++++++++++++++++++--------------------------
>  t/t3903-stash.sh |  2 +-
>  2 files changed, 25 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index a14e832e9f..1ba24c1173 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1739,6 +1739,11 @@ static int push_stash(int argc, const char **argv,=
 const char *prefix,
>  			     include_untracked, only_staged);
>  }
>=20=20
> +static int push_stash_unassumed(int argc, const char **argv, const char =
*prefix)
> +{
> +	return push_stash(argc, argv, prefix, 0);
> +}
> +
>  static int save_stash(int argc, const char **argv, const char *prefix)
>  {
>  	int keep_index =3D -1;
> @@ -1787,15 +1792,28 @@ int cmd_stash(int argc, const char **argv, const =
char *prefix)
>  	pid_t pid =3D getpid();
>  	const char *index_file;
>  	struct strvec args =3D STRVEC_INIT;
> -
> +	parse_opt_subcommand_fn *fn =3D NULL;
>  	struct option options[] =3D {
> +		OPT_SUBCOMMAND("apply", &fn, apply_stash),
> +		OPT_SUBCOMMAND("clear", &fn, clear_stash),
> +		OPT_SUBCOMMAND("drop", &fn, drop_stash),
> +		OPT_SUBCOMMAND("pop", &fn, pop_stash),
> +		OPT_SUBCOMMAND("branch", &fn, branch_stash),
> +		OPT_SUBCOMMAND("list", &fn, list_stash),
> +		OPT_SUBCOMMAND("show", &fn, show_stash),
> +		OPT_SUBCOMMAND("store", &fn, store_stash),
> +		OPT_SUBCOMMAND("create", &fn, create_stash),
> +		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
> +		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
>  		OPT_END()
>  	};
>=20=20
>  	git_config(git_stash_config, NULL);
>=20=20
>  	argc =3D parse_options(argc, argv, prefix, options, git_stash_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_DASHDASH);
> +			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
> +			     PARSE_OPT_KEEP_DASHDASH);
>=20=20
>  	prepare_repo_settings(the_repository);
>  	the_repository->settings.command_requires_full_index =3D 0;
> @@ -1804,33 +1822,10 @@ int cmd_stash(int argc, const char **argv, const =
char *prefix)
>  	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
>  		    (uintmax_t)pid);
>=20=20
> -	if (!argc)
> -		return !!push_stash(0, NULL, prefix, 0);
> -	else if (!strcmp(argv[0], "apply"))
> -		return !!apply_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "clear"))
> -		return !!clear_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "drop"))
> -		return !!drop_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "pop"))
> -		return !!pop_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "branch"))
> -		return !!branch_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "list"))
> -		return !!list_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "show"))
> -		return !!show_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "store"))
> -		return !!store_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "create"))
> -		return !!create_stash(argc, argv, prefix);
> -	else if (!strcmp(argv[0], "push"))
> -		return !!push_stash(argc, argv, prefix, 0);
> -	else if (!strcmp(argv[0], "save"))
> -		return !!save_stash(argc, argv, prefix);
> -	else if (*argv[0] !=3D '-')
> -		usage_msg_optf(_("unknown subcommand: %s"),
> -			       git_stash_usage, options, argv[0]);
> +	if (fn)
> +		return !!fn(argc, argv, prefix);
> +	else if (!argc)
> +		return !!push_stash_unassumed(0, NULL, prefix);
>=20=20
>  	/* Assume 'stash push' */
>  	strvec_push(&args, "push");
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2a4c3fd61c..376cc8f4ab 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -25,7 +25,7 @@ test_expect_success 'usage on main command -h emits a s=
ummary of subcommands' '
>  	grep -F "or: git stash show" usage
>  '
>=20=20
> -test_expect_failure 'usage for subcommands should emit subcommand usage'=
 '
> +test_expect_success 'usage for subcommands should emit subcommand usage'=
 '
>  	test_expect_code 129 git stash push -h >usage &&
>  	grep -F "usage: git stash [push" usage
>  '

This isn't on you, but I found the control flow here really confusing. I
wonder if we could this cleanup before/squashed in. I may have missed
some cases, but it passes all tests.

I.e. the whole business of pushing this "did we assume?" around goes
away if we simply pass the command-line as-is to push_stash(), and ask
it to determine this.

diff --git a/builtin/stash.c b/builtin/stash.c
index 1ba24c11737..a588389d66b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1665,10 +1665,8 @@ static int do_push_stash(const struct pathspec *ps, =
const char *stash_msg, int q
 	return ret;
 }
=20
-static int push_stash(int argc, const char **argv, const char *prefix,
-		      int push_assumed)
+static int push_stash(int argc, const char **argv, const char *prefix)
 {
-	int force_assume =3D 0;
 	int keep_index =3D -1;
 	int only_staged =3D 0;
 	int patch_mode =3D 0;
@@ -1696,20 +1694,22 @@ static int push_stash(int argc, const char **argv, =
const char *prefix,
 		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
+	int push_assumed =3D argc =3D=3D 1 || strcmp(argv[1], "push");
=20
-	if (argc) {
-		force_assume =3D !strcmp(argv[0], "-p");
-		argc =3D parse_options(argc, argv, prefix, options,
-				     push_assumed ? git_stash_usage :
-				     git_stash_push_usage,
-				     PARSE_OPT_KEEP_DASHDASH);
+	if (!push_assumed) {
+		argc--;
+		argv++;
 	}
=20
+	argc =3D parse_options(argc, argv, prefix, options,
+			     push_assumed ? git_stash_usage :
+			     git_stash_push_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
 	if (argc) {
 		if (!strcmp(argv[0], "--")) {
 			argc--;
 			argv++;
-		} else if (push_assumed && !force_assume) {
+		} else if (push_assumed) {
 			die("subcommand wasn't specified; 'push' can't be assumed due to unexpe=
cted token '%s'",
 			    argv[0]);
 		}
@@ -1739,11 +1739,6 @@ static int push_stash(int argc, const char **argv, c=
onst char *prefix,
 			     include_untracked, only_staged);
 }
=20
-static int push_stash_unassumed(int argc, const char **argv, const char *p=
refix)
-{
-	return push_stash(argc, argv, prefix, 0);
-}
-
 static int save_stash(int argc, const char **argv, const char *prefix)
 {
 	int keep_index =3D -1;
@@ -1791,8 +1786,7 @@ int cmd_stash(int argc, const char **argv, const char=
 *prefix)
 {
 	pid_t pid =3D getpid();
 	const char *index_file;
-	struct strvec args =3D STRVEC_INIT;
-	parse_opt_subcommand_fn *fn =3D NULL;
+	parse_opt_subcommand_fn *fn =3D push_stash;
 	struct option options[] =3D {
 		OPT_SUBCOMMAND("apply", &fn, apply_stash),
 		OPT_SUBCOMMAND("clear", &fn, clear_stash),
@@ -1803,7 +1797,7 @@ int cmd_stash(int argc, const char **argv, const char=
 *prefix)
 		OPT_SUBCOMMAND("show", &fn, show_stash),
 		OPT_SUBCOMMAND("store", &fn, store_stash),
 		OPT_SUBCOMMAND("create", &fn, create_stash),
-		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
+		OPT_SUBCOMMAND("push", &fn, push_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
@@ -1811,6 +1805,7 @@ int cmd_stash(int argc, const char **argv, const char=
 *prefix)
 	git_config(git_stash_config, NULL);
=20
 	argc =3D parse_options(argc, argv, prefix, options, git_stash_usage,
+			     PARSE_OPT_KEEP_ARGV0 |
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
 			     PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_KEEP_DASHDASH);
@@ -1821,14 +1816,11 @@ int cmd_stash(int argc, const char **argv, const ch=
ar *prefix)
 	index_file =3D get_index_file();
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
+=09
+	if (fn !=3D push_stash) {
+		argc--;
+		argv++;
+	}
=20
-	if (fn)
-		return !!fn(argc, argv, prefix);
-	else if (!argc)
-		return !!push_stash_unassumed(0, NULL, prefix);
-
-	/* Assume 'stash push' */
-	strvec_push(&args, "push");
-	strvec_pushv(&args, argv);
-	return !!push_stash(args.nr, args.v, prefix, 1);
+	return !!fn(argc, argv, prefix);
 }
