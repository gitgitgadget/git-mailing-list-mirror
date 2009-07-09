From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: found a resource leak in file builtin-fast-export.c
Date: Thu, 9 Jul 2009 10:31:37 +0200
Message-ID: <200907091031.43494.trast@student.ethz.ch>
References: <20090709075728.137880@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1587947.vFQ4VUiJZm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Martin Ettl" <ettl.martin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOp2t-0004zQ-Hx
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZGIIbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbZGIIbw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:31:52 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20035 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbZGIIbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 04:31:51 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Jul 2009 10:31:49 +0200
Received: from thomas.localnet ([77.58.131.161]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Jul 2009 10:31:49 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.95; x86_64; ; )
In-Reply-To: <20090709075728.137880@gmx.net>
X-OriginalArrivalTime: 09 Jul 2009 08:31:49.0301 (UTC) FILETIME=[B3E57650:01CA006F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122943>

--nextPart1587947.vFQ4VUiJZm
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi Martin

Martin Ettl wrote:
>=20
> I have attached a patch to resolve this.

Please read Documentation/SubmittingPatches in the source tree.  And
use git to track git.git!

As for the actual patch:

> --- git-1.6.3.3/builtin-fast-export.c	2009-06-22 08:24:25.000000000 +0200
> +++ git-1.6.3.3/builtin-fast-export_new.c	2009-07-09 09:44:28.000000000 +=
0200
> @@ -442,8 +442,9 @@ static void export_marks(char *file)
>  		deco++;
>  	}
> =20
> -	if (ferror(f) || fclose(f))
> +	if (ferror(f))
>  		error("Unable to write marks file %s.", file);
> +  	fclose(f);

You no longer check the error returned by fclose().  This is
important, because the FILE* API may buffer writes, and a write error
may only become apparent when fclose() flushes the file.

>  }
> =20
>  static void import_marks(char *input_file)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1587947.vFQ4VUiJZm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAkpVqu8ACgkQqUud07tmzP1WHACXcGmIvy5KmEDEhEpDwRx5FuJz
IACfc2FyIfQC015XfAZfkGE9ItBT/WA=
=jg0V
-----END PGP SIGNATURE-----

--nextPart1587947.vFQ4VUiJZm--
