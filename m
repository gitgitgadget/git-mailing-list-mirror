From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/5] Rework unquote_c_style to work on a strbuf.
Date: Wed, 19 Sep 2007 10:22:39 +0200
Message-ID: <20070919082239.GC28205@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224121.24C3B344AB3@madism.org> <7v4phrqdow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8X7/QrJGcKSMr1RN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXupb-00011I-Jr
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbXISIWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXISIWm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:22:42 -0400
Received: from pan.madism.org ([88.191.52.104]:47063 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbXISIWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:22:41 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5565757F;
	Wed, 19 Sep 2007 10:22:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DE11A4CA59; Wed, 19 Sep 2007 10:22:39 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4phrqdow.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58692>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 08:09:19AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > If the gain is not obvious in the diffstat, the resulting code is more
> > readable, _and_ in checkout-index/update-index we now reuse the same bu=
ffer
> > to unquote strings instead of always freeing/mallocing.
> >
> > This also is more coherent with the next patch that reworks quoting
> > functions.
> >
> > The quoting function is also made more efficient scanning for backslash=
es
> > and treating portions of strings without a backslash at once.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  builtin-apply.c          |  125 +++++++++++++++++++++++---------------=
--------
> >  builtin-checkout-index.c |   27 +++++-----
> >  builtin-update-index.c   |   51 ++++++++++---------
> >  fast-import.c            |   47 ++++++++---------
> >  mktree.c                 |   25 +++++----
> >  quote.c                  |   92 ++++++++++++++++------------------
> >  quote.h                  |    2 +-
> >  7 files changed, 184 insertions(+), 185 deletions(-)
> > ...
> > diff --git a/quote.c b/quote.c
> > index 4df3262..67c6527 100644
> > --- a/quote.c
> > +++ b/quote.c
> > @@ -201,68 +201,62 @@ int quote_c_style(const char *name, char *outbuf,=
 FILE *outfp, int no_dq)
> >   * should free when done.  Updates endp pointer to point at
> >   * one past the ending double quote if given.
> >   */
>=20
> You need to update the comment above which talks about the input
> and return values.  You no longer return an allocated memory
> which the caller should free.  You return something else.

  Oh my, okay I'll do that. I intend to send an updated series at some
point anyways, because of the two mistakes I already spotted, and
because next conflicts with this series (in not too hard ways to deal
with but still, that would save you some useless merges).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8NxPvGr7W6HudhwRAvH9AJ45HIRlp9369z4IaWhKT1E62yTJKQCeKClp
MlcxB3zR7Y6cVQ15oRwFM9E=
=ypXK
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
