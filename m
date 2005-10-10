From: Elfyn McBratney <beu@gentoo.org>
Subject: [RFC] Cleaning up die() error messages
Date: Mon, 10 Oct 2005 11:50:08 +0100
Message-ID: <20051010105008.GB30202@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
X-From: git-owner@vger.kernel.org Mon Oct 10 12:52:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOvEX-0008UN-KY
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 12:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVJJKuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 06:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVJJKuN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 06:50:13 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:19726 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750742AbVJJKuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 06:50:12 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=zippy.emcb.local)
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1EOvEQ-0001Ni-19
	for git@vger.kernel.org; Mon, 10 Oct 2005 10:50:10 +0000
Received: by zippy.emcb.local (Postfix, from userid 1001)
	id 9D343148042; Mon, 10 Oct 2005 11:50:09 +0100 (BST)
To: git mailing list <git@vger.kernel.org>
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
Organisation: Gentoo Foundation, Inc.
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9885>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello git list,

I've started working on cleaning up the various die() error messages
found throughout git, and had a few thoughts along the way.

Currently, I've been adding missing program name prefixes, and quoting path
names (e.g., "%s" -> "'%s'"), but before I go any further, I'm wondering
if this is a) desired, or perhaps b) superfluous?  This may be best
discussed with along-side the patch - which'll follow shortly. ;)

Also, I got to thinking whether it might be an idea to use the following
idiom in the code:

	[shell scripts]
	prog=3D"`basename $0`"
	..
	foo || die "${prog}: foo failed"

	[C sources]
	static char *prog;
	..
	static inline void set_prog_name (char *argv0)
	{
		prog =3D strrchr(argv0, '/');
		if (prog)
			prog++;
		else
			prog =3D argv0;
	}
	..
	int main (int argc, char **argv)
	{
		set_prog_name(argv[0]);
		..
		if (!do_bar())
			die("%s: do_bar() failed", prog);
		..
	}

The idea behind this being that, if any of the git programs get renamed
(again :) there won't be a need for s/git-foo/git-bar/g just to fix-up
die() error messages, and it'll also shave a *bit* off of the size of the
compiled binaries. ;)

(Of course, the C parts (`prog' and `set_prog_name()') would go into a
header, and not in every single C source file. ;)

So, any thoughts/comments/flames? :)

Best,
Elfyn

--=20
Elfyn McBratney
Gentoo Developer/Perl Team Lead
beu/irc.freenode.net                            http://dev.gentoo.org/~beu/
+------------O.o--------------------- http://dev.gentoo.org/~beu/pubkey.asc

PGP Key ID: 0x69DF17AD
PGP Key Fingerprint:
  DBD3 B756 ED58 B1B4 47B9  B3BD 8D41 E597 69DF 17AD

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDSkdgjUHll2nfF60RAqP4AKCjCOhsHgxPdVaTiZHE1PFc7Ey6bACggqWI
5gzBPwyFrtnJN/t7K6pAX9I=
=yV1v
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
