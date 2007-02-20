From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Obey NO_C99_FORMAT in fast-import.c.
Date: Tue, 20 Feb 2007 13:57:16 +0100
Message-ID: <45DAF02C.4020003@fs.ei.tum.de>
References: <17825.1171931229@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig347C879174845D118E8177C9"
Cc: git <git@vger.kernel.org>
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Feb 20 13:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJUYz-0005y9-LM
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 13:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbXBTM5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 07:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbXBTM5X
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 07:57:23 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:60182 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927AbXBTM5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 07:57:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 0AE922819F;
	Tue, 20 Feb 2007 13:57:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JaOuqezj9OQL; Tue, 20 Feb 2007 13:57:20 +0100 (CET)
Received: from [62.216.212.7] (ppp-62-216-212-7.dynamic.mnet-online.de [62.216.212.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9349028199;
	Tue, 20 Feb 2007 13:57:20 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <17825.1171931229@lotus.CS.Berkeley.EDU>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40235>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig347C879174845D118E8177C9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jason Riedy wrote:
> Define UM_FMT and UM10_FMT and use in place of %ju and %10ju,
> respectively.  Both format as unsigned long long, so this
> assumes the compiler supports long long.

So there are really systems which do not support the "j" (standardized) s=
ize modifier, but support "long long" (unstandardized) integers?  Oh my.

> +#if !defined(NO_C99_FORMAT)
> +#define UM_FMT "%ju"
> +#define UM10_FMT "%10ju"
> +#else
> +/* Assumes unsigned long long exists. */
> +#define UM_FMT "%llu"
> +#define UM10_FMT "%10llu"
> +#endif

I think this should read something like

#ifndef PRIuMAX
#define PRIuMAX		"llu"	/* Assumes unsigned long long exists */
#endif

After all, these macros are standardized (<inttypes.h>)

Hunks like this should of course read differently then:

> -		die("mark :%ju not declared", orig_idnum);
> +		die("mark :" UM_FMT " not declared", orig_idnum);

die("mark :%"PRIuMAX" not declared", orig_idnum);

> +		fprintf(stderr, "Alloc'd objects: " UM10_FMT "\n", alloc_count);

And then this UM10_FMT stunt isn't needed either:

fprintf(stderr, "Alloc'd objects: %10"PRIuMAX"\n", alloc_count);

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig347C879174845D118E8177C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2vAvr5S+dk6z85oRAu0EAKDF4kzquQ7XThhgveLbaMu6VCucLACeO9Tz
lLh7GCUK7SqwQS+6zfXQBLc=
=c9Ih
-----END PGP SIGNATURE-----

--------------enig347C879174845D118E8177C9--
