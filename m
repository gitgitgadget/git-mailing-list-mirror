From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH]: first take at cleanup of #include, xmalloc / xrealloc,
 git status report usage.
Date: Fri, 29 Apr 2005 18:24:07 +0200
Message-ID: <20050429182407.5f6afd15.froese@gmx.de>
References: <bfbb1f23220e1918afe70d4cf3de24f5@mpe.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 18:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRYDb-0001BR-Ox
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 18:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVD2QYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Apr 2005 12:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVD2QYc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 12:24:32 -0400
Received: from imap.gmx.net ([213.165.64.20]:20969 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262820AbVD2QYO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 12:24:14 -0400
Received: (qmail invoked by alias); 29 Apr 2005 16:24:11 -0000
Received: from p509052DC.dip.t-dialin.net (EHLO dialup) [80.144.82.220]
  by mail.gmx.net (mp019) with SMTP; 29 Apr 2005 18:24:11 +0200
X-Authenticated: #271361
To: Robert =?ISO-8859-1?Q?S=FCtterlin?= <robert@mpe.mpg.de>
In-Reply-To: <bfbb1f23220e1918afe70d4cf3de24f5@mpe.mpg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Robert S=FCtterlin wrote:
>[...]
> +static int
> +create_directories(const char *path)
>   {
> -	int len =3D strlen(path);
> -	char *buf =3D xmalloc(len + 1);
> -	const char *slash =3D path;
> +	char *buf =3D (char *)path;
> +	char *slash =3D buf;
>=20
>   	while ((slash =3D strchr(slash+1, '/')) !=3D NULL) {
> -		len =3D slash - path;
> -		memcpy(buf, path, len);
> -		buf[len] =3D 0;
> -		mkdir(buf, 0755);
> +		*slash =3D '\0';
> +		if (0 !=3D mkdir(buf, 0755))
> +			return error("Unable to mkdir(``%s'', 0755)", buf);
> +		*slash =3D '/';

You need the temp buffer.  Simply casting the const away may
shut up the compiler but it's not correct.

> -		if (errno !=3D EEXIST)
> +		if (EEXIST !=3D errno)

Too much Star Wars?  Joda-speak?

Ciao, ET.


PS: the mkdir mode should be 0777 ...

