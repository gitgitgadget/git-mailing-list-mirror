From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 13/13] Build in merge
Date: Tue, 1 Jul 2008 00:48:33 +0200
Message-ID: <20080630224833.GQ4729@genesis.frugalware.org>
References: <20080628023355.GH2058@genesis.frugalware.org> <ed4b7f44474d6b9398fb0752740ede264bea25b2.1214620551.git.vmiklos@frugalware.org> <7vprq0fzum.fsf@gitster.siamese.dyndns.org> <20080630013612.GY2058@genesis.frugalware.org> <7vlk0n4h0a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSBi-0006ga-RG
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbYF3Wsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbYF3Wsi
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:48:38 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44886 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932565AbYF3Wsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:48:38 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 513801B2543;
	Tue,  1 Jul 2008 00:48:36 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 045854465E;
	Tue,  1 Jul 2008 00:20:03 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 943B711901EE; Tue,  1 Jul 2008 00:48:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlk0n4h0a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86954>


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2008 at 10:40:53PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Actually reset_hard does not return if an error occures:
>=20
> I know that; didn't I already say "Luckily no"?  The point was it was not
> apparent from the above 6 lines alone.

Ah, OK.

>=20
> >> > +	for (i =3D 0; i < use_strategies.nr; i++) {
> >> > +		if ((unsigned int)use_strategies.items[i].util &
> >> > +			NO_FAST_FORWARD)
> >> > +			allow_fast_forward =3D 0;
> >> > +		if ((unsigned int)use_strategies.items[i].util & NO_TRIVIAL)
> >> > +			allow_trivial =3D 0;
> >>=20
> >> Can we abstract out these ugly casts?  Any code that use path_list to
> >> store anything but list of paths (i.e. some value keyed with string) t=
ends
> >> to have this readability issue.
> >
> > If you don't cast, you can't use the & operator. If I change the
> > path_list_item's util to be an unsigned number then I break fast-export.
> > I think if we _really_ want to get rid of those casts, we could have
> > something like:
>=20
> No, no, no.  That is not what I meant.
>=20
> The places that use use_strategies in your code knows too much about the
> internal implementation detail of path_list, while path_list pretends to
> be a general purpose "table keyed with string" facility.  The fact is that
> the table is not a very useful general purpose abstraction unless you are
> pointing at some structures that exist regardless of your use of path_list
> (e.g. you have some "struct object" and you hold pointers in a path_list).
> It does not work very well as an abstraction for use case like yours.
>=20
> With something like:
>=20
>         static inline unsigned nth_strategy_flags(struct path_list *s, in=
t nth)
>         {
>                 return (unsigned) s->items[nth].util;
>         }
>=20
> the checks would be more like:
>=20
> 	if (nth_strategy_flags(&use_strategies, i) & NO_FAST_FORWARD)
> 		...
>=20
> or even:
>=20
>         static inline check_nth_strategy_flags(struct path_list_item *i, =
unsigned flags)
>         {
>         	return !((unsigned) i->util & flags);
>         }
>=20
>         if (check_nth_strategy_flags(&use_strategies,items[i], NO_FAST_FO=
RWARD)
>         	...=09
>=20
> either of which would be much easier on the eye.

Probably this is subjective, but I think the previous form is easier to
read, so I choose that one.

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhpYsEACgkQe81tAgORUJZ5QwCgiV13lgru/wFpy5M2DaN0VNqg
QrwAoIdzl/MmxBaims8Xv7SYTHsU3h36
=QDEj
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
