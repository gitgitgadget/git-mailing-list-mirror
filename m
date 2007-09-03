From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 10:46:10 +0200
Message-ID: <20070903084610.GA21759@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <200709030743.44188.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="opJtzjQTFsWo+cga";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:46:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7Zh-0005yy-QH
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbXICIqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbXICIqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:46:16 -0400
Received: from pan.madism.org ([88.191.52.104]:35697 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbXICIqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:46:15 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 277081DA28;
	Mon,  3 Sep 2007 10:46:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B1D9D3224A4; Mon,  3 Sep 2007 10:46:11 +0200 (CEST)
Mail-Followup-To: Johan Herland <johan@herland.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200709030743.44188.johan@herland.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57451>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2007 at 05:43:44AM +0000, Johan Herland wrote:
> On Monday 03 September 2007, Pierre Habouzit wrote:
> >   , and would=20
> > patches that would refactor the strbuf module to have those functions,
> > and would fix the code that uses strbuf's to interact properly, be
> > accepted ?
>=20
> I don't know. Keep in mind that there is a parallel process (cf. the=20
> continuation of the "Buffer overflows" thread) to evaluate the Bstring=20
> library ( http://bstring.sourceforge.net/ ), and possibly substitute that=
=20
> for the strbuf "module".
>
> I wouldn't want the work done by you or others to be wasted (depending on=
=20
> which solution wins out in the end), so I suggest you take a look at=20
> bstring and offer up arguments why your solution would be better for git.

  Oh I completely missed that the thread was still alive.

> I'd like to know how your solution compare with the alternatives (in this=
=20
> case bstring): What's the performance compared to bstring? How much thoug=
ht=20
> has been given to the usability of the API? What functionality is covered=
=20
> (compared to bstring)? In short: Why is your alternative the best for git?

  Well, technically, I don't mind, I wasn't really pushing this or this
implementation. I had a look at bstring, I dislike the code that looks
pretty ugly, but they almost took the same decisions, so if the
consensus is that bstring gives flexibility, so be it.

  For the record, I dislike the fact that bstring pullutes the b*
namespace, whereas it should use bstr as a prefix everywhere, and some
functions (like bstrcpy, that should definitely be named bstrdup) are
really named the _wrong_ way: you can dislike legacy C string APIs all
the way you want, if you name a function from your foostr library
foostrbar, it better behave the way strbar does in the legacy C API. In
the legacy C, strcpy clobbers the destination, here there is no
destination as bstrcpy is definitely a strdup operation. I only had a
quick look, and maybe it was the sole of the kind, but ... well.

  I also dislike the fact that there is no inline version of the
function that appends C strings, because it means that when you append a
constant string into a bstr, you'll need to write:

  bstrcat(bstr, "foo", sizeof("foo") - 1) or bstrcat(bstr, "foo", 3),
both suck a lot, and with an inline function using strlen, most
compilers will optimize the strlen away, and the code is way more
readable. But again, this is trivial to implement as an extension as
well, so I really don't mind that much either.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG28nSvGr7W6HudhwRAlvzAKCbsUBgCRU1NGJYTlHNx8Z9yaB0WgCeJtAt
Y4qgNTiH5VADG4XRtiGGjJk=
=HzoV
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
