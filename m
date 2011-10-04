From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Tue, 04 Oct 2011 12:33:22 +0200
Message-ID: <1317724404.2577.6.camel@bee.lab.cmartin.tk>
References: <20110926184739.GA11745@erythro.kitwarein.com>
	 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
	 <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
	 <7v1uv228t4.fsf@alter.siamese.dyndns.org>
	 <1317079692.5579.19.camel@centaur.lab.cmartin.tk>
	 <20110927033134.GB8534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-DGyeNmxlJZRZtq6w8iIU"
Cc: Junio C Hamano <gitster@pobox.com>, mathstuf@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2JY-000440-Hc
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab1JDKd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 06:33:28 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51997 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab1JDKd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 06:33:26 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id CDAF946100;
	Tue,  4 Oct 2011 12:33:00 +0200 (CEST)
In-Reply-To: <20110927033134.GB8534@sigill.intra.peff.net>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182755>


--=-DGyeNmxlJZRZtq6w8iIU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-09-26 at 23:31 -0400, Jeff King wrote:
> On Tue, Sep 27, 2011 at 01:28:09AM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > > term I think we should fix it properly. We are already learning "what=
 are
> > > the refs the remote side currently has" from the transport and the ri=
ght
> > > fix ought to be to use that original information, not the version fil=
tered
> > > for the use of the primary objective of fetch, which is to only fetch=
 what
> > > the user asked for.
> >=20
> > Do you mean that we should ignore the refspec? Or do you mean that we
> > should look at the refspec if it exists, and only consider deleting
> > those that meet the refspec, so that `--prune --tags` would only delete
> > tags that don't exist in the remote?
>=20
> The latter. If I say:
>=20
>   git fetch --prune origin refs/heads/master:refs/remotes/origin/master
>=20
> and refs/heads/master doesn't exist on the remote, I would expect
> refs/remotes/origin/master to be deleted locally. And that naturally
> extends to:
>=20
>   git fetch --prune origin refs/heads/*:refs/remotes/origin/*

I have some code locally that solves this second part. If we are given
refspecs on the command-line, it will try to match against that instead
of blindly trusting what get_stale_heads tells us. I'm looking into
putting the logic into get_stale_heads so that we can trust it.

The first part might be more complicated. If the remote head doesn't
exist, get_fetch_map dies. It does take a missing_ok flag, so it might
be as easy as passing 1 there; but I'm not sure what that would do for a
non-prune fetch.

>=20
> We do something similar with "git push --mirror", which does pruning
> like this[1].
>=20
> -Peff
>=20
> [1] Actually, I'm not sure how correct "push --mirror" is. It would be
>     nice if the prune operation could be split from the mirror, too. In
>     the past, I have wanted to do both:
>=20
>       # backup to a repository where our objects will be shared
>       # with other related backups. So we must only use our slice of the
>       # ref namespace.
>       git push --mirror backup-repo +refs/*:refs/`hostname`/*

Is --mirror needed there? I would have thought that
refs/*:refs/`hostname`/* would do the same by itself.

>=20
>     and:
>=20
>       # update topic branches we have already published (using the
>       # "matching" refspec), but remove any that we have deleted
>       # locally.
>       git push --mirror publish-point +:
>=20
>     and I don't think either works.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--=-DGyeNmxlJZRZtq6w8iIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOiuDyAAoJEHKRP1jG7ZzTGVoIAJnJsPYJ9mi7yayTi5hIYfCH
HtxXsUJ4IgN2TP9yGzAvYglM4GeJRXRAGZbvvrLfvmjeyl4CKQiXHsLkbslsKVE1
30e4khKgtq4/PYxa43Dnej2tdosilxCMLDBydFt4WrJrBJ719opnArqvivaGuft4
SscDBIU36IwNwUiM2QfYUjuFcmP4oOXHmdNPSSjBrm6CWCI1RNYiPNXgt5BIfzid
lm8zbAse8PM+6mlKMU79xP3G4o/5LN4P3nO8wutImzB5V4+9FWXvLaxbRtLVr0W/
kSh/Oypq3lfcXyXuZS8gdvPfIMK9BMVx3H/7vApj/yuPD5/irkNOVZp5KqvMBJg=
=H45T
-----END PGP SIGNATURE-----

--=-DGyeNmxlJZRZtq6w8iIU--
