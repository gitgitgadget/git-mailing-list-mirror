From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 23:04:02 +0100
Message-ID: <20080420215700.GA18626@bit.office.eurotux.com>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org> <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:06:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhen-0006B8-1u
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbYDTWEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbYDTWEN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:04:13 -0400
Received: from os.eurotux.com ([216.75.63.6]:42600 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYDTWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:04:12 -0400
Received: (qmail 7388 invoked from network); 20 Apr 2008 22:04:10 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Apr 2008 22:04:10 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79988>


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2008 at 09:03:13AM -0700, Linus Torvalds wrote:
>=20
>=20
> On Sun, 20 Apr 2008, Luciano Rocha wrote:
> >=20
> > That's a lot. Why not use a stat cache?
>=20
> Well, the thing is, the OS _does_ a stat cache for us, and the one that=
=20
> the OS maintains is a lot better, in that it works across processes and i=
s=20
> coherent with other processes changing things.

Sure. I am even unsure if the cache didn't break any sanity check (did a
file change after ...? Did someone chdir(2)?).

> And the thing is, your stat cache makes the *common* cases slower. I=20
> didn't do a whole lot of testing, but on my machine, doing just a "git=20
> status" with and without your stat cache shows
<snip>

Well, it can be improved. The memcpy can be avoided by using the stored
data directly, and a _or_die can be added for the common case.

> Now, admittedly, I also do think that we should generally optimize the=20
> slow cases more than we should care about things that are already very=20
> fast, so I do not think that it's wrong to say "ok, let's make the really=
=20
> fast case a bit slower, in order to not be so slow in the bad case", so i=
n=20
> that sense I do not think the slowdown is disastrous.
>=20
> BUT.=20
>=20
> I really dislike adding a cache that is there just because we do somethin=
g=20
> stupid. We can fix the over-abundance of lstat() calls by just being=20
> smarter. And the smarter we are, the less the cache will help, and the=20
> more it will hurt. Which is the real reason why I think the cache is a=20
> really really bad idea: it optimizes for the wrong kind of behavior.

I agree completly. If we can reduce the number of (l)stat calls to a
single one per file, then we'll all be happier. But that kind of change
is beyond my current understanding of git internals. ;)

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFIC73SinSul6a7oB8RAl8MAJ9z7LRL54ndM30XaklgoPxNsZ5hogCfeHU2
78wnYdEazMwH6vL2kZVF3w0=
=vxbI
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
