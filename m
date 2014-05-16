From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Fri, 16 May 2014 22:34:10 +0000
Message-ID: <20140516223410.GB180798@vauxhall.crustytoothpaste.net>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
 <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
 <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
 <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
 <20140512202153.GB2329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Cc: git@vger.kernel.org,
	Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 00:34:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlQhn-0008GV-EL
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbaEPWeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:34:15 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47788 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753687AbaEPWeP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 18:34:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c1bd:3a45:42c8:45a6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B16F428087;
	Fri, 16 May 2014 22:34:13 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
Content-Disposition: inline
In-Reply-To: <20140512202153.GB2329@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249424>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2014 at 04:21:53PM -0400, Jeff King wrote:
> On Sat, May 10, 2014 at 09:01:32PM +0000, brian m. carlson wrote:
> > * Make git understand that it really needs to try again with different
> >   credentials in this case (how to do that is unknown).
>=20
> It should be pretty straightforward to loop again; http_request_reauth
> just needs to turn into a for-loop on getting HTTP_REAUTH, rather than a
> static two-tries (I even had a patch for this a while ago, but the
> function has changed a bit in the interim).
>=20
> The tricky part is figuring out when to return HTTP_NOAUTH ("do not try
> again, we failed") versus HTTP_REAUTH ("get credentials and try again")
> in handle_curl_result. Right now the decision is based on "did we have a
> username and password for this request?" I'm not clear on what extra
> bits would be needed to decide to continue in the case you guys are
> discussing.

I'm honestly not sure, either.  That's why I said, "how to do that is
unknown".

However, if you base64-decode the two Negotiate replies in the
successful attempt with WinHTTP and pass it through od -tc, you'll see
that the second reply contains some form of user ID that the first one
does not.  The curl binary sends an identical reply for the first pass,
but then gives up and does not try a second pass.  I don't know if
libcurl is able to provide the data required in the second pass.

All of this is way outside my knowledge, since my Kerberos/GSSAPI
Negotiate requests look very different than the NTLM ones.

> > * Provide some way of forcing git to use a particular authentication
> >   protocol.
>=20
> Yeah, we just set CURLAUTH_ANY now, but it would be fairly trivial to
> add "http.authtype" and "http.proxyauthtype" to map to CURLOPT_HTTPAUTH
> and CURLOPT_PROXYAUTH.

This might be the easiest option.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTdpJhAAoJEL9TXYEfUvaLyvAQAMg1GtsJ/oXS9Y/dNt2XWEka
225uaT5WJKcHzue+PgLQuBZ5wFWrQ2jqXdjps2Ez3+3CDfvgsj+OqrIHipoePkR0
+/F8g0WLXNhyU9KrRz0L6ZW+Rx0G6TRqOzrsCqL+EGFCSEAff95qC6MeRMW4PZ5L
zEWVubTZrqKH9R7YBO3mu+vDU4Mb5QwHymFblYkVsOyBa71EEjYVP0mXvn0IsJPx
K1W4wfnjOQjx/RIzrI/5McD1bEqnWhfy/uEYaPKvy1MWp37ahJ/9b1f/DoLpIfMK
bnR+nhmzvfD7RMoHTTod/KjMEzDzECxWf110Gd8ptwaE7lsdTn6kA2TlnrvK79LF
IAXo5Ea6uluh8jJ8PmodS8PNUxxLL7Kujaf5jh7ipPnXXvFBd+4kwwQb05m93q9G
JvkiZ71ttU3GZ96wHSPyJf/FUsw2KcQLtiGNh4TqEHnDoAEmgEYtNcKwGQzz3xCI
51nsNeJEAj8S/0D/9duNkme+mZk+LSYvWNHxkvUMxx41AeOD0OvugKIQdRUe9eVA
gZnsH2Inj2FlNgbikWU7MOYnNNwsfooXwphM+dqkGBvki2KrXjJf95u9OOquktcs
63Cj6RcuEqw/MRmhBRn2x7qJC+NMO+rDAxizQPsq8fd60oIeUmnso3BQegh3ZYtR
C8lljKhhh+0DcNqtWvRq
=gWED
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
