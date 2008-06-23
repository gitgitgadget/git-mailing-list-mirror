From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 17:53:15 +0200
Message-ID: <20080623155315.GA18593@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="mP3DRpeJDSE+ciuQ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAoN0-0008Pg-Fu
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbYFWPxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbYFWPxX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:53:23 -0400
Received: from pan.madism.org ([88.191.52.104]:49116 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732AbYFWPxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:53:22 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B49DC37DBD;
	Mon, 23 Jun 2008 17:53:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 961CF357734; Mon, 23 Jun 2008 17:53:15 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806231312130.6440@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85876>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 12:26:41PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 23 Jun 2008, Pierre Habouzit wrote:
>=20
> > This "PARSE_OPT_IGNORE_UNRECOGNIZED" thing has been discussed many time=
s=20
> > in the past, but it just doesn't fly.
> >=20
> > Though to help migrations we can probably introduce a new parse option
> > construct that would be a callback that is responsible for dealing with
> > "things" the upper level parser doesn't know about, something where the
> > callback could be:
> >=20
> > enum {
> >     FLAG_ERROR =3D -1,
> >     FLAG_NOT_FOR_ME,
> >     FLAG_IS_FOR_ME,
> >     FLAG_AND_VALUE_ARE_FOR_ME,
> > }
> >=20
> > int (*parse_opt_unknown_cb)(int shortopt, const char *longopt,
> >                             const char *value, void *priv);
>=20
> I believe that this is what Junio was talking about when he mentioned=20
> callbacks.
>=20
> However, I think it buys us more trouble than it saves us.
>=20
> Thinking about the recursive approach again, I came up with this POC:

  Well I proposed something like that in the past, and we believed it to
be too cumbersome. I can live with it well fwiw, but it doesn't solve
the issue of migrating a very complex option parsing chain to
parse-options well IMHO. THe big problem with diff and rev opt parsing
is that one you want to migrate _any_ of the commands, you have to
migrate _all_ of them, which is huge.

  I believe the callback proposal as an _intermediate_ step allows a
better "upgrade" path. We can then converge to this proposal, or a big
fat macro, I don't care what we do in the end, but as one guy that
migrated quite a few commands, I care about the work being doable in an
incremental way.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhfxukACgkQvGr7W6Hudhwf2ACfeLPG6gsqt5lBdapeelmoTojU
oXwAoICVCJNGCWty/imdQ97v2485p8Al
=TlAT
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
