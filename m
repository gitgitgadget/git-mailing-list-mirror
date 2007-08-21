From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 17:12:43 +0200
Message-ID: <20070821151243.GA29020@artemis.corp>
References: <864pj16r10.fsf@lola.quinscape.zz> <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr> <861wdxgncz.fsf@lola.quinscape.zz> <20070821115611.GA21410@mimvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LZvS9be/3tNcYl/X";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 17:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INVPX-0005ZN-IS
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 17:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760896AbXHUPMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 11:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760879AbXHUPMq
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 11:12:46 -0400
Received: from pan.madism.org ([88.191.52.104]:57609 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760613AbXHUPMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 11:12:45 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A67551B7FE
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 17:12:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 56C9227D5D7; Tue, 21 Aug 2007 17:12:43 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070821115611.GA21410@mimvista.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56301>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2007 at 11:56:11AM +0000, David Watson wrote:
> Now, I'm not sure this is 100% the fault of git-svn. Perhaps keeping its
> metadata about which SVN branch it's connected to isn't the best thing, b=
ut
> git-merge is doing exactly what you ask for. Perhaps we need a merge comm=
and in
> git-svn that does the right thing? Although what that right thing would b=
e, I'm
> not quite sure.  Either way, there needs to be a BIG GIGANTIC WARNING in =
the
> git-svn manual that if you actually use git for what it claims to be grea=
t at
> (i.e., merging) you may be in for a world of pain, with your coworkers an=
d boss
> coming at you with pitchforks and torches. Especially because there are
> so many git users who need to interoperate with SVN.

  IMHO here is what git-svn should do. It should use the not-so-new
remotes mechanism, and have all the svn remotes branches under a remote
namespace, clean, simple, and also knowing which "upstream" svn "thing"
it's following.

  Then, when you just git checkout --track -b <branch> <svn-remote/foo>

  hack hack hack
  git commit
  hack hack hack
  git commit
  git merge <svn-remote/another-branch>
  hack hack hack
  git commit

  and then you just want to:

  git svn dcommit.

  Using the fact that <branch> tracks <svn-remote/foo> and that
<svn-remote/foo> is in fact the plain mirror of upstream's branch foo,
it should be able to know where to actually commit and wrt what it has
to make history clean.


  IMHO a git-$scm gateway just has to feed "remotes" branches, and
provide some plumbing commands (like dcommit) to be able to feed some
changes to the other $scm, with a workflow like this one:

  1. pull $scm into a shadow git repository
  2. import/merge $scm changes into your local branch
  3. make changes / merges whatever
  4. push $scm..<yourbranch> into $scm
  5. goto 1, so that you can "win" your changes from 4. back in the $scm
     local shadow repository.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGywDrvGr7W6HudhwRAoo7AKCIdPwRDutBFLS+Z3QNhth1fkFMvgCfUcRB
TV7akYqHdu3u0cbjalMKvnw=
=T6XI
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
