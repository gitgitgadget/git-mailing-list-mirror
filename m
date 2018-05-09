Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE691F42E
	for <e@80x24.org>; Wed,  9 May 2018 17:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935519AbeEIRuI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:50:08 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:43241 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935274AbeEIRuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:50:02 -0400
Received: by mail-yb0-f182.google.com with SMTP id v12-v6so3657979ybl.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MSpPDjW6cZRL071CP3rrlsmaenP6nL0/0sbqQ0cwabo=;
        b=VFuPPwSSxWc9E3KurXROIZT7YKtNyPtuOaJ4cbtTBSfPRVnh9ecH4dGVba9mngIzvT
         RYUpYlAmJMShPNQkd/sx516Fm/RDKQjEgoJq/Nm+VIbR9AmvajA7kTrHOmBZ1J7BfSAl
         2BpGINEM/yV7/dFwTvMLdkp6+QT6QWTpKXbuzAcDrcHa4YnqmreL86WQ7mckBx9htbd8
         Qfl8Vt9vWtYcXtEAcMsI+YNFx8jeXyHc/wddtLKxMgt/pjAQSFN4H9nzQPaUDmyCMVhx
         S2gENBZJoMDGSvG4EbT93KuFn3Laq1OZHtwUc8OVa+I3iPhNnA2RgaTTfbu3l8le6jFN
         Qsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MSpPDjW6cZRL071CP3rrlsmaenP6nL0/0sbqQ0cwabo=;
        b=pdoK1IQs/WDT760veeVn4rt+Sxz9tAat2nQjNXMwPVxpAAkVpnwj5Udj7+7BepllOa
         6UrGBSt0kWAeu4US5xLd3l9Smp/Q2dGAR5bhAZ5wS7OVEulTzsqy6bI0lj/i5c7kDGYK
         xDnl9kdBfqejNpUMLOpYsn2LtHTokMWl5+fhYZOD+ptuWyEbCpBlNuI9BGkKEUVa8sVu
         jrakMiCBBbObLnp67ELYCxs2Zck/CWFzcq8/k+7NSBYygI26SD7bEqP7j5pdNW0M5nHq
         ZEt+MAuozCA8aJARjw/nhXbPBgcBEAO6/mER0yeQFEgld1gXJWJTyrlghGLIHgRujhg1
         7J5A==
X-Gm-Message-State: ALQs6tAkh9iBCJgctEW4coOBqL019em++q0xB2S7sW1JOBhCm4XyBO8L
        gsXou2nYX8nVCJYNPvw76zesVkHzgp0zE6CpXPkqYA==
X-Google-Smtp-Source: AB8JxZpo/9AsPblTDp30uUjXktwDEpyfMm+gO5LBytfvJ2ZN77YFLS1bV8PEwHoCahAEl8AOxiVsXr/leZuGlJrxygQ=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr27723895ybb.334.1525888201280;
 Wed, 09 May 2018 10:50:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 10:50:00 -0700 (PDT)
In-Reply-To: <20180509170409.13666-1-pclouds@gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 10:50:00 -0700
Message-ID: <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 10:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> the_repository is special. One of the special things about it is that
> it does not allocate a new index_state object like submodules but
> points to the global the_index variable instead. As a global variable,
> the_index cannot be free()'d.

ok. That is the situation we're in.

>
> Add an exception for this in repo_clear(). In the future perhaps we
> would be able to allocate the_repository's index on heap too. Then we
> can remove revert this.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  I was trying to test the new parsed_object_pool_clear() and found this.

So this would go with the latest sb/object-store-alloc ?

My impression was that we never call repo_clear() on
the_repository, which would allow us to special case
the_repository further just as I did in v2 of that series[1] by
having static allocations for certain objects in case of \
the_repository.

[1] https://public-inbox.org/git/20180501213403.14643-14-sbeller@google.com=
/

We could just deal with all the exceptions, but that makes repo_clear
ugly IMHO.

I would rather special case the_repository even more instead
of having it allocate all its things on the heap. (However we rather
want to profile it and argue with data....)

>  repository.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/repository.c b/repository.c
> index a4848c1bd0..f44733524a 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -238,7 +238,9 @@ void repo_clear(struct repository *repo)
>
>         if (repo->index) {
>                 discard_index(repo->index);
> -               FREE_AND_NULL(repo->index);
> +               if (repo->index !=3D &the_index)
> +                       free(repo->index);
> +               repo->index =3D NULL;

So after this we have a "dangling" the_index.
It is not really dangling, but it is not part of the_repository any more
and many places still use the_index, it might make up for interesting
bugs?

What is your use case of repo_clear(the_repository)?

Thanks,
Stefan
