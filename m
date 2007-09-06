From: martin f krafft <madduck@madduck.net>
Subject: [announce] colgit: manage git repository collections
Date: Thu, 6 Sep 2007 12:11:15 +0200
Message-ID: <20070906101115.GA29360@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Cc: home in vcs discussion list <vcs-home@lists.madduck.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEKg-0006fh-Kw
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXIFKLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 06:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbXIFKLZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:11:25 -0400
Received: from clegg.madduck.net ([82.197.162.59]:47031 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbXIFKLY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 06:11:24 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 39D38BEC0;
	Thu,  6 Sep 2007 12:11:16 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A88039F161;
	Thu,  6 Sep 2007 12:11:15 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 7A08A43F4; Thu,  6 Sep 2007 12:11:15 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57856>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Ob crosspost: please keep vcs-home on Cc all times. Please remove
git mailing list from Cc when the reply isn't enough about git]

Dear colleagues,

Last night, while Andy Roddick was giving his best against bored
world champion Roger Federer (and still lost after a game of many
crazy shots), I reached what I think is a milestone in my attempt to
let git manage my home directory across several machines. I called
it colgit, which attempts to hint at "collection of gits", and this
is the birth announcement of this shell script.

  http://git.madduck.net/v/bin/colgit.git

The problem I am trying to solve is that I maintain different
projects in different repos, including scripts in ~/.bin and
configuration files, and that I use multiple computers on a daily
basis. Moreover, I might happen upon a new computer which I have to
use for a few days and would like to be able to set up my account
easily.

With SVN, I'd have a repository for each machine, which existed only
of svn:externals references pulling in other repos and thus
assembling my home directory. git-submodule isn't quite designed for
this sort of stuff, and thus I came up with colgit.

The idea is simple: ~ is a git repository with a .colgit/ directory,
which hosts a hierarchy of directories holding a selection of files
=66rom .git directories. For instance, ~/.colgit/.etc/mutt/config is
the git-config file for the repository that I want to have in
~/.etc/mutt. Since all of ~/.colgit is checked in to the repo in ~,
I can easily clone that for another machine, or branch from it and
add yet other repositories, or remove some.

Each directory in ~/.colgit can also hold hooks, description, and
info/exclude, which are used to seed the repository in the plain
~ hierarchy. Right now, the design requires a central repository and
appropriate remote.origin.*/branch.master.merge entries in the
config file so that it can initialise repositories on new machines.

colgit currently is still very much a hack, but it already sports
the following commands:

  update/init: for each leaf directory in ~/.colgit, create the
  corresponding repository in ~, seed it, and run git-pull. If the
  respository already exists, just pull.

  register: given an existing repository somewhere under ~, obtain
  the relevant config files from its $GIT_DIR and populate the
  corresponding directory under ~/.colgit.

  status: for each leaf directory in ~/.colgit, query the
  corresponding repository in ~ and note to stdout if it has local
  changes

I also envision the following commands:

  add: given a repository URL and a local path, clone the repository
  and run register

  do: run the given git commands over each known repository

The process of initialising an account on a remote machine thus
becomes:

  git clone -n ssh://.../machines/base temp && mv temp/.git ~
  cd ~ && git checkout HEAD
  ...
  colgit init

This is release early release often, so it's far from perfect and
and probably buggy. But suggestions and patches are welcome!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
# vim:tw=3D70
=20
spamtraps: madduck.bogus@madduck.net

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG39JDIgvIgzMMSnURAl/CAKCVmJULatIqlqLshmQSdGNDHX1XfACg11aN
qSpLrAqKWvrKyky//hqhqro=
=peiS
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
