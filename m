Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90280C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 08:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjFAIk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjFAIjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 04:39:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790618F
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 01:39:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9700219be87so70743266b.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685608769; x=1688200769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqIUamrYDg/VQEZehKz40m/wClnroy9PCXYjv3MebtE=;
        b=XcOJxJ+u2sXweZN93pAY9TkZFJ9uzLGs1Asb/2ZeLQcO7hkciPTjmhhe5xx71Dvhg7
         Wzle/cwxhTsM0Z/TJNdpdmf8jxdhimKgQhlMplZt63jb1kee0TMnKZvIZ7Z2HY2gDZGB
         JDEgQzwkFNLBIVxqvTHDl+5awfB52wYcyFDCM6Xk/LbAIAn6F6E/qZovEQl0v6Vryqqn
         qvr1fBU1/eTsIpzxICXnHTCwtSNlriyIkB4d2h4y3cP82Fgv23LhGxbX2dFJAKU7WJIc
         3WrGgmCMi5eSbf2JK4JM708F3ODr88KfhrJdjdjPHwRmBmHysYHuzRmNDq9KgGtYYdoc
         /woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608769; x=1688200769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqIUamrYDg/VQEZehKz40m/wClnroy9PCXYjv3MebtE=;
        b=ibIV5qiP+6naHuewX+Q2rbfkT0UzsrAQLl9b9+69oLQaeY0p6ATUn/7Pt2+d9ZUtzO
         dT8Zzba5lztVSR2XeZjgbKkLetKkwpKnt7dXhZD/HRk8CJJafcqYt+bmYMXggMV8MzIx
         KK5HERtJi3dsfbPby/jASv9gMvtpYZX5ecFm5qW//XvJIVxNjG5OPizLnxMDqfba11Be
         QTiKf+d7fKJViH7ZIVaQbZOs+4LylveCcsfhGtRPE0p7/FKrJuV/CYFlHY6JXdEQKBdT
         1/CpvxdaqZTigLBn7u6rui49vqFaadDxVH5sxDENrK6p8p/y8zeUIHhQ/FMCCI3J7Ae1
         cafg==
X-Gm-Message-State: AC+VfDxGU/MCy+s8X4XNwpBSGFHCxFgRo2MJQ3OwShx09w0II/G++HLo
        YoqiYbx6GvTFndtiqgrL2gOS/8oiQj0uD22eu4c=
X-Google-Smtp-Source: ACHHUZ7LeqoFDSirqHflyqxQdp7/Z0dnDfSPPtmkKC36oBqr7WJBJqoQE96bVI1VykIqxqlyw9dBvCJ3GroiHIYUm4k=
X-Received: by 2002:a17:906:fe44:b0:96f:be1e:bf1d with SMTP id
 wz4-20020a170906fe4400b0096fbe1ebf1dmr6081508ejb.69.1685608768474; Thu, 01
 Jun 2023 01:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230529192209.17747-1-five231003@gmail.com> <20230529192209.17747-2-five231003@gmail.com>
In-Reply-To: <20230529192209.17747-2-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Jun 2023 10:39:16 +0200
Message-ID: <CAP8UFD1FkUJ0t0OosendGBQWZJC6AbntN4r7GmaVNVKHwHEc=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/lib-gpg: introduce new prereq GPG2
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2023 at 9:23=E2=80=AFPM Kousik Sanagavarapu
<five231003@gmail.com> wrote:
>
> GnuPG v2.0.0 released in 2006, which according to its release notes
>
>         https://gnupg.org/download/release_notes.html
>
> is the "First stable version of GnuPG integrating OpenPGP and S/MIME".
>
> Use this version or it's successors for tests that will fail for
> versions less than v2.0.0 because of the difference in the output on
> stderr between the versions (v2.* vs v0.* or v2.* vs v1.*). Skip if
> the GPG version detected is less than v2.0.0.

Yeah, I think it's reasonable to stop worrying about the output of GPG
versions that are 17 year old.

> +test_lazy_prereq GPG2 '
> +       gpg_version=3D$(gpg --version 2>&1)
> +       test $? !=3D 127 || exit 1
> +
> +       case "$gpg_version" in
> +       !"gpg (GnuPG) 2."*)

Maybe something like `"gpg (GnuPG) 0."* | "gpg (GnuPG) 1."*)` would be
better, as it would allow versions 3.X, 4.X, etc if they are ever
released.

> +               say "This test requires a GPG version >=3D v2.0.0"
> +               exit 1
> +               ;;

> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index ccbc416402..96b316ae01 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -218,6 +218,13 @@ test_expect_success GPG 'amending already signed com=
mit' '
>         ! grep "BAD signature from" actual
>  '
>
> +test_expect_success GPG2 'bare signature' '
> +       git verify-commit fifth-signed 2>expect &&
> +       echo "" >>expect &&

We sometimes use `echo "" >` to add a new line, but we much more often
use just `echo >` for that purpose:

$ git grep 'echo >' | wc -l
339
$ git grep 'echo "" >' | wc -l
16

> +       git log -1 --format=3D"%GG" fifth-signed >actual &&
> +       test_cmp expect actual
> +'

Thanks!
