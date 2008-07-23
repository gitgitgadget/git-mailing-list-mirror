From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-checkout: fix argument parsing to detect ambiguous  arguments.
Date: Wed, 23 Jul 2008 03:32:03 +0200
Message-ID: <20080723013203.GJ11831@artemis.madism.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org> <alpine.DEB.1.00.0807230215480.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="jIYo0VRlfdMI9fLa";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLTE4-0007ii-2d
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYGWBcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbYGWBcH
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:32:07 -0400
Received: from pan.madism.org ([88.191.52.104]:40522 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYGWBcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:32:06 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 29FC73A4C9;
	Wed, 23 Jul 2008 03:32:04 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 44E861426F0; Wed, 23 Jul 2008 03:32:03 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807230215480.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89595>


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 01:17:52AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Pierre Habouzit wrote:
>=20
> > diff --git a/builtin-checkout.c b/builtin-checkout.c
> > index fbd5105..1490e8e 100644
> > --- a/builtin-checkout.c
> > +++ b/builtin-checkout.c
> > @@ -438,9 +438,14 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
> > =20
> >  	opts.track =3D git_branch_track;
> > =20
> > -	argc =3D parse_options(argc, argv, options, checkout_usage, 0);
> > -	if (argc) {
> > +	argc =3D parse_options(argc, argv, options, checkout_usage,
> > +			     PARSE_OPT_KEEP_DASHDASH);
> > +
> > +	if (argc && strcmp(argv[0], "--")) {
> >  		arg =3D argv[0];
> > +
> > +		if (argc =3D=3D 1 || strcmp(argv[1], "--"))
> > +			verify_non_filename(NULL, arg);
>=20
> Why "argc =3D=3D 1"?  Should "git checkout <path>" really fail?  That wou=
ld be=20
> a change in behavior that _would_ hit me.

  No I was mistaken about what verify_non_filename did, actually I
should not code when I'm so obviously tired, and I wanted
verify_non_filename to do what I meant instead of checking what it does
;P

  I believe my resent patch is better.

> However, you may want to verify_non_filename() when argc =3D=3D 1 _and_=
=20
> get_sha1() succeeded.  Because then, <path> is ambiguous.

  Yes and the reverse when we have sucessfully parsed something that
looks like a path as a path. Anyways, someone should carefully proofread
my resent patch, it's likely that errors slipped through given my sleep
deprivation atm.

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGihMACgkQvGr7W6Hudhw4MwCggUMiCTDmg7G2/Am0Kx15qp15
ETEAniB9+43N5PLUaAOvkA7qNaN5bWC2
=g66W
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
