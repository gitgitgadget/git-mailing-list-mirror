From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: fall back to Basic auth if Negotiate fails.
Date: Sat, 27 Dec 2014 21:09:36 +0000
Message-ID: <20141227210935.GA10649@vauxhall.crustytoothpaste.net>
References: <FBFEB910-4CB8-4049-901C-AADBFAB3AE9E@cisco.com>
 <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <20141227175604.GA23732@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Cc: git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 27 22:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4ycS-0004J0-IQ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 22:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbaL0VJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 16:09:44 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56060 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702AbaL0VJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2014 16:09:44 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4A6412808F;
	Sat, 27 Dec 2014 21:09:42 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Disposition: inline
In-Reply-To: <20141227175604.GA23732@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261840>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2014 at 12:56:04PM -0500, Jeff King wrote:
> On Sat, Dec 27, 2014 at 04:01:33AM +0000, brian m. carlson wrote:
>=20
> > Apache servers using mod_auth_kerb can be configured to allow the user
> > to authenticate either using Negotiate (using the Kerberos ticket) or
> > Basic authentication (using the Kerberos password).  Often, one will
> > want to use Negotiate authentication if it is available, but fall back
> > to Basic authentication if the ticket is missing or expired.
> >=20
> > Teach the HTTP client code to stop trying authentication mechanisms that
> > don't use a password (currently Negotiate) after the first failure,
> > since if they failed the first time, they will never succeed.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > I was able to reproduce the problem on my server.  This fixes the
> > problem for me both when info/refs requires authentication and when it
> > does not.  Dan, please try and see if this fixes the problem for you.
> >=20
> > I'm not clear on whether NTLM is a passwordless authentication method.
> > Since I don't use Windows or NTLM, I can't test it, but if it is, just
> > adding it to HTTP_AUTH_PASSWORDLESS should be sufficient.
>=20
> I don't think this should make things any worse for NTLM if it is. It
> would just not get the benefit of the feature you are adding, and
> somebody with a working setup can test and add it at that time, right?

Correct.

> I'm not familiar enough with Negotiate auth to do give a thorough review
> on the logic above. But FWIW, it makes sense to me, and the code looks
> correct.

libcurl will try very hard to use something other than Basic auth, even
over HTTPS.  If Basic and something else are offered, libcurl will never
use Basic.  I should probably make a note of that in the commit message.

> The credential struct is already a global for all requests. If you made
> the "no_passwordless" flag similarly global, it would be enough to set
> it in handle_curl_result and respect it in get_curl_handle.

I'll reroll with that change.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUnyAPAAoJEL9TXYEfUvaLvRwP/itqddr8TbHehqTVY8PkHva4
mhtl21W8a66KM47LqNBO4yuUjpxp+6HkZRQCsdu0wFVqmDvsJkDdM3/o7pjbDNOd
UonByai5+Sd3mJg20b8Tr+g+M/hOV95N0I3yi6WqYZ0qNaPFRqs3/ID3kMpoxf/r
rfCo6zw+8eaNog4PDBnYbZrw0RpZE+Dw3U2GnX7mhRZGNvpHX0UoxDcLmBNb6tCo
29N+SDzOslOmVE/YGUvhLPN1127hrRCrw0czBBn4HxX4UM6R9dQlJGtJ58glUx7a
d9WjRaJYCyDBJTHiSfcl9E4rYGi0XnuyLOJ4n7usTGjV2vNdPhvEACsV8F0xTgj1
jGkVyH3HwK8xAhtMXg+oXs8DI1oFU743W5Fehz0eNmPb5ADSRCYWicsm4mnPYaCH
2eOl2ZIpGXVMxlULrKO3SSVfhnDWACzP1fWHTrG+IYefDJZuCdT/7kb9yQbj0dxR
J+bOzqAsieLs7oh+WY4nTu1+hIA+ftsjr/2kNXYrsXXubFyNBAInFuqp1PLM0LDx
9hhtCMJWxIyneSGpKv0Q/fSSUW3XjMdhzD27+OaMhtFfhsGVodQ4P0NmqcheIbfg
oB7yvbJmVq1PuTSkurLMVyYzBbG/C7ip6d8HX9P+sjg3YYWqOxNY0XWpYVX2kDk+
adFGwP2y5Sj0QFTv+BPf
=+hqT
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
