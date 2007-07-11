From: martin f krafft <madduck@madduck.net>
Subject: Re: how to combine two clones in a collection
Date: Wed, 11 Jul 2007 21:22:25 +0200
Message-ID: <20070711192225.GB31957@piper.oerlikon.madduck.net>
References: <20070711181301.GA26815@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707111929120.4516@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:23:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hmn-0007Ce-Po
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 21:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbXGKTWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764417AbXGKTWa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 15:22:30 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:57383 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933061AbXGKTW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 15:22:28 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 12AA8895D74
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 21:22:27 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 00736-10 for <git@vger.kernel.org>;
	Wed, 11 Jul 2007 21:22:26 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id B557D895D72
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 21:22:26 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 0FC089F15D
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 21:22:26 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id DA56C43FC; Wed, 11 Jul 2007 21:22:25 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707111929120.4516@racer.site>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52191>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, Johannes, for this explanation. I actually had to prod him
on IRC a bit more until I understood, but the result is now
available on my blog:

  http://blog.madduck.net/vcs/2007.07.11_creating-a-git-branch-without-ance=
stry

  [...]
  Update: Johannes Schindelin taught me how to do the same without
  touching files in .git/:

  $ git symbolic-ref HEAD refs/heads/newbranch
  [...]

  and also addressed the issue which would have all files already
  committed to the "master" branch now appear in the git status
  output as staged.

  This is because the index contains the full copy of a revision of
  a file, as it would be if committed at any point. git status shows
  the differences between what has been committed, what would be
  committed, and what is available in the working tree. Since we
  pointed HEAD to nowhere ("newbranch" does not yet exist), the
  index and what has been committed (nothing in this case) diverge,
  the files are still staged, and thus are scheduled to be part of
  the impending commit.

  The way to fix this is to remove the index:

    $ rm .git/index

  This may seem weird, but it works, because git recreates the index
  whenever you switch branches:

    piper:~> git init-db
    Initialized empty Git repository in .git/
    piper:~> echo 1 > a; git add a; git commit -m.
    Created initial commit e774324: .
    1 files changed, 1 insertions(+), 0 deletions(-)
    create mode 100644 a
    piper:~> git symbolic-ref HEAD refs/heads/newbranch
    piper:~> rm .git/index
    piper:~> git status
    # On branch newbranch
    #
    # Initial commit
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       a
    nothing added to commit but untracked files present (use "git add" to t=
rack)
    piper:~> echo 2 > b; git add b; git commit -m.
    Created initial commit 54ff342: .
    1 files changed, 1 insertions(+), 0 deletions(-)
    create mode 100644 b
    piper:~> git branch
      master
    * newbranch
    piper:~> git checkout master
    fatal: Untracked working tree file 'a' would be overwritten by merge.
    piper:~> git checkout -f master

    Switched to branch "master"
    piper:~> git status
    # On branch master
    nothing to commit (working directory clean)
    piper:~> ls
    a
    piper:~> git checkout newbranch
    Switched to branch "newbranch"
    piper:~> git status
    # On branch newbranch
    nothing to commit (working directory clean)
    piper:~> ls
    b

  As you can see, the creation of the branch is a bit complex, but
  once you (forcefully) switched back to master, you can then
  freely switch between and commit to them.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"when women love us, they forgive us everything, even our crimes;
 when they do not love us, they give us credit for nothing,
 not even our virtues."
                                                   -- honor=E9 de balzac

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlS3xIgvIgzMMSnURAl1nAKDOCEpKSaNKsPp3bJHQ5GekjLVVOQCg42dR
dUEwa2NFgQsVACKqc/rX03g=
=pj1i
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
