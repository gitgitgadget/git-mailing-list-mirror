From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 13:48:44 +0200
Message-ID: <20070603114843.GA14336@artemis>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="T4sUOijqQbZv57TR";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 13:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuoZo-0005RZ-LH
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 13:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780AbXFCLsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 07:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757833AbXFCLsq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 07:48:46 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:59696 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757633AbXFCLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 07:48:45 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 4DE3417B4A
	for <git@vger.kernel.org>; Sun,  3 Jun 2007 13:48:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1854EDC; Sun,  3 Jun 2007 13:48:44 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48981>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi, I'm currently trying to think about a bug tracking system that
would be tightly integrated with git, meaning that it would have to be
somehow decentralized.

  Though there is a few design issues I have, that block me from doing
first decisions about how to implement some kind of Proof of Concept. My
main problem is: should I put this bug tracking system in the repository
it tracks bugs for, or not.

  I mean, the immediate idea is to have some .bugs/ directories (or
alike). This has many good properties, e.g. for projects like the linux
kernel with its many subsystems or driver, it would make sense to have
per driver/subsystems/... bug packs, and move bugs from one pack to
another would be the way of assigning bugs to different modules.

  Also, a good thing is that when you "report" a bug, it gets commited
in the repository, and taints all the commit chilren, until you commit
the closing patch. This allow a release manager to rapidly _see_ if his
stable branch has this or this bug.

  OTOH it comes with many problems. First, and most obvious IMHO, it's
that it'll mean bugs will have to be pulled into the mainlines. Let's
take example with the linux repository, I'm not sure Linus would be
really keen on doing rounds of bugs pulls, not to mention it'll bloat
the repository somehow.

  The other problem I see is that at the time a bug gets reported, the
user knows it's found at a commit say 'X'. But it could in fact have
been generated at a commit Y, with this pattern:

  --o---o---Y---o---o---o---o---X---o---o--> master
                     \
                      o---o---o---o---o---o--> branch B


  Sadly, the bug report has been commited at 'X', hence it does taints
branch B. As "inserting" or "moving" 'X' commit before the branch is not
an option as it would rewrite history, that becomes also a major no-go
for in-tree collecting of bugs.

  Last of all, I'd also like to have a design where bugs pulls do not
create too much painful merges and conflicts. If we e.g. say that a bug
is a status file and a mbox of comments (makes sense to me), the mbox
can be merged easily (concatenate all mboxes, and purge duplicates), but
the status file is quite problematic on its own too.

  So here are the first ideas/problems/remarks I have with that. I'd
be thrilled to have your comments about those points.

PS: What I left over, is why I wanted such a tool. Programmers tends (or
    say I tend to, maybe I'm over-generalizing, but I seem to remember a
    thread on the lkml where Linus was basically saying the same) to
    hate bugzillas and such out-of-tree tool because they suck, and do
    not really fit in the programming cycle. I'd rather see a
    bugtracking system where the backend is in-tree, basically mboxes so
    that you can read them easily with your favourite MUA, as well as
    adding new comments in it the same way. It also accommodates with
    linux-like workflows where bugs usually are sent on the lkml, a bit
    like patches and pull requests are handled. That's the reasons why I
    came with this idea.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYqqbvGr7W6HudhwRAit0AJ9ovsQZk0PGfbp7XMa+Y9qa3LAeVwCgpgt3
VVCKeyR811g0uiSBWkM3NRw=
=cmT0
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
