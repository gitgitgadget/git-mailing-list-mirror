From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 13:33:07 +0100
Message-ID: <20071217123307.GK7453@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ibvzjYYg+QDzMCy1";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4FAJ-00065q-DA
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbXLQMdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbXLQMdK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:33:10 -0500
Received: from pan.madism.org ([88.191.52.104]:33380 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbXLQMdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:33:09 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 137CC30837;
	Mon, 17 Dec 2007 13:33:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 80FAB4BE7F4; Mon, 17 Dec 2007 13:33:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1w9la7o8.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68557>


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 11:21:11AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Mon, Dec 17, 2007 at 10:53:00AM +0000, Junio C Hamano wrote:
> > ...
> >> This is just a quick idea before I go back to sleep, but your earlier
> >> comment on "--no-<an-option-that-is-not-even-boolean>" made me realize
> >> that the alternative I was suggesting earlier would actually work much
> >> nicer, if you introduce "--<an-option-that-take-optional-arg>-default"
> >> magic.
> >
> >   meeeow I love the idea !
>=20
> There is a bit more serious issue than coding, actually.
>=20
> Short options.
>=20
> A script wants to use default rename detection threshold for unknown
> commit $foo whose name might look like a number.  IOW, this
>=20
> 	git diff -M $foo
>=20
> could be ambiguous.  Obviously, "git diff -M-default $foo" would not fly
> very well.

Yes, I thought about that too actually.

After having written this mail 4 time already, I came up with an idea I
kind of like: like find, we could make {} be a placeholder for the
"default" argument. For example:

  $ git foo --abbrev {} 10
  $ git log -M {} 1
  ...

{} would have the same semantics as your --long-opt-default. It tells the
option parser that "no there isn't anything to grok for that command thank =
you
very much". Of course if for some reason you really want to pass "{}" to the
command, the stuck form holds:

  $ git foo --long-opt=3D{}
  $ git foo -o{}

What do you think ?

PS: I know that in some shells {} needs escaping, which isn't nice. I chose=
 it
    because it's the same as find(1) but we could e.g. use '_' that is less
    "conventional" (if it even makes sense) but is a bit easier to type tha=
n \{}.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZmyDvGr7W6HudhwRAlEDAJ9Z6Pd0dn6k9FTKYDxO3rCY/BEJHwCcDnzT
0R1deJOdNg5YYNo96YTI5AA=
=J1Jh
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
