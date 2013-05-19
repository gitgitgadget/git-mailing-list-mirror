From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/9] for-each-ref: add %(color:...)
Date: Sun, 19 May 2013 16:55:25 +0530
Message-ID: <CALkWK0md2eH+=6wEWz=x-2MwmLddFD++-ctw=Oy1O5jb7KLfrA@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com> <1368959235-27777-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1kh-00036E-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab3ESL0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:26:07 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34662 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab3ESL0G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:26:06 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so12290817iec.1
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D+Uk9tI994XkWrcsrQ6zYDiYRofoWV5nm4i2n2gsHXI=;
        b=wpPts0fhDYH8z7aRLLvUx/B6AcU+7nrgtvRpI28NZopbl7R++U4EjyPLT51FZZadKP
         Y9/ytDWRk4mzsFsx+qbY8zfizC+k1TN5X6wdsHfq4k5zqJslXDxgeO1cXQvkgGlsTDJR
         6JijMunuFxMHKYSyzr6quHUUg4g4aSWrfHrC8G+YjMgw9Yn/W3ffNrYSKiGp0XOhBwIT
         mEQAuFIYeiSvesQEjmzAwB2tA8N+JNbFB1SdbnCjkJCjHxvrUTaFf84aS0acjcaYZor9
         VZzIFh0kCg9twtmpnMMxt+tlyKipJTSVw8eDOl8sFDIqwHtw0I6C1BTpZ/oE9aR4OfsQ
         NQgA==
X-Received: by 10.50.33.19 with SMTP id n19mr2827895igi.44.1368962765932; Sun,
 19 May 2013 04:26:05 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:25:25 -0700 (PDT)
In-Reply-To: <1368959235-27777-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224853>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index b10d48a..db5c211 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -78,6 +81,7 @@ static struct {
>         { "current" },
>         { "tracking" },
>         { "tracking:upstream" },
> +       { "color" },
>  };

No, I intentionally did not make color an atom in $gmane/224692.  It
doesn't print any information about the branch, like the other atoms
do: have it augment the final printing.

>  /*
> @@ -707,6 +711,21 @@ static void populate_value(struct refinfo *ref)
>                         v->s =3D sb.buf;
>                         continue;
>                 }
> +               else if (!prefixcmp(name, "color:")) {
> +                       const char *color =3D name + 6;
> +                       ref->auto_color =3D 0;
> +                       if (!prefixcmp(color, "red"))
> +                               v->s =3D GIT_COLOR_RED;
> +                       else if (!prefixcmp(color, "green"))
> +                               v->s =3D GIT_COLOR_GREEN;
> +                       else if (!prefixcmp(color, "blue"))
> +                               v->s =3D GIT_COLOR_BLUE;
> +                       else if (!prefixcmp(color, "reset"))
> +                               v->s =3D GIT_COLOR_RESET;
> +                       else if (!prefixcmp(color, "auto"))
> +                               ref->auto_color =3D 1;
> +                       continue;
> +               }

So I can't have %(color:yellow)? :(
Why are you parsing it here when you can use color_parse_name()?
