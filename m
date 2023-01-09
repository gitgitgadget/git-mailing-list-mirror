Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE3BC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjAIS6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbjAIS6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:58:23 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9F373B1
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:58:10 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k2so4664643qkk.7
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzgHSoKvqUhHejw7M6nx5ZEjRowGHV7LUfOkP+KyoEs=;
        b=eUCtQjis4EHvnhwpSMILnzejsIzMEjlUm68y1odajdEa8vpVxPE5b/Wii84Nggoajq
         HQAjLfV1ogX38BZEq7TfGzSxdt6jTb42sHEbbUZ3McN7b8Gzsg7kStVVOc9CfOYpJMZs
         6eCiF+xBSz272Z3+kOEIn1RyZKweAdFU+VdhNPshVXI7zDlPzudciDWQD1ravK+kR265
         Fka5vbtsj6xiBBCpj8A9EZIH7sFM24T74m+HqwrzybW2K2sXh0oku5a+Id4pvJzp6ctl
         aKFT+MqdcahDvEttlwVnPkzNR0Qs/VdmGeqiuSpuAJl6O6O679B7MTN1sKZxKeSd5pD5
         TH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzgHSoKvqUhHejw7M6nx5ZEjRowGHV7LUfOkP+KyoEs=;
        b=lCrkp0gCgqirf/I5EsmjZIXIaxJUN7ftdony8eYecOzRfXy3xsXvCIx0eBLiC994ip
         WgE7+oCYrsYmpv0UL2VUrKKyzdReWONZQRVQ3QcCuiy3v+c6MXCuYtmFSkuyIyZAY93G
         kq5zjE3obQFsA2pN0e7jCykSJmGc/WCn6t/fKbLNfrl1M1O80MAN9mB0IQdZBgf95Kxp
         sqU6TVO9oIvfqCRyP6LO1f+tte9u/y0gCkxNMrVlD4muxmfkpLrp7aYHMv5vLd++H91F
         cD1YMdvNMTJXA8N6aaUdtNzCQzEecmNUcO2bSd3n6WWPfq8mZ60/3kKgt9U98gCX3Moj
         jkRg==
X-Gm-Message-State: AFqh2kojqh++p5MKxzeYR8Ig4UDrAnxznP+LuhaTtQUHgvTdlYeVfS/w
        AfqRFW01Q2+gGVQcJKD1MGMXhx/I0CPoJC4LAtW7FYuQcfQ=
X-Google-Smtp-Source: AMrXdXsDs4tKmdioP1yoASqOAsuF/0O7qTt/9ZZnZGYfyUPTx+r/zTUvz3x6eyIJE6gS8a6qbPonzl8tZYQttfkJhkE=
X-Received: by 2002:a05:620a:191f:b0:702:4519:496b with SMTP id
 bj31-20020a05620a191f00b007024519496bmr2848316qkb.619.1673290689402; Mon, 09
 Jan 2023 10:58:09 -0800 (PST)
MIME-Version: 1.0
References: <Y7v6jThT9GQ8Oav8@danh.dev> <20230109122915.30973-1-congdanhqx@gmail.com>
In-Reply-To: <20230109122915.30973-1-congdanhqx@gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 9 Jan 2023 10:57:58 -0800
Message-ID: <CABURp0o5hhr0u+=4w0u4dPphFXS0gM4W_QtX+2hLLb0v3ErnJg@mail.gmail.com>
Subject: Re: [PATCH] date.c: limit less precision ISO-8601 with its marker
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, plavarre@purestorage.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 4:29 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <=
congdanhqx@gmail.com> wrote:
>
> The newly added heuristic to parse less precision ISO-8601 conflicts
> with other heuristics to parse datetime-strings. E.g.:
>
>         Thu, 7 Apr 2005 15:14:13 -0700
>
> Let's limit the new heuristic to only datetime string with a 'T'
> followed immediately by some digits, and if we failed to parse the
> upcoming string, rollback the change.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>
> Here is a better thought out change, which tried to minimize the impact o=
f
> new heuristics.
>
> While I think it's a fixup, but I still needs explaination, I think I may
> reword it's as a full patch instead.
> Range-diff:
> 1:  4036e5a944 ! 1:  b703425a57 fixup! date.c: allow ISO 8601 reduced pre=
cision times
>     @@ Metadata
>      Author: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
>
>       ## Commit message ##
>     -    fixup! date.c: allow ISO 8601 reduced precision times
>     +    date.c: limit less precision ISO-8601 with its marker
>     +
>     +    The newly added heuristic to parse less precision ISO-8601 confl=
icts
>     +    with other heuristics to parse datetime-strings. E.g.:
>     +
>     +            Thu, 7 Apr 2005 15:14:13 -0700
>     +
>     +    Let's limit the new heuristic to only datetime string with a 'T'
>     +    followed immediately by some digits, and if we failed to parse t=
he
>     +    upcoming string, rollback the change.
>
>          Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congd=
anhqx@gmail.com>
>
>     @@ date.c: static int match_alpha(const char *date, struct tm *tm, in=
t *offset)
>         }
>
>      +  /* ISO-8601 allows yyyymmDD'T'HHMMSS, with less precision */
>     -+  if (*date =3D=3D 'T' && isdigit(date[1])) {
>     -+          tm->tm_hour =3D tm->tm_min =3D tm->tm_sec =3D 0;
>     -+          return strlen("T");
>     ++  if (*date =3D=3D 'T' && isdigit(date[1]) && tm->tm_hour =3D=3D -1=
) {
>     ++          tm->tm_min =3D tm->tm_sec =3D 0;
>     ++          return 1;
>      +  }
>      +
>         /* BAD CRAP */
>     @@ date.c: static inline int nodate(struct tm *tm)
>      - * We just do a binary 'and' to see if the sign bit
>      - * is set in all the values.
>      + * Have we seen an ISO-8601-alike date, i.e. 20220101T0,
>     -+ * In those special case, those fields have been set to 0
>     ++ * In which, hour is still unset,
>     ++ * and minutes and second has been set to 0.
>        */
>      -static inline int notime(struct tm *tm)
>      +static inline int maybeiso8601(struct tm *tm)
>     @@ date.c: static inline int nodate(struct tm *tm)
>      -  return (tm->tm_hour &
>      -          tm->tm_min &
>      -          tm->tm_sec) < 0;
>     -+  return tm->tm_hour =3D=3D 0 &&
>     ++  return tm->tm_hour =3D=3D -1 &&
>      +          tm->tm_min =3D=3D 0 &&
>      +          tm->tm_sec =3D=3D 0;
>       }
>
>       /*
>      @@ date.c: static int match_digit(const char *date, struct tm *tm, i=
nt *offset, int *tm_gmt
>     -   /* 4 digits, compact style of ISO-8601's time: HHMM */
>     -   /* 2 digits, compact style of ISO-8601's time: HH */
>     -   if (n =3D=3D 8 || n =3D=3D 6 ||
>     +
>     +   /* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
>     +   /* 6 digits, compact style of ISO-8601's time: HHMMSS */
>     +-  /* 4 digits, compact style of ISO-8601's time: HHMM */
>     +-  /* 2 digits, compact style of ISO-8601's time: HH */
>     +-  if (n =3D=3D 8 || n =3D=3D 6 ||
>      -          (!nodate(tm) && notime(tm) &&
>     -+          (!nodate(tm) && maybeiso8601(tm) &&
>     -           (n =3D=3D 4 || n =3D=3D 2))) {
>     +-          (n =3D=3D 4 || n =3D=3D 2))) {
>     ++  if (n =3D=3D 8 || n =3D=3D 6) {
>                 unsigned int num1 =3D num / 10000;
>                 unsigned int num2 =3D (num % 10000) / 100;
>     +           unsigned int num3 =3D num % 100;
>     +@@ date.c: static int match_digit(const char *date, struct tm *tm, i=
nt *offset, int *tm_gmt
>     +           else if (n =3D=3D 6 && set_time(num1, num2, num3, tm) =3D=
=3D 0 &&
>     +                    *end =3D=3D '.' && isdigit(end[1]))
>     +                   strtoul(end + 1, &end, 10);
>     +-          else if (n =3D=3D 4)
>     +-                  set_time(num2, num3, 0, tm);
>     +-          else if (n =3D=3D 2)
>     +-                  set_time(num3, 0, 0, tm);
>     +           return end - date;
>     +   }
>     +
>     ++  /* reduced precision of ISO-8601's time: HHMM or HH */
>     ++  if (maybeiso8601(tm)) {
>     ++          unsigned int num1 =3D num;
>     ++          unsigned int num2 =3D 0;
>     ++          if (n =3D=3D 4) {
>     ++                  num1 =3D num / 100;
>     ++                  num2 =3D num % 100;
>     ++          }
>     ++          if ((n =3D=3D 4 || n =3D=3D 2) && !nodate(tm) &&
>     ++              set_time(num1, num2, 0, tm) =3D=3D 0)
>     ++                  return n;
>     ++          /*
>     ++           * We thought this is an ISO-8601 time string,
>     ++           * we set minutes and seconds to 0,
>     ++           * turn out it isn't, rollback the change.
>     ++           */
>     ++          tm->tm_min =3D tm->tm_sec =3D -1;
>     ++  }
>     ++
>     +   /* Four-digit year or a timezone? */
>     +   if (n =3D=3D 4) {
>     +           if (num <=3D 1400 && *offset =3D=3D -1) {
>
>       ## t/t0006-date.sh ##
>      @@ t/t0006-date.sh: check_parse '20080214T20:30' '2008-02-14 20:30:0=
0 +0000'
>
>  date.c          | 49 +++++++++++++++++++++++++++++++++----------------
>  t/t0006-date.sh |  3 ++-
>  2 files changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/date.c b/date.c
> index b011b9d6b3..6f45eeb356 100644
> --- a/date.c
> +++ b/date.c
> @@ -493,6 +493,12 @@ static int match_alpha(const char *date, struct tm *=
tm, int *offset)
>                 return 2;
>         }
>
> +       /* ISO-8601 allows yyyymmDD'T'HHMMSS, with less precision */
> +       if (*date =3D=3D 'T' && isdigit(date[1]) && tm->tm_hour =3D=3D -1=
) {
> +               tm->tm_min =3D tm->tm_sec =3D 0;
> +               return 1;
> +       }
> +
>         /* BAD CRAP */
>         return skip_alpha(date);
>  }
> @@ -639,15 +645,15 @@ static inline int nodate(struct tm *tm)
>  }
>
>  /*
> - * Have we filled in any part of the time yet?
> - * We just do a binary 'and' to see if the sign bit
> - * is set in all the values.
> + * Have we seen an ISO-8601-alike date, i.e. 20220101T0,
> + * In which, hour is still unset,
> + * and minutes and second has been set to 0.
>   */
> -static inline int notime(struct tm *tm)
> +static inline int maybeiso8601(struct tm *tm)
>  {
> -       return (tm->tm_hour &
> -               tm->tm_min &
> -               tm->tm_sec) < 0;
> +       return tm->tm_hour =3D=3D -1 &&
> +               tm->tm_min =3D=3D 0 &&
> +               tm->tm_sec =3D=3D 0;
>  }
>
>  /*
> @@ -701,11 +707,7 @@ static int match_digit(const char *date, struct tm *=
tm, int *offset, int *tm_gmt
>
>         /* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
>         /* 6 digits, compact style of ISO-8601's time: HHMMSS */
> -       /* 4 digits, compact style of ISO-8601's time: HHMM */
> -       /* 2 digits, compact style of ISO-8601's time: HH */
> -       if (n =3D=3D 8 || n =3D=3D 6 ||
> -               (!nodate(tm) && notime(tm) &&
> -               (n =3D=3D 4 || n =3D=3D 2))) {
> +       if (n =3D=3D 8 || n =3D=3D 6) {
>                 unsigned int num1 =3D num / 10000;
>                 unsigned int num2 =3D (num % 10000) / 100;
>                 unsigned int num3 =3D num % 100;
> @@ -714,13 +716,28 @@ static int match_digit(const char *date, struct tm =
*tm, int *offset, int *tm_gmt
>                 else if (n =3D=3D 6 && set_time(num1, num2, num3, tm) =3D=
=3D 0 &&
>                          *end =3D=3D '.' && isdigit(end[1]))
>                         strtoul(end + 1, &end, 10);
> -               else if (n =3D=3D 4)
> -                       set_time(num2, num3, 0, tm);
> -               else if (n =3D=3D 2)
> -                       set_time(num3, 0, 0, tm);
>                 return end - date;
>         }
>
> +       /* reduced precision of ISO-8601's time: HHMM or HH */
> +       if (maybeiso8601(tm)) {
> +               unsigned int num1 =3D num;
> +               unsigned int num2 =3D 0;
> +               if (n =3D=3D 4) {
> +                       num1 =3D num / 100;
> +                       num2 =3D num % 100;
> +               }
> +               if ((n =3D=3D 4 || n =3D=3D 2) && !nodate(tm) &&
> +                   set_time(num1, num2, 0, tm) =3D=3D 0)
> +                       return n;
> +               /*
> +                * We thought this is an ISO-8601 time string,
> +                * we set minutes and seconds to 0,
> +                * turn out it isn't, rollback the change.
> +                */
> +               tm->tm_min =3D tm->tm_sec =3D -1;
> +       }
> +
>         /* Four-digit year or a timezone? */
>         if (n =3D=3D 4) {
>                 if (num <=3D 1400 && *offset =3D=3D -1) {
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 16fb0bf4bd..130207fc04 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -93,7 +93,8 @@ check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000=
'
>  check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
>  check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
>  check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
> -check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
> +check_parse '20080214T000000.20' '2008-02-14 00:00:00 +0000'
> +check_parse '20080214T00:00:00.20' '2008-02-14 00:00:00 +0000'
>  check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
>  check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
>  check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
> --
> 2.39.0.287.g690a66fa66
>

Thanks, =C4=90o=C3=A0n.  LGTM, and much safer.
