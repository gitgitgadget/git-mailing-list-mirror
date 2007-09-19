From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] Use xmemdup in many places.
Date: Wed, 19 Sep 2007 10:26:11 +0200
Message-ID: <20070919082611.GE28205@artemis.corp>
References: <20070917161113.GB460@artemis.corp> <20070917161142.D3C9A344A49@madism.org> <7v6427qdqr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KlAEzMkarCnErv5Q";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXut1-0002BX-6p
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbXISI0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbXISI0O
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:26:14 -0400
Received: from pan.madism.org ([88.191.52.104]:47715 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbXISI0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:26:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 36FFE57F;
	Wed, 19 Sep 2007 10:26:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D31A01A3A0; Wed, 19 Sep 2007 10:26:11 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v6427qdqr.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58694>


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 08:08:12AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  attr.c                  |    7 +------
> >  builtin-add.c           |    8 ++------
> >  builtin-apply.c         |   11 ++---------
> >  builtin-fetch--tool.c   |    6 +-----
> >  builtin-fmt-merge-msg.c |   17 ++++++-----------
> >  builtin-for-each-ref.c  |   40 +++++++++-------------------------------
> >  builtin-log.c           |   12 ++----------
> >  builtin-ls-files.c      |    9 +--------
> >  builtin-mv.c            |    5 +----
> >  builtin-revert.c        |    4 +---
> >  builtin-shortlog.c      |   11 ++---------
> >  commit.c                |   16 ++++++----------
> >  connect.c               |    4 +---
> >  convert.c               |    7 +------
> >  diff.c                  |   13 ++-----------
> >  diffcore-order.c        |    7 ++-----
> >  fast-import.c           |    4 +---
> >  http-push.c             |    9 ++-------
> >  imap-send.c             |   20 +++++---------------
> >  merge-recursive.c       |   19 ++++---------------
> >  refs.c                  |   12 ++++--------
> >  sha1_file.c             |   12 +++---------
> >  tag.c                   |    4 +---
> >  23 files changed, 60 insertions(+), 197 deletions(-)
> > ...
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index 05011bb..900d0a7 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -293,11 +293,7 @@ static char *find_name(const char *line, char *def=
, int p_value, int terminate)
> >  			return def;
> >  	}
> > =20
> > -	name =3D xmalloc(len + 1);
> > -	memcpy(name, start, len);
> > -	name[len] =3D 0;
> > -	free(def);
> > -	return name;
> > +	return xmemdup(start, len);
> >  }
>=20
> Did we start leaking "def" here?=20

  Hmm I fear we are. that has to be fixed indeed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8N0jvGr7W6HudhwRAn6QAJ4rnDkLXG89WpNXUO0+Jmu8LUaKXQCeJ9fe
ZZvjRhgAH1fjoPnfc64XOQk=
=pD+o
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
