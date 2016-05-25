From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/26] remote-curl.c: convert fetch_git() to use argv_array
Date: Wed, 25 May 2016 02:41:45 -0400
Message-ID: <CAPig+cQjteE3vgT=UoOne1PX7zmE5JhkqpXUbkCwheRvzkUJgw@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
	<1460552110-5554-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 08:41:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5SVu-0004lB-KK
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 08:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbcEYGlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 02:41:47 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37528 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcEYGlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2016 02:41:46 -0400
Received: by mail-ig0-f172.google.com with SMTP id l10so23682897igk.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=9qoHo1ag0Cna0jJZDZzP/kygMnH9atXmFZlWb0IkHlI=;
        b=UhaObuQIfCFbBGD9CV9Mac9L7JSXTzO36LQzuSOdn3MVnfHzkE4g4cx+fk9LCusKlX
         LDD436azU01MoyruP80HvTP50uyYHw9eSHqxNUt2TmFAB5knx/wZuvMRXhVfzJlnm3bi
         VMPwedjMtRJw9LGmeajeX/nmrPKV2XKfNjKMB61dZ9aduX0tnVaBaUsP1kkpRXV8m3Bb
         v51aznMa6S3vBkT0jUand/hlKKL7sK9BltYZcfCIgCQVj+JgTmkSmKk6bjqRhmwMbbL2
         nwxUrQQuaphg7AL10TfIOlFJnW9Y8t2lk/KmJogJCmHFVPZhAkIAXtlE6mQ6F2n+OPQV
         VcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=9qoHo1ag0Cna0jJZDZzP/kygMnH9atXmFZlWb0IkHlI=;
        b=KG3QoqhGIfn6xarfOwo96zhvdU9ZoVRsv1imFskZbXqvfLGuv3Ye0lNnkM4D/QAzJO
         GT0BgJgPlBZGxOKzvZlHwiiaKR6zq85kyibuzHxmex0Nw0l7hs/Jq0QWFWM53ivRNo37
         wQT+0eDTeFUmlFANB0un81EaHUBszQKl6+hZrempufPF75oqzSboI6KNOM1bJ4QQ4q2F
         TmNbV8mDSQwS8AVw8PtV8V5UVQy5P4QR/fL8BI8fYZPzW1Z+NWlclE5D4boXrj0ZdlE5
         nbc1ikRK5nZPInZEogfadTypxlGUxk90QcIKs3WOb0c7wkx+fZRoGznxFkZgyBv+rLTn
         q7wA==
X-Gm-Message-State: AOPr4FVrLCd+cPk+LsVaJc4V22VMhwo4f3E2NrFczJ5LnU+k67V0NKRpu9mW6vs9NOquUF645X9SNln0jik1Ag==
X-Received: by 10.50.0.233 with SMTP id 9mr20928459igh.17.1464158505252; Tue,
 24 May 2016 23:41:45 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Tue, 24 May 2016 23:41:45 -0700 (PDT)
In-Reply-To: <1460552110-5554-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Ju08snuQbVO6O2dEUZoTJoeRx-s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295563>

On Wed, Apr 13, 2016 at 8:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/remote-curl.c b/remote-curl.c
> @@ -726,37 +726,30 @@ static int fetch_git(struct discovery *heads,
>         char *depth_arg =3D NULL;
> -       int argc =3D 0, i, err;
> -       const char *argv[17];
> +       int i, err;
> +       struct argv_array args =3D ARGV_ARRAY_INIT;
> [...]
>         if (options.verbosity >=3D 3) {
> -               argv[argc++] =3D "-v";
> -               argv[argc++] =3D "-v";
> +               argv_array_push(&args, "-v");
> +               argv_array_push(&args, "-v");

A bit more natural might have been:

    argv_array_pushl(&args, "-v", "-v", NULL);

though the diff becomes noisier when the braces get dropped. Not worth
a re-roll, of course.

>         }
> [...]
> -       if (options.depth) {
> -               struct strbuf buf =3D STRBUF_INIT;
> -               strbuf_addf(&buf, "--depth=3D%lu", options.depth);
> -               depth_arg =3D strbuf_detach(&buf, NULL);
> -               argv[argc++] =3D depth_arg;
> -       }
> -       argv[argc++] =3D url.buf;
> -       argv[argc++] =3D NULL;
> +               argv_array_push(&args, "--no-progress");
> +       if (options.depth)
> +               argv_array_pushf(&args, "--depth=3D%lu", options.dept=
h);

'depth_arg' becomes unused with this change and can be retired...

> +       argv_array_push(&args, url.buf);
> @@ -779,6 +772,7 @@ static int fetch_git(struct discovery *heads,
>         strbuf_release(&rpc.result);
>         strbuf_release(&preamble);
>         free(depth_arg);

=2E..along with this unnecessary free().

> +       argv_array_clear(&args);
>         return err;
>  }
