Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28F51F403
	for <e@80x24.org>; Mon, 11 Jun 2018 15:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeFKPDD (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 11:03:03 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35531 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeFKPDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 11:03:02 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so10296593uad.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gbvGA20C107ykdcQh7KUhAdMmgsaBwejlGFQnBTa9Rc=;
        b=fUwsRId4faISVHuLScH7W2wqUhmKDfSggDY/AcmHTc1ESuF3ZNd4oIq1XGmEGbJxbs
         sBpdm7GlckWubkiBkPnNHWPgGvvD2rlmIH2947RhGAGlI1XM/BdRF6+Us2elmhTbSYqe
         ObvBjgbvsgigoPfdQ2IvYZ1JQV3Y7VbIraqAV83cZzNW1Log2h+fnmiKHwkSkzsNZBPa
         NMYW66tGv66iXNgDfKITE0j8ol1A7rTbD+Gs6xxTYa5oVgJ3YCCJkfK4WuO9bsRPEtmd
         ER7w4cmQ4eoW7dQnkJgvWgtxD2KJkKyZoIj1hdP2qTyWOgtFfepjOlaItGaDsuNWl2FZ
         kZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gbvGA20C107ykdcQh7KUhAdMmgsaBwejlGFQnBTa9Rc=;
        b=Rhqh653Y1IkUfaFhS+dz5oJ93P9bGspIuATI9Kxx/D+N0SSc0hvb9yJ6YBww483Qtp
         ak7g4GsSeRk644/KFziK111hwiq/FxPvehQCiRl+lwGJSka0YOkzwcneDosgWEiSHEF4
         XcBkkNm5dOA74TK/R+nLqQbkHXQU8Np1ZaDcYBD5CASBade8JRsd9bVq+J+mpbplHLke
         xamzaP6vDFSa9QaLnmG4XbNS41OHKLxnUUcmEeqMW+01Fslqd9+/RKmgPIy38ITkrQXh
         FZiVYcy8JAGJogmMK1YFYrpg8JhHN9Ps2IG4TgwtZeSx1KmrLYsLY1l6KkdvMAaoJTp+
         jy5A==
X-Gm-Message-State: APt69E12gEeK6T23uoBeP340Y1fpks6IA+mqTDTlsfkDzD6hHAfMZ4K1
        NpVZs+miR4B7NNAFwju5Ku5fZehVr6utY71LoVI=
X-Google-Smtp-Source: ADUXVKINU7h1+tXHwpZ+REUJFpUiS1Ogsvkg9iE08HgXSZOWIuXBptp5pwFrlYdKeAvyf9kwGLnLwAC5WtYNyy83av0=
X-Received: by 2002:ab0:1723:: with SMTP id j35-v6mr11701656uaf.154.1528729381423;
 Mon, 11 Jun 2018 08:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 08:03:00
 -0700 (PDT)
In-Reply-To: <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-25-newren@gmail.com>
 <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 08:03:00 -0700
Message-ID: <CABPp-BF3gUf_hzUNXtXdyv01R1hQzLCKdRgb+iKPnBgLYi6d+Q@mail.gmail.com>
Subject: Re: [PATCH 24/30] merge-recursive: Add computation of collisions due
 to dir rename & merging
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 3:56 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 10.11.2017 um 20:05 schrieb Elijah Newren:
>> +static struct dir_rename_entry *check_dir_renamed(const char *path,
>> +                                               struct hashmap *dir_rena=
mes) {
>> +     char temp[PATH_MAX];
>> +     char *end;
>> +     struct dir_rename_entry *entry;
>> +
>> +     strcpy(temp, path);
>> +     while ((end =3D strrchr(temp, '/'))) {
>> +             *end =3D '\0';
>> +             entry =3D dir_rename_find_entry(dir_renames, temp);
>> +             if (entry)
>> +                     return entry;
>> +     }
>> +     return NULL;
>> +}
>
> The value of PATH_MAX is platform-dependent, so it's easy to exceed when
> doing cross-platform development.  It's also not a hard limit on most
> operating systems, not even on Windows.  Further reading:
>
>    https://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html
>
> So using a fixed buffer is not a good idea, and writing to it without
> checking is dangerous.  Here's a fix:

Thanks for the pointers, and for providing a fix.

> -- >8 --
> Subject: [PATCH] merge-recursive: use xstrdup() instead of fixed buffer
>
> Paths can be longer than PATH_MAX.  Avoid a buffer overrun in
> check_dir_renamed() by using xstrdup() to make a private copy safely.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  merge-recursive.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index ac27abbd4c..db708176c5 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2211,18 +2211,18 @@ static struct hashmap *get_directory_renames(stru=
ct diff_queue_struct *pairs,
>  static struct dir_rename_entry *check_dir_renamed(const char *path,
>                                                   struct hashmap *dir_ren=
ames)
>  {
> -       char temp[PATH_MAX];
> +       char *temp =3D xstrdup(path);
>         char *end;
> -       struct dir_rename_entry *entry;
> +       struct dir_rename_entry *entry =3D NULL;;
>
> -       strcpy(temp, path);
>         while ((end =3D strrchr(temp, '/'))) {
>                 *end =3D '\0';
>                 entry =3D dir_rename_find_entry(dir_renames, temp);
>                 if (entry)
> -                       return entry;
> +                       break;
>         }
> -       return NULL;
> +       free(temp);
> +       return entry;
>  }
>
>  static void compute_collisions(struct hashmap *collisions,
> --
> 2.17.1

Reviewed-by: Elijah Newren <newren@gmail.com>
