From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Sun, 20 May 2007 14:43:45 +0200
Message-ID: <20070520124345.GB27087@efreet.light.src>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi> <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com> <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Cc: David Kastrup <dak@gnu.org>, Paolo Teti <paolo.teti@gmail.com>,
	git@vger.kernel.org
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@helsinki.fi>
X-From: git-owner@vger.kernel.org Sun May 20 14:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpklc-0008Fo-UF
	for gcvg-git@gmane.org; Sun, 20 May 2007 14:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbXETMoD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 08:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755200AbXETMoD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 08:44:03 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2391 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755015AbXETMoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 08:44:01 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.405970;
	Sun, 20 May 2007 14:43:45 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HpklF-00083I-2P; Sun, 20 May 2007 14:43:45 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47831>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2007 at 17:02:56 +0300, Ilpo J=C3=A4rvinen wrote:
> David Kastrup <dak@gnu.org> wrote:
>=20
> > Only if size_t is a larger type than int (could be on x86-64 and alpha
> > architectures).  Other than that, this comparison would work.  Which
> > does not mean that this does not warrant fixing, but it is not
> > necessarily the cause of this problem.
>=20
> ...sizeof(size_t) =3D=3D sizeof(int) should hold...

Really?

$ cat test.c
#include <stdio.h>
int main(void)
{
    printf("sizeof(int) =3D %i\n", sizeof(int));
    printf("sizeof(long) =3D %i\n", sizeof(long));
    printf("sizeof(size_t) =3D %i\n", sizeof(size_t));
    return 0;
}
$ gcc -otest test.c
$ ./test
sizeof(int) =3D 4
sizeof(long) =3D 8
sizeof(size_t) =3D 8

Hm, it does not seem that sizeof(size_t) =3D=3D sizeof(int).

$ uname -m
x86_64

Yes, this is a 64-bit system.

Anyway, comparing it with -1 is ALWAYS OK in spite of this!

$ cat test2.c
#include <stdio.h>
int main(void)
{
    size_t x =3D 0;
    --x;
    printf("x =3D 0x%lx\n", x);
    printf("(x =3D=3D -1) =3D %i\n", (x =3D=3D -1));
    return 0;
}
$ gcc -otest2 test2.c
$ ./test2
x =3D 0xffffffffffffffff
(x =3D=3D -1) =3D 1

So at least with gcc that comparison is OK anyway. There has to be something
else that causes that problem.

> Anyway, if this has any relevance: I'm using non-utf system, and (as you=
=20
> see) my surname has =C3=A4... The system was recently upgraded to git 1.5=
+=20
> which started to complain also about a missing i18n.commitencoding,=20
> figured out that when I set it to utf8 (empty =3D> defaults to it) and ha=
ve=20
> signed-off line (with native non-utf =C3=A4), I get that error...
>=20
> ...and please, do not drop me from cc since I'm not subscribed...
>=20
> --=20
>  i.
--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUEKBRel1vVwhjGURAj1HAJ9e/pPY5IJio4xRqBlgsKI85t4D2wCfSnMl
e7mH8sRuM+E3+ERxJHWhJE8=
=hmXI
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
