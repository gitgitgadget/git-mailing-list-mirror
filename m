Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92087C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 03:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiGNDgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiGNDgU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 23:36:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA607113
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 20:36:17 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p21-20020aa78615000000b00528d84505b5so527779pfn.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 20:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Y4a3ZFGVrE5cmONlEpjrwxmBJUiN/cwIrwnzlsxmDhg=;
        b=N4/LLipL37GFvtyavqstpZOX3jjJn/QIX9CtUX3dwL5xPMmiQZRXeVtwbuwwXthbqt
         G/FcqeLy+10L+Mt0hMLfSNJlCvvdkC9W3x7bO938uDDg9P0WRmK065YL2J9MZ89Q1Nb1
         F1O6gIaOjLITASwK7GQ9kJovha7uDsagSpuI2q69QZ04IYi0bNY54zA4VGgXCse+bqr5
         n3VnwlNHiXf4Mxdem+kFzFcTGmHFdsOzqYOgcNet8h6WTyXvsZZyk32Ysfi5vjQHLQGg
         Z+EtYNyDqw7nAqlAOeh3e7uBDePLQYu6CZw2OL2W8UtfHzBCSfVKfSE2HZrvh524K/iH
         b4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Y4a3ZFGVrE5cmONlEpjrwxmBJUiN/cwIrwnzlsxmDhg=;
        b=xDtq3m/dDccVUT6rIHaZ5jq9hPGVKWTiff3ZnwpWc0Ze+dLAOsDrTIKy4jH8h8sv2A
         uavys7fN53x44fYUCn37ZTUntuH6iOw15erYRD77HL7pm0Q3uN/Mm0syH2v1XZCRe3e5
         Ou2nkuV3A9LUWmdkj5X3tCBI1omgXqVB080vuLaqI7QqyhvclJtfKg12C+FK3WWaucM2
         JKiQ3B1GgZ7jedrD5gX7VMvxNZZE3wwYbNUfQI/LxC8LIlFts3X9BAsVY2dc1FxGMnx8
         jjFCVqbsS0DxNxUkhi4vo0kNSM0k3nrC5a524FZApKEd4dOu2oNFNOa0wING9P3qns3z
         coCw==
X-Gm-Message-State: AJIora/9KvAwzQbme47E1lw7CwyzCH50r/Qn46jVH++aOwGEe6x7IHLC
        ynLB29DzhaTUT2EjfcSNPnLh3ouAUbSFQg==
X-Google-Smtp-Source: AGRyM1tFeDiYsDhzIaGLjQNz1DaIJ/dBlP72oeNZUVNt+Y4ZjnR8iNng9u81Xzpau23HChOyhFfdgStHotEfgg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f608:b0:168:e92b:47e8 with SMTP
 id n8-20020a170902f60800b00168e92b47e8mr6396180plg.115.1657769777457; Wed, 13
 Jul 2022 20:36:17 -0700 (PDT)
Date:   Wed, 13 Jul 2022 20:36:10 -0700
In-Reply-To: <patch-05.11-76eab92c8b6-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6l5yk05psl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-05.11-76eab92c8b6-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 05/11] submodule--helper: free() leaking
 {run,capture}_command() argument
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Free the "dir" member of "struct child_process" that various functions
> in submodule-helper.c allocate allocates with xstrdup().
>
> Since the "dir" argument is "const char *" let's keep a
> "char *to_free" variable around for this rather than casting when we
> call free().
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 41 +++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a8e439e59b8..2099c5774b2 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2198,27 +2198,36 @@ static int is_tip_reachable(const char *path, str=
uct object_id *oid)
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	struct strbuf rev =3D STRBUF_INIT;
>  	char *hex =3D oid_to_hex(oid);
> +	char *to_free;
> +	int ret;
> =20
>  	cp.git_cmd =3D 1;
> -	cp.dir =3D xstrdup(path);
> +	cp.dir =3D to_free =3D xstrdup(path);
>  	cp.no_stderr =3D 1;
>  	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NU=
LL);
> =20
>  	prepare_submodule_repo_env(&cp.env);
> =20
> -	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
> -		return 0;
> +	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len) {
> +		ret =3D 0;
> +		goto cleanup;
> +	}
> =20
> -	return 1;
> +	ret =3D 1;
> +cleanup:
> +	free(to_free);
> +	return ret;
>  }
> =20
>  static int fetch_in_submodule(const char *module_path, int depth, int qu=
iet, struct object_id *oid)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	char *to_free;
> +	int ret;
> =20
>  	prepare_submodule_repo_env(&cp.env);
>  	cp.git_cmd =3D 1;
> -	cp.dir =3D xstrdup(module_path);
> +	cp.dir =3D to_free =3D xstrdup(module_path);
> =20
>  	strvec_push(&cp.args, "fetch");
>  	if (quiet)
> @@ -2232,7 +2241,9 @@ static int fetch_in_submodule(const char *module_pa=
th, int depth, int quiet, str
>  		free(remote);
>  	}
> =20
> -	return run_command(&cp);
> +	ret =3D run_command(&cp);
> +	free(to_free);
> +	return ret;
>  }
> =20
>  static int run_update_command(struct update_data *ud, int subforce)
> @@ -2240,6 +2251,8 @@ static int run_update_command(struct update_data *u=
d, int subforce)
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	char *oid =3D oid_to_hex(&ud->oid);
>  	int must_die_on_failure =3D 0;
> +	char *to_free;
> +	int ret;
> =20
>  	switch (ud->update_strategy.type) {
>  	case SM_UPDATE_CHECKOUT:
> @@ -2273,7 +2286,7 @@ static int run_update_command(struct update_data *u=
d, int subforce)
>  	}
>  	strvec_push(&cp.args, oid);
> =20
> -	cp.dir =3D xstrdup(ud->sm_path);
> +	cp.dir =3D to_free =3D xstrdup(ud->sm_path);
>  	prepare_submodule_repo_env(&cp.env);
>  	if (run_command(&cp)) {
>  		switch (ud->update_strategy.type) {
> @@ -2301,11 +2314,14 @@ static int run_update_command(struct update_data =
*ud, int subforce)
>  			exit(128);
> =20
>  		/* the command failed, but update must continue */
> -		return 1;
> +		ret =3D 1;
> +		goto cleanup;
>  	}
> =20
> -	if (ud->quiet)
> -		return 0;
> +	if (ud->quiet) {
> +		ret =3D 0;
> +		goto cleanup;
> +	}
> =20
>  	switch (ud->update_strategy.type) {
>  	case SM_UPDATE_CHECKOUT:
> @@ -2329,7 +2345,10 @@ static int run_update_command(struct update_data *=
ud, int subforce)
>  		    submodule_strategy_to_string(&ud->update_strategy));
>  	}
> =20
> -	return 0;
> +	ret =3D 0;
> +cleanup:
> +	free(to_free);
> +	return ret;
>  }
> =20
>  static int run_update_procedure(struct update_data *ud)

I assume I'm missing something, but couldn't we achieve the same result
by just removing the xstrdup() calls? i.e. we only leak .dir (which we
don't clear because it's const), so couldn't we just assign to it
without xstrdup() and not have to worry about free()-ing it?

I didn't see a correctness reason for us to xstrdup(), and indeed, t7406
passes with the change I just described (which I believe covers all of
the sites here). In fact, we already have one site that does exactly
this in the recursive part of update_submodule():

	if (update_data->recursive) {
		struct child_process cp =3D CHILD_PROCESS_INIT;
		struct update_data next =3D *update_data;
		int res;

		next.prefix =3D NULL;
		oidcpy(&next.oid, null_oid());
		oidcpy(&next.suboid, null_oid());

		cp.dir =3D update_data->sm_path;

Tangentially related question (primarily for my own learning): in all of
these hunks, the string being xstrdup()-ed is update_data.sm_path, which
is only ever set in update_submodules():

		update_data->sm_path =3D ucd.sub->path;

where ucd.sub->path is a "const char *". So we never have to worry about
free()-ing update_data.sm_path, right? (Your patch doesn't attempt to
free() it, which sounds correct.)
