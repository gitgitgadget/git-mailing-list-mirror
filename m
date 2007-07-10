From: martin f krafft <madduck@madduck.net>
Subject: finding the right remote branch for a commit
Date: Tue, 10 Jul 2007 16:49:07 +0200
Message-ID: <20070710144907.GA324@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:49:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8H1e-00013F-Id
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbXGJOtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbXGJOtL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:49:11 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:35695 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbXGJOtK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:49:10 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id CFDE5895D73
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:49:08 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17966-04 for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 16:49:08 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 90352895D72
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:49:08 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id BCB6D9F121
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:49:07 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 94A0A43FC; Tue, 10 Jul 2007 16:49:07 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52083>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I am trying to figure out a way to store ~/.etc in git. With SVN,
I would have a .etc repository for each machine, which would use
svn:externals to reference locations of the various subdirectories,
which SVN would then pull and assemble. Thus, my ~/.etc might be

  ~/.etc
  ~/.etc/ssh [svn+ssh://svn.madduck.net/priv/etc/ssh]
  ~/.etc/vim [svn+ssh://svn.madduck.net/pub/etc/vim]
  ...

With git, I am now considering using remote branches for this kind
of stuff. So I'll have a repository for my ssh config and
a repository for my vim config, and so on.

The idea then is to create another repository for each machine and
to register the remote tracking branches there in much the same way
that I used svn:externals previously (and with the added benefit
that I don't have to stay within subdirectories).

Thus, the vim repository might look like this:

  .etc/
  |-- vim/
  |   `-- rc.vim
  `-- .vimrc -> .etc/vim/rc.vim

and the ssh configuration might be

  .etc/
  |-- ssh/
  |   |-- config
  |   `-- authorized_keys
  `-- .ssh -> .etc/ssh/

My theory is that merging all those remotely tracked branches into
a local repo populates my home directory, and bringing it up to the
latest version is as simple as:

  git remote update
  git branch -r | xargs git merge   # any way to just merge all remote bran=
ches?

So far so good, this seems to work just fine.

Right now I am trying to figure out how to push updates back to the
central store so that other machines who "subscribe" to a given
branch can receive the updates.

For instance, I may have made a change to ~/.vimrc and to
~/.ssh/config and committed each to the machine-local repository.
What I need now is a way to tell me

  (a) which commits are local and have not been merged from a remote
      tracking branch. If I actually want to keep commits local,
      e.g. because of changes only applicable to this one machine,
      I can move them to a local branch and rebase that whenever the
      remotes change.

  (b) which commits should be pushed where. This is a bit of
      a strange one it may seem, but in my case, remote branches are
      orthogonal and never touch the same file. Thus, each file
      belongs to one remote branch. How can I determine which one?

      Or even better, how could I push all my local commits to the
      respective remotes?

Thanks for any comments, and sorry to be cluttering the list with my
newbie stuff...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"moderation is a fatal thing. enough is as bad as a meal. more than
 enough is as good as a feast."
                                                        -- oscar wilde

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGk5xjIgvIgzMMSnURAkfKAKClMqqRP2i1+viP1UAkc96dYO/erACeP6ia
6WYcjxFlHlefxAafniRvFdA=
=1EJG
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
