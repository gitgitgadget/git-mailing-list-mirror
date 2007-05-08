From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] remove unnecessary loop
Date: Tue, 8 May 2007 12:13:17 +0200
Message-ID: <20070508101317.GC9007@efreet.light.src>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com> <81b0412b0705080208x3713cbc1y3c870383b586c877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Cc: Liu Yubao <yubao.liu@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 12:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMhN-0008MK-9E
	for gcvg-git@gmane.org; Tue, 08 May 2007 12:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966377AbXEHKNd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 06:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966416AbXEHKNd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 06:13:33 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2274 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966377AbXEHKNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 06:13:32 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.68114;
	Tue, 08 May 2007 12:13:18 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HlMh3-0002YB-OO; Tue, 08 May 2007 12:13:17 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0705080208x3713cbc1y3c870383b586c877@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46561>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2007 at 11:08:35 +0200, Alex Riesen wrote:
> On 5/8/07, Liu Yubao <yubao.liu@gmail.com> wrote:
> >+#ifdef __CYGWIN__
> >+               /*
> >+                * On cygwin, lstat("hello", &st) returns 0 when
> >+                * "hello.exe" exists, so test with open() again.
> >+                */
> >+               if (lstat(match, &st) && -1 !=3D (fd =3D open(match,=20
> >O_RDONLY))) {
>=20
> This does not "test again" if lstat returns 0. If lstat returns 0
> (file stat info
> obtained) the open is not even called. Besides, cygwin lies not only about
> .exe but also about .lnk files.
>=20
> P.S. Somehow I have the feeling that even if it is a stupidity in cygwin
> they will not fix it (nor will they admit it is a bug).

They will not. Because it is not a bug. It seems to be (part of) workaround
to get programs written for unix work in windows.

One reason for such workaround I can think of is, that some programs try to
find themselves and since their argv[0] often does NOT contain the extensio=
n,
the stat has to succeed for them.

Using open here unfortunately won't work though, because:
 - For stale links open will fail, but the lstat should succeed. This does
   apply to cygwin, because cygwin emulates links.
 - I'd expect open to actually succeed in this case, because there are
   programs that don't only try to find themselves, but also open themselve=
s,
   because they bundle some data.

Another problem is, that the file might exist or might be cygwin artefact a=
nd
there does not seem to be an easy way to tell.

IMHO the described problem is harmless (you know the file does not exist, so
you should have no reason to add it and nothing happens if you don't) and
happens very rarely (adding binaries to version control is usually not a go=
od
idea), so I suggest to let this be, as the workaround can easily cause other
problems.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQE09Rel1vVwhjGURAk1FAJ4tx6jnnGRXOMfUxXjkobfU2cWIdQCePnKu
RM6DPNQLDOESPAlnX3+dAVs=
=Tu+l
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
