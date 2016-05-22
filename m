From: Joey Hess <id@joeyh.name>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Sun, 22 May 2016 15:04:04 -0400
Message-ID: <20160522190404.GA20998@kitenet.net>
References: <20160517171836.GA12183@kitenet.net>
 <xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
 <20160517182645.GA27396@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 21:05:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Ygy-0000Lc-9q
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbcEVTER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 15:04:17 -0400
Received: from kitenet.net ([66.228.36.95]:55502 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbcEVTEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 15:04:16 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=b3egMzWW;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463943844; bh=700fJk6Ud3QTNhjJM9l3VkfN43170pNTE6bbfBj8Ka4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=b3egMzWWzAff5NjNH48jS5QN7E850imqFzeGNuJS2SYsHcZZXVBPInnjgWWj6X76C
	 e86hgH9G09x/Ul7Ud+b6jHe307kOPImtuEX5gvo14N0mksUiV9XNS1EjEhlHKliwNj
	 CFt8n4x2KeltOCes477cAI1595M1Ux63jzyX/J6w=
Content-Disposition: inline
In-Reply-To: <20160517182645.GA27396@kitenet.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-93.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295288>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is actually worse than I thought; when git is being run with a
detached work tree, GIT_INDEX_FILE is treated as a path relative to CWD,
instead of the normal behavior of relative the top of the work tree.

Normal and expected (according to this thread anyway):

joey@darkstar:~/src/other/git/Documentation> input=3D"100644 8a1218a1024a21=
2bb3db30becd860315f9f3ac52 1    frotz"
joey@darkstar:~/src/other/git/Documentation> echo "$input" | GIT_INDEX_FILE=
=3D.git/newindex git update-index --index-info=20
joey@darkstar:~/src/other/git/Documentation> ls ../.git/newindex=20
=2E./.git/newindex

Fully detached worktree and git dir:

joey@darkstar:/> echo "$input" | GIT_INDEX_FILE=3D.git/index git --git-dir=
=3D/home/joey/src/other/git/.git --work-tree=3D/home/joey/src/other/git upd=
ate-index --index-info=20
fatal: Unable to create '/.git/index.lock': No such file or directory
joey@darkstar:/> echo "$input" | GIT_WORK_TREE=3D/home/joey/src/other/git G=
IT_DIR=3D/home/joey/src/other/git/.git GIT_INDEX_FILE=3D.git/newindex git u=
pdate-index --index-info=20
fatal: Unable to create '/.git/newindex.lock': No such file or directory

Work tree detached via git configuration:

joey@darkstar:~/src/other/git> git config core.worktree /home/joey/src/othe=
r/git/tmptree
joey@darkstar:~/src/other/git> mkdir tmptree
joey@darkstar:~/src/other/git> cd tmptree/
joey@darkstar:~/src/other/git/tmptree> mkdir Documentation
joey@darkstar:~/src/other/git/tmptree> cd Documentation/
joey@darkstar:~/src/other/git/tmptree/Documentation> echo "$input" | GIT_IN=
DEX_FILE=3D.git/index git update-index --index-info
fatal: Unable to create '/home/joey/src/other/git/tmptree/.git/index.lock':=
 No such file or directory

This seems to make it basically impossible for any program that wants to
use GIT_INDEX_FILE to use anything other than an absolute path;
there are too many configurations to keep straight that could change how
git interprets what should be a simple relative path to a file.

--=20
see shy jo

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV0ICpMkQ2SIlEuPHAQKeRQ/8CWvv8Tx06ezQU4MZLloeu8e6I+vZvfv1
7x2o8eAqvrITwN8HuIDTbDhatc4YTB+CdAQWLutzABkAxckXLivkFg7B357pXxGI
e7aF0Wo4lxecIqRZUoTUHx3Zq92lA7yfBBsSYf9I9Xb/PyVNFHurV2CSbdf/Gya5
Pm41jpL9IdfUTRrIyZuN4uikuzRQspVUwKoE9rGf3TWwlvaONznQp3vvalpU+c1w
HBSR7C4NbvJ/bEWh5/IeA/0ILC4tME+B4WV1Tknw9AuawqXQa14B9YeXtKLEOhfM
UlgdQ0bdfNzsG/GzsETBRWnXtt45YReNvFILZ9KHlSxEN4t3GnQsDvoVZ0gQciTD
xLvevVI0LAK1X70o/HyUCiJ+Rw5Nf2j6XdTTeALiP5jilJWgmkF/X1KHUh1LQLLk
5C7griG4LivSaypNYG0fvflRBnpPG5ianSAqhLKtxNUlYfF0g/8xFE2e4zFstvlM
7pTIdExcQkQt5qyBbNEIim+wkGhYLdk6DeMjakn1/XHZGjbRzqLyFhRDA5S/KLjJ
fRTiyGX47JAMKv6KTPqzTqZ9vLUe6SErxyV2vzVc27FAltIndVg9n+bLqMl/iUus
bqc3pzVyT1yfsdwHNDTj1lVe5/Q3eD7xnP1WeJC4mYkQL6qrzcCkXk2ZToMxZUWe
AUUoviW3cJ8=
=hN1t
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
