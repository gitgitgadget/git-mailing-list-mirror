From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Sat, 10 May 2014 21:01:32 +0000
Message-ID: <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
 <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
 <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Cc: git@vger.kernel.org
To: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 23:01:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjEOt-0007T6-UG
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 23:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbaEJVBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 17:01:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47678 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752038AbaEJVBh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 17:01:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a04c:bcbd:f5ef:c7f5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 46DA728087;
	Sat, 10 May 2014 21:01:36 +0000 (UTC)
Mail-Followup-To: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248665>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2014 at 12:21:33PM +0200, Ivo Bellin Salarin wrote:
> Well, I'm on Windows.
> using `git version 1.9.2.msysgit.0`.
>=20
> You can find all the exchanges, recorded with wireshark, of the
> following usecases:
> * git vanilla (not working),
> * VisualStudio2013 with libgit (working)
> * curl (--ntlm, working)
> * curl (--negotiate, not working)

Okay, so what it looks like is that for some reason, the server and
libcurl refuse to connect with Negotiate authentication.  git uses
CURLAUTH_ANY, and libcurl picks the best choice: Negotiate.  The
difference between your setup and mine is that I'm using Negotiate with
Kerberos 5, and you're using Negotiate with NTLM.

What it looks like is happening is that git is offering Negotiate data,
and then your server is responding with a 401 Unauthorized.  libgit2
(presumably using WinHTTP) continues in this case, retrying with a
longer set of credential containing more data, but git gives up.

Both responses comply with RFC 2616, by my reading.  I guess there are a
couple of choices here:

* Make your web server happy with the data that it gets passed
  initially.
* Make git understand that it really needs to try again with different
  credentials in this case (how to do that is unknown).
* Provide some way of forcing git to use a particular authentication
  protocol.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTbpOsAAoJEL9TXYEfUvaL3q4QAMAwEeKdV43gXCRS75yfZzNH
1f5EwoOzZ12G8cdbEM059uakqEyRIaq4GaZLwSkg2EqHz/cPyt7cxUUfYBTBhInS
JrBByAEN1KrDy0MIrHqw0BA5fNeoU4AGdO75ZnS++61KFDMRaVLApClircuzPXdp
nyu0bhKh4VwBxomiFXvPyz/H0yrXpnZgAbeVlgMx4wDTfLx3bXaaskhtNGCLhsow
fydVzZtQQgLMRzxL/G3RET/OsLLOiiQBltoGUmX9GOOoxVI+xcrg+MrH78ZRC48q
N9+D6qOX0dQocYliwy3kp65/7q7RGgtu/TT6YvuxrqreyBqJxFM4CYZ7SnD4q7b6
Gdu4O4o2tcJy90DAgq2vM6javYUoMnCGbhtBNw8EzH3V6CqW+D1eP7MoBEYy+M54
JEQ446Sw3ltZx9yzQ8KIQ6TkyO/JAk6aeapO7tAo3t4xEIAWwUaCYZD0E3BCai1x
0PORQz2m0JJVPVwUfP4+whEqOnsBPvn3FaGjPL+HrNwKgGBkYfCyF8Wke1XNhWjz
QnDqdpLd4xt3kwj7zyWkxIJIGO5n4X+4Rr32JAnHXht1T//yuv9TEf002Eh1BGP3
QzMXUF/kBnoUppV3mK4nSi89P2h0VR00MZI0PSW3LiRMuyHXMUQGUJl+cUu4Omud
8pWJhikpxmsLVo01mVl6
=505+
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
