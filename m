From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations   when not needed
Date: Thu, 08 Nov 2007 00:31:45 +0100
Message-ID: <20071107233145.GB5483@artemis.corp>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site> <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org> <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org> <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx> <20071107001112.GD4382@artemis.corp> <20071107001458.GE4382@artemis.corp> <4732487A.4050100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tjCHc7DPkfUGtrlw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:32:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpuNW-0000qq-Ez
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575AbXKGXbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbXKGXbs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:31:48 -0500
Received: from pan.madism.org ([88.191.52.104]:48899 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757550AbXKGXbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:31:47 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9202D28E22;
	Thu,  8 Nov 2007 00:31:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CC80B31711B; Thu,  8 Nov 2007 00:31:45 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4732487A.4050100@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63898>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2007 at 11:21:30PM +0000, Ren=C3=A9 Scharfe wrote:
> Pierre Habouzit schrieb:
> > {
> >     const char *percent =3D strchrnul(fmt, '%');
> >     while (*percent) {
> >         strbuf_add(sb, fmt, percent - fmt);
> >         fmt =3D percent + 1;
> >=20
> >         /* do your stuff */
> >=20
> >         percent =3D strchrnul(fmt, '%');
> >     }
> >     strbuf_add(sb, fmt, percent - fmt);
> > }
> >=20
> >=20
> > Which would require strchrnul, but it's trivial compat/ material for su=
re.
>=20
> Grepping through the source I see several places that can be simplified
> by converting them to strchrnul(), so I think introducing this GNU
> extension is a good idea in any case.

  Yes, strchrnul is _very_ useful for parsing.

> Using strchr()/strchrnul() instead of strbuf_addch()'ing is sensible, of
> course.  I don't like the duplicate code in your sketch above, though.
> I'll try to look into it later today.

Well you can alternatively write it this way of course:

for (;;) {
    const char *percent =3D strchrnul(fmt, '%');
    strbuf_add(sb, fmt, percent - fmt);
    if (!*percent)
        break /* or return probably */;
    fmt =3D percent + 1;

    /* do your stuff */
}

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMkrhvGr7W6HudhwRAuZ0AJ9EOK5WxKUXlnS0NTz8daRymgVFugCghHeA
2OzKG//rstcFscetQmVHuuk=
=4y29
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
