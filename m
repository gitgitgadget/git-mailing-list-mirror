From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: multiple-commit cherry-pick?
Date: Sun, 16 Nov 2008 10:11:02 +0100
Message-ID: <20081116091102.GA19315@artemis.corp>
References: <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com> <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de> <20081114050822.GA23963@foursquare.net> <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org> <7v1vxeb4il.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811140936050.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811140945000.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Frey <cdfrey@foursquare.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 16 10:12:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1dgB-0001eA-3T
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 10:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYKPJLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 04:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbYKPJLM
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 04:11:12 -0500
Received: from pan.madism.org ([88.191.52.104]:57109 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbYKPJLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 04:11:09 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AA14A3DB5B;
	Sun, 16 Nov 2008 10:11:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D5DBB2A346; Sun, 16 Nov 2008 10:11:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811140945000.3468@nehalem.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101120>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2008 at 05:55:51PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Fri, 14 Nov 2008, Linus Torvalds wrote:
> >=20
> > but if you already do
> >=20
> > 	gitk a..b
> >=20
> > then you're _already_ doing a revision limiter and forcing the revision=
=20
> > walk to be synchronous, so there would be no interactivity downside=20
> > between 'a..b' and '{a..b}'.
>=20
> Btw, the biggest problem (I think) is actually non-simple ranges and just=
=20
> the _syntax_ of these things.
>=20
> It's entirely reasonable to want to group a more complex expression than=
=20
> just a single range. IOW, something like
>=20
> 	gitk {..origin/pu ^origin/next} {HEAD~5..HEAD~2}
>=20
> to show a union of what is in 'pu' but not master or next, and the=20
> symmetrical difference of the current merge. It's a perfectly sensible=20
> thing to do. And we _can_ do it right now, just with a nasty syntax:
>=20
> 	gitk --no-walk $(git rev-list ..origin/pu ^origin/next) $(git rev-list H=
EAD~5..HEAD~2)
>=20
> actually works. But look again at how nasty it is to parse the '{x}'=20
> version, because the '{..}' thing now spans multiple arguments.=20

That would probably be a job that parseopt could take care of. to some
degree.

Also { } is a poor choice as it's an expansion thingy for many shells.
zsh even refuses ` { a.. b } ` as an argument, pretending there is a
syntax error at the closing brace. [ ] looks like a safer choice, it's
used for shells supporting arrays, but only when stuck after an
identifier which won't be our case ever, so we would be probably safe.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkf46UACgkQvGr7W6Hudhx9AgCeM4uY1/ouc1bm9twix7tM+cOJ
UhwAnjHPKBi1aiWvafZWLW/RA1BHg1vr
=XB3j
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
