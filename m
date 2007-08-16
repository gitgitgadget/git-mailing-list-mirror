From: martin f krafft <madduck@madduck.net>
Subject: gitignore and shared worktrees (resend)
Date: Thu, 16 Aug 2007 12:22:25 +0200
Message-ID: <20070816102225.GA5351@piper.oerlikon.madduck.net>
References: <20070717130936.GA19724@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 12:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILcV4-0002Uy-LG
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 12:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761121AbXHPKWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 06:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933323AbXHPKWc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 06:22:32 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:44116 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234AbXHPKW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 06:22:29 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id C0D19895F7D;
	Thu, 16 Aug 2007 12:22:27 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 14974-09; Thu, 16 Aug 2007 12:22:27 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 00B65895F7B;
	Thu, 16 Aug 2007 12:22:26 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 4F2489F171;
	Thu, 16 Aug 2007 12:22:26 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id C72E543F9; Thu, 16 Aug 2007 12:22:25 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20070717130936.GA19724@piper.oerlikon.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56002>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I sent the following message a month ago to the mailing list and
never got a reply. Just to make sure it didn't simply get
overlooked, I am reposting.

Basically the issue is with using multiple git repos all sharing the
same worktree, and that I cannot come up with a sensible way to
maintain the .gitignore file such that it is part of the repo (and
thus exists in other clones as well).

I found that one can actually add and commit $GIT_DIR/info/exclude to
a repo (quite possibly a bug), but the checkout fails without -f, so
this is not really an option.

I could set core.excludesfile to some unique name, but that again is
not saved in the repository and requires manual intervention after
cloning.

I still like best the suggestion to honour .gitignore/* in case
=2Egitignore is a directory instead of a file. Would people be
interested in a patch for this?

----- Forwarded message from martin f krafft <madduck@madduck.net> -----

Date: Tue, 17 Jul 2007 15:09:36 +0200
=46rom: martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: gitignore and shared worktrees (was: finding the right remote
	branch for a commit)
Message-ID: <20070717130936.GA19724@piper.oerlikon.madduck.net>

Sorry for the somewhat late reply, I just found time on the weekend
to check out this suggestion by Johannes

  (http://marc.info/?l=3Dgit&m=3D118418927823760&w=3D2)

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.07.11.21=
26 +0200]:
> Come to think of it, this is maybe what I would have done, but it
> appears to me that this is the _ideal_ use case for worktree:
>=20
> In $HOME/gits:
>=20
> $ mkdir vim.git && cd vim.git
> $ git --work-tree=3D$HOME init
> $ cat >> info/exclude < EOF
> *
> !/.vimrc
> EOF
>=20
> Then you could do all Git operations like push, fetch, pull, log in=20
> $HOME/gits/vim.git, and all editing in $HOME.

This actually seems to work really nicely, but I am somewhat
displeased by the gitignore/exclude handling, since it's local. What
I want to do is synchronise the vim configuration across many
workstations with git, and I don't want to have to modify
$GIT_DIR/info/exclude on each machine.

So I am tempted to use .gitignore, but that lives in the worktree,
and since the suggestion is to share worktrees between different git
repos, I can only ever have one .gitignore file, which would have to
list ignores for *all* repos in $HOME/gits, which breaks my head.

Do you have any other idea on how to handle ignores? I guess one
alternative is just to ignore git status output altogether, but
that's not really nice.

Would people consider honoring .gitignore-* in addition to just
=2Egitignore? Or maybe even honouring .gitignore/*, if .gitignore is
a directory, not a file?

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
fashions have done more harm than revolutions.
                                                        -- victor hugo
=20
spamtraps: madduck.bogus@madduck.net

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxCVhIgvIgzMMSnURAniqAJ91JoRPNKy+r9FflCO25d8FsAOm2gCffIbm
y2YMKy1zfdatgTlruI5N5eY=
=VmuX
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
