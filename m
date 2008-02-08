From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: small question about the repack algorithm
Date: Fri, 08 Feb 2008 09:38:58 +0100
Message-ID: <20080208083858.GA24913@artemis.madism.org>
References: <20080207090331.GA1958@artemis.madism.org> <7vodarly4z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VS++wcV0S1rZb1Fb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 09:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNOll-0002mt-Eu
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 09:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbYBHIjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 03:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbYBHIjD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 03:39:03 -0500
Received: from pan.madism.org ([88.191.52.104]:48501 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525AbYBHIjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 03:39:00 -0500
Received: from madism.org (def92-8-82-236-12-71.fbx.proxad.net [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EF14A2C441;
	Fri,  8 Feb 2008 09:38:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 764D392BE; Fri,  8 Feb 2008 09:38:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vodarly4z.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73054>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2008 at 07:12:44AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   I've trying to see if that optimization was used but I was somehow
> > unable to find if it was the case, as the code is a bit tough :)
> >
> >   I was wondering if the repacking window was using triangle inequality
> > to discard trying some costly deltas (I assume that what costs the most
> > in the repacking is computing the delta). I mean, if you consider the
> > "size" of a delta, I'm almost sure that it's very near a distance.
> >
> >   So assuming that we know the delta sizes between any pair of reference
> > objects in the window, well, if an object we want to delta against the
> > window Od are near one reference O1 enough, for each Oi in the window
> > that holds: len(=CE=B4(O1, Oi)) > 2 * len(=CE=B4(Od, O1)), then it's no=
t worth
> > investigating.
>=20
> We do not keep track of the delta size matrix between delta-base
> candidates in the window, but I presume we could.  The storage
> cost for doing so is very cheap (window^2 * size_t).  But we do
> not even compute the distance matrix fully (I'll mention the
> reason why the above is not (window^2 * size_t / 2) later).
>=20
>     1-----------------------------i   <=3D delta-base candidates
>      \
>       \=20
>        D <-- the target we are considering
>=20
> Your idea is that if we want to find the cheapest delta-base,
> and after we find out that candidate #1 is close to our target D
> and candidate #i is very far from candidate #1, then delta to
> create D using candidate #i as the base would be much bigger.
> If the distance space is Euclidean, that would be a nice
> optimization.

  Well, Euclidean is too much, a simple Metric Space is enough IIRC.

> The second reason is that the deltification is not symmetric.
> If you define the "distance" between #1 and #i as "the size of
> delta to reproduce #i using #1 as base", the distance between #1
> and #i is very different from the distance between #i and #1.

  Well that's the most obvious reason indeed and I totally missed that,
dang. The delta is not near a distance enough. Too bad :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHrBUivGr7W6HudhwRAgwMAJ9zf7hxQZaAmqy0DYRhvRMqSsKfwACfQ/+u
oM1vk4uWAoeVAd20qekRUYM=
=w+tr
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
