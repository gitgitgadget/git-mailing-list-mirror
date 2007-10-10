From: martin f krafft <madduck@madduck.net>
Subject: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 02:55:45 +0100
Message-ID: <20071010015545.GA17336@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 03:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfQns-0003Dn-SU
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 03:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbXJJBzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 21:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbXJJBzy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 21:55:54 -0400
Received: from clegg.madduck.net ([82.197.162.59]:46104 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbXJJBzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 21:55:53 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 81A6ABE8C
	for <git@vger.kernel.org>; Wed, 10 Oct 2007 03:55:48 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id A82C257DDA; Wed, 10 Oct 2007 02:55:45 +0100 (BST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4516/Tue Oct  9 19:31:18 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60457>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I hope this is not a daily series of mine, being confused about Git
merging, but I've run my head against a wall again and before
I crush my skull, I'd prefer to reach out to you to help me regain
an understanding.

This is about the new mdadm for Debian packaging effort. You can
clone from git://git.debian.org/git/pkg-mdadm/mdadm-new.git and see
the repo at
http://git.debian.org/?p=3Dpkg-mdadm/mdadm-new.git;a=3Dsummary. Do not
track as this repo is subject to change.

My master branch was last merged with upstream's mdadm-2.6.2 tag
(commit 263a535). Since then, I've committed a couple of changes to
master including three cherry-picks from upstream since mdadm-2.6.2.

I tagged upstream at the point which I want to merge into master:
mdadm-2.6.3+200709292116+4450e59. When I merge that tag into master,
I get a merge conflict on Monitor.c:

  <<<<<<< HEAD:Monitor.c
                                  if (mse->devnum !=3D MAXINT &&
  =3D=3D=3D=3D=3D=3D=3D
                                  if (mse->devnum !=3D INT_MAX &&
  >>>>>>> upstream:Monitor.c

There are five commits between mdadm-2.6.2 and
mdadm-2.6.3+200709292116+4450e59 that affect Monitor.c:

  01d9299
  e4dc510
* 66f8bbb
  98127a6
  4450e59

The third commit, the one with the asterisk is the one that
I cherry-picked (as 845eef9); the other two cherries I picked do not
touch Monitor.c.

The fifth/last commit (4450e59) is the one responsible for the
change which seems to cause the conflict. It is the *only* commit
since the common ancestor of *both* branches that touches the
conflicting lines.

The fourth commit (98127a6) inserts a single line at the top of the
file, so that's nothing that would cause a conflict.

To be honest, I can't explain it. But I didn't give up.

I branched master2 off 845eef9b~1, cherry-picked the first two
commits that touch Monitor.c, cherry-picked all the commits
845eef9b..master into master2 and merge upstream...

=2E.. to get exactly the same conflict in exactly the same line in
exactly the same file.

What is going on. Am I seriously overestimating Git's merging
capacities, or do I have a bug in my brain?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"the only difference between shakespeare and you
 was the size of his idiom list -- not the size of his vocabulary."
                                                      -- alan perlis
=20
spamtraps: madduck.bogus@madduck.net

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDDEhIgvIgzMMSnURAnqjAKDSD3vBj2gyX5IiCM9nLLmIzKNdNwCfbGub
kNC8GYAol5XE04nfcz8xYKg=
=u//n
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
