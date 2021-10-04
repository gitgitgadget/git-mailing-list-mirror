Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63718C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4755561184
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhJDN4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhJDN4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6BC0619C0
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p11so12121916edy.10
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gZKS78GyuCr7oN+oL9tpIH8hYAWx18+hbevEU85m2Qg=;
        b=RraT2/7EsQ4KVaODhNHZj1+VKprJCQfQzO0VTgVzRPan/ir0x9+CNwqZbCuCjlNGvA
         RJWtMCXFrOPjt1AkTAyeDehqX7zKmm6jh+DIQgJzuDUpyjJ1YrJiqsufFSajDCpLo+iP
         dtXzjF4qSRx6OMXuO+HIBnYvlV+u2oRRhXjsT6UZYLc28vO+HNIfyV4nFkc7D8DNVB8e
         sl7y9U7OCA6O2yqml6NZnnQy1nMWjrOsgL0+EuwBc9NaIXxV7okK0/n/lojenmi685lF
         VcVw0mXgKGsx22pIjYNqudBAnx0X7UnF+D40qCG0+1CCAHbbMQqZRFxOhNtyPWMKIa92
         CUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gZKS78GyuCr7oN+oL9tpIH8hYAWx18+hbevEU85m2Qg=;
        b=hztIQs756N/kUf7PbOALjJj2jZdsZBnEdG4bG4ISRInDTy3ljM8SSIqcRg5ijiYHWd
         ur9WO5lfMLa3SdBko1WOqinsKY0wO0dHNfPfyfnvVn0yaRarA6TZcDb82TrZMnDU7Gd0
         46X05W8RQR/QMhNFjBBMQADS7wiOLQY+6mAw0Mq/oHPvrgBJWRg6GpNTn+js3hWP76eT
         Yfb7+YA9cBGPj6ob6VoQ6SnIjQJm5FYTsy73/5C4gJX/ygKWKdb+bNti9+OjLpDFmPyR
         9XltMcAJjvxTeVQD7wTE9UzToF1y2utQSxma4RKcfGiLWpFqGIrxjvdyyPl26ep2Tdu2
         KZ4w==
X-Gm-Message-State: AOAM532iIowg6Ose62qqfMMKZAmxQA619UGTUsHcISSWnUUvwB5A5XOH
        /AqIgg1e9AX7H4iaG5Jxu1gHB+sa7RxcpAAc8xU=
X-Google-Smtp-Source: ABdhPJxb1xBJgWdRgSDELa/Kt98UJvzTsZh99fjNf8a0AgXSaPsf8RESjvNIesd+hlS18UpDVStJ26Fxvkq+ZyDoAIU=
X-Received: by 2002:a05:6402:1848:: with SMTP id v8mr15764714edy.0.1633355103282;
 Mon, 04 Oct 2021 06:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-09.10-aa2bec76f6e-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-09.10-aa2bec76f6e-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BHqzRXxatAuMn8rNDPSuN5nAWJFVNziLL3+LS+YJ98V-w@mail.gmail.com>
Subject: Re: [PATCH 09/10] merge.c: avoid duplicate unpack_trees_options_release()
 code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Refactor code added in 1c41d2805e4 (unpack_trees_options: free
> messages when done, 2018-05-21) to use a ret/goto pattern, rather than
> duplicating the end cleanup in the function.
>
> This control flow will be matched in subsequent commits by various
> other similar code, which often needs to do more than just call
> unpack_trees_options_release(). Let's change this to consistently use
> the same pattern everywhere.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  merge.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/merge.c b/merge.c
> index 2f618425aff..2e3714ccaa0 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -54,6 +54,7 @@ int checkout_fast_forward(struct repository *r,
>         struct tree_desc t[MAX_UNPACK_TREES];
>         int i, nr_trees =3D 0;
>         struct lock_file lock_file =3D LOCK_INIT;
> +       int ret =3D 0;
>
>         refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
>
> @@ -95,12 +96,14 @@ int checkout_fast_forward(struct repository *r,
>
>         if (unpack_trees(nr_trees, t, &opts)) {
>                 rollback_lock_file(&lock_file);
> -               unpack_trees_options_release(&opts);
> -               return -1;
> +               ret =3D -1;
> +               goto cleanup;
>         }
> -       unpack_trees_options_release(&opts);
>
>         if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
> -               return error(_("unable to write new index file"));
> -       return 0;
> +               ret =3D error(_("unable to write new index file"));
> +
> +cleanup:
> +       unpack_trees_options_release(&opts);
> +       return ret;
>  }
> --
> 2.33.0.1404.g83021034c5d

I would say 'meh'...but the commit message is downright confusing.  It
suggests that subsequent commits, plural, will be modifying this code
further.  There is only one more commit in this series, and looking
ahead, it doesn't even touch this file.  So, there actually isn't any
reason for these changes beyond what we see in this file, at least not
for this series.  And as far as this series is concerned, I think it's
actually less readable.  If there's a subsequent series that will use
this and make further changes I could be convinced, but then I'd say
this commit belongs as part of the later series, not this one.
