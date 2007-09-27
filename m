From: Pierre Habouzit <madcoder@debian.org>
Subject: git push (mis ?)behavior
Date: Thu, 27 Sep 2007 15:04:47 +0200
Message-ID: <20070927130447.GH10289@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="e5GLnnZ8mDMEwH4V";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 15:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iat3A-0004DW-Q9
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 15:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbXI0NE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbXI0NE5
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 09:04:57 -0400
Received: from pan.madism.org ([88.191.52.104]:51998 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbXI0NE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 09:04:57 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 14CAFC8F3
	for <git@vger.kernel.org>; Thu, 27 Sep 2007 15:04:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 01579DC14; Thu, 27 Sep 2007 15:04:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59295>


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  There is a behavior of git-push that is the most annoying thing while
working with a central-repository: `git push` without any arguments
insists on pushing every local refspec that match one in origin.

  While it's perfectly correct when you push to a public repository (you
do that seldom, and usually only after having prepared it with care),
it's not true for the central-repository layout. At work, I often have
this situation:

  [I'm in the devel branch, would be next for git e.g.]
  ... hack ... hack ... *OMG* what a nasty bug...
  $ git stash
  $ git checkout <stable branch>
  .. fix nasty bug ..
  $ git commit
  $ git push # so that co-workers have the fix asap
  $ git checkout <devel branch>
  $ git stash apply
  ... OOOOH NOES it pushed my WIP in my devel branch as well ...

  There has been (and still is atm) a quite heated discussion on IRC
about that. Some arguments were that pull/push were opposite words in
English, but weren't doing an opposite thing in git, which led to some
fight. But that's not close to the point IMHO.

  The real question is "what does users intend when they `git push`". In
a git/kernel/... like model, you don't think the same than in a
svn/cvs-like model. I mean, Junio or Linus likely don't push a lot to
their public repository. It happens probably a couple of time per day.
While I'm at work, it happens up way more frequentely, and I then want
to lazily type `git push` and not `git push origin <somebranch>`. it's
too long.

  I'm not sure what we can do about it, but I'm pretty sure it bites a
lot of people out there. For now I use this alias in my .gitconfig:

  p=3D!git-push origin `git-symbolic-ref HEAD`

but still, it feels really wrong to me. Not to mention that git-push(1)
says that it has a --all option that in fact is the current default
behavior, hence sounds pretty useless.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+6pvvGr7W6HudhwRAik1AKCQ7aHrOXhMkKU0Y3wd6laAaOQMSwCbBNzt
9GZtLBBRLmQX5JtV+OEVUjg=
=r31w
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
