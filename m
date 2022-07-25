Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiGYX5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiGYX5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:57:31 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D02825C7F
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:57:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d10-20020a170903230a00b0016d63e4112bso3489373plh.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LwyI4Od667QWZnEho6t4fDHg3FRPqen+8eogqEN934w=;
        b=rYS6hSyL5r+ssXNYRZGqVJPMGIH+keO3ZVBsxkg4TCyfFqiRFHXPowpbErisdwRJ4B
         l3FlZzHxoqmzvztjQAaj8JqmVCkcxFFA99P6G3Vpen0+Cy4Bh0ZzoTUVrjCIAjnE0VRn
         EjXeDJY7RoEUkQ1VHbq8UI2+1cywdvI15eRTWah98IiZeA4zh3nswUs787Ze6h4f64Lt
         G6BhJjEFmdnFRGpfJF01h/pH/acdaKiJX8+Ut1wa/SM4YRGs+GTcw1d5vm24kfvL1nIa
         T4Ir3n2uU67VQI6Rzo+mzpKyIFdSvEy9AM9S+iag3BMjtkc/RbMP4i67hRPEmm7Yi+ud
         hN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LwyI4Od667QWZnEho6t4fDHg3FRPqen+8eogqEN934w=;
        b=AZ4VHxXcyAWHMUgMP8FlygnyzIioGCPt40UeVkpHPlSEaFEnV5K36keOHPWKskoilO
         1/k2vSqD17rHZFHVCyDKlY2Ubp84ZjOkNpOpZHvkY3wyVm3ehI+qbjnCSUZ8uE+NSJpQ
         V03dulB+yQPFYmw9/+NiKpmLsTW/4dhP6BTGbmIiof7A12L3+LVef9BRxTwEQxiUKGBb
         mMYy1IWNhHDLTtIRTSz2VEAacOdHcgX0+TJJ/OyjVCebHLJMAMMSq/CCRQgLTFVvJgpY
         7SKSUld001bjooF/Gs1N6uPgfUeem7zUqTWmRM5m/21mvGi0XlTWUniuYdLQAwW6on8E
         Bu+w==
X-Gm-Message-State: AJIora8ttE7McJoeKKk5WBh68yrn26CbO0bMecYoGfI5FWmIEtrJ8i/W
        uKFLsK4lSoS/bSdb80p8r+6AmJ3qiCDSTA==
X-Google-Smtp-Source: AGRyM1vmvWNfrLZnv/uL7ZWONdPw+M89Ziqi8sdBtlaGaitt5JQ3O8Uv+2HYSfwWVjRcz3j1KTJooIPAMQK50g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4404:0:b0:415:aacf:d394 with SMTP id
 r4-20020a634404000000b00415aacfd394mr13129053pga.437.1658793449899; Mon, 25
 Jul 2022 16:57:29 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:57:28 -0700
In-Reply-To: <patch-v3-23.26-4c60784d281-20220721T191249Z-avarab@gmail.com>
Message-Id: <kl6ltu74sq3b.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <patch-v3-23.26-4c60784d281-20220721T191249Z-avarab@gmail.com>
Subject: Re: [PATCH v3 23/26] submodule--helper: don't exit() on failure, return
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

> Change code downstream of module_update() to short-circuit and return
> to the top-level on failure, rather than calling exit().
>
> To do so we need to diligently check whether we "must_die_on_failure",
> which is a pattern started in c51f8f94e5b (submodule--helper: run
> update procedures from C, 2021-08-24), but which hadn't been completed
> to the point where we could avoid calling exit() here.
>
> This introduces no functional changes, but makes it easier to both
> call these routines as a library in the future, and to avoid leaking
> memory.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 790f0ccb82e..b65665105e7 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2283,7 +2283,8 @@ static int fetch_in_submodule(const char *module_pa=
th, int depth, int quiet, str
>  	return run_command(&cp);
>  }
> =20
> -static int run_update_command(struct update_data *ud, int subforce)
> +static int run_update_command(struct update_data *ud, int subforce,
> +			      int *must_die_on_failurep)

It's not obvious in the context lines, but there is an auto variable
named "must_die_on_failure", so we need the "p".

>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	char *oid =3D oid_to_hex(&ud->oid);
> @@ -2345,8 +2346,10 @@ static int run_update_command(struct update_data *=
ud, int subforce)
>  			BUG("unexpected update strategy type: %s",
>  			    submodule_strategy_to_string(&ud->update_strategy));
>  		}
> -		if (must_die_on_failure)
> -			exit(128);
> +		if (must_die_on_failure) {
> +			*must_die_on_failurep =3D 1;
> +			return 128;
> +		}

[...]

> =20
>  		/* the command failed, but update must continue */
>  		return 1;
> @@ -2380,7 +2383,8 @@ static int run_update_command(struct update_data *u=
d, int subforce)
>  	return 0;
>  }
> =20
> -static int run_update_procedure(struct update_data *ud)
> +static int run_update_procedure(struct update_data *ud,
> +				int *must_die_on_failure)
>  {
>  	int subforce =3D is_null_oid(&ud->suboid) || ud->force;
> =20
> @@ -2407,7 +2411,7 @@ static int run_update_procedure(struct update_data =
*ud)
>  			    ud->displaypath, oid_to_hex(&ud->oid));
>  	}
> =20
> -	return run_update_command(ud, subforce);
> +	return run_update_command(ud, subforce, must_die_on_failure);
>  }
> =20
>  static const char *remote_submodule_branch(const char *path)
> @@ -2543,7 +2547,8 @@ static void update_data_to_args(struct update_data =
*update_data, struct strvec *
>  				    "--no-single-branch");
>  }
> =20
> -static int update_submodule(struct update_data *update_data)
> +static int update_submodule(struct update_data *update_data,
> +			    int *must_die_on_failure)
>  {
>  	int ret =3D 1;
> =20
> @@ -2584,8 +2589,13 @@ static int update_submodule(struct update_data *up=
date_data)
>  	}
> =20
>  	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->for=
ce) {
> -		if (run_update_procedure(update_data))
> +		ret =3D run_update_procedure(update_data, must_die_on_failure);
> +		if (ret && *must_die_on_failure) {
> +			goto cleanup;
> +		} else if (ret) {
> +			ret =3D 1;
>  			goto cleanup;
> +		}
>  	}
> =20
>  	if (update_data->recursive) {
> @@ -2608,7 +2618,8 @@ static int update_submodule(struct update_data *upd=
ate_data)
>  		die_message(_("Failed to recurse into submodule path '%s'"),
>  			    update_data->displaypath);
>  		if (ret =3D=3D 128) {
> -			exit(ret);
> +			*must_die_on_failure =3D 1;
> +			goto cleanup;

One important property in the preimage is that there's an obvious
connection between the exit(128) and this section here, i.e. the child
"git submodule update" process failed in a way that the parent needs to
stop immediately.

With this patch, this property is no longer obvious because we return
128 from the lowest level (run_update_command()). By the time we reach
the top level (module_update()), it's no longer clear that the return
value was meant to be 128.

Two ways we can fix this:

1) Just return 128 at all levels to mean "must die on failure", which
   will let us get rid of "must_die_on_failure".

or...

>  		} else if (ret) {
>  			ret =3D 1;
>  			goto cleanup;
> @@ -2646,13 +2657,18 @@ static int update_submodules(struct update_data *=
update_data)
> =20
>  	for (i =3D 0; i < suc.update_clone_nr; i++) {
>  		struct update_clone_data ucd =3D suc.update_clone[i];
> +		int code;
> +		int must_die_on_failure =3D 0;
> =20
>  		oidcpy(&update_data->oid, &ucd.oid);
>  		update_data->just_cloned =3D ucd.just_cloned;
>  		update_data->sm_path =3D ucd.sub->path;
> =20
> -		if (update_submodule(update_data))
> -			res =3D 1;
> +		code =3D update_submodule(update_data, &must_die_on_failure);
> +		if (code)
> +			res =3D code;
> +		if (must_die_on_failure)
> +			goto cleanup;
>  	}

2) In update_submodules() (i.e. just before module_update()), we make=20
   update_submodules() return 128 if must_die_on_failure !=3D 0. Then we
   can drop the return value of 128 from the rest of the call chain and
   just use an opaque nonzero return value instead.

> =20
>  cleanup:
> --=20
> 2.37.1.1095.g0bd6f54ba8a


