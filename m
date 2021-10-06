Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12035C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC1A61019
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJFQjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFQjv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:39:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52464C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 09:37:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r18so12154708edv.12
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j9kn7ux0s5il+1rSwprFsifxliXlyS3SOF3tEveI8MM=;
        b=j8CQpNmspW9PvQV09luRn01EfBhZqHtyLzqmBhlIpTbjI4sYGGkl2tSdiy65XGMDtX
         MeG5/ytTXcdnA4M/1HUOgwCzkVQGNdv7IVWPg5ZaDQERpvQ2sW5jyzLY49eATDXqlSsr
         nVvejJVoRJCoHnjkfvxlZxKUqU6lOnbWNVQgtUQFXzTEWxKD6OqELTtks4ZV8uQSQyk5
         T/WAQAu6dFcfvmcOmWSEmlhAcsMApuMe94RPmwymlgRNaq9TDjeH2UpgsmKEUqK/ANhX
         PIEpQ3BYjzceQwIK+jRGoGSWEWxPwCB4Q5MKgz9z1gyIyTJDzZk2N+u0a4XiyPJmGuhu
         rRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j9kn7ux0s5il+1rSwprFsifxliXlyS3SOF3tEveI8MM=;
        b=mVMwqg88gqIi8zDSEzWCqyBuSHJHmvtXMm0QzDcrXUJsnRT3LVk0+YepOpjPISe0Wj
         5pGyIHRYodaSG+jlwLD/B2LDvDLXweFeUy3NaJ8ncZhkZqM3Mti41h7OxveMbp46hgo2
         7edDXhDKU6QLm+96RDPX5ecRa+v8ql6oE2jggq5qc/1osdQHufql1kXOn2MvhYaAB5Sd
         fLA6pC7fP5UgCotKhgx6U+FG1BtDVORQP34mt4Cj3sDg4nOpuEJr+Ss0UF153ybTquG9
         VGaE9SVGiIec4dyfrhEW99NIrTiHY5N3Vt3INjy9CMlxEsjlmMxM5Fh1PAk/sSbGLzIV
         AVeA==
X-Gm-Message-State: AOAM532AgXqz/wRJvZVEs4GWce614zUN5firnY+kGZmoMtpQKGpDRxwb
        0XznQBX+qJqQU/etAua4nnbdDdVH4QYrKrzr8jBYrjoO5ZQ=
X-Google-Smtp-Source: ABdhPJzV8uEuEAj1o86LcF18IkdiTGHHMLKpD8emzxwoFkEVFnrvDog6LuhI6wqRO2sPmRCGI/qccgMkQnWgfr7m80g=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr33773453ejp.520.1633538277850;
 Wed, 06 Oct 2021 09:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <patch-2.7-c24e115aa49-20211006T095426Z-avarab@gmail.com>
In-Reply-To: <patch-2.7-c24e115aa49-20211006T095426Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 09:37:46 -0700
Message-ID: <CABPp-BFgsAKX1nxaX5Rk0XvOjsSxUveEXbqRgrm3n_ZG4Skd7g@mail.gmail.com>
Subject: Re: [PATCH 2/7] tests: fix a memory leak in test-parse-options.c
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 3:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Fix a memory leak in t/helper/test-parse-options.c, we were not
> freeing the allocated "struct string_list" or its items. While I'm at
> it move the declaration of the "list" string_list the
> cmd__parse_options() function.

missing verb after the final "string_list"?  I'm having trouble
parsing this paragraph.

> In c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
> the "list" variable was added, and later on in
> c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
> the "expect" was added.
>
> The "list" variable was last touched in 2721ce21e43 (use string_list
> initializer consistently, 2016-06-13), but it was still left at the
> static scope, it's better to move it to the function for consistency.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/helper/test-parse-options.c | 7 ++++++-
>  t/t0040-parse-options.sh      | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.=
c
> index a282b6ff13e..48d3cf6692d 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -14,7 +14,6 @@ static int dry_run =3D 0, quiet =3D 0;
>  static char *string =3D NULL;
>  static char *file =3D NULL;
>  static int ambiguous;
> -static struct string_list list =3D STRING_LIST_INIT_NODUP;
>
>  static struct {
>         int called;
> @@ -107,6 +106,8 @@ int cmd__parse_options(int argc, const char **argv)
>                 NULL
>         };
>         struct string_list expect =3D STRING_LIST_INIT_NODUP;
> +       struct string_list list =3D STRING_LIST_INIT_NODUP;
> +
>         struct option options[] =3D {
>                 OPT_BOOL(0, "yes", &boolean, "get a boolean"),
>                 OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
> @@ -185,5 +186,9 @@ int cmd__parse_options(int argc, const char **argv)
>         for (i =3D 0; i < argc; i++)
>                 show(&expect, &ret, "arg %02d: %s", i, argv[i]);
>
> +       expect.strdup_strings =3D 1;
> +       string_list_clear(&expect, 0);
> +       string_list_clear(&list, 0);
> +
>         return ret;
>  }
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index da310ed29b1..ed422a1a616 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -5,6 +5,7 @@
>
>  test_description=3D'our own option parser'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  cat >expect <<\EOF
> --
> 2.33.0.1441.gbbcdb4c3c66

Otherwise, looks good.
