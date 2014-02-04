From: Miklos Vajna <vmiklos@collabora.co.uk>
Subject: Re: git log history simplification problem
Date: Tue, 4 Feb 2014 20:05:18 +0100
Message-ID: <20140204190516.GD17861@collabora.co.uk>
References: <20140204173713.GC17861@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 20:00:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAlE6-0000jP-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 20:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbaBDS77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 13:59:59 -0500
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34482 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbaBDS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 13:59:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id 03785608CAA
Content-Disposition: inline
In-Reply-To: <20140204173713.GC17861@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241539>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 06:37:13PM +0100, Miklos Vajna <vmiklos@collabora.c=
o.uk> wrote:
> But then I run:
>=20
> git grep 'mnTitleBarHeight =3D' sd
>=20
> and it's not there. Am I missing something, as in e.g. even with
> --full-history git-log does some simplification?

I tried to reproduce this with a repo from scratch, and it seems my
problem is the following:

1) "A" creates a feature branch
2) "A" works on it, and in the meantime master progresses as well
3) "A" merges master to the feature branch
4) "A" does some additional changes, and -- in an evil way -- uses "git
commit -a --amend" to squeeze these into the merge commit
5) "B" (that's me) comes and try to find out where a string got deleted,
but can't.

Here is a reproducer script:

----
rm -rf scratch
mkdir scratch
cd scratch
git init
echo -e "a\na\na\na\na\na\na\na\n" > a
git add a
git commit -m init
git branch feature
echo "b" >> a
git add a
git commit -m "more master changes"
git checkout feature
sed -i '1iXXX' a # insert first row
git add a
git commit -m "feature"
git merge -m merge master
sed -i '1d' a # delete first row
git add a
git commit --amend -m "merge"
----

I now know that the XXX got removed by the merge commit, but how can I
see it that I'm right? If I run 'git log --all -p' in the result, I see
that XXX got inserted by one commit, now I don't have it, but I don't
see any deletion, which confuses me.

Any ideas? :-)

Thanks,

Miklos

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLxOewACgkQe81tAgORUJa4vACfYAM8RrtfqGPpgIDq+K9ZcmNh
HxgAoIPH7ytZKeWIvL9Sgtp7/denkhIK
=u3bJ
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
