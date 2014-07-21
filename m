From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git + mod_auth_kerb
Date: Mon, 21 Jul 2014 23:17:21 +0000
Message-ID: <20140721231721.GB5616@vauxhall.crustytoothpaste.net>
References: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Cc: git <git@vger.kernel.org>
To: Jean-Francois Bouchard <jfbouchard@accedian.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 01:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Mpm-0001Qd-UK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 01:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbaGUXR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 19:17:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48993 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbaGUXR0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 19:17:26 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c1ea:6730:f7e1:6379])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6C2502808E;
	Mon, 21 Jul 2014 23:17:25 +0000 (UTC)
Mail-Followup-To: Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254003>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 05:06:50PM -0400, Jean-Francois Bouchard wrote:
> Hello,
>=20
> We are currently working on a single sign on setup for our git install. W=
e are
> using git 2.0.2 (ubuntu) plus apache/2.2.22 mod_auth_kerb on the
> server side. Here some scenario we are trying to accomplish :
>=20
> -Without Kerberos ticket stored.
> Git ask for username/password.
> Result =3D Authentication failed
>=20
> -Kerberos ticket in store and BAD password :
> Git ask for username/password.
> Result =3D Authentication failed
>=20
> -Kerberos ticket in Store entering good password :
> Git ask for username/password.
> Result =3D Authentication failed on some host, other works
>=20
> -Kerberos ticket in Store and embedding the username in the URI (aka
> https://username@repo)
> Git don't ask for anything or ask for password
> Result =3D Works on some host, other request the password. (Will fail if
> the kerberos ticket not in store)

So git uses libcurl with CURLAUTH_ANY.  In order for authentication to
work with libcurl, you have to supply a username.  If you specify it in
the URL, the libcurl realizes that it can use Kerberos, and goes on its
merry way.

If you don't specify the username in the URL, git notices that
authentication has failed, and asks the credential store for a username
and password.  git does not know that a password is not needed, so the
credential subsystem prompts for one anyway.

I have mod_auth_kerb set up against Apache 2.4.9 at the moment, although
I've used 2.2 before.  I always use a username in the URL, and if I get
prompted for the password, I just Ctrl-C out and run kinit before
pushing again.

I don't have mod_auth_kerb set up to fall back to basic auth, but if you
do, using a username and password should work properly.  You can use
set the environment variable GIT_CURL_VERBOSE to 1 to see more
information about what's actually going over the wire.

> This is a very strange behaviour. It seems to be cause by the way
> libcurl and git interact and the way the authentication goes
> (Negociate first, then basic auth). I have tried to use the helper to
> store invalid authentication information. With not much success.

libcurl will always prefer something (anything) over basic auth, since
basic auth is completely insecure unless you're using HTTPS.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTzZ+BAAoJEL9TXYEfUvaLq1IQAJvnaYfAJh97XJWDw6K5L8wP
MErQE3BPwIcbALdta4wIJlgsvwQgwJPY0fG9U8OwlCXYFJKEtUDC5jh3/E67Mem9
3l2lGT9t+ilfEDbjT90K82B0jE5TyhuylZiAomYUeDBAPRJ1VeKxVl1ayjQi2iqG
ENMB9ZJXXyl9gNjWbMgrVVCtJk36xXHanQkVtTDU/7Bi4zgFbnQWU5Hzuz+zMzfw
GJh6baeaXvxVPWWUuhWRXfQvkAFyEjS6ul/CXyIyS4dmDxe55WxWCvfxJwRckaV3
jkYL+kCm0OQkO+LyPmh9f8ZX5O037iqvXDkRFjkXgFQ/suAe1Jk2/YBtmg9zolll
HJ/TjQVi0Hb7kRq88E9sCXeDiSX8MvaOqn2Gfkgz/g8cbDpor0A7Py3ZJnEKZQP/
yfoi2NDDdrFysw4uuuBM+tpsCU5lzTBaekcxzZo0Mbw6A+bOwiMQtg+82kMm6iGL
QDH9BZ8Bz0rR+zbobCTXulPOxEQIrERysAlVzfUDUlQO7dCdpPalg769G6gbdIjQ
hKKB3vQrqJlq9kJU9IPPbMgy2/bx2y+ULNUATuqSWXRcJy/bC9P2JmmeizlyP3Yf
YP1mOkjry7fKWv7KWSS+QyjjzSJ7lj+BfOmF86ZJ/rBat8nimkMBfGXIssVwdOcn
/IZCZCXLBgmwxIRZTfxD
=TYIU
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
