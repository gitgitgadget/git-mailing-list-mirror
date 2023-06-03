Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA5C77B73
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 06:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFCGWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jun 2023 02:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2023 02:22:48 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF34EE58
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685773357; x=1686378157; i=l.s.r@web.de;
 bh=oyxx9hswY9MlyK9J4IFveh7msXldb08CNfj3bSFfBJA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=spm2eEpWDox+GGJTOIdpYLh5OxAD0+ir1oFLnX3iIj0l20ZcJ24g49l9/Ga3jO9XVbhfaWV
 j+k/EkhqxVDcZ3FM5Zl/DWDLa1+NwzKkRAtAcTzYTKItrrLWcB/8L/T1PfBeRs9QF50hq64Um
 HSsfFfGG8K21S5LAROHnBAgG+owV8faBkARcJ56zRBM+w71YLuJYV0bgVLI8DUjb1k0SP+8+G
 fPOGC1wTLeVX8Ytw/7kJc1zRaF51ZLwgbTaQLJeDpwcO4BH2QIhe0BBJptslrB5s5UEsEwGiI
 0bwVdPR2djn6Lehlwp5Ox4H6Ho0LNPUi1ZRCenuVqLiprarHiuWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.134]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi9q-1pYH4P1vEu-00XGl7; Sat, 03
 Jun 2023 08:22:37 +0200
Message-ID: <a1967c58-48c5-6ae0-f60a-2d8c107f8f66@web.de>
Date:   Sat, 3 Jun 2023 08:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] replace-objects: create wrapper around setting
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
 <0831e7f8b5e23d0af68aa55d66e0cd745ced1e22.1685716158.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <0831e7f8b5e23d0af68aa55d66e0cd745ced1e22.1685716158.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9zXx7oLZG4ahS8TD0Ycl25FvWh39YrFF+MwjtjtdnoXwiZxbXAd
 pYMbqQoVi/x67kMtEF6xIqrue6iC45jzeQlHvqR5aoSGWehYPBXxo7RITWSziaZb6cW4Vya
 oR6OSUMgVa8qzbR1NDZIVxTUd9Oa3nkM7XHkdGAozx98S9wdFNwfQaiBsORB9AEyR+z6zQk
 tGbC2tfWSxhC5WDlC+Cvw==
UI-OutboundReport: notjunk:1;M01:P0:SAqwTX3EWdc=;3HAXo4NkdlsiKMAeUaLUmtcDRM2
 wijalWwPbH8dE9mku7Ya27h6sijrGE4VSJfYLf6HDCSqRmi5YadVODkTG5mTiIYXLlyUSebG0
 VwLjA6m4sooS880xoGLSYT+h7ek/T2zcwHmr/ChxtaNzr4P+6q5ZZLdasEXKJgslGI1FHIu1H
 5LcaA8TTtl1VHFBSViulb6dmNLNtNb/acLPAGD4zLy8cHI6q7NR6iOxb0apymFasssdRlY83G
 f3z/x+GwrH6Behe1ULSRJPjOUy/DlsPpVOAiR+Sjf/xE1UXBQharoSXRnuCTRYORM06SH/w8D
 w3ptabQjiTrJk1HhOCAsETjlwARkDihse/ofoOqaSzc2rk0vfdybC+jk6Z0pYJdJn7zIfUzCe
 YHL1wZCITt8Q+/Aztux8DLZAp+vlz0vx7KUztLWCB8mIClswfH8Ms7YIV1lJi44npUt2n8K5b
 ouREBC9HYuh0fRXOSZ7O5/iHJPz/opNf7BrEC7ne6+c4stWsbAM1nuntlmYGkebRfMfFOYZOh
 QZamceqFlWj7C4PXzXnUHYiMFdQrU/kKNjxDlhmZ5opG0sjgof1u5RuWjd2zm08/uBMtKHbF0
 YNtFfzAbtp6xKr+J4/8y6RsOIuka4+eYbIl6W0f4+FituQpmLUWhiCG9yswjzcrV8a5uct8RA
 pKb2TpptL2/J7pxgAWOdpCboo5f5Y8epxVHMGCXfBaY6u6vLh2zXT2dGv/a8EpNAX+9/btyGJ
 RAHEWYjND2Filw+7HpJLZb17f2JBQoGbCdsSCj0IqLI/Mx1vf8QCJmR27WxagQLwXmlRkKKmq
 HdhUvedvJ8rpZiAkw4KcpVfF4uz6Q8+DReKbKl6CLRYLaPvCWenfV3LddwtBLBXRHNtIhuj/Y
 YjWJoMgQvhaHYW5cnRjohLjj6K9TGTA6aAcimmdMFe5QVg7AfAW5y+WTTuanQhfaxL3jX0HL+
 GVCKSg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.06.23 um 16:29 schrieb Derrick Stolee via GitGitGadget:
> diff --git a/replace-object.c b/replace-object.c
> index ceec81c940c..cf91c3ba456 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -85,7 +85,14 @@ const struct object_id *do_lookup_replace_object(stru=
ct repository *r,
>  	die(_("replace depth too high for object %s"), oid_to_hex(oid));
>  }
>
> +static int read_replace_refs =3D 1;
> +

This breaks compilation:

   replace-object.c:88:12: error: static declaration of 'read_replace_refs=
' follows non-static declaration
   static int read_replace_refs =3D 1;
              ^
   ./replace-object.h:14:12: note: previous declaration is here
   extern int read_replace_refs;
              ^

And this variable is still referenced in two more places outside this
file, which won't work now that it has become static (file-scoped):

   $ git grep read_replace_refs
   builtin/commit-graph.c:extern int read_replace_refs;
   config.c:               read_replace_refs =3D git_config_bool(var, valu=
e);
   replace-object.c: * references, regardless of the value of read_replace=
_refs.
   replace-object.c:static int read_replace_refs =3D 1;
   replace-object.c:       read_replace_refs =3D 0;
   replace-object.c:       return read_replace_refs;
   replace-object.h:extern int read_replace_refs;

Perhaps postpone adding "static" to patch 3?

>  void disable_replace_refs(void)
>  {
>  	read_replace_refs =3D 0;
>  }
> +
> +int replace_refs_enabled(struct repository *r)
> +{
> +	return read_replace_refs;
> +}
> diff --git a/replace-object.h b/replace-object.h
> index 7786d4152b0..b141075023e 100644
> --- a/replace-object.h
> +++ b/replace-object.h
> @@ -27,6 +27,19 @@ void prepare_replace_object(struct repository *r);
>  const struct object_id *do_lookup_replace_object(struct repository *r,
>  						 const struct object_id *oid);
>
> +
> +/*
> + * Some commands disable replace-refs unconditionally, and otherwise ea=
ch
> + * repository could alter the core.useReplaceRefs config value.
> + *
> + * Return 1 if and only if all of the following are true:
> + *
> + *  a. disable_replace_refs() has not been called.
> + *  b. GIT_NO_REPLACE_OBJECTS is unset or zero.
> + *  c. the given repository does not have core.useReplaceRefs=3Dfalse.
> + */
> +int replace_refs_enabled(struct repository *r);
> +
>  /*
>   * If object sha1 should be replaced, return the replacement object's
>   * name (replaced recursively, if necessary).  The return value is
> @@ -41,7 +54,7 @@ const struct object_id *do_lookup_replace_object(struc=
t repository *r,
>  static inline const struct object_id *lookup_replace_object(struct repo=
sitory *r,
>  							    const struct object_id *oid)
>  {
> -	if (!read_replace_refs ||
> +	if (!replace_refs_enabled(r) ||
>  	    (r->objects->replace_map_initialized &&
>  	     r->objects->replace_map->map.tablesize =3D=3D 0))
>  		return oid;

