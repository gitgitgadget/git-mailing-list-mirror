From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Tue, 04 Sep 2007 18:18:43 +0200
Message-ID: <20070904161843.GB3381@artemis.corp>
References: <20070904115317.GA3381@artemis.corp> <11889144741644-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709041642350.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rS8CxjVDS/+yyDmU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISb77-0008BM-Cy
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbXIDQSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbXIDQSq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:18:46 -0400
Received: from pan.madism.org ([88.191.52.104]:53225 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbXIDQSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:18:45 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5699B1DE82;
	Tue,  4 Sep 2007 18:18:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 82EEB1AB93; Tue,  4 Sep 2007 18:18:43 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709041642350.28586@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57606>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2007 at 03:44:30PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 4 Sep 2007, Pierre Habouzit wrote:
>=20
> > +void strbuf_grow(struct strbuf *sb, size_t extra) {
> > +	if (sb->len + extra + STRBUF_GROW_STEP < sb->len)
> > +		die("you want to use way to much memory");
> > +
> > +	sb->alloc =3D ((sb->len + extra) + STRBUF_GROW_STEP) & ~(STRBUF_GROW_=
STEP - 1);
> > +	sb->buf   =3D xrealloc(sb->buf, sb->alloc);
> > +}
>=20
> Why not use ALLOC_GROW()?  Seems to me more efficient than growing by 1kB=
=20
> blocks all the time, for big strings as for short strings.

  ooooh, now I'm guilty of not knowing all git APIs very well yet :) Indeed,
this should just be:

    void strbuf_grow(struct strbuf *sb, size_t extra) {
        if (sb->len + extra + 1 < sb->len)
            die("you want to use way to much memory");
        ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
    }

  This is definitely better on so many levels !

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3YVjvGr7W6HudhwRAv8iAJ9Y6gesJkbwBoMNIh+kG8CU6AG91ACeLOYi
KqOmBcLpr/pYy7XYLVaIqIU=
=3Ipw
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
