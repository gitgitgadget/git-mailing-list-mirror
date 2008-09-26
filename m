From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Fri, 26 Sep 2008 17:15:17 +0200
Message-ID: <20080926151517.GV23137@genesis.frugalware.org>
References: <20080925235029.GA15837@neumann> <1222389359-22191-1-git-send-email-vmiklos@frugalware.org> <20080926010312.GE6816@neumann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZtAI5QFBF0GmLcW"
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:16:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjF3W-0005T9-J7
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbYIZPPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYIZPPU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:15:20 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52777 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbYIZPPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:15:19 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A64BA58054;
	Fri, 26 Sep 2008 17:15:17 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9B4384465E;
	Fri, 26 Sep 2008 17:15:17 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8B0CA11901A1; Fri, 26 Sep 2008 17:15:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080926010312.GE6816@neumann>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96866>


--NZtAI5QFBF0GmLcW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2008 at 03:03:12AM +0200, SZEDER G=E1bor <szeder@ira.uka.de=
> wrote:
> * FAIL 18: Hand committing of a redundant merge removes dups
>        =20
>        =20
>                 git rev-parse second master >expect &&
>                 test_must_fail git merge second master &&
>                 git checkout master g &&
>                 EDITOR=3D: git commit -a &&
>                 git cat-file commit HEAD | sed -n -e "s/^parent //p"
> -e "/^$/q" >actual &&
>                 test_cmp expect actual
>        =20
>        =20
>=20
> * failed 1 among 18 test(s)
> make: *** [t7502-commit.sh] Error 1

OK, here is the scenario.

The basic problemis that if it's git-commit that creates the merge
commit and not git-merge, then git-commit does not "know" that git-merge
was invoked using --no-ff.

--no-ff means that if reduce_heads() removes a parent, that will be a
problem, since the resulting commit will no longer be a merge commit.

I think we can't avoid storing this info in a MERGE_MODE file, because
we have to add HEAD to the list of parents in case --no-ff is used, but
we should not do so in case it's reachable from existing heads and
--no-ff is not used.

I'll send a patch that does this in a bit.

--NZtAI5QFBF0GmLcW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjc/IUACgkQe81tAgORUJbrMACeI9M4dxlj+STTzZcL9KdwJKXx
EpsAoJUoTgJKP2PUOAWCs95V+XPmH+2h
=ypr1
-----END PGP SIGNATURE-----

--NZtAI5QFBF0GmLcW--
