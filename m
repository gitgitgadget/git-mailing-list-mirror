Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68602C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiG2RIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiG2RIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:08:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73B6C10D
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:08:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l8-20020a170903244800b0016dd492f4f6so1124237pls.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=UKe9bTXCjPavS8tSMKzQ49zHzscUY/02uZ25HrWoD/s=;
        b=V/Z3mbXHfIp+kJCgPmXg5awRdQIiHpVS4FB9tT4PxuHpkFObFupRXOxzda7V45w9Vp
         2fG18HlhF2D4Xe2u6p3nALHfxTau4mUU9MbxSobVpIhxsY2vUhZSjFMGK+mpEFB4oYxZ
         WGzbMTGXY7L6s3OAcHSq/bw0/AFul5kdTwcMhlZYDfh1rnLgQ2Vb3BlxnieFa6W7hENl
         /kwxqTsdtsoUXO/xq4xk8a/AdaqYJNJRqg2amY/VkUeoIe5mIdl5F4YIvnWvOrvgif1p
         q6o7g+icirdHvIggU5Zqs+2IzQ3j8DUOkm8YUqeroJ2i7GMlN4l86VgyPqJp8GfsyNj3
         cPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=UKe9bTXCjPavS8tSMKzQ49zHzscUY/02uZ25HrWoD/s=;
        b=wuTo8nV3EvANfoQwZ2b2VCDwHx84gEP/eOhpdobEhr7Fyru9l5vqlIdypOR3FqtCi1
         s/UHPFpPTi9TBzs0P+17cT1gOllEg3jpJbOtmoNaaYeyH6QDOirGebA3IwGzNy9fWcX8
         FDAU9HQLaqLWtn3LQyn6LhxnSSqGjF1ykAwtEx3ykD3Yr18x/8wGYZ5Za0t1mEKCk+sN
         Msu40N/rvlBFP1K57RN0Wd3DFk3Q4LtyPRXC5ijhIPN58kE8fhZyuJ8A0l3YnyPiy5Qo
         LFv/5cI9d3gltpvxL6qySlhve4vkxaB+ctT5tfq2N86p8Bo/gCF9RcfyvoxWitMXBKNH
         b1Dg==
X-Gm-Message-State: ACgBeo3cKRYieMyhIpKFaAKeLsztH+grNPEN5XwhtnWhJawC6xHwuYdS
        mSb3/zf6aQu+vUaa2BQMm/SX2BmtIyDs+g==
X-Google-Smtp-Source: AA6agR6cZhtICuzlrE2uYMML/djLMGVQugPzXLSYhsI728j8sxOYb1znkTZHOpuadrTl6tcKhzC3yCRSpdOSZw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bcca:b0:16d:3e8a:bb5a with SMTP
 id o10-20020a170902bcca00b0016d3e8abb5amr4834924pls.94.1659114529127; Fri, 29
 Jul 2022 10:08:49 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:08:47 -0700
In-Reply-To: <patch-13.20-afe34d8b73b-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6l4jyzsv6o.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-13.20-afe34d8b73b-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 13/20] submodule--helper: stop conflating "sb" in clone_submodule()
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

> Refactor the two uses of a "struct strbuf sb" such that each of them
> exists in its own scope. This makes the control flow clearer.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f74957444e1..6cedcc5b239 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1557,16 +1557,24 @@ static void prepare_possible_alternates(const cha=
r *sm_name,
>  	free(error_strategy);
>  }
> =20
> -static int clone_submodule(struct module_clone_data *clone_data)
> +static char *clone_submodule_sm_gitdir(const char *name)
>  {
> -	char *p, *sm_gitdir;
> -	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	char *sm_gitdir;
> =20
> -	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
> +	submodule_name_to_gitdir(&sb, the_repository, name);
>  	sm_gitdir =3D absolute_pathdup(sb.buf);
> -	strbuf_reset(&sb);
> +	strbuf_release(&sb);
> +
> +	return sm_gitdir;
> +}
> +
> +static int clone_submodule(struct module_clone_data *clone_data)
> +{
> +	char *p;
> +	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
> +	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> =20
>  	if (!is_absolute_path(clone_data->path))
>  		clone_data->path =3D xstrfmt("%s/%s", get_git_work_tree(),
> @@ -1624,6 +1632,8 @@ static int clone_submodule(struct module_clone_data=
 *clone_data)
>  			die(_("clone of '%s' into submodule path '%s' failed"),
>  			    clone_data->url, clone_data->path);
>  	} else {
> +		struct strbuf sb =3D STRBUF_INIT;
> +
>  		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
>  		    !is_empty_dir(clone_data->path))
>  			die(_("directory not empty: '%s'"), clone_data->path);
> @@ -1631,7 +1641,7 @@ static int clone_submodule(struct module_clone_data=
 *clone_data)
>  			die(_("could not create directory '%s'"), clone_data->path);
>  		strbuf_addf(&sb, "%s/index", sm_gitdir);
>  		unlink_or_warn(sb.buf);
> -		strbuf_reset(&sb);
> +		strbuf_release(&sb);
>  	}

As Junio mentioned in
https://lore.kernel.org/git/xmqqlesmf9or.fsf@gitster.g, we could also
replace this with xstrfmt(). I think that gets rid of all of the
users of "sb", so I doubt we'll even need this patch once we
make that change :)

> =20
>  	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
> @@ -1653,7 +1663,6 @@ static int clone_submodule(struct module_clone_data=
 *clone_data)
>  	free(sm_alternate);
>  	free(error_strategy);
> =20
> -	strbuf_release(&sb);
>  	free(sm_gitdir);
>  	free(p);
>  	return 0;
> --=20
> 2.37.1.1167.g38fda70d8c4
