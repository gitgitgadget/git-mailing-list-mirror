From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Mon, 12 Jan 2009 00:02:40 +0100
Message-ID: <20090111230240.GA27489@artemis.corp>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com> <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de> <200901111620.03345.borntraeger@de.ibm.com> <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain> <20090111194258.GA4840@uranus.ravnborg.org> <f19298770901111147t625a2161t779bfcfc0317225c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="YZ5djTAD1cGYuMQK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 00:04:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM9Ll-00011E-0y
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZAKXCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZAKXCp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:02:45 -0500
Received: from pan.madism.org ([88.191.52.104]:43335 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbZAKXCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:02:44 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 69E181A170;
	Mon, 12 Jan 2009 00:02:42 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CD5B12B100; Mon, 12 Jan 2009 00:02:40 +0100 (CET)
Mail-Followup-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f19298770901111147t625a2161t779bfcfc0317225c@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105249>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2009 at 07:47:18PM +0000, Alexey Zaytsev wrote:
> On Sun, Jan 11, 2009 at 22:42, Sam Ravnborg <sam@ravnborg.org> wrote:
> >>
> >> For bisect, it's indeed somewhat annoying, and we could have perhaps d=
one
> >> some things a bit differently, but it's about the closest you can get =
to
> >> "real history" without making the first btrfs merge-point a _total_
> >> disaster.
> >>
> >> For bisect purposes, if you know you're not chasing down a btrfs issue,
> >> you can do
> >>
> >>       git bisect good 34353029534a08e41cfb8be647d734b9ce9ebff8
> >>
> >> where that commit 34353029 is the last one which has _just_ the btrfs
> >> files. The next commit is when it does "Merge Btrfs into fs/btrfs", and
> >> that one has the whole kernel tree again.
> >
> > The cost of moving this piece of history from one git tree to another
> > git tree is that we make it harder to debug the kernel for the advanced=
 user
> > that knows how to do bisect.
>=20
> And wasn't is trivial to avoid? Just exporting the commits as
> patches and importing them into the kernel tree would preserve
> the history, and not break bisection.

And would have brought a whole history of totally irrelevant stuff that
never exited for real, with probably a lot of non-compiling sub-steps
which would be even worse.

No, the two possible choices were to squash the whole stuff at once, or
do what has been done IMNSHO.  People have to grok how to take shortcuts
with git-bisect.  I know that git-bisect puts people on the brainless
course of actions where they git-bisect; configure; compile; boot; test;
mark as good/bad and retry.  And that's what I sometimes don't like with
it.  Because people trust git-bisect too much and forget how to think
right.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklqeo4ACgkQvGr7W6Hudhz4lgCeKcYQJuqGwLCVuxhlJSeoJyFx
xkUAnjQN9pI7xbCkMODK1zYLNGn4QuiH
=EZOU
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
