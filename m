From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 05 Oct 2007 18:35:17 +0200
Message-ID: <20071005163517.GD20305@artemis.corp>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org> <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org> <20071005162139.GC31413@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="WChQLJJJfbwij+9x";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idq9E-0001EW-Qh
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758618AbXJEQfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758441AbXJEQfV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:35:21 -0400
Received: from pan.madism.org ([88.191.52.104]:41916 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757533AbXJEQfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:35:19 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EC56B23902;
	Fri,  5 Oct 2007 18:35:17 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2FA8F1E16F; Fri,  5 Oct 2007 18:35:17 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
Content-Disposition: inline
In-Reply-To: <20071005162139.GC31413@uranus.ravnborg.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60108>


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 04:21:39PM +0000, Sam Ravnborg wrote:
> On Fri, Oct 05, 2007 at 08:26:44AM -0700, Linus Torvalds wrote:
> >=20
> >=20
> > On Fri, 5 Oct 2007, Pierre Habouzit wrote:
> > > =20
> > > -	strbuf_grow(buf, len);
> > > +	/* only grow if not in place */
> > > +	if (strbuf_avail(buf) + buf->len < len)
> > > +		strbuf_grow(buf, len - buf->len);
> >=20
> > Umm. This is really ugly.
> >=20
> > The whole point of strbuf's was that you shouldn't be doing your own=20
> > allocation decisions etc. So why do it?
> >=20
> > Wouldn't it be much better to have a strbuf_make_room() interface that=
=20
> > just guarantees that there is enough room fo "len"?=20
> >=20
> > Otherwise, code like the above would seem to make the whole point of a=
=20
> > safer string interface rather pointless. The above code only makes sens=
e=20
> > if you know how the strbuf's are internally done, so it should not exis=
ts=20
> > except as internal strbuf code. No?
>=20
> Took a short look at strbuf.h after seeing the above code.
> And I was suprised to see that all strbuf users were exposed to
> the strbuf structure.
> Following patch would at least make sure noone fiddle with strbuf interna=
ls.
> Cut'n'paste - only for the example of it.
> It simply moves strbuf declaration to the .c file where it rightfully bel=
ongs.

  you're looking at an antiquated version, please look at the one in
current master on current next. In this one, what you can do or not do
with the struct is explained

> git did not build with this change....

  Of course it doesn't! people want to have direct access to ->buf and
->len, and it's definitely OK.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBmfFvGr7W6HudhwRAmoDAKCe4FfLl0bI/2fYXaK2tJ7f+z16CACfeTtR
axpBCVzTUqePR7h3SbMzVIk=
=YN3/
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
