From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 22:32:29 +0200
Message-ID: <20070603203229.GH30347@artemis>
References: <20070603114843.GA14336@artemis> <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org> <20070603201723.GG6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="82evfD9Ogz2JrdWZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huwke-0006nZ-MB
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbXFCUcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbXFCUcb
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:32:31 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:41348 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbXFCUcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:32:31 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 2B4E51919B;
	Sun,  3 Jun 2007 22:32:30 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id F37D8E3; Sun,  3 Jun 2007 22:32:29 +0200 (CEST)
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070603201723.GG6992@nan92-1-81-57-214-146.fbx.proxad.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49033>


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 10:17:23PM +0200, Yann Dirson wrote:
> On Sun, Jun 03, 2007 at 12:22:20PM -0700, Linus Torvalds wrote:
> > On Sun, 3 Jun 2007, Pierre Habouzit wrote:
> > >   Though there is a few design issues I have, that block me from doing
> > > first decisions about how to implement some kind of Proof of Concept.=
 My
> > > main problem is: should I put this bug tracking system in the reposit=
ory
> > > it tracks bugs for, or not.
> >=20
> > Make it a separate (and independent) branch of the repository you track=
,=20
> > and then you can do it - or not do it - as you want later.
>=20
> And since we have cheep branches, we can even have one BTS branch for
> each project branch.
>=20
> But then, since we probably want git-merge to merge the BTS branch
> when present in the local repo, that would mean adding some support in
> the core porcelain - eg. a config option declaring some coupling
> between a branch and its bug-tracking pal, so git-merge can be taught
> to merge it too.

  In fact, I don't think so. In my answer to Linus, I was almost writing
the same thing as you. In fact, no, we don't want a BTS branch per
project branch. We just want to be able to list commits where we found
the bug, and commits where we didn't found them. Lets call them good and
bad commits (yeah, ring a bell ;p). One of the "good" commit will be
better than any other good one, as it'll be the "fixing" commit. Or one
of the fixing commits, as you may have different ones if you just
cherry-pick just the patch in a stable branch.

  So what you need is a way to link a bug to git objects, namely
commits. Linking to files or subtrees also makes sense. In fact we need
to link bugs to well git objects (what a shock :D).

  And if you want to know what affects a given branch, well, you need to
list bugs whose affected objects are present in that given branch. Even
if you have one branch per project branch, as the bug branch chronology
will not be the same as the project's one, you'll still need to answer
the previous question the very same way. And I don't think it's be more
complicated if all project's branches (or may project's branches) are
dealt with or not.

> > >   I mean, the immediate idea is to have some .bugs/ directories (or
> > > alike). This has many good properties, e.g. for projects like the lin=
ux
> > > kernel with its many subsystems or driver, it would make sense to have
> > > per driver/subsystems/... bug packs, and move bugs from one pack to
> > > another would be the way of assigning bugs to different modules.
> >=20
> > I would suggest _not_ doing this kind of mixing. I think it might be=20
> > appropriate for some cases, but I don't think it's appropriate in gener=
al.=20
> > Partly because I don't think the people who change the bugs are at all=
=20
> > necessarily at all the same people who actually do development.
>=20
> The same functionality could probably be obtained through more
> annotations (ie. record which subsystem the bug relates to, just like
> any other property of the bug).

  Well, annotations are certainly useful to create a [git object] ->
[bug #id] map. That way, listing bugs in a branch is "just" a matter of
listing still open bugs in the ancestry graph. Sadly, if I'm not
mistaken, this is at least a linear operation wrt the number of objects
in the branch (supposing that access to objects is O(1)).  IMHO that's
not good enough, but I'm not really in the implementation stage yet.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYyVdvGr7W6HudhwRAut/AJwPdYzyAIRvDUF9R2aS8jszL9bGVgCfS2E9
1b986ktZuICOYm6lq91tLC8=
=h1FV
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
