From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] 64bit issue in test-parse-options.c
Date: Wed, 30 Jul 2008 21:35:17 +0200
Message-ID: <20080730193516.GC24164@artemis.madism.org>
References: <20080730141656.41ce02ec@pc09.procura.nl> <20080730123713.GA31392@artemis.madism.org> <20080730144452.797d8686@pc09.procura.nl> <20080730140523.GC31392@artemis.madism.org> <7vej5b5grc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="xesSdrSSBC0PokLI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHTD-0002e5-An
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYG3TfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYG3TfX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:35:23 -0400
Received: from pan.madism.org ([88.191.52.104]:54049 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbYG3TfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:35:22 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5E3F82CDFA;
	Wed, 30 Jul 2008 21:35:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 09C92763A; Wed, 30 Jul 2008 21:35:17 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vej5b5grc.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90841>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2008 at 07:11:35PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > The proper fix is to let integer be an *INT* (long integer is bogus
> > anyways) and to put the date in a long using static unsigned long date,
> > and make OPT_DATE use this long.
>=20
> I am still puzzled by the original report of the breakage, as H. Merijn
> cannot be the first person to ever ran test-parse-options on 64-bit
> machine.  Maybe there is a bytesex issue involved as well?

  Yes there is: I assume HP-UX works on big endian machines, else on
machines where longs are 64 bits, we put timestamps in it which are
probably current dates, which still fit on 31 (or 32) bits, hence do not
touch the most significant 32 bits hence work on 64 bits little endian
machines (like ... x86_64).

  So when we parse an integer in it again, the 32 most significant bits
remain 0 hence the test passes.

> In any case, this should work.
>=20
>  test-parse-options.c     |    8 +++++---
>  t/t0040-parse-options.sh |   11 ++++++++++-
>  2 files changed, 15 insertions(+), 4 deletions(-)

  Ack. I wanted to write it but hadn't the time yet, I was just pointing
to the right fix. Thanks for writing the patch :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiQwnQACgkQvGr7W6Hudhy0TACcCQ4xN2F9ejw30stFe4UbWijJ
3FMAn3JZTZ/ilZrH/1I7G+rFoG5S8839
=34ul
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
