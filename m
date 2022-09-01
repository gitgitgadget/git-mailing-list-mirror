Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB8ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 21:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiIAVUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiIAVUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 17:20:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C21C90B
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 14:20:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t13-20020a170902e84d00b00174b03be629so8675655plg.16
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=tAXhK9Xmkut1/wP6A2ke6yzfsCD3AIRwMH1LaDhcaQk=;
        b=oD1qUirrdosBGjZKR2HWwVj9Lc5/Og08ZCLP/pX+nol+SjB+jOoAPycqjCOMWx4aLg
         pKaNKyHYeH2wvltiwXPN5CDIghbzseGRWreYLIQnaLopGaewPCartYzXVSzcv7XOoMA8
         mWWm83owHE4x4hN5jfVDxUjtzf6x/xeNXluRKD/HR9/tMziN7Q+3s4JFBWQfxmowT9bx
         86bZPtLS2vKZVjHTm2FeC7Y/KnLfcD2dVBy35m+bvlCYjF6FiEBjc+J18/u86+Oca2LP
         4g3Ey/A07NGGWi/CT6/rsnIZmvjKet3kvt/7DzEgquTQN5+frjQbjAFO8bqY1dDWBZsM
         wa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=tAXhK9Xmkut1/wP6A2ke6yzfsCD3AIRwMH1LaDhcaQk=;
        b=PvMYGv+rbyqjEa4234XUS9eqneL+GoKcUoZUu0EFG+op6WzONWiFysvkx8JTzjUzju
         Ws7sDDPq0uXiXPCxHwDzOqqLsmYIIs4/WfHxMVk2EE4QDgaFpek1sCQEO65XOMkh6Rcv
         IYx2fAqI6JOAhOhK/Te5B8tytr+A+aT0kK6sk+HxnINJWUvr3EfiOdp+rzyOLUVBBU6/
         JQnlbENUSAzOMmezdc8A2ijpAzJmhNSNT7C+y0zyQoswyB5jLuLelc1qrK/nsjfozFxX
         XmT8oMNqV1C8HUGbE/r5AI1rNvhw2672O29Fx5gz8rxkjBE1RjxTvkLPA+z8anaxNjTK
         ocoA==
X-Gm-Message-State: ACgBeo0hwq+mZOE6RJmmzSLuw43Ht3u33qhVP8rsDBYKajdbCiQG2I8s
        gl8LPEWDqoW7d3aaLP8R2sQ6itxSNzLdGQ==
X-Google-Smtp-Source: AA6agR53b12eeD+NY05d6sYRRN7ZQ1gboR4VZuBchGA29krZxE5VotPYaWyXJPVc/KwrBpV77zVKb7bnjILLzw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d294:b0:175:33a8:c60e with SMTP
 id t20-20020a170902d29400b0017533a8c60emr12334582plc.79.1662067214930; Thu,
 01 Sep 2022 14:20:14 -0700 (PDT)
Date:   Thu, 01 Sep 2022 14:20:13 -0700
In-Reply-To: <patch-v7-16.17-63ff554e306-20220831T231003Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
 <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com> <patch-v7-16.17-63ff554e306-20220831T231003Z-avarab@gmail.com>
Message-ID: <kl6ltu5qbxma.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 16/17] submodule--helper: free rest of "displaypath" in
 "struct update_data"
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

> A better fix for this would be to remove the "displaypath" member from
> the "struct update_data" entirely. Along with "oid", "suboid",
> "just_cloned" and "sm_path" it's managing members that mainly need to
> be passed between 1-3 stack frames of functions adjacent to this
> code. But doing so would be a much larger change (I have it locally,
> and fully untangling that in an incremental way is a 10 patch
> journey).

Yeah that does sound like a better fix _and_ too much churn right now.

> So let's go for this much more isolated fix suggested by Glen. We
> FREE_AND_NULL() the "update_data->displaypath", the "AND_NULL()" part
> of that is needed due to the later "free(ud->displaypath)" in
> "update_data_release()" introduced in the preceding commit
>
> Moving ensure_core_worktree() out of update_submodule() may not be
> strictly required, but in doing so we are left with the exact same
> ordering as before, making this a smaller functional change.

Ok, it's nice that we don't have to reason about functional changes,
though I doubt it will matter in this case.

I worry a bit about whether this is setting up an implicit contract
where we always need to call ensure_core_worktree() before
update_submodule(), but the contract has always been quite fuzzy here,
e.g. the "struct update_data" at this point contains a mix of CLI args +
clone result; we should fix that at some point, so doing this
change in the meantime seems harmless.

> Helped-by: Glen Choo <chooglen@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 94ebd8ea38e..1650bf0070b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2487,13 +2487,6 @@ static int update_submodule(struct update_data *up=
date_data)
>  {
>  	int ret;
> =20
> -	ret =3D ensure_core_worktree(update_data->sm_path);
> -	if (ret)
> -		return ret;
> -
> -	update_data->displaypath =3D get_submodule_displaypath(
> -		update_data->sm_path, update_data->prefix);
> -
>  	ret =3D determine_submodule_update_strategy(the_repository,
>  						  update_data->just_cloned,
>  						  update_data->sm_path,
> @@ -2599,7 +2592,15 @@ static int update_submodules(struct update_data *u=
pdate_data)
>  		update_data->just_cloned =3D ucd.just_cloned;
>  		update_data->sm_path =3D ucd.sub->path;
> =20
> +		code =3D ensure_core_worktree(update_data->sm_path);
> +		if (code)
> +			goto fail;
> +
> +		update_data->displaypath =3D get_submodule_displaypath(
> +			update_data->sm_path, update_data->prefix);
>  		code =3D update_submodule(update_data);
> +		FREE_AND_NULL(update_data->displaypath);
> +fail:
>  		if (!code)
>  			continue;
>  		ret =3D code;

Looks good.

> --=20
> 2.37.3.1420.g76f8a3d556c
