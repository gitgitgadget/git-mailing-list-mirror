Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CBC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiGMVA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGMVA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 17:00:27 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EA31349
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 14:00:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q132-20020a632a8a000000b00411eb01811fso5775372pgq.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=uFBmDMYqd65F0eIeXw8toHJCFGRVbrYU1pPdSmMHtTk=;
        b=A6t0kQTmH/YZJFzV1UJbKZE/GNsqGXl4uTjczkAbAKooCBXRzfdNMBm4EJlMIwTRoJ
         5jTQlZwiBeY2DmfpsLYWqgjdgk1jOFDnwfTaKNu1+RMUsE+zu7mzm0MswiXWD7UnTCJj
         MpbKBATgt8oFppMT7eu/1L52mD5zZMYkTzS6l11Wcrlr/DWFxEPZEyYFND6kmwAra+kh
         gXU3B0LisMIP8qWmBjS8GyyTk7WISCdsR3R9iOhimrHzQMilyWuKfqBfA9EdCjjTuC25
         O/Mx8qB0CkrsYP2mwlut2hQcfNNSFKNknip8ex37ryTpLDWNIcWX90yoR2MHrbfAoamj
         SoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=uFBmDMYqd65F0eIeXw8toHJCFGRVbrYU1pPdSmMHtTk=;
        b=g51LoPz75eH8X4gm3ckz/bRm4SfNTSTZzpr7dR7XLfnjMnSVDyScBy+FK1G9XUzygP
         XFpkXbd478wmGa0OqQHyRIK4x/8xB9uzyO4A4O4yyMo/8k+eKMOyiFbT2gnb6XDCy546
         SZ30FaDNbIplTikxPwKQVXFlAQU3XeCMU4xElDE3G0dsTv3QWwbe5qvuzGiVqojq5yIY
         b8S4rJtXhZzyny9oDY8udzD60TURi2iXJVV3qlEePwDFVwPV+M9x2DHULutfkYyhlUik
         Aacm8Q4i2How6NAuw/SvyLjWDkUudblV0LtArfsa5h9J+2NH0fVSHAXF5uM0JF0G4Smq
         gJaw==
X-Gm-Message-State: AJIora+ILwVoMxozZphLZHFuTfL0q1PDeCgMGCXi3pN5b0WKpltwsNFL
        c0X9uicCE7XvZpgqHfa/hvscCBUfFECVNQ==
X-Google-Smtp-Source: AGRyM1vnuAWXTXXVo9aLnvLrj7Q7D0yidM0Q53ZHWTUjrjO8r70Sy1us3Dtz9/3ja2eguf3DgYZ4Kvch9u96hA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:174f:b0:525:518e:71d6 with SMTP
 id j15-20020a056a00174f00b00525518e71d6mr5116814pfc.68.1657746026159; Wed, 13
 Jul 2022 14:00:26 -0700 (PDT)
Date:   Wed, 13 Jul 2022 14:00:08 -0700
In-Reply-To: <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 02/11] submodule--helper: replace memset() with { 0 }-initialization
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

> Use the less verbose { 0 }-initialization syntax rather than memset()
> in builtin/submodule--helper.c, this doesn't make a difference in
> terms of behavior, but as we're about to modify adjacent code makes
> this more consistent, and lets us avoid worrying about when the
> memset() happens v.s. a "goto cleanup".

Ok. I wonder if we could reduce this kind of churn in the future by
adding this to CodingGuidelines, e.g. "always use { 0 } for stack
variables". Tangentially, do we require { NULL } when the first element
is a pointer? (I'm not sure because this isn't in CodingGuidelines
either AFAICT.)

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index fac52ade5e1..73717be957c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1744,7 +1744,7 @@ static int module_clone(int argc, const char **argv=
, const char *prefix)
>  {
>  	int dissociate =3D 0, quiet =3D 0, progress =3D 0, require_init =3D 0;
>  	struct module_clone_data clone_data =3D MODULE_CLONE_DATA_INIT;
> -	struct list_objects_filter_options filter_options;
> +	struct list_objects_filter_options filter_options =3D { 0 };
> =20
>  	struct option module_clone_options[] =3D {
>  		OPT_STRING(0, "prefix", &clone_data.prefix,
> @@ -1786,7 +1786,6 @@ static int module_clone(int argc, const char **argv=
, const char *prefix)
>  		NULL
>  	};
> =20
> -	memset(&filter_options, 0, sizeof(filter_options));
>  	argc =3D parse_options(argc, argv, prefix, module_clone_options,
>  			     git_submodule_helper_usage, 0);
> =20
> @@ -2563,7 +2562,7 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  {
>  	struct pathspec pathspec;
>  	struct update_data opt =3D UPDATE_DATA_INIT;
> -	struct list_objects_filter_options filter_options;
> +	struct list_objects_filter_options filter_options =3D { 0 };
>  	int ret;
> =20
>  	struct option module_update_options[] =3D {
> @@ -2623,7 +2622,6 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  	update_clone_config_from_gitmodules(&opt.max_jobs);
>  	git_config(git_update_clone_config, &opt.max_jobs);
> =20
> -	memset(&filter_options, 0, sizeof(filter_options));
>  	argc =3D parse_options(argc, argv, prefix, module_update_options,
>  			     git_submodule_helper_usage, 0);
> =20
> --=20
> 2.37.0.932.g7b7031e73bc
