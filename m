From: martin f krafft <madduck@madduck.net>
Subject: inconsistent use of worktree? (resend)
Date: Sat, 15 Sep 2007 17:23:03 +0200
Message-ID: <20070915152303.GA12859@piper.oerlikon.madduck.net>
References: <20070906134138.GA8548@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Cc: matled@gmx.net, Johannes.Schindelin@gmx.de
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 17:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWZUN-0003Tx-A2
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 17:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbXIOPXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbXIOPXP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 11:23:15 -0400
Received: from clegg.madduck.net ([82.197.162.59]:49429 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbXIOPXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 11:23:14 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 8BBC6BA3A7;
	Sat, 15 Sep 2007 17:23:04 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id F40149F161;
	Sat, 15 Sep 2007 17:23:03 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id BE574B3106; Sat, 15 Sep 2007 17:23:03 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>, matled@gmx.net,
	Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <20070906134138.GA8548@piper.oerlikon.madduck.net> <20070906132906.GA7791@piper.oerlikon.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4279/Sat Sep 15 14:53:34 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58253>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[this message received no replies, I thus resend once with Matthias
and Johannes on Cc, and slightly modified]

Hi there,

I have a $GIT_DIR in ~/.bin/colgit.git, which is bare=3Dfalse and has
worktree=3D.. (the parent). This relates back to a suggestion by
Johannes Schindelin [0] for maintaining files like ~/.vimrc and
~/.zshrc in separate repos sharing the same worktree. In short:
while ~/.bin/colgit.git holds all of colgit's objects, refs, and the
index, the repository's files are in ~/.bin (and thus in $PATH).

0. http://marc.info/?l=3Dgit&m=3D118418927823760&w=3D2

I am trying to figure out a sensible way to work with this, ideally
one which does not require me to set $GIT_DIR (which works):

  GIT_DIR=3D~/.bin/colgit.git git status
  GIT_DIR=3D~/.bin/colgit.git git add ...
  GIT_DIR=3D~/.bin/colgit.git git commit ...
  (or one export GIT_DIR)

but that's a lot of typing and thus error-prone.

I found this to work:

  piper:~/.bin/colgit.git> git status
  # On branch master
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #
  #       modified:   colgit
  #
  no changes added to commit (use "git add" and/or "git commit -a")

  piper:~/.bin/colgit.git> git add ../colgit

  piper:~/.bin/colgit.git> git status
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #       modified:   colgit

and I rejoiced, because that's really pretty cool. But then, trying
to commit, reality hit back:

  piper:~/.bin/colgit.git> git commit -m'initial commit'
  nothing to commit (use "git add file1 file2" to include for commit)

So I had to revert to using GIT_DIR for this:

  piper:~/.bin> GIT_DIR=3Dcolgit.git git commit -m'initial commit'
  Created initial commit 008594d: initial commit
   1 files changed, 104 insertions(+), 0 deletions(-)
   create mode 100755 colgit

And then things got really weird, after I accidentally tried the
direct commit (without GIT_DIR) again, following some touchups
I made to the colgit file:

  piper:~/.bin/colgit.git> git commit -m'repairing registration and other t=
ouchups'
  Created commit acd86b9: Merge branch 'vimplate'

First, it seems that commits work just fine for changes made only to
files already tracked by git, but not if a commit introduces a new
file.

But second, git-commit does appear to get really confused, since
the commit it claims to have just created is actually not part of
the current repository, but rather the HEAD of the repository in
~/.git (which tracks ~).

git-commit -a also does not work:

  piper:~/.bin/colgit.git> git commit -m'add list action to enumerate all k=
nown repos' -a
  error: .bin/colgit: cannot add to the index - missing --add option?
  fatal: Unable to process path .bin/colgit

And finally, git-diff seems to think that I removed the file, rather
than to show differences:

piper:~/.bin/colgit.git> git diff | diffstat                               =
                     #[334]
 colgit |  138 ------------------------------------------------------------=
-----
 1 file changed, 138 deletions(-)

When in fact:

piper:~/.bin> GIT_DIR=3Dcolgit.git git diff | diffstat                     =
                       #[342]
 colgit |    1 +
 1 file changed, 1 insertion(+)

It seems to me that worktree support is still somewhat buggy. Has
anyone experienced similar things? Does anyone have an idea what
this could be about?

I hope to be able to go through the code in the near future but
I first have to learn a lot about git innards, so this could take
a while. Maybe Matthias has a clue? I'd be happy yo test.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"i wish there was a knob on the tv to turn up the intelligence.
 there's a knob called 'brightness', but it doesn't seem to work."
                                                          -- gallagher
=20
spamtraps: madduck.bogus@madduck.net

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6/jXIgvIgzMMSnURAsSkAKDFatQd9kFULfR2Aywal3XcBV7BpQCfSMOo
KfNIA1Aq4/MqKoIjPFKnZmQ=
=HaVM
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
