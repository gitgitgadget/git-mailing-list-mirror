From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2] Rename suffixcmp() to has_suffix() and inverse its result
Date: Tue, 5 Nov 2013 19:39:36 +0100
Message-ID: <C9A6A1E9-E08C-4C9B-B18D-CED751ACB975@quendi.de>
References: <20131105045722.20276.20853.chriscool@tuxfamily.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_AD126043-61B7-474F-8D8E-94F7DFD35B6D"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 05 19:39:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdlXh-0004Fu-JD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 19:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab3KESjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 13:39:52 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:41414 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807Ab3KESjw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Nov 2013 13:39:52 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VdlXQ-0007kK-Sp; Tue, 05 Nov 2013 19:39:40 +0100
In-Reply-To: <20131105045722.20276.20853.chriscool@tuxfamily.org>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383676791;f3894051;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237333>


--Apple-Mail=_AD126043-61B7-474F-8D8E-94F7DFD35B6D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

+1 for the change. I find the resulting code easier to understand, too.


On 05.11.2013, at 05:57, Christian Couder <chriscool@tuxfamily.org> =
wrote:

> As suffixcmp() should not be used as an ordering comparison function,
> and anything-cmp() ought to be usable as an ordering comparison =
function,
> suffixcmp() should be renamed to something that doesn't end with =
"cmp".
>=20
> has_suffix() is a straightforward name for such a function, except
> that with such a name callers will expect that it will return 1
> when the suffix is present and 0 otherwise.
>=20
> So we need to also inverse the value returned by this function ti

> match what the callers will expect, because suffixcmp() like all
> anything-cmp() returns 0 when the suffix is present and 1 or -1
> otherwise.
>=20
> As we inverse the value returned by the function, we also have
> to inverse the ways its callers are using its returned value.

s/inverse/invert/  (multiple times)

Taking one step back, shouldn't the commit message rather explain the =
new status, instead of referring so much to the past? If I imagine =
somebody reading this in a year, they might not even know suffixcmp =
(e.g. if they joined the project after this patch was merged).

How about something like this:

--- 8< ----

Rename suffixcmp() to has_suffix() and invert its result

Now has_suffix() returns 1 when the suffix is present and 0 otherwise.

The old name followed the pattern anything-cmp(), which suggests
a general comparison function suitable for e.g. sorting objects.
But this was not the case for suffixcmp().

--- 8< ----


By the way, a much stronger reason why suffixcmp is not suitable than =
that it is not clear what it would mean, is that it is not transitive. =
I.e. for an ordering you would want that if a<b and b<c then a<c. This =
is /was not the case for suffixcmp:

  suffixcmp("3", "31") =3D -1  (because "31" is longer than "3"), so "3" =
< "31"
  suffixcmp("31", "2") =3D -1  (because "1" < "2"), so "31" < "2"
but
  suffixcmp("3", "2") =3D 1    so "3" > "2"



>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Hi Junio and Peff,
>=20
> So here is a new version of the patch to rename
> suffixcmp() into has_suffix(). We now inverse the
> result of the function as we rename it.
>=20
> This patch should be added to or squashed into the
> patch series that removes postfixcmp().
>=20

[...]



--Apple-Mail=_AD126043-61B7-474F-8D8E-94F7DFD35B6D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJ5O2wACgkQIpJVslrhe1mVTQEAhQXzONSg/E3lszxCLrWNS2gr
eQc7F43PQqqeIqESnEcBALaP4yrI26wW9xYFFoKuAQ0W9zBhr+l7wxAx8vwMgHdi
=k0In
-----END PGP SIGNATURE-----

--Apple-Mail=_AD126043-61B7-474F-8D8E-94F7DFD35B6D--
