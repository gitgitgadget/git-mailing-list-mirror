From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Bug?] compiler warning with gcc >= 4.2
Date: Fri, 6 Jul 2007 10:55:08 +0200
Message-ID: <20070706085508.GC3991@efreet.light.src>
References: <20070703125844.GL12721@planck.djpig.de> <alpine.LFD.0.999.0707030957160.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:55:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6jay-0000h8-QK
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbXGFIzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbXGFIzS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:55:18 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:33814 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756256AbXGFIzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:55:16 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1646357480;
	Fri,  6 Jul 2007 10:55:15 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id lrIWM8e4uAwg; Fri,  6 Jul 2007 10:55:11 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 72C0C5744E;
	Fri,  6 Jul 2007 10:55:11 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I6jam-0006QR-7C; Fri, 06 Jul 2007 10:55:08 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707030957160.26459@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51736>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2007 at 10:18:52 -0400, Nicolas Pitre wrote:
> On Tue, 3 Jul 2007, Frank Lichtenheld wrote:
>=20
> > Hi,
> >=20
> > while testing for an (probably) unrelated miscompilation bug,
> > I got the following warning while compiling git:
> >=20
> > gcc-4.2 -o sha1_file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>'
> > -DETC_GITCONFIG=3D'"/home/djpig/etc/gitconfig"' -DNO_STRLCPY sha1_file.c
> > sha1_file.c: In function =E2=80=98check_packed_git_idx=E2=80=99:
> > sha1_file.c:523: warning: assuming signed overflow does not occur when =
assuming that (X + c) < X is always false
> > sha1_file.c:523: warning: assuming signed overflow does not occur when =
assuming that (X + c) < X is always false
> >=20
> > This comes from the new -Wstrict-overflow which warns about the fact
> > that with -fstrict-overflow, which is activated by default with -O2,
> > the if clause referenced in the warning will be optimised away.
> >=20
> > So I would be interested to know
> > a) if the compiler optimising this check away (which seems to be a check
> >    about whether signed overflow can occour) can lead to unwanted resul=
ts
>=20
> Of course it can if the compiler blindly optimizes the test away.
>=20
> In this particular case, the answer can be determined at compile time=20
> though, since all values to perform the test are constants.  So in this=
=20
> case the warning is rather obnoxious.
>=20
> However it would be completely wrong if the compiler optimized away the=
=20
> if from index-pack.c on line 104, or from builtin-pack-objects.c on line=
=20
> 579.  Even warning about it without actually optimizing it away would be=
=20
> bad in those cases.

The compiler *will* optimize it away according to the manual
(http://gcc.gnu.org/onlinedocs/gcc-4.2.0/gcc/Optimize-Options.html#index-fs=
trict_002doverflow-551).
Reasoning behind that is, that C standard does not define what will happen =
on
signed overflow and therefore the code should not depend on it. Gcc 4.2 has
an option to specify that signed overflow always wraps -- -fwrapv, in which
case the compiler will compute the result as intended (and should not produ=
ce
the warning).

> > b) if not a), if it would make sense trying to suppress that warning, so
> >    that other people don't end up wondering the same as me
>=20
> I really wonder what's the point for gcc to warn about such things. =20
> Sure the warning should go away, but not by compromizing the test that=20
> we need performed on the actual definition of off_t.

Yes, there is. The expression is undefined according to the C specification,
(or at least GCC manual claims it).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGjgNsRel1vVwhjGURAjMGAJ9mpHpYGI7sIElwKgesPvPfBombeQCgshXh
b0/A2ggFz2ErHs+CyC5m2IQ=
=2H2b
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
