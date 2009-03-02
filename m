From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: "warning: no common commits" triggered due to change of remote's IP address?
Date: Mon, 2 Mar 2009 09:40:21 +0100
Message-ID: <200903020940.24813.trast@student.ethz.ch>
References: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com> <200903012221.03662.trast@student.ethz.ch> <e38bce640903011501t2c7a134dp887f5a96db3db0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1966798.TGJr6sEOOM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 09:42:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le3jA-0003jI-3A
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 09:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbZCBIku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 03:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbZCBIku
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 03:40:50 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:2351 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756230AbZCBIkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 03:40:49 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 09:40:45 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 09:40:45 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-3.2-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <e38bce640903011501t2c7a134dp887f5a96db3db0f4@mail.gmail.com>
X-OriginalArrivalTime: 02 Mar 2009 08:40:45.0908 (UTC) FILETIME=[94737140:01C99B12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111918>

--nextPart1966798.TGJr6sEOOM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brent Goodrick wrote:
> On Sun, Mar 1, 2009 at 1:20 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> > [...] have you rewritten the repo hosting 'home' between
> > two fetches?  Using (especially, but not only) git-filter-branch can
> > easily render your history disjoint from the pre-filtering state.
>=20
> Hmmm, maybe, without knowing it.

It's rather hard to rewrite history without knowing it, there are big
warnings all over the relevant tools' manpages...

> Originally, that section of the
> .git/config file had "*"'s where "home" was. To clarify, the original
> was:
>=20
> [remote "origin"]
> 	url =3D <some_ip_address>:git.repos/environ.git
> 	fetch =3D +refs/heads/*:refs/remotes/origin/*
>=20
> and the current one is now:
>=20
> [remote "origin"]
> 	url =3D <some_ip_address>:git.repos/environ.git
> 	fetch =3D +refs/heads/home:refs/remotes/origin/home
>=20
> Maybe I had made that change and this is the first time I am doing a
> fetch to using that change. I thinking that was the cause of this,
> because I retried doing a fetch into a separate throw-away repo with
> just the change of IP address, and it did not need to fetch anything
> more. I had not executed git-filter-branch at all.

Ironically I cannot reproduce this except with my "own" version that
includes the patch I posted yesterday.  I'll have to look into why it
fails to list any refs to the remote.  In the meantime please
disregard that patch.

If you still have a repo that can reproduce the problem, please keep a
copy for future investigation, and then try

  git fetch-pack -v $url refs/remotes/origin/home 2>&1 \
  | git name-rev --stdin

The -v will dump a lot of output about the common commit search.  The
message "giving up" indicates that you hit the 256 commit limit; if
that doesn't appear, please include the full output so that we can see
where it stops.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1966798.TGJr6sEOOM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmrm3gACgkQqUud07tmzP3dRQCdG5GUFjeKnmeKfy/fL6YPXyU/
1igAniU0J09q+vwS1HWWgY2GQQ/4Ivve
=nzYT
-----END PGP SIGNATURE-----

--nextPart1966798.TGJr6sEOOM--
