From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 22:16:32 +0200
Message-ID: <20070603201632.GF30347@artemis>
References: <20070603114843.GA14336@artemis> <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6v9BRtpmy+umdQlo";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuwVE-00048C-PD
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXFCUQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbXFCUQe
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:16:34 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:36513 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbXFCUQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:16:33 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 9615218F44;
	Sun,  3 Jun 2007 22:16:32 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4C4524BB64; Sun,  3 Jun 2007 22:16:32 +0200 (CEST)
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49029>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 12:22:20PM -0700, Linus Torvalds wrote:
>=20
>=20
> On Sun, 3 Jun 2007, Pierre Habouzit wrote:
> >=20
> >   Though there is a few design issues I have, that block me from doing
> > first decisions about how to implement some kind of Proof of Concept. My
> > main problem is: should I put this bug tracking system in the repository
> > it tracks bugs for, or not.
>=20
> Make it a separate (and independent) branch of the repository you track,=
=20
> and then you can do it - or not do it - as you want later.
>=20
> See as an example the git "todo" branch, ie you can always look at what=
=20
> Junio may or may not be planning with a
>=20
> 	git show remotes/origin/todo:TODO
>=20
> which just shows the "TODO" file in the "remotes/origin/todo" branch.
>=20
> The same approach could be done for bug tracking: you *could* check out=
=20
> the bug-tracking branch separately (and you can create a repository that=
=20
> has _only_ that bug tracking branch, or _only_ the actual development=20
> branch in it), but you could also access it without even checking it out=
=20
> at all, and mix the two projects in the same repository.

  Well I went that way, but we loose the quite cool "if I branch my
repository I branch the bugs coming with them too"-feature. And I'd be
sad to give that up. But maybe it's an error to want to use git to
encode that relation.

  [10 minutes of pondering later]

  Well yes, I think it's basically an error to encode the bug
dependencies in git branches and so on, because bug tracking is often
done asynchronously from devel. So you'll have to assign bug to parts of
the history that are already cold from a devel point of view.

  My conclusion is indeed that a separate branch is really the way to
go. That does not tells how I'll be able to answer the usual "what are
the current opened bugs in my branch" question fast, but well, one step
at a time.

> >   I mean, the immediate idea is to have some .bugs/ directories (or
> > alike). This has many good properties, e.g. for projects like the linux
> > kernel with its many subsystems or driver, it would make sense to have
> > per driver/subsystems/... bug packs, and move bugs from one pack to
> > another would be the way of assigning bugs to different modules.
>=20
> I would suggest _not_ doing this kind of mixing. I think it might be=20
> appropriate for some cases, but I don't think it's appropriate in general=
=2E=20
> Partly because I don't think the people who change the bugs are at all=20
> necessarily at all the same people who actually do development.
>=20
> IOW, bug-reporters obviously have to have write access to *some*=20
> bug-tracking thing, and I don't think you want to try to merge the=20
> bug-tracking together with the real development.=20

  I agree, but I don't see how it's very different from you not trusting
the average kernel contributor and wanting your lieutenants to ack
patches first. My point is, the user-exposed part doesn't *has* to be
pushed in the mainline repository, it could be in ... the bugs
repository, from which developpers could pull some bug reports that are
worth. Or you can also have more layers if you have a QA team in charge
of the bugs. Possibilities are endless, and well, I don't pretend to be
the one that will teach you that :)

  Though I don't like 100% the idea of a .bugs repository. The reason
why I came up with that, is that (experience talking), as a
developper/maintainer/...whatever I have to get in touch with the
reporter. Most convenient way : mail. So I want to be able to use
`$MUA -f /path/to/bug/mbox` to answer, because this is the sole
operation that makes sense. Though I suppose it could be easy to make a
thin wrapper that does a local checkout calls $MUA, and commits the new
mail. So I'd easily give up on that, as I acknowledge I've no real
reasons to design it that way.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYyGgvGr7W6HudhwRAjDYAJ9x4e3xNFc4uhRqAiKnkb3vb3Ud1QCdE2Fe
1B4XNKmEXR2ec7y4nNTmuQ8=
=TOCW
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
