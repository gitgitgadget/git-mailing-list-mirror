From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] blame: add correct paddings in time_buf for align
Date: Fri, 18 Apr 2014 21:42:22 +0700
Message-ID: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com>
References: <43a3735a164c923acc8e6e2681dfbd727cda63de.1397810231.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 16:43:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbA0L-000693-FB
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 16:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbaDROmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2014 10:42:54 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:34711 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbaDROmx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 10:42:53 -0400
Received: by mail-qa0-f48.google.com with SMTP id s7so1605679qap.21
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SEeh6sd9Reqm1dqjxSvMk2RGG8vG6/sLVD+B5Z9R+2c=;
        b=tKkNSTA3/BlH7P11GVRdHsvmRlundqgK3bzgaQOLxMBK0zetu3eUWK6L6AvidOQ1xq
         UUTLp7UgPsziVR+aGz1zXFrkIJ5jn+SYLuhB4uOG3V/76QZUujFSBjgud2FdbuzU4rjG
         edkc34LEd8dlALorw7DquRQRd01zY1/ha4VlRffIJqWBEJtv9qMP3n11AfSeJGVQqMNC
         GTe2Dg5HT96ZOV1S5kBAXi4N13T75XjTAP8PtHpHz3FxIXeU0g8eohPwbLSqQIxxvUXy
         AaB7FGeSiH23tCrz1vH4CF4r2/xJ54+lvoNk2W/qVkC8JpqgrNQ8RbrNS9TJDUlbZFZl
         gB1g==
X-Received: by 10.140.107.229 with SMTP id h92mr24700670qgf.30.1397832172501;
 Fri, 18 Apr 2014 07:42:52 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 18 Apr 2014 07:42:22 -0700 (PDT)
In-Reply-To: <43a3735a164c923acc8e6e2681dfbd727cda63de.1397810231.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246472>

On Fri, Apr 18, 2014 at 3:44 PM, Jiang Xin <worldhello.net@gmail.com> w=
rote:
> When show blame information with relative time, the UTF-8 characters =
in
> `time_str` will break the alignment of columns after the date field.
> This is because the `time_buf` padding with spaces should have a
> constant display width, not a fixed strlen size.  So we should call
> utf8_strwidth() instead of strlen() for calibration.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>
> Before applying this patch:
>
>         5817da01 builtin-blame.c   (Pierre Habouzit             6 =E5=
=B9=B4=E5=89=8D                         21) #include "parse-options.h"
>         ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 =E5=
=B9=B4=E5=89=8D                         22) #include "utf8.h"
>         3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 =E5=
=B9=B4 10 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D            23) #include =
"userdiff.h"
>         25ed3412 builtin/blame.c   (Bo Yang                     1 =E5=
=B9=B4 1 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D             24) #include =
"line-range.h"
>         58dbfa2e builtin/blame.c   (Eric Sunshine               9 =E4=
=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                   25) #include "line-=
log.h"
>         cee7f245 builtin-pickaxe.c (Junio C Hamano              8 =E5=
=B9=B4=E5=89=8D                         26)
>
> After applying this patch:
>
>         5817da01 builtin-blame.c   (Pierre Habouzit             6 =E5=
=B9=B4=E5=89=8D                           21) #include "parse-options.h=
"
>         ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 =E5=
=B9=B4=E5=89=8D                           22) #include "utf8.h"
>         3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 =E5=
=B9=B4 10 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                 23) #inc=
lude "userdiff.h"
>         25ed3412 builtin/blame.c   (Bo Yang                     1 =E5=
=B9=B4 1 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                  24) #inc=
lude "line-range.h"
>         58dbfa2e builtin/blame.c   (Eric Sunshine               9 =E4=
=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                       25) #include "l=
ine-log.h"
>         cee7f245 builtin-pickaxe.c (Junio C Hamano              8 =E5=
=B9=B4=E5=89=8D                           26)


The numbers 21..26 still do not look aligned, both in gmail raw
message view and gmane.

>
>  builtin/blame.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 88cb799..c8f6647 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1564,12 +1564,19 @@ static const char *format_time(unsigned long =
time, const char *tz_str,
>         else {
>                 const char *time_str;
>                 int time_len;
> +               int time_col;
>                 int tz;
>                 tz =3D atoi(tz_str);
>                 time_str =3D show_date(time, tz, blame_date_mode);
>                 time_len =3D strlen(time_str);
>                 memcpy(time_buf, time_str, time_len);
> -               memset(time_buf + time_len, ' ', blame_date_width - t=
ime_len);
> +               /*
> +                * Add space paddings to time_buf to display a fixed =
width
> +                * string, and use time_col for display width calibra=
tion.
> +                */
> +               time_col =3D utf8_strwidth(time_str);
> +               memset(time_buf + time_len, ' ', blame_date_width - t=
ime_col);
> +               *(time_buf + time_len + blame_date_width - time_col) =
=3D 0;

And you may want to turn time_buf[128] to strbuf as well while you're a=
t it.

>         }
>         return time_buf;
>  }
> --
> 1.9.2.474.g17b2a16
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Duy
