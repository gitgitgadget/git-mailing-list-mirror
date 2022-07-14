Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFFEC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiGNSmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiGNSmu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:42:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF83599F1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:42:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f7-20020a170902ce8700b0016cb1f2298fso601411plg.18
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Q7eD3iKuI2xZcm8CVZCcs3TiOv1GMonptT6uEVH/Ab8=;
        b=fa1ppt07LxBY1pHq7gN3VXYXZw4/TblvDV8I+Rnom+690YTxXO58EiqFt6iuucQ+kQ
         6oyB7hw7pSTcDcxmCz2MXOHD698nACN5MPjoZh/49tW4EblJOdihXdfwK41aeODIIJ6s
         W8hFVkH5KXIoyObhKgrs4S72/ClTNRShXBYatW4WD4IFenu7y7SIhMMw3JrOEzzPZPwA
         67xr4wjyFs+uEANZt1aHX8bCq9KmPkjK0OcfkC9L2GEdUUnqMAAdFu3UpjyWCJZX14gf
         vp3Baek60uSDA4OKteSgxhMtvk2LjljvdpEZzZpMmRgrXZhzS3zSsAFl25SPLP7l/xZf
         gfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Q7eD3iKuI2xZcm8CVZCcs3TiOv1GMonptT6uEVH/Ab8=;
        b=tvermJ//ruBVbjqiSNMaNJGgcKL1sR5gRQ+VvAadMwnQ4FBK+YYxw5oT/JprVEHCuT
         k4pEZr3ibZKrcUY6+glNpLOUO31rREqMGWas7iPzx8WCoozvocPE+O43sOzC/mjBZkkf
         kq0Sia3x9lkiiQCqmgjcJEpkSsfg0+nGycN6tRDxfXSsuvJvx2GM7TDzZcjSBBciYTzc
         RcGWGuNs0k4CCZubQCtF2tY2anqkQqfMgL6j/xHy5wit4wrN5aR275YYXt9GQbEWvWVO
         8HQzeJCDOuTKMxeguxNwFQBKCHiHVXh5GL/xe3/t5qGPXPdsGw9CwVaka+dJJZ1g1e1R
         K8Zg==
X-Gm-Message-State: AJIora/ZqKEaRYG5ifUkNJZkJmVMcG2CYRnw5qDaSHhizwZTE+UcclLO
        7PKPRKe6hTQtPTUW9cZYuxpOvMToOZw2PA==
X-Google-Smtp-Source: AGRyM1va7iMUjHPt7kIp5QmneYA2vhS91SvjE9caTysw4nwrT25vz5bLcmcq/ZspIMPBpl+AX0exeJsnlYBa3Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:edc7:b0:16b:e481:3af1 with SMTP
 id q7-20020a170902edc700b0016be4813af1mr9367257plk.8.1657824169399; Thu, 14
 Jul 2022 11:42:49 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:42:47 -0700
In-Reply-To: <patch-11.11-475b1196a93-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6lr12n4jtk.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-11.11-475b1196a93-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 11/11] submodule--helper: fix "reference" leak is "module_clone_data"
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

> Fix leaks in the "reference" member of "struct module_clone_data" that
> have been with us since 31224cbdc72 (clone: recursive and reference
> option triggers submodule alternates, 2016-08-17) and
> 8c8195e9c3e (submodule--helper: introduce add-clone subcommand,
> 2021-07-10).
>
> Those commits added an xstrdup()'d member of the
> STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
> those, but not the ones we get from argv, let's make use of the "util"
> member, if it has a pointer it's the pointer we'll need to free.

Yes, this is a clear-cut case of "sometimes free()-able, sometimes not"
(the others upthread were much less clear), so the approach sounds good.

Well, we could make this always free()-able with some wacky
OPT_STRING_LIST_DUP thing, but I don't think that idea is going anywhere
;)

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d9fab5d77da..966f543fbd9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1598,6 +1598,7 @@ struct module_clone_data {
>  static void module_clone_data_release(struct module_clone_data *cd)
>  {
>  	free(cd->path_free);
> +	string_list_clear(&cd->reference, 1);
>  }
> =20
>  struct submodule_alternate_setup {
> @@ -1652,7 +1653,9 @@ static int add_possible_reference_from_superproject=
(
> =20
>  		sm_alternate =3D compute_alternate_path(sb.buf, &err);
>  		if (sm_alternate) {
> -			string_list_append(sas->reference, xstrdup(sb.buf));
> +			char *p =3D strbuf_detach(&sb, NULL);
> +
> +			string_list_append(sas->reference, p)->util =3D p;
>  			free(sm_alternate);
>  		} else {
>  			switch (sas->error_mode) {
> @@ -3194,9 +3197,11 @@ static int add_submodule(const struct add_data *ad=
d_data)
>  		clone_data.url =3D add_data->realrepo;
>  		clone_data.quiet =3D add_data->quiet;
>  		clone_data.progress =3D add_data->progress;
> -		if (add_data->reference_path)
> -			string_list_append(&clone_data.reference,
> -					   xstrdup(add_data->reference_path));
> +		if (add_data->reference_path) {
> +			char *p =3D xstrdup(add_data->reference_path);
> +
> +			string_list_append(&clone_data.reference, p)->util =3D p;
> +		}
>  		clone_data.dissociate =3D add_data->dissociate;
>  		if (add_data->depth >=3D 0)
>  			clone_data.depth =3D xstrfmt("%d", add_data->depth);
> --=20
> 2.37.0.932.g7b7031e73bc

Ok.
