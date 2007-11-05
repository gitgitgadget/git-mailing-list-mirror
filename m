From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/3] parseopt: introduce OPT_RECURSE to specify shared  options
Date: Mon, 05 Nov 2007 17:53:59 +0100
Message-ID: <20071105165359.GC6205@artemis.corp>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org> <1194264204-3475-2-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site> <Pine.LNX.4.64.0711051315300.4362@racer.site> <Pine.LNX.4.64.0711051340490.4362@racer.site> <alpine.LFD.0.999.0711050755340.15101@woody.linux-foundation.org> <Pine.LNX.4.64.0711051623450.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8X7/QrJGcKSMr1RN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 17:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip5DQ-00043m-7v
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 17:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbXKEQyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 11:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXKEQyD
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 11:54:03 -0500
Received: from pan.madism.org ([88.191.52.104]:33288 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbXKEQyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 11:54:02 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0597728939;
	Mon,  5 Nov 2007 17:53:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 541229BE8; Mon,  5 Nov 2007 17:53:59 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711051623450.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63526>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 04:29:43PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 5 Nov 2007, Linus Torvalds wrote:
>=20
> > On Mon, 5 Nov 2007, Johannes Schindelin wrote:
> > >=20
> > > After kicking this around a bit more on IRC, we had another idea. =20
> > > Instead of introducing OPT_RECURSE(), do something like OPT__QUIET(),=
=20
> > > only this time in diff.h: ....
> >=20
> > I think the preprocessor approach would tend to be simpler, which is an=
=20
> > advantage. But whichever approach is chosen, I think one important issu=
e=20
> > is to make sure that options that *hide* other options are correctly=20
> > handled in the help printout..
>=20
> Yep. See my patch 3/3, which just used a char[256] for the short names,=
=20
> and a path-list for the long names.
>=20
> > But that's an implementation issue. The same certainly *can* be done=20
> > with a recursive setup, just passing a linked list of what the earlier=
=20
> > levels were (which is what we do in other places). And it's not like th=
e=20
> > recursion is going to be very deep or complex.
>=20
> Exactly.
>=20
> The more pressing issue is that we have pointers in the option structure,=
=20
> which point back to the variables expected to hold the option values.
>=20
> The recurse approach would need fixing up those (or some ugly copying of=
=20
> a struct diff_options).
>=20
> But the preprocessor approach means wasting space (since we basically hav=
e=20
> the same options in different builtins),

The "lost" space is the number of options x sizeof(struct option), the
latter being (if I'm correct):

on i386:  9 * 4 =3D 36 octets
on amd64: 4 x 2 + 8 * 4 + 8 (padding) + 8 * 2 =3D 64 octets.

It's not even near being an issue :)

>                                          and it means that the callback=
=20
> functions needed to parse e.g. the diff colour names need to be public. =
=20
> Which is not the worst thing, of course.

  Well it's certainly less ugly than copying the diff_options or
reseting it or anything like that. I don't care if we need to make a
couple of opt-parsing function public more than what we could have
needed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL0qnvGr7W6HudhwRAllSAKCaK5iu8CeQyeO6JXS1xmOZvh81OQCfZQKE
K414e9REGiwXgrteKv1P1gs=
=Jde7
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
