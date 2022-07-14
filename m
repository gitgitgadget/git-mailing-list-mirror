Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E70C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiGNSd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGNSd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:33:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D0275EF
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:33:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mi13-20020a17090b4b4d00b001ef9759d26aso1670535pjb.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HgI17jnugSmvq4fNKhFTKdr6IJDOmmZ+Q0wbWBGFDys=;
        b=p1ffSmOs8BPUfo27LfdjHH11W6oWmvKRFMBUhSIWvxORprpVIAgn4ApO9KvTtB/TrH
         yP6I8gX0CIVvIc/04Rv2YyRVfHZj6xq3y3s6R+U+HtzcOlMOPGoWehijLrb1DQZs55ge
         JaRYIbikWF3VWpClEs+jAdXSoa9JqM65jsVhHtN/lVkLeN7lgg3zFsL3hhnAXaoGgUYP
         irlTt3n7pwkQcap4Dt7yLtrQrp+U8ESKOXBGWknMIn6+J27XmRGci6/sFhe5NkREGKKG
         gkQ3eswRM7X04pfdmrGdGJ209XkqyZM/jKDqQtbq+VxZ9Tn4sXUDUuUqqhLFj6XAUp9m
         lfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HgI17jnugSmvq4fNKhFTKdr6IJDOmmZ+Q0wbWBGFDys=;
        b=QGP3pBEm6grwKKniWwo7QFmHxiq0zmwR3Vsh7TB99RcWhYLJr24Q+CVeZUQcmcQ7/Y
         jGHBDqTx/uMTkqU+nnBz2unBp3F6xKPbEznXArgUtCm/wrxAVuVd9+9TnUnAdqoC9D/l
         j94m9WokMFXVDnPM1l79jdlMAaWhyiYhkrCbf2gE6pLl6m0+FfCK3eTrhPNo+83G+LWy
         /mRm9x+wkvGDTOTSfy9NWoVsfEO+OldcurXeOFL+QrWt6CIbrv8vvxvvGsq2OX0SCslL
         N7+2uxeMoe8FDTT8vsKuDg0ssL+IDqKkYaBDAdhvI7tAurywtX31BlPa6ntxsDQQTJu9
         8FlQ==
X-Gm-Message-State: AJIora9iLj9P3BqXUHk+GLJUnQRgq0XmEE5Tuptg34ncQNFgczgQrBvx
        DedpzFSoeUOrTYuSZ5IO48D6arlQgfFJpA==
X-Google-Smtp-Source: AGRyM1vwUePGlo/2bjkfzwZxsWBp0omuW29YUwZedrEM6HePfxDsRQjIf6tynLqr1ZAvmw406aQseux8d7koSw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ca85:b0:16c:a4b6:e41b with SMTP
 id v5-20020a170902ca8500b0016ca4b6e41bmr5986891pld.12.1657823605399; Thu, 14
 Jul 2022 11:33:25 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:33:23 -0700
In-Reply-To: <patch-09.11-7b36f71879e-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6ltu7j4k98.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-09.11-7b36f71879e-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 09/11] submodule--helper: free "char *" in "struct update_data"
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

> Make the update_data_release() function free the "recursive_prefix"
> and "displaypath" members when appropriate. For the former it could
> come from either "argv" or from our own allocation, so we need to keep
> track of a "to_free" sibling seperately.

Obsolete message probably? "recursive_prefix" no longer exists as of
gc/submodule-use-super-prefix ;)

> For "displaypath" it's always ours, so the "const char *" type was
> wrong to begin with, it should be a "char *" instead.

Ok.

> For update_submodule() we'll free() these as we go along, it's called
> in a loop by update_submodules(), and we'll need to free the "last"
> one.

Hm, I don't follow this part. Does "as we go along" mean "as we go along
freeing things in update_submodules()", or "we'll do this later on"?

I'm assuming it's the latter since this patch only frees the "last" one
and doesn't free inside of update_submodule(), but maybe it's not so
hard to do? I think it's just:

  diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
  index 0bac39880d..34b54e97d1 100644
  --- a/builtin/submodule--helper.c
  +++ b/builtin/submodule--helper.c
  @@ -2560,6 +2560,7 @@ static int update_submodule(struct update_data *upd=
ate_data)
  {
    ensure_core_worktree(update_data->sm_path);

  +	free(update_data->displaypath);
    update_data->displaypath =3D get_submodule_displaypath(
      update_data->sm_path, update_data->prefix);

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2b44f391f15..0bac39880d2 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1949,7 +1949,7 @@ static void submodule_update_clone_release(struct s=
ubmodule_update_clone *suc)
> =20
>  struct update_data {
>  	const char *prefix;
> -	const char *displaypath;
> +	char *displaypath;
>  	enum submodule_update_type update_default;
>  	struct object_id suboid;
>  	struct string_list references;
> @@ -1987,6 +1987,7 @@ struct update_data {
> =20
>  static void update_data_release(struct update_data *ud)
>  {
> +	free(ud->displaypath);
>  	module_list_release(&ud->list);
>  }
> =20
> --=20
> 2.37.0.932.g7b7031e73bc
