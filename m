From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/41] usage.c: move format processing out of die_errno()
Date: Sun, 1 May 2016 14:23:34 -0400
Message-ID: <CAPig+cQhQ2C-gOuQwJ9RBXM7HBBJkWORfRkq-t-PY=vvxgAonA@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462101297-8610-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aww1s-00023H-U7
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 20:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbcEASXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 14:23:35 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36704 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcEASXf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 14:23:35 -0400
Received: by mail-ig0-f195.google.com with SMTP id c3so7551412igl.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=phF9BQk+rcXxbfsqCCTUlwJx97Ticb/mhDbMX6RoUjI=;
        b=sBJWy3kfpAIP6HwaMrSL1Ds797d6PE5ZtCBN6a3xMHSgnNdSzFjGHEdbyaIA6pAljC
         wE/mDnDlVjopeYz6tjRf9lxeQCYjFLiTooheN8VO3kDaW+PROiJ0n0Sl9kDwBgD5nmRJ
         stx9ZVNQO9cdf9qV0P64DNQhk24z+omAB22Q+MMC4fztSrsRczqsusFGJ21JkB79qhTN
         pA7P11q5CV/894V28Ig7vGJgzSCZjOOGLjMcoONQbAFg7tqvKKJ6bGtCBlXd+QA9SVMr
         jHNx23+kujd51WPdy7M/jp4UbOv36kazHIGoc2nnwJdpE/uU3QDrRvNT07c+fJOidVdX
         zr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=phF9BQk+rcXxbfsqCCTUlwJx97Ticb/mhDbMX6RoUjI=;
        b=aeaPGUFTTG0Yloxsq6gnPzXITAlurNYPNOuesa1m3BKcPEO+StLVJ9pH4CzJHT7AF3
         SxtjsRCr+Lt8aAghfkHpkHUSvbnyaUrQpuaKE6w90DR1K45UdaQUj8EvKSdfepLZjB7f
         ReOARjv/y2SQo9NW0xWJm0swHB11sAt6L1w/aiqH/FUYb8FCTZeqM2JdgMdgxHmoKieG
         7rekuS2A810uFaKJ3Rt38fvhazrXEdFu2l3jFKuBhIP2SZHCP+lOHe91Du3Mg7VXOa9Y
         tOz/MAByh5vu2P+ozF6l3V6WdGj7nxU7skNI0QnzkC1E3S2O1YXhfw4sI0xs2ws9YUsL
         G+0w==
X-Gm-Message-State: AOPr4FUtHHx+UCgm8otCpkRHloQaxwGyHKdMEnWpjfi7FX6dalb45CaENImBl+mcNyiC91OZoWK/I0YOsdiDkQ==
X-Received: by 10.50.36.9 with SMTP id m9mr16609184igj.91.1462127014181; Sun,
 01 May 2016 11:23:34 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 11:23:34 -0700 (PDT)
In-Reply-To: <1462101297-8610-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: jn9HwmAFxZRS0PbmktfwIFFRVhk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293201>

On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> fmt_with_err() will be shared with the coming error_errno() and
> warning_errno().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/usage.c b/usage.c
> @@ -109,19 +109,12 @@ void NORETURN die(const char *err, ...)
> -void NORETURN die_errno(const char *fmt, ...)
> +static const char *fmt_with_err(const char *fmt)
>  {
> -       va_list params;
> -       char fmt_with_err[1024];
> +       static char fmt_with_err[1024];

Rather than this static buffer, did you consider having the caller
pass in the buffer?

    static const char *fmt_with_err(char *buf, size_t n, const char *fm=
t)
    {
        ...
        snprintf(buf, n, "%s: %s", fmt, str_error);
        return buf;
    }

    void die_errno(const char *fmt, ...)
    {
        char fmtbuf[1024];
        ...
        die_routine(fmt_with_err(fmtbuf, sizeof(fmtbuf), fmt),
            params);
        ...
    }

Better? Worse? Indifferent?

>         char str_error[256], *err;
>         int i, j;
>
> -       if (die_is_recursing()) {
> -               fputs("fatal: recursion detected in die_errno handler=
\n",
> -                       stderr);
> -               exit(128);
> -       }
> -
>         err =3D strerror(errno);
>         for (i =3D j =3D 0; err[i] && j < sizeof(str_error) - 1; ) {
>                 if ((str_error[j++] =3D err[i++]) !=3D '%')
> @@ -137,9 +130,21 @@ void NORETURN die_errno(const char *fmt, ...)
>         }
>         str_error[j] =3D 0;
>         snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, s=
tr_error);
> +       return fmt_with_err;
> +}
> +
> +void NORETURN die_errno(const char *fmt, ...)
> +{
> +       va_list params;
> +
> +       if (die_is_recursing()) {
> +               fputs("fatal: recursion detected in die_errno handler=
\n",
> +                       stderr);
> +               exit(128);
> +       }
>
>         va_start(params, fmt);
> -       die_routine(fmt_with_err, params);
> +       die_routine(fmt_with_err(fmt), params);
>         va_end(params);
>  }
