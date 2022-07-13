Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiGMRiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGMRh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 13:37:59 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4E2CDC8
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 10:37:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x12-20020a62fb0c000000b0052af899ae7cso1973672pfm.6
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=+PTrflZO3l9piqpwnuy3yUXc1S1284PGSoonnFRRT0E=;
        b=LjBm4pmiuAqOA5Xc2eOYg9PfJvS2A4FjEPmt5/v2MRzOMStkKZkT9c1gHKA1eQdS4l
         b9TB/jRUaUzVSZJCsWS0CverUrgGhDuv2RRUmIoohFdkK65GwaLmYcP/LwLvN9PbBJYy
         je3fBeDe6NbLpyNpfzIcniW96mczl9ltiPTu6YKnmLLM9tYDgSkZqzy6WtC1taNXcg9E
         pdmonGo5FibkN6pWc7e3je/C0ziJzEWErbd0aLrv5sZFV+JFwb9ouuu7mqt6ytaSEAAt
         Sana72KYGi56DgdFOYMdaagHDqBLjLpjA7NiYDAxdOVJqklQsJr/m5mQid2f9r7xbKmH
         fKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=+PTrflZO3l9piqpwnuy3yUXc1S1284PGSoonnFRRT0E=;
        b=WWPzQThDd8FhOhLKkZTQaEtrufC+Pd6mzm81atzr5TuXGKkQQ7iFefwigLLKuQWv9N
         qTiNhVVADPBQhqxGjp8QhP0ACwp5BmMHWGXc+e7X9pwv3x/4N04msNUDeTILHbL7MZ2y
         yQdEIt/cXldrww23KtgK0HcFDVUdEqoRNDfSvEY41PluQy1JQ3J7+wSz5pYNTMGKVlgm
         TT4lpal0W5mj1DglHJnGUQIxrZ9hPJCj+ou399I3Zo7IvpPzi8zh5sZGbG+XC7goQfYZ
         17OovPr16vrpYDrGA0cpSdDS7t+kMNuNlXMMGr4AqSNjqlXXYV+IZTofWnQDPGaAWaXc
         GH1Q==
X-Gm-Message-State: AJIora9BoJxr3JooZaQoI0PVr6723CoAKgRUsBYt6lQfrn517wV3wOPT
        MeP235AlaCQK1dCi2qBTuRY/5rd9C+PxgQ==
X-Google-Smtp-Source: AGRyM1u4SbBMwbPM9AurdTKeTxIsSFWk4XwR5zePldPom28eHyXhAMiFE4W6LB7aCtNNgUmTZMwTt5lGlnV7Xw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:1a8b:0:b0:528:d505:1a06 with SMTP id
 a133-20020a621a8b000000b00528d5051a06mr4324258pfa.78.1657733876741; Wed, 13
 Jul 2022 10:37:56 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:37:54 -0700
In-Reply-To: <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6lmtdc6hhp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 03/11] submodule--helper: fix "module_clone_data" memory leaks
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

> The "path" member can come from "argv" (i.e. not malloc'd), or it can
> be something we determine at runtime. In the latter case let's save
> away a pointer to free() to avoid leaking memory.

[...]

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 73717be957c..23ab9c7e349 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1511,6 +1511,7 @@ static int module_deinit(int argc, const char **arg=
v, const char *prefix)
>  struct module_clone_data {
>  	const char *prefix;
>  	const char *path;
> +	char *path_free;
>  	const char *name;
>  	const char *url;
>  	const char *depth;
> @@ -1527,6 +1528,11 @@ struct module_clone_data {
>  	.single_branch =3D -1, \
>  }
> =20
> +static void module_clone_data_release(struct module_clone_data *cd)
> +{
> +	free(cd->path_free);
> +}
> +
>  struct submodule_alternate_setup {
>  	const char *submodule_name;
>  	enum SUBMODULE_ALTERNATE_ERROR_MODE {
> @@ -1651,9 +1657,9 @@ static int clone_submodule(struct module_clone_data=
 *clone_data)
> =20
>  	if (!is_absolute_path(clone_data->path)) {
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
> -		clone_data->path =3D strbuf_detach(&sb, NULL);
> +		clone_data->path =3D clone_data->path_free =3D strbuf_detach(&sb, NULL=
);
>  	} else {
> -		clone_data->path =3D xstrdup(clone_data->path);
> +		clone_data->path =3D clone_data->path_free =3D xstrdup(clone_data->pat=
h);
>  	}

Hm, having .path_free doesn't seem necessary. If I'm reading the code
correctly,

- in module_clone() we set clone_data.path from argv
- then we unconditionally call clone_submodule(), which does all of the
  hard work
- in clone_submodule(), we always hit this conditional, which means that
  past this point, clone_data.path is always free()-able.

which suggests that we don't need clone_data.path_free at all. I suspect
that just this

   static void module_clone_data_release(struct module_clone_data *cd)
   {
   	free(cd->path);
   }

is enough to plug the leak (though admittedly, I haven't properly tested
the leak because it's been a PITA to set up locally).

That's a pretty hacky suggestion though, since we're still using the
same member to hold free()-able and non-free()-able memory. Instead,
maybe we could move this "clone_data.path =3D freeable" logic into
module_clone(), like:

  diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
  index 73717be957..d67d4b9647 100644
  --- a/builtin/submodule--helper.c
  +++ b/builtin/submodule--helper.c
  @@ -1649,13 +1649,6 @@ static int clone_submodule(struct module_clone_dat=
a *clone_data)
    sm_gitdir =3D absolute_pathdup(sb.buf);
    strbuf_reset(&sb);

  -	if (!is_absolute_path(clone_data->path)) {
  -		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
  -		clone_data->path =3D strbuf_detach(&sb, NULL);
  -	} else {
  -		clone_data->path =3D xstrdup(clone_data->path);
  -	}
  -
    if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
      die(_("refusing to create/use '%s' in another submodule's "
            "git dir"), sm_gitdir);
  @@ -1745,12 +1738,13 @@ static int module_clone(int argc, const char **ar=
gv, const char *prefix)
    int dissociate =3D 0, quiet =3D 0, progress =3D 0, require_init =3D 0;
    struct module_clone_data clone_data =3D MODULE_CLONE_DATA_INIT;
    struct list_objects_filter_options filter_options =3D { 0 };
  +	const char *clone_path;

    struct option module_clone_options[] =3D {
      OPT_STRING(0, "prefix", &clone_data.prefix,
          N_("path"),
          N_("alternative anchor for relative paths")),
  -		OPT_STRING(0, "path", &clone_data.path,
  +		OPT_STRING(0, "path", &clone_path,
          N_("path"),
          N_("where the new submodule will be cloned to")),
      OPT_STRING(0, "name", &clone_data.name,
  @@ -1795,6 +1789,15 @@ static int module_clone(int argc, const char **arg=
v, const char *prefix)
    clone_data.require_init =3D !!require_init;
    clone_data.filter_options =3D &filter_options;

  +	if (!is_absolute_path(clone_path)) {
  +		struct strbuf sb =3D STRBUF_INIT;
  +		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_path);
  +		clone_data.path =3D strbuf_detach(&sb, NULL);
  +		strbuf_release(&sb);
  +	} else {
  +		clone_data.path =3D xstrdup(clone_path);
  +	}
  +
    if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
      usage_with_options(git_submodule_helper_usage,
            module_clone_options);
