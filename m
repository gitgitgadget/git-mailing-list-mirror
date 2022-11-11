Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B142EC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 13:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiKKNwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 08:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiKKNwt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 08:52:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E360EAE
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 05:52:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t25so12679691ejb.8
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nHGu5mFmExcyMRiXDcmi3sF6Kcmdl09d3C34GmNfJHw=;
        b=Wr8pX/lM/qDgooAsrNRNGE/tqnilNGIF1AOiuPMH5kKDvLPgszF7sAw89FuIzVWCks
         GcfWg8ZXAlMKUQ9JTTrM4ozzwtzIp7MrBzDrFVtpVYqB6h4X1aS7XDsi3zBZtE/CKyNY
         NZPbMb+xM4hpHJuGP0Mmb6xdNVgV42UPAB0/FKxLifJoOeyRngGJHBAs819Tynrxr9Rj
         eyVcB1IpwnB+5nCyTT8578oovNmzWZWZeYt/ZsC632jXKIIlDhXxwjkbE/bc126YQEdx
         /Lt+Dm8QPLauzySIpaZtS1T1v+GkrLF3kTvhjZ1PihzS/sf8E9pvgyt5NEpg/mrFTG0D
         Hy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHGu5mFmExcyMRiXDcmi3sF6Kcmdl09d3C34GmNfJHw=;
        b=z1KYzBcNxQQ1+y8jX5ATwlw7VHLhu2MU+XnP2/3JEEuuOXAb0iEOsgjq7kIjjXq1x2
         lLXVyXbszUIvXh2j7u6DfXA1vffHyfSo860vSZVImz9oRxQnuskK6lRgO1qPlRl/Y4u/
         iJvYT/ImbfkZHoFP6YbPHT5/r/Z9frDImE13U/IqiMLeSaXgvX5EChdW7sLasqmjYmFK
         zRlwmIAa6t1aV+u4zEzVOjasOdfwcopR/S4035D1HztsjsAFylzXYY2tw4gzsU8oSRvB
         xWoaDiKoO+25W1ra0PwTQvnbcNtZEL/bIGAZ21vhlnvLnh/UsK9vibmkKWY0YCMo+9Lv
         obZQ==
X-Gm-Message-State: ANoB5pnYr4SroWd2pGYtFgPaVSS9yBHNURQcsSKug/sh0qs8JYHV9S21
        8eBul42rn1Tavqunq3KrEDA=
X-Google-Smtp-Source: AA0mqf7s5eFROb+xB9hxyFJ3EHU7NpytYe2VeyL4rQHXcXUKqWdTsBtdEX80j6bTigB9ii8HUyzajQ==
X-Received: by 2002:a17:906:2315:b0:7ae:4a7f:3281 with SMTP id l21-20020a170906231500b007ae4a7f3281mr1864802eja.50.1668174763569;
        Fri, 11 Nov 2022 05:52:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b007adf2e4c6f7sm880313ejc.195.2022.11.11.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 05:52:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otUSY-001uYT-1V;
        Fri, 11 Nov 2022 14:52:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/3] bisect--helper: move all subcommands into their
 own functions
Date:   Fri, 11 Nov 2022 14:51:44 +0100
References: <cover.1667561761.git.congdanhqx@gmail.com>
 <cover.1668097286.git.congdanhqx@gmail.com>
 <248ed392ea8bc7c812156276bd120bc9d5b8ba6e.1668097286.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <248ed392ea8bc7c812156276bd120bc9d5b8ba6e.1668097286.git.congdanhqx@gmail.com>
Message-ID: <221111.86mt8xoaxh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In a later change, we will use OPT_SUBCOMMAND to parse sub-commands to
> avoid consuming non-option opts.
>
> Since OPT_SUBCOMMAND needs a function pointer to operate,
> let's move it now.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  builtin/bisect--helper.c | 155 ++++++++++++++++++++++++++++++---------
>  1 file changed, 121 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 5ec2e67f59..d425555d1f 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1279,6 +1279,117 @@ static int bisect_run(struct bisect_terms *terms,=
 const char **argv, int argc)
>  	return res;
>  }
>=20=20
> +static int cmd_bisect__reset(int argc, const char **argv, const char *pr=
efix UNUSED)
> +{
> +	if (argc > 1)
> +		return error(_("--bisect-reset requires either no argument or a commit=
"));
> +	return bisect_reset(argc ? argv[0] : NULL);
> +}
> +
> +static int cmd_bisect__terms(int argc, const char **argv, const char *pr=
efix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	if (argc > 1)
> +		return error(_("--bisect-terms requires 0 or 1 argument"));
> +	res =3D bisect_terms(&terms, argc =3D=3D 1 ? argv[0] : NULL);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__start(int argc, const char **argv, const char *pr=
efix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	set_terms(&terms, "bad", "good");
> +	res =3D bisect_start(&terms, argv, argc);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__next(int argc, const char **argv UNUSED, const ch=
ar *prefix)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	if (argc)
> +		return error(_("--bisect-next requires 0 arguments"));
> +	get_terms(&terms);
> +	res =3D bisect_next(&terms, prefix);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__state(int argc, const char **argv, const char *pr=
efix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	set_terms(&terms, "bad", "good");
> +	get_terms(&terms);
> +	res =3D bisect_state(&terms, argv, argc);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__log(int argc, const char **argv UNUSED, const cha=
r *prefix UNUSED)
> +{
> +	if (argc)
> +		return error(_("--bisect-log requires 0 arguments"));
> +	return bisect_log();
> +}
> +
> +static int cmd_bisect__replay(int argc, const char **argv, const char *p=
refix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	if (argc !=3D 1)
> +		return error(_("no logfile given"));
> +	set_terms(&terms, "bad", "good");
> +	res =3D bisect_replay(&terms, argv[0]);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__skip(int argc, const char **argv, const char *pre=
fix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	set_terms(&terms, "bad", "good");
> +	get_terms(&terms);
> +	res =3D bisect_skip(&terms, argv, argc);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__visualize(int argc, const char **argv, const char=
 *prefix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	get_terms(&terms);
> +	res =3D bisect_visualize(&terms, argv, argc);
> +	free_terms(&terms);
> +	return res;
> +}
> +
> +static int cmd_bisect__run(int argc, const char **argv, const char *pref=
ix UNUSED)
> +{
> +	int res;
> +	struct bisect_terms terms =3D { 0 };
> +
> +	if (!argc)
> +		return error(_("bisect run failed: no command provided."));
> +	get_terms(&terms);
> +	res =3D bisect_run(&terms, argv, argc);
> +	free_terms(&terms);
> +	return res;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1318,8 +1429,6 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
>  		OPT_END()
>  	};
> -	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL=
 };
> -
>  	argc =3D parse_options(argc, argv, prefix, options,
>  			     git_bisect_helper_usage,
>  			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
> @@ -1329,60 +1438,38 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>=20=20
>  	switch (cmdmode) {
>  	case BISECT_RESET:
> -		if (argc > 1)
> -			return error(_("--bisect-reset requires either no argument or a commi=
t"));
> -		res =3D bisect_reset(argc ? argv[0] : NULL);
> +		res =3D cmd_bisect__reset(argc, argv, prefix);
>  		break;
>  	case BISECT_TERMS:
> -		if (argc > 1)
> -			return error(_("--bisect-terms requires 0 or 1 argument"));
> -		res =3D bisect_terms(&terms, argc =3D=3D 1 ? argv[0] : NULL);
> +		res =3D cmd_bisect__terms(argc, argv, prefix);
>  		break;
>  	case BISECT_START:
> -		set_terms(&terms, "bad", "good");
> -		res =3D bisect_start(&terms, argv, argc);
> +		res =3D cmd_bisect__start(argc, argv, prefix);
>  		break;
>  	case BISECT_NEXT:
> -		if (argc)
> -			return error(_("--bisect-next requires 0 arguments"));
> -		get_terms(&terms);
> -		res =3D bisect_next(&terms, prefix);
> +		res =3D cmd_bisect__next(argc, argv, prefix);
>  		break;
>  	case BISECT_STATE:
> -		set_terms(&terms, "bad", "good");
> -		get_terms(&terms);
> -		res =3D bisect_state(&terms, argv, argc);
> +		res =3D cmd_bisect__state(argc, argv, prefix);
>  		break;
>  	case BISECT_LOG:
> -		if (argc)
> -			return error(_("--bisect-log requires 0 arguments"));
> -		res =3D bisect_log();
> +		res =3D cmd_bisect__log(argc, argv, prefix);
>  		break;
>  	case BISECT_REPLAY:
> -		if (argc !=3D 1)
> -			return error(_("no logfile given"));
> -		set_terms(&terms, "bad", "good");
> -		res =3D bisect_replay(&terms, argv[0]);
> +		res =3D cmd_bisect__replay(argc, argv, prefix);
>  		break;
>  	case BISECT_SKIP:
> -		set_terms(&terms, "bad", "good");
> -		get_terms(&terms);
> -		res =3D bisect_skip(&terms, argv, argc);
> +		res =3D cmd_bisect__skip(argc, argv, prefix);
>  		break;
>  	case BISECT_VISUALIZE:
> -		get_terms(&terms);
> -		res =3D bisect_visualize(&terms, argv, argc);
> +		res =3D cmd_bisect__visualize(argc, argv, prefix);
>  		break;
>  	case BISECT_RUN:
> -		if (!argc)
> -			return error(_("bisect run failed: no command provided."));
> -		get_terms(&terms);
> -		res =3D bisect_run(&terms, argv, argc);
> +		res =3D cmd_bisect__run(argc, argv, prefix);
>  		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> -	free_terms(&terms);
>=20=20
>  	/*
>  	 * Handle early success

FWIW I tried my suggestion in an earlier review of factoring this into a
function, I don't know if it's worth it, but it is a net reduction in
lines. Some of the error messages are changed as a result.

If you think the end result looks better, feel free to pick it up /
adapt it etc with my Signed-off-by.

 builtin/bisect--helper.c | 109 +++++++++++++++++++------------------------=
----
 1 file changed, 43 insertions(+), 66 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d4d813ebfce..e5a5261f9f2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -469,8 +469,11 @@ static int get_terms(struct bisect_terms *terms)
 	return res;
 }
=20
-static int bisect_terms(struct bisect_terms *terms, const char *option)
+static int bisect_terms(struct bisect_terms *terms, const char **argv,
+			int argc)
 {
+	const char *option =3D argc =3D=3D 1 ? argv[0] : NULL;
+
 	if (get_terms(terms))
 		return error(_("no terms defined"));
=20
@@ -1024,7 +1027,7 @@ static int process_replay_line(struct bisect_terms *t=
erms, struct strbuf *line)
 		struct strvec argv =3D STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res =3D bisect_terms(terms, argv.nr =3D=3D 1 ? argv.v[0] : NULL);
+		res =3D bisect_terms(terms, argv.v, argv.nr);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1033,8 +1036,10 @@ static int process_replay_line(struct bisect_terms *=
terms, struct strbuf *line)
 	return -1;
 }
=20
-static enum bisect_error bisect_replay(struct bisect_terms *terms, const c=
har *filename)
+static int bisect_replay(struct bisect_terms *terms, const char **argv,
+			int argc)
 {
+	const char *filename =3D argv[0];
 	FILE *fp =3D NULL;
 	enum bisect_error res =3D BISECT_OK;
 	struct strbuf line =3D STRBUF_INIT;
@@ -1279,6 +1284,24 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 	return res;
 }
=20
+typedef int (*cmd_bisect_fn_t)(struct bisect_terms *terms, const char **ar=
gv, int argc);
+static int terms_cmd(int argc, const char **argv, const char *prefix UNUSE=
D,
+		     cmd_bisect_fn_t fn, int set, int errcond,
+		     const char *errmsg, const char *errcmd)
+{
+	int res;
+	struct bisect_terms terms =3D { 0 };
+
+	if (errcond)
+		return error(_(errmsg), errcmd);
+	if (set)
+		set_terms(&terms, "bad", "good");
+	get_terms(&terms);
+	res =3D fn(&terms, argv, argc);
+	free_terms(&terms);
+	return res;
+}
+
 static int cmd_bisect__reset(int argc, const char **argv, const char *pref=
ix UNUSED)
 {
 	if (argc > 1)
@@ -1286,27 +1309,15 @@ static int cmd_bisect__reset(int argc, const char *=
*argv, const char *prefix UNU
 	return bisect_reset(argc ? argv[0] : NULL);
 }
=20
-static int cmd_bisect__terms(int argc, const char **argv, const char *pref=
ix UNUSED)
+static int cmd_bisect__terms(int argc, const char **argv, const char *pref=
ix)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	if (argc > 1)
-		return error(_("--bisect-terms requires 0 or 1 argument"));
-	res =3D bisect_terms(&terms, argc =3D=3D 1 ? argv[0] : NULL);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_terms, 0, argc > 1,
+			 N_("'bisect %s' requires 0 or 1 argument"), "terms");
 }
=20
-static int cmd_bisect__start(int argc, const char **argv, const char *pref=
ix UNUSED)
+static int cmd_bisect__start(int argc, const char **argv, const char *pref=
ix)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	set_terms(&terms, "bad", "good");
-	res =3D bisect_start(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_start, 1, 0, NULL, NULL);
 }
=20
 static int cmd_bisect__next(int argc, const char **argv UNUSED, const char=
 *prefix)
@@ -1322,16 +1333,9 @@ static int cmd_bisect__next(int argc, const char **a=
rgv UNUSED, const char *pref
 	return res;
 }
=20
-static int cmd_bisect__state(int argc, const char **argv, const char *pref=
ix UNUSED)
+static int cmd_bisect__state(int argc, const char **argv, const char *pref=
ix)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	set_terms(&terms, "bad", "good");
-	get_terms(&terms);
-	res =3D bisect_state(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_state, 1, 0, NULL, NULL);
 }
=20
 static int cmd_bisect__log(int argc, const char **argv UNUSED, const char =
*prefix UNUSED)
@@ -1341,53 +1345,26 @@ static int cmd_bisect__log(int argc, const char **a=
rgv UNUSED, const char *prefi
 	return bisect_log();
 }
=20
-static int cmd_bisect__replay(int argc, const char **argv, const char *pre=
fix UNUSED)
+static int cmd_bisect__replay(int argc, const char **argv, const char *pre=
fix)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	if (argc !=3D 1)
-		return error(_("no logfile given"));
-	set_terms(&terms, "bad", "good");
-	res =3D bisect_replay(&terms, argv[0]);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_replay, 1, argc !=3D 1,
+			 N_("'bisect %s': no logfile given"), "replay");
 }
=20
-static int cmd_bisect__skip(int argc, const char **argv, const char *prefi=
x UNUSED)
+static int cmd_bisect__skip(int argc, const char **argv, const char *prefi=
x)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	set_terms(&terms, "bad", "good");
-	get_terms(&terms);
-	res =3D bisect_skip(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_skip, 1, 0, NULL, NULL);
 }
=20
-static int cmd_bisect__visualize(int argc, const char **argv, const char *=
prefix UNUSED)
+static int cmd_bisect__visualize(int argc, const char **argv, const char *=
prefix)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	get_terms(&terms);
-	res =3D bisect_visualize(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_visualize, 0, 0, NULL, NULL);
 }
=20
-static int cmd_bisect__run(int argc, const char **argv, const char *prefix=
 UNUSED)
+static int cmd_bisect__run(int argc, const char **argv, const char *prefix)
 {
-	int res;
-	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL };
-
-	if (!argc)
-		return error(_("bisect run failed: no command provided."));
-	get_terms(&terms);
-	res =3D bisect_run(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
+	return terms_cmd(argc, argv, prefix, bisect_run, 0, !argc,
+			 N_("bisect %s failed: no command provided."), "run");
 }
=20
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
