From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: svn-cp equivalent for history on a single file from a git-svn user.
Date: Sun, 27 May 2007 03:14:30 -0700
Message-ID: <20070527101430.GA27013@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: jokey@gentoo.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 12:14:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsFlm-0008An-MC
	for gcvg-git@gmane.org; Sun, 27 May 2007 12:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbXE0KO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 06:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXE0KO2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 06:14:28 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:54988 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750715AbXE0KO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 06:14:27 -0400
Received: (qmail 17688 invoked from network); 27 May 2007 10:14:25 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 27 May 2007 10:14:25 +0000
Received: (qmail 3359 invoked by uid 10000); 27 May 2007 03:14:30 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48526>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Not a problem I ran into directly, but fellow Gentoo developer did
(CC'd), and I couldn't find a reasonable answer as the person that they
were asking hard Git questions of (I _think_ I saw it somewhere on the
web before, but I can't find it atm).

I'm personally a CVS and then Git guy, with SVN usage as a distant
relative. I wouldn't personally host a project in SVN [and I find
git-svn to be a miracle-worker in helping me out].

Some rough problem background:
- They have a SVN repo, with a few areas under trunk. Relevant to us are
  'submitted' and 'reviewed'. Under each, the unique content is in
  directories that are treated as single units.
- It is normal to have both portions checked out at once.
- There are users that can put stuff into the 'submitted' portion.
- There are a subset of users that can commit stuff to 'reviewed'.
- The reviewer subset of users is orthogonal to the people that can
  commit to 'reviewed'.
- $Header$ expansion is disabled in the SVN repo.
- Git v1.5.1.4

Problem:
The Git docs say to use plain 'cp' where svn-cp would be used, as Git
detects copies after-the-fact. However, doing so in Git does not appear
to sanely preserve the history in Git, or when the files are committed
back to the SVN tree (git-svn dcommit).

Here's an example of their process done purely with SVN.
('submitted' =3D sunrise).
http://overlays.gentoo.org/proj/sunrise/changeset/3687
Specifically of interest are the portions that have '(copied from
$OLDPATH)'
'svn log' produces this output:
http://rafb.net/p/bETJkV31.html
The bottom two entries are relevant to the file in it's location inside
the 'submitted' tree, and were copied to the history in the 'reviewed'
tree.

Here's the same thing, done with plain cp per the Git documentation.
The files that previously showed 'copied from ...' just show up as new,
and their history has remained separate.
http://overlays.gentoo.org/proj/sunrise/changeset/3687

If one looks at the SVN log between the two styles on a file that is
newly added, the SVN case includes the history of the file in the old
location, whereas Git does not. Git only has the commit that introduced
it at it's present location.

'svn-cp' revision list:
http://overlays.gentoo.org/proj/sunrise/log/reviewed/app-admin/blockhosts/b=
lockhosts-2.0.3.ebuild?rev=3D3687

'git using plain cp' revision list:
http://overlays.gentoo.org/proj/sunrise/log/reviewed/dev-libs/dswifi/dswifi=
-0.3.1.ebuild?rev=3D3749
Git SHOULD have included this history:
http://overlays.gentoo.org/proj/sunrise/log/sunrise/dev-libs/dswifi/dswifi-=
0.3.1.ebuild?rev=3D3749

While researching this for the other guy, I notice a related defect in
SVN's svn-cp implementation, but pertaining to existing files.
- The actions of 'svn-cp' that create a new file copy the existing
  history.
- The actions of 'svn-cp' that do NOT create a new file only applies the
  changes as a single commit, without copying any history.

Thinking about the problem from the perspective of what it's supposed to
do, I think the correct action in BOTH cases would be to take the
portions of both commits that lead to the present state of the file in
'submitted', and tell Git that they are relevant to the history of the
file in 'reviewed'. As to how best to go about this, I'm not certain.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGWVoGPpIsIjIzwiwRAoAdAJ4g+RMsY7NlWRPq0wBrPGowGv7XgwCgumPp
cJUbhOwI/nbjnHF8E7ZVVIs=
=qy8X
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
