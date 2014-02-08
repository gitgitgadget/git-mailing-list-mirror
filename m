From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] dir: warn about trailing spaces in exclude pattern
Date: Sat, 08 Feb 2014 15:33:48 +0100
Message-ID: <52F6404C.1080107@web.de>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com> <1391847004-22810-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 15:34:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC8yl-0001GU-Iq
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 15:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbaBHOdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 09:33:55 -0500
Received: from mout.web.de ([212.227.15.3]:60295 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbaBHOdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 09:33:54 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LoYX0-1VaMW30DQQ-00gZ3R for <git@vger.kernel.org>;
 Sat, 08 Feb 2014 15:33:53 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1391847004-22810-2-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:m2PyPrBUzKjIlq0Q0/UhFlDcEH0Mf/f+deyH1eMNTORBewyy1r/
 IhxTEjL8nco23H8IdsBU9T9EGoF6l9MmXKjUBhfcnOejvrSrKGXwYel5XBh7acW1eKtE+wq
 /iBVabVIkc3g6BjP0fyJ5d84tlVx40JT6bRF88aWGu0gUNZYFs5wc+Fspf1QF21DMf8L7DH
 sfHgV1aJYvGWgcDOo1y4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241837>

On 2014-02-08 09.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/dir.c b/dir.c
> index b35b633..9edde44 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -491,6 +491,16 @@ void clear_exclude_list(struct exclude_list *el)
>  	el->filebuf =3D NULL;
>  }
> =20
> +static void check_trailing_spaces(const char *fname, char *buf)
> +{
> +	int len =3D strlen(buf);
> +	while (len && buf[len - 1] =3D=3D ' ')
> +		len--;
> +	if (buf[len] !=3D '\0')
Do we need the while loop here, (when we only warn) ?

> +		warning(_("%s: trailing spaces in '%s'. Please quote them."),
> +			fname, buf);
> +}
This is nice. However we can hint the user that there are 2 choices:=20
		warning(_("%s: trailing spaces in '%s'. Please remove them or quote t=
hem."),
> +
>  int add_excludes_from_file_to_list(const char *fname,
>  				   const char *base,
>  				   int baselen,
> @@ -542,6 +552,7 @@ int add_excludes_from_file_to_list(const char *fn=
ame,
>  		if (buf[i] =3D=3D '\n') {
>  			if (entry !=3D buf + i && entry[0] !=3D '#') {
>  				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
> +				check_trailing_spaces(fname, entry);
>  				add_exclude(entry, base, baselen, el, lineno);
>  			}
>  			lineno++;
>=20
