From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt  restriction.
Date: Mon, 17 Dec 2007 21:42:04 +0100
Message-ID: <20071217204204.GA13004@artemis.madism.org>
References: <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org> <20071217203143.GA2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oyUTqETQ0mS9luUI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MnO-00080G-IS
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759807AbXLQUmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759676AbXLQUmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:42:09 -0500
Received: from pan.madism.org ([88.191.52.104]:56047 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759626AbXLQUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:42:07 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1E137309FC;
	Mon, 17 Dec 2007 21:42:05 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CE1404A7148; Mon, 17 Dec 2007 21:42:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217203143.GA2105@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68615>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 08:31:43PM +0000, Jeff King wrote:
> On Mon, Dec 17, 2007 at 11:52:29AM -0800, Junio C Hamano wrote:
>=20
> > So in short, for an option that takes optional option-argument:
>=20
> I agree with everything you said, except...
>=20
> >    - if it is given as "--long-name", and there is a next word, see if
> >      that is plausible as its argument.  Get it and signal the caller
> >      you consumed it, if it is.  Ignore it and signal the caller you
> >      didn't, if it isn't.
>=20
> This "plausible" makes me a little nervous, and I wonder why we want to
> support this at all. Is it
>=20
>   1. We have traditionally supported "--abbrev 10"? I don't think this
>      is the case.

  Yes, that's why the restriction bugs me a bit too.

>   2. Consistency with "--non-optional-arg foo"? Do we have any such
>      non-optional long arguments? I didn't see any; I think we stick
>      with --non-optional-arg=3Dfoo everywhere.

  there are some, I don't recall the exact commands, but option parsing
was quite inconsistent in git (well still is), there are the very simple
loops that just do strcmp and look for the '=3D', there are the loops that
allow interleaving of options and arguments (and that rewrite argc/argv
a bit like parseopt does) and also the ones that allow the separate
mode, and the one that do both.

  The force-stick-mode is a regression for them.

> >    - if it is given as "-s", and there is a next word, and if the option
> >      has long format counterpart as well, then see if the next word is
> >      plausible as its argument.  Get it and signal the caller you
> >      consumed it, if it is.  Ignore it and signal the caller you didn't,
> >      if it isn't.
>=20
> Similarly, what is the goal here?
>=20
>   1. Have we ever supported "-s foo"? Not for -B/-M/-C, nor for
>      shortlog's -w.

  Yes for git tag -n for example, and there are some other
examples, look at maint for commands that have been migrated to
parse_options, some behave like that, and more than one for sure.

>   3. It's longer to type.

  It's way more readable, but YMMV.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZt8cvGr7W6HudhwRAspFAJ9oC4wXo7Nd7bNEYHhWSFFl9C5RDQCcCNE4
UoI5CH0pAmKSv7wSYlVquxY=
=xwVo
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
