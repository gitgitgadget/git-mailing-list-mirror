From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Simplify strbuf uses in archive-tar.c using the proper functions.
Date: Wed, 19 Sep 2007 10:36:57 +0200
Message-ID: <20070919083657.GF28205@artemis.corp>
References: <20070905085720.GD31750@artemis.corp> <11890199232110-git-send-email-madcoder@debian.org> <11890199232128-git-send-email-madcoder@debian.org> <7v8x73qdtr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="udcq9yAoWb9A4FsZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:37:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXv3R-0005pH-5I
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbXISIg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbXISIg7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:36:59 -0400
Received: from pan.madism.org ([88.191.52.104]:59075 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbXISIg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:36:58 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AA5D71EF4F;
	Wed, 19 Sep 2007 10:36:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 553FC1A3A3; Wed, 19 Sep 2007 10:36:57 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8x73qdtr.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58698>


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 08:06:24AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
> > +	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
>=20
> Where are you getting the MAX() macro from?  On my Linux box
> it appears that <sys/params.h> happens to define it but I do not
> think that is something we can rely upon portably.

  indeed.

> Moreover, isn't this allocation wrong?  I thought "grow" was
> about "we want this much more in addition to the existing
> length", not "reserve at least this much", and this "path" is a
> static that will keep the buffer and length from the previous
> invocation.

  I'm a nitwit, the strbuf_reset() should be done _before_ the grow
indeed.

> > +	strbuf_reset(&path);
> > +	strbuf_add(&path, base, baselen);
> > +	strbuf_add(&path, filename, filenamelen);
> >  	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> > -		strbuf_append_string(&path, "/");
> > +		strbuf_addch(&path, '/');
> >  		buffer =3D NULL;
> >  		size =3D 0;
> >  	} else {
>=20
> Having said that, I suspect that the preallocation does not
> really matter in practice.  How about doing something like:
>=20
> 	strbuf_reset(&path);
>         strbuf_grow(&path, PATH_MAX);
>         strbuf_add(&path, base, baselen);
>         strbuf_add(&path, filename, filenamelen);

  yeah, I was about to propose the same, I'll add a patch in my current
series to fix that this way.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8N+pvGr7W6HudhwRAvdOAJ4lIIQy/VNd4ewb1mjrMidu0Lf8qQCfYEJq
VVRZ4sHWcPsZ7jg06Gn36Ls=
=ZQQ/
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
