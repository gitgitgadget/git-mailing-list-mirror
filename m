From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 11:58:34 +0100
Message-ID: <20071217105834.GG7453@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="7uYPyRQQ5N0D02nI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Dgl-0003s5-2G
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 11:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935430AbXLQK6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 05:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935360AbXLQK6j
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 05:58:39 -0500
Received: from pan.madism.org ([88.191.52.104]:44097 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934854AbXLQK6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 05:58:37 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D6334197CB;
	Mon, 17 Dec 2007 11:58:36 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 42A8A46670D; Mon, 17 Dec 2007 11:58:35 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vir2xa8z7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68537>


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 10:53:00AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Okay this is kind of disgusting, and I'm absolutely not pleased with
> > it (I mean I'm not pleased that parse_opt forces us to write things like
> > that).
> > ...
> > I'll try to think harder about what we can do about it. Though for now,
> > we will have to go for it for a while.
>=20
> This is just a quick idea before I go back to sleep, but your earlier
> comment on "--no-<an-option-that-is-not-even-boolean>" made me realize
> that the alternative I was suggesting earlier would actually work much
> nicer, if you introduce "--<an-option-that-take-optional-arg>-default"
> magic.

  meeeow I love the idea !

> Then, normal users who know what the value of $foo is (iow, not scripts)
> can say:
>=20
> 	git cmd --abbrev 10
>         git cmd --abbrev HEAD
>         git cmd --abbrev=3D10 HEAD
>=20
> and scripts that want to have $foo to be treated as rev, even when it
> consists entirely of digits, can say:
>=20
> 	git cmd --abbrev-default $foo
>=20
> to disambiguate (i.e.  like "--no-" magic, "-default" is a magic, and it
> tells the parser that "there is no option-argument given to this").
>=20
> To make sure $foo is treated as the precision, the script can say:
>=20
> 	git cmd --abbrev=3D$foo
>=20
> If the script wants DWIM just like human users want, it can do:
>=20
> 	git cmd --abbrev $foo
>=20
> There of course is a little details called coding, but I think this is
> probably the most user friendly to the users and the scripts alike.  It
> certainly is nicer than what the current parse_options() does, and/or
> the git-tag workaround does.

I like the idea, this way we can do the "let's pass the argument as an
option to the callback and let it say if it likes it or not, and have a
quite not so bad way to help the guy scripting this disambiguate. I like
it a lot, and it shouldn't be that hard to deal with. I'll work on it,
and propose new patches ASAP.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZlZavGr7W6HudhwRAqWDAJ0cA4oihaucL/kNFJMoCbzlwC/LNwCfewnR
HXBIGjt7p48rsb8YidgGEow=
=AIAa
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
