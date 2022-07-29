Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28EDC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiG2WXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiG2WXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:23:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA08AEE0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:23:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n184-20020a2540c1000000b0067691de454cso3964959yba.11
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=vnkZ+Xs3KZ2W1HTohoBs/zIH7OnF3H7wGs0qQbNqQh8=;
        b=F56SfDm4U3t0JSudwESaEZyUtzs3U7mHORKIuImQQitugtDuVS4zc+BpmZS/UY2wYj
         vFqVYwootPWSCkA62i/k79yQDO9eqAOa/3lxfez6GbFL6Ad58hdCxUvgJIwoTSQ2BXiw
         dDWhy47OTpfNmokKENHr6XlArN1AYuEX0OmT3Ip3EsZij9s+UNpccU5/1ZDkwNRivbBN
         JjbRwDBK1oIjNDgvuxdCtmSOUrT0TBjdQ3I5uYs1ZHHhr/I75VShNR1elUf+HGnpse3Q
         46vo9UnNar48Z/TOeP3G36LVXmJn2JauhDbxAKfRfgREQGbC3yjKTJI06gBx7vtfbz6+
         wzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=vnkZ+Xs3KZ2W1HTohoBs/zIH7OnF3H7wGs0qQbNqQh8=;
        b=dFKNqCoTreqzmS/yPkSvmmmkhufFo1erDoL3VLh9aLSjV+1ZVBN7pQFTqeqJ/qn6g+
         YYcF0dvJT3mPhjZN4QgsIwT41F05CV7HcO67FqJCQKZlPPqhydgz1aCTDrh2+OuJMPEg
         rBqpRZuz9LzWrVJV11R8Q+3zdpkqlKUt+fSNBqfuUTGkjFaodf0RVmYh5cBk7oyL/g62
         Hm1KcqUxcCxJ6QodFY4/R4JZW4yB5VOAn+yDJTLEcCw06caz3Z5eHEjSUtkiKR2txezD
         bFAIC9NJUJkhKsVA+BVH1VqsELBpjqQJ9q6W+AvF6Na1uDgEXz1tx+3/dHurzQcP2kgU
         ajAw==
X-Gm-Message-State: ACgBeo38uVdKJ1DbRudip1WTeAoA1s0zwdl+ZlcBkNBQvZ4D8RVeICk4
        cLYD89ehbUQs5IHsStVyM50jwtOojhgTHQ==
X-Google-Smtp-Source: AA6agR6REade3qOLI/a5EIyv8Svw/t/20SyIcDVIMGuLPDUQWn2MPIvVBdHaStOOzw62/WNvScaEsBP7fyWKTQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:d142:0:b0:31e:1ec7:3dbc with SMTP id
 t63-20020a0dd142000000b0031e1ec73dbcmr4835871ywd.463.1659133383685; Fri, 29
 Jul 2022 15:23:03 -0700 (PDT)
Date:   Fri, 29 Jul 2022 15:23:01 -0700
In-Reply-To: <patch-19.20-5a26c9428be-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6lilnfr22i.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-19.20-5a26c9428be-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 19/20] submodule--helper: don't exit() on failure, return
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
> call these routines as a library in the future, and to eventually
> avoid leaking memory.
>
> This and similar control flow in submodule--helper.c could be made
> simpler by properly "libifying" it, i.e. to have it consistently
> return -1 on failures, and to early return on any non-success.
>
> But let's leave that larger project for now, and (mostly) emulate what
> were doing with the "exit(128)" before this change.

Thanks! This is a lot clearer. I'm still kind of iffy on this change
though. On the one hand, we know for sure that we're doing the right
thing because we have tests for "git submodule update --recursive". But
on the other, we return 128 from so deep inside the call chain that I
don't think it's easy for a casual reader to convince themselves that
this is indeed the same.

If the "libification" isn't too hard, I'd strongly prefer to have that
now, but since we already have tests in place, I don't feel strongly
enough to block this patch.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 68aa10a26cd..d3f22f03766 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2121,7 +2121,8 @@ static int fetch_in_submodule(const char *module_pa=
th, int depth, int quiet, str
>  	return run_command(&cp);
>  }
> =20
> -static int run_update_command(struct update_data *ud, int subforce)
> +static int run_update_command(struct update_data *ud, int subforce,
> +			      int *must_die_on_failurep)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	char *oid =3D oid_to_hex(&ud->oid);
> @@ -2183,8 +2184,10 @@ static int run_update_command(struct update_data *=
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
> =20
>  		/* the command failed, but update must continue */
>  		return 1;
> @@ -2218,7 +2221,8 @@ static int run_update_command(struct update_data *u=
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
> @@ -2245,7 +2249,7 @@ static int run_update_procedure(struct update_data =
*ud)
>  			    ud->displaypath, oid_to_hex(&ud->oid));
>  	}
> =20
> -	return run_update_command(ud, subforce);
> +	return run_update_command(ud, subforce, must_die_on_failure);
>  }
> =20
>  static const char *remote_submodule_branch(const char *path)
> @@ -2381,7 +2385,8 @@ static void update_data_to_args(struct update_data =
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
> @@ -2420,8 +2425,13 @@ static int update_submodule(struct update_data *up=
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
> @@ -2444,7 +2454,8 @@ static int update_submodule(struct update_data *upd=
ate_data)
>  		die_message(_("Failed to recurse into submodule path '%s'"),
>  			    update_data->displaypath);
>  		if (ret =3D=3D 128) {
> -			exit(ret);
> +			*must_die_on_failure =3D 1;
> +			goto cleanup;
>  		} else if (ret) {
>  			ret =3D 1;
>  			goto cleanup;
> @@ -2482,13 +2493,18 @@ static int update_submodules(struct update_data *=
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
> =20
>  cleanup:
> --=20
> 2.37.1.1167.g38fda70d8c4
