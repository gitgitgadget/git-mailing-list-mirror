Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F15C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 01:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiBQBkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:40:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiBQBkq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 20:40:46 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666420190E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:40:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so3381978ejb.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T5As2NC8ZWlZpIb3Fb+Xq53EGU50XkqAZIFFtil7OUA=;
        b=RDYqf+SeaeGp0LvJYjDt8D9w4TVha8lYoPaYRJHaSulXEHLFFSk/3JHYt+cF+wyGup
         6tO3pzqvr0XEe/IlLBw/WA3349K2RCVwM7ie1GPhgDsCN2f58bun5A2NVBCXwY8fUixI
         71VL4DxJXkzCjDvjJd0D1SC4dHmWc1TNiBS3tlptscEmHBYUpz0QWQP+SoO+Ou4esY6D
         qtDdfYDs3T3TNJ8pfYgc2ssfZdespP+2uC3cB2P1wS2EXGOqURr8Zys8dZ1g93KFH0Yn
         S+88I8njOGVBmTZ21jeIdv4ZdVSbbrMg+/9ZL+1KO42bl+3uK7U4dEMipR68Ms85ikXQ
         yioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T5As2NC8ZWlZpIb3Fb+Xq53EGU50XkqAZIFFtil7OUA=;
        b=BdK8qkD0oSoqam+94R+TCDINhlipI7Kvwnpdq0vfaIs67HBV71ssMFNGJqTYsFtf5a
         qjtH34je0Udlj9m1w+8W/D4jhrpcMyMhv0NA25H0Zk3pcA7fi1/yKa3g8u5vU8J9JnzG
         3dLiBHRjAMtuzKbXOzpnB8o8SkRSRl5BH6yQXj5nnaIOeP+rHWUL12k0s7+EGOOC9/PR
         GSvWV81bu4JIpibpeaZNwzHet/SYkCPo5fl6OxKE0kdAYjz5qYQ10wlBMdpirrX/J1eS
         wnK/GAmenCKtW2fsT+sKWj9RpfpzH10peLOX/wFViZb9FQNlU+Jp8raEQFE9WT7QBVpG
         aDtQ==
X-Gm-Message-State: AOAM530cGbgvZ8m9inqN1lb3MiUK96+qvsKaReoBw7wWao6utnDOrHQK
        cNiDws0+Va8ETE67ai4xJJ87D/poDq6ULFIeBvPxSx6Ss+Y=
X-Google-Smtp-Source: ABdhPJxBh0b6fXVrKKfT/OEX2F7d5TcdzMNTgbJBz2iWv8mE1fvbOoB+7ihud1E9C8Mhey9zpgWUkzWcz1iV6+nSKDY=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr569559eja.493.1645062031419; Wed, 16
 Feb 2022 17:40:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
In-Reply-To: <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 17:40:19 -0800
Message-ID: <CABPp-BE9_RVu28C-6QuY2qDYaEExeqCqph0e37DgiFtPZRHY2A@mail.gmail.com>
Subject: Re: [PATCH 6/6] fetch: make `--atomic` flag cover pruning of refs
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 12:25 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> When fetching with the `--prune` flag we will delete any local
> references matching the fetch refspec which have disappeared on the
> remote. This step is not currently covered by the `--atomic` flag: we
> delete branches even though updating of local references has failed,
> which means that the fetch is not an all-or-nothing operation.
>
> Fix this bug by passing in the global transaction into `prune_refs()`:
> if one is given, then we'll only queue up deletions and not commit them
> right away.
>
> This change also improves performance when pruning many branches in a
> repository with a big packed-refs file: every references is pruned in
> its own transaction, which means that we potentially have to rewrite
> the packed-refs files for every single reference we're about to prune.
>
> The following benchmark demonstrates this: it performs a pruning fetch
> from a repository with a single reference into a repository with 100k
> references, which causes us to prune all but one reference. This is of
> course a very artificial setup, but serves to demonstrate the impact of
> only having to write the packed-refs file once:
>
>     Benchmark 1: git fetch --prune --atomic +refs/*:refs/* (HEAD~)
>       Time (mean =C2=B1 =CF=83):      2.366 s =C2=B1  0.021 s    [User: 0=
.858 s, System: 1.508 s]
>       Range (min =E2=80=A6 max):    2.328 s =E2=80=A6  2.407 s    10 runs
>
>     Benchmark 2: git fetch --prune --atomic +refs/*:refs/* (HEAD)
>       Time (mean =C2=B1 =CF=83):      1.369 s =C2=B1  0.017 s    [User: 0=
.715 s, System: 0.641 s]
>       Range (min =E2=80=A6 max):    1.346 s =E2=80=A6  1.400 s    10 runs
>
>     Summary
>       'git fetch --prune --atomic +refs/*:refs/* (HEAD)' ran
>         1.73 =C2=B1 0.03 times faster than 'git fetch --prune --atomic +r=
efs/*:refs/* (HEAD~)'

Very nice!

[...]
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 93a0db3c68..afa6bf9f7d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -349,11 +349,9 @@ test_expect_success 'fetch --atomic --prune executes=
 a single reference transact
>         cat >expected <<-EOF &&
>                 prepared
>                 $ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-del=
etion
> -               committed
> -               $ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-del=
etion
> -               prepared
>                 $ZERO_OID $head_oid refs/remotes/origin/new-branch
>                 committed

Up to here this is just what I expected.

> +               $ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-del=
etion
>                 $ZERO_OID $head_oid refs/remotes/origin/new-branch

But now scheduled-for-deletion and new-branch are both listed again
even with your fixes?  Is this some peculiarity of the reference
transaction hook that it lists the refs again after the
prepared...committed block?  (It may well be; I'm not that familiar
with this area of the code.)
