From: Martin Eisenhardt <list-receive@mneisen.org>
Subject: Possible bug in git-svn
Date: Sat, 12 May 2007 18:24:08 +0200
Organization: mneisen.org
Message-ID: <200705121824.14190.list-receive@mneisen.org>
Reply-To: Martin Eisenhardt <martin.eisenhardt@mneisen.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1955241.chiNLjBEnQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 12 18:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmuVS-0003FP-Si
	for gcvg-git@gmane.org; Sat, 12 May 2007 18:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbXELQbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 12:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbXELQbd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 12:31:33 -0400
Received: from node-0.mneisen.org ([88.198.37.77]:60663 "EHLO mail.mneisen.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbXELQbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 12:31:33 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 May 2007 12:31:32 EDT
Received: from dinoso.local (pd9e520f9.dip.t-dialin.net [217.229.32.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mneisen.org (Postfix) with ESMTP id 9F4045A780726;
	Sat, 12 May 2007 18:24:15 +0200 (CEST)
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47063>

--nextPart1955241.chiNLjBEnQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Eric,
hello list,

I came across what might just possibly be a bug in git-svn. My apologies if=
=20
this was already handled somewhere on the list but I was not able to find=20
this exact problem mentioned before.

Let's say I run a SVN repository at svn+ssh://svn@example.com/repos and hav=
e=20
it set up as described at
=09
http://svnbook.red-bean.com/nightly/en/svn.serverconfig.svnserve.html#svn.s=
erverconfig.svnserve.sshtricks

In essence, there is only one user "svn" with access to the repository, and=
=20
every developer has his/her public key in ~svn/.ssh/authorized_keys with a=
=20
line like

command=3D"svnserve -t --tunnel-user=3Dharry -r /svn/" TYPE1 KEY1=20
harry@example.com

This is desirable to limit the developers access to the repository; no shel=
l,=20
access restricted to svn's home directory.

Now let's assume that within this repository, there are several projects, s=
o=20
we have f.e. the following structure:

+-proj1-+-trunk
|       +-branches
|       +-tags
|
+-proj2-+-trunk
|       +-branches
|       +-tags
+-[more projects]

I have no problem setting up a local .git tracking such a project using

    $ git-svn init svn+ssh://svn@example.com/repos/proj1/trunk
    $ git-svn fetch

After having made local changes and commited them to git, I want to push th=
em=20
to the remote subversion repository:

    $ # do some work
    $ git-commit -a
    $ git-svn dcommit

The last command gives me (invariably):

    Couldn't find a repository: No repository found=20
in 'svn+ssh://example.com/repos/proj1/trunk' at at /home/mneisen/bin/git-sv=
n=20
line 403

What is odd is that git-svn uses the URL-prefix svn+ssh://example.com/[...]=
=20
instead of the correct svn+ssh://svn@example.com/[...], i.e., git-svn drops=
=20
the user name.

This behavior is surprisingly inconsistent as git-svn uses the correct user=
=20
name while fetching and stores it correctly in .git/config.

The server log contains the following lines:

May 12 18:18:50 [sshd] Accepted keyboard-interactive/pam for mneisen from=20
217.229.32.249 port 37685 ssh2
May 12 18:18:50 [sshd(pam_unix)] session opened for user mneisen by (uid=3D=
0)
May 12 18:18:51 [sshd(pam_unix)] session closed for user mneisen

which supports my suspicion that git-svn drops the user name for dcommit an=
d=20
uses the current account name instead.

A git repository on the same machine as the subversion repository is able t=
o =20
track the SVN repository, so it seems that my problems are directly related=
=20
to the combination of git-svn and the svn+ssh transport of subversion.

If this an error on my part, please advise me how to solve it.

Kind regards
Martin Eisenhardt

--nextPart1955241.chiNLjBEnQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGReouMNkO5Mfxwc8RAi/yAKCKPInRU5oSS6eYNBa1LuUHrhLDHwCfYJ8T
aLIn5KHQzma6hIldNTmBpYE=
=rX88
-----END PGP SIGNATURE-----

--nextPart1955241.chiNLjBEnQ--
