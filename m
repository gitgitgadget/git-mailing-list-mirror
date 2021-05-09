Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40FC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DB6613B6
	for <git@archiver.kernel.org>; Sun,  9 May 2021 14:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhEIOOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhEIOOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 10:14:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B7C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 07:13:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id t3so12340819iol.5
        for <git@vger.kernel.org>; Sun, 09 May 2021 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LBr3mQaB+gYL+G7HcnJRNq6JYGcwk+Mw6yXDkwIH9SI=;
        b=IJhzWfFyADIUEkSKYtSxe/NkI6oGnspoCFcvzknjqFgE3gnMEWm0SzsFWqQyF7+BEO
         68n2q8tnN4nrebXYXG+HiUXW3j1Jzj17w2O3lSjD2a8wEwhpsy29xYy/UM3wKA+3DhjD
         GC+BG44FTFPugnx+pzf8Lt2v68SwbvnkiYQOs7neQuWFNDrdQK232ahQFVOlsN3ye+2e
         /JpejZmVp+Qd1+kE5qmqQu/Ba5yVnBTTSAnFQeXFkKriK5WTVFa0tp9k23hIPR+H9LO6
         1YLQtB8MCWIPzQ90311ceuH7Pnxig4ZaAMjSyoU0muVyP0r9vheiC1FZ3JjxkwD7FK1i
         sMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LBr3mQaB+gYL+G7HcnJRNq6JYGcwk+Mw6yXDkwIH9SI=;
        b=t+8dss5RJLZdGZ7IKF0IXa7dqrmMX30MTitzASIWepNTc5fWWglrKQMyBDyfDRxHST
         cPZ9qHB+9mrdMPtx3ld4s854JfGdxb3Dfu4PyfDJQ6zQILejLXdGDWipgHOhGQgoZ0G3
         XIrhpcO3hXaLHaEbTsOEsOgXU4kiU6ZeAni9EYSovhivXCmQu4vQKrcXl8bHjL24INCe
         doYqVeSdLsKg3brf6PUTC7X0VaOa38S/LbAwvhF7MOYJyV9E7XUX8N2DQCUJq1oCVZ/9
         KTGF48FjuRSVkbw3CKHGjrODalzY7bqbyZtXLmRnxpiVjuCntZFXc+nYziyXzFsWV4Dd
         WM8g==
X-Gm-Message-State: AOAM531gHs3384v2PRejCE0xoBIA20nqIR47balNw1xS3pEMS7ooDkoK
        msanr2okiS+31v84hKelW2Ody8R9Jatyq6SFFfj/N2O2mHtsjQ==
X-Google-Smtp-Source: ABdhPJz5cGBMGXJVi+PnT+aefAJ5yrn821hS2Rw1VcHbwDCw7fQxFWKpX6e164UT18yakjGrel8hMr+iv1ESA9B4YJM=
X-Received: by 2002:a02:a182:: with SMTP id n2mr17067108jah.29.1620569626005;
 Sun, 09 May 2021 07:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620551314.git.martin.agren@gmail.com> <3d06c3beee0299db369f1dd859b092d529bd6846.1620551314.git.martin.agren@gmail.com>
In-Reply-To: <3d06c3beee0299db369f1dd859b092d529bd6846.1620551314.git.martin.agren@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 9 May 2021 22:13:34 +0800
Message-ID: <CAOLTT8R2ACJtcL7esLd8AiSu22Wn2hrdVTwub-HXc-eT_U2-+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pretty-formats.txt: add missing space
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=88=
9=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=885:10=E5=86=99=E9=81=93=EF=BC=
=9A
>
> The description of "%ch" is missing a space after "human style", before
> the parenthetical remark. This description was introduced in b722d4560e
> ("pretty: provide human date format", 2021-04-25). That commit also
> added "%ah", which does have the space already.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-form=
ats.txt
> index cd697f508c..58bb279528 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -208,7 +208,7 @@ The placeholders are:
>  '%ci':: committer date, ISO 8601-like format
>  '%cI':: committer date, strict ISO 8601 format
>  '%cs':: committer date, short format (`YYYY-MM-DD`)
> -'%ch':: committer date, human style(like the `--date=3Dhuman` option of
> +'%ch':: committer date, human style (like the `--date=3Dhuman` option of
>         linkgit:git-rev-list[1])
>  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>  '%D':: ref names without the " (", ")" wrapping.
> --
> 2.31.1.751.gd2f1c929bd
>

Sorry, but in here:[1], I have fixed this space missing error.

Junio, this patch have not been merged to master?

[1]: https://lore.kernel.org/git/pull.939.v4.git.1620056221874.gitgitgadget=
@gmail.com/
