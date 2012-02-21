From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] Do attempt pretty print in ASCII-incompatible encodings
Date: Tue, 21 Feb 2012 21:53:30 +0700
Message-ID: <CACsJy8C30mTFwduiSv_z458DgDBb0O=Jn19qMSwkAHuFadtBMg@mail.gmail.com>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com> <1329834292-2511-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 15:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzr6Y-0003g9-QP
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab2BUOyC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 09:54:02 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46043 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab2BUOyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 09:54:01 -0500
Received: by wics10 with SMTP id s10so3548109wic.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 06:54:00 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.14.73 as permitted sender) client-ip=10.180.14.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.14.73 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.14.73])
        by 10.180.14.73 with SMTP id n9mr26586320wic.16.1329836040314 (num_hops = 1);
        Tue, 21 Feb 2012 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=9RXLtOc0FqV366vD6CfKw9JTYkLK5Yfa8gY1svedOME=;
        b=xSzKXz5qyOy4lltZRt0MvlPBdzZ90Jnw82vHFbRshLAdTdwe0a8VWFxcm9MLgwzMRs
         +jHG3pNZTVeEfFR9qUy8vjM429RjpRB3oFZzqk6Wtn3reSTCUZsbOOJwCK6BZXqAfrPd
         vK88yy+Lt6oRP07qo5+vsyi5HPAf5daUVPPrw=
Received: by 10.180.14.73 with SMTP id n9mr22119984wic.16.1329836040272; Tue,
 21 Feb 2012 06:54:00 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 06:53:30 -0800 (PST)
In-Reply-To: <1329834292-2511-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191163>

2012/2/21 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> @@ -482,3 +482,18 @@ char *reencode_string(const char *in, const char=
 *out_encoding, const char *in_e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return out;
> =C2=A0}
> =C2=A0#endif
> +
> +int ascii_superset_encoding(const char *encoding)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *sample =3D " !\"#$%&'()*+,-./01234=
56789:;<=3D>?@"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "ABCDEFGHIJKLMNOPQ=
RSTUVWXYZ[\\]^_`"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "abcdefghijklmnopq=
rstuvwxyz{|}~\n";
> + =C2=A0 =C2=A0 =C2=A0 char *output;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 if (!encoding)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> + =C2=A0 =C2=A0 =C2=A0 output =3D reencode_string(sample, encoding, "=
US-ASCII");
> + =C2=A0 =C2=A0 =C2=A0 ret =3D !output || !strcmp(sample, output);
> + =C2=A0 =C2=A0 =C2=A0 free(output);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}

Side note about this function, which was written to ban all
ascii-incompatible charsets from entering commit objects. The idea of
mixing charsets in the same buffer without clear boundary does not
sound healthy. Plus, ident.c will silently drop '\n', '<' and '>' in
author/committer. If a hypothetical charset happens to place a letter
in those, um.. code points?, the letter will be dropped. But meh..
--=20
Duy
