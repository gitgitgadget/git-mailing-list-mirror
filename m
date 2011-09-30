From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need
 before updating our ref) breaks fetch
Date: Sat, 01 Oct 2011 01:48:10 +0200
Message-ID: <1317426491.4331.23.camel@centaur.lab.cmartin.tk>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
	 <20110928185327.GB1482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-3YCvFZQG1MEFnmUO11VP"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 01 01:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9moT-0003SU-2D
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 01:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab1I3XsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 19:48:12 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56179 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620Ab1I3XsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 19:48:11 -0400
Received: from [192.168.1.17] (brln-4dbc5ac8.pool.mediaWays.net [77.188.90.200])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 12A4D4617B;
	Sat,  1 Oct 2011 01:47:47 +0200 (CEST)
In-Reply-To: <20110928185327.GB1482@sigill.intra.peff.net>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182526>


--=-3YCvFZQG1MEFnmUO11VP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-09-28 at 14:53 -0400, Jeff King wrote:
> On Wed, Sep 28, 2011 at 06:04:27PM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > Whilst trying to do some work related to fetch, I came across a
> > regression in the 'next' branch. Bisecting gave me this commit as
> > breaking point (and I tried with the parent and there it worked). When
> > doing 'git fetch', rev-list will complain about usage, and fetch will
> > say that we didn't receive enough, even though earlier versions of git
> > have no problems. This fails both on github and on git.or.cz and for gi=
t
> > and http transports:
> >=20
> > $ ./git-fetch git://repo.or.cz/git
> > usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
>=20
> Hmm. I notice you're running a not-installed version of fetch. Might
> this be a problem with a new git fetch running an older, installed
> version of rev-list?

Yes, this seems indeed to be the case.

>=20
> The commit you mention calls rev-list with --verify-objects, but that
> feature is only added in the parent commit. So I can reproduce your
> issue with:
>=20
>   $ git checkout 6d4bb38~2 ;# or anything before --verify-objects
>   $ make install
>   $ git checkout 6d4bb38
>   $ make
>   $ ./git-fetch git://repo.or.cz/git
>=20
> but this works (because it sets the exec path properly):
>=20
>   $ ./bin-wrappers/git fetch git://repo.or.cz/git
>=20
> as does this:
>=20
>   $ make install
>   $ ./git-fetch git://repo.or.cz/git
>=20
> So I don't think there's a bug. It's just that running compiled programs
> straight out of the build directory isn't supported. It works _most_ of
> the time, but as you can see, you may end up calling older, installed
> versions of git. The bin-wrappers scripts set up the exec path properly
> to let you test.

Indeed, as both you and Junio pointed out (within three minutes of each
other :) I was running git from the build directory and expected it to
work, as I was testing a few changed I had made to the fetch code.

Mea culpa, I tend to forget that git tends to behave like a bunch of
shell scripts that happen to be written in C. Thanks to both.

   cmn



--=-3YCvFZQG1MEFnmUO11VP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOhlU6AAoJEHKRP1jG7ZzTJO4H/2Soxcf9BfqRAlXOlm707ZmE
qcSDnDLwN3UljlbJGqVNu2kapbAouQTQMSsOrrTCoP5bg2XrD2AR67d+/nUbbUyV
WTfuDLBJzUBDBl0bIs3dowTvuGNXvba4sVL9TKSblISNKXy+ps94RPxErjVY6i1M
+AvXiBduYKPSOOTqwvlq8OwFtLPfJU1EdADHBCKZi6uAmoa3gFOk/vse/WRCpe3q
f8PZ/QSJ8HF2PwDD6jFT7ZZDCPJOYwjtJRu/NzfStcxlCqwfQOOjoBaspnkBmEXT
XGxF5yi5h5RtmKTMh/H7t2Ilww4MWzNXeESsy9KH3wf/Rs6p24cTy85nHlQIFho=
=XDl1
-----END PGP SIGNATURE-----

--=-3YCvFZQG1MEFnmUO11VP--
