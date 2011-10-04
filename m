From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Tue, 04 Oct 2011 13:06:18 +0200
Message-ID: <1317726379.2577.19.camel@bee.lab.cmartin.tk>
References: <20110926184739.GA11745@erythro.kitwarein.com>
	 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
	 <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
	 <7v1uv228t4.fsf@alter.siamese.dyndns.org>
	 <1317079692.5579.19.camel@centaur.lab.cmartin.tk>
	 <20110927033134.GB8534@sigill.intra.peff.net>
	 <1317724404.2577.6.camel@bee.lab.cmartin.tk>
	 <20111004103624.GA11863@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-tYZ6KISLqOrpAh5ARw6r"
Cc: Junio C Hamano <gitster@pobox.com>, mathstuf@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 13:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2pP-0007pQ-Iq
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 13:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077Ab1JDLGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 07:06:23 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42074 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755376Ab1JDLGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 07:06:22 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id C7A2B46100;
	Tue,  4 Oct 2011 13:05:55 +0200 (CEST)
In-Reply-To: <20111004103624.GA11863@sigill.intra.peff.net>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182759>


--=-tYZ6KISLqOrpAh5ARw6r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-10-04 at 06:36 -0400, Jeff King wrote:
> On Tue, Oct 04, 2011 at 12:33:22PM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > > The latter. If I say:
> > >=20
> > >   git fetch --prune origin refs/heads/master:refs/remotes/origin/mast=
er
> > >=20
> > > and refs/heads/master doesn't exist on the remote, I would expect
> > > refs/remotes/origin/master to be deleted locally. And that naturally
> > > extends to:
> > >=20
> > >   git fetch --prune origin refs/heads/*:refs/remotes/origin/*
> >=20
> > I have some code locally that solves this second part. If we are given
> > refspecs on the command-line, it will try to match against that instead
> > of blindly trusting what get_stale_heads tells us. I'm looking into
> > putting the logic into get_stale_heads so that we can trust it.
> >=20
> > The first part might be more complicated. If the remote head doesn't
> > exist, get_fetch_map dies. It does take a missing_ok flag, so it might
> > be as easy as passing 1 there; but I'm not sure what that would do for =
a
> > non-prune fetch.
>=20
> Let's not worry about the first one for now, then. It is a natural
> extension of the other, but in practice, I don't expect people to really
> care that much about auto-pruning one specific ref. Instead, they want
> to prune wildcards. So as long as it works in the wildcard case, that is
> a good start.

I'm going to add the logic to do specific-ref-prunning because it's just
adding a strcmp to an if (I may yet be proven wrong, mind) and if that
works, we can use it later. get_stale_heads is going to gain a couple of
arguments so it can inspect the user-given refspecs. It should now be a
simple matter of adding a check to see if the refspec's dst matches the
refname (it's a simple matter once you've spent five hours trying to
understand what the fetch code does).

>=20
> > >       # backup to a repository where our objects will be shared
> > >       # with other related backups. So we must only use our slice of =
the
> > >       # ref namespace.
> > >       git push --mirror backup-repo +refs/*:refs/`hostname`/*
> >=20
> > Is --mirror needed there? I would have thought that
> > refs/*:refs/`hostname`/* would do the same by itself.
>=20
> I wanted it to auto-prune the remote branches. So if I delete
> "refs/heads/foo" locally, then it will be deleted from the backup on the
> next push. Regular "push" will not do that, but --mirror will.

OK, gotcha.

   cmn


--=-tYZ6KISLqOrpAh5ARw6r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOiuiqAAoJEHKRP1jG7ZzTsQcH/0tL5U/zoHHMX1zpFwOvopiP
KoMUZ8xkpsPVEmZffXrJIPFMFsAhXEQgFa0cQcFtwY378BpsUHIZDMFwIKxuzY9U
xYm5KH41yWC23IIZUVmLodIfF7IAIhKxT/EumO4I/L0xfsFEmnF0h9AmI50tyGwY
fRoFizB+m/0bQx2TOR00vlXPDIF+rslqyAcKlZUKex99Xnp9VjDPdNzWeRfttyJH
TajgQLOwmZx3Nx63wx4MSXXfSHLS8yjCrm97ixiCATvX0KumgGeim6ZHeFagazHx
6ka/yRKONdGbfIhUVm2qUlF+RF+t8T6gYbG6Wf0HxLp6cT4hqbYrqc2Y/nxdoGg=
=GMqn
-----END PGP SIGNATURE-----

--=-tYZ6KISLqOrpAh5ARw6r--
