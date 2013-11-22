From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 13:28:59 -0400
Message-ID: <20131122172859.GA703@kitenet.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <20131122020911.GA12042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 22 18:29:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjuXU-0007iu-TM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 18:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab3KVR3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 12:29:04 -0500
Received: from wren.kitenet.net ([80.68.85.49]:47228 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413Ab3KVR3D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 12:29:03 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id 78F34305EC1; Fri, 22 Nov 2013 12:28:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131122020911.GA12042@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238200>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> > BTW, I've also seen git cat-file --batch report wrong sizes for objects,
>=20
> Hrm. For --batch, I'd think we would open the whole object and notice
> the corruption, even with the current code. But for --batch-check, we
> use sha1_object_info, and for an "experimental" object, we do not need
> to de-zlib the object at all.  So we end up reporting whatever crap we
> decipher from the garbage bytes.  My patch would fix that, as we would
> not incorrectly guess an object is experimental anymore.
>=20
> If you have specific cases that trigger even after my patch, I'd be
> interested to see them.

I was seeing it with --batch, not --batch-check. Probably only with the
old experimental loose object format. In one case, --batch reported a
size of 20k, and only output 1k of data. With the object file I sent
earlier, --batch reports a huge size, and fails trying to allocate the
memory for it before it can output anything.

I also have seen at least once a corrupt pack file that caused git to try
and allocate a absurd quantity of memory.

Unfortunately I do not currently have exemplars for these, although I
should be able to run a less robust version of my code and find them
again. ;) Will try to find time to do that.

BTW, the fuzzing code is here:
http://source.git-repair.branchable.com/?p=3Dsource.git;a=3Dblob;f=3DGit/De=
stroyer.hs

--=20
see shy jo

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUo+UWMkQ2SIlEuPHAQi3EhAAqCOgtTRwT8xSNfswH9ci4ZX2/18fYhUE
W9ntVN4hb+Tskh+erNevOA9JtrY7JOTQm7NIRK0OjJyd7gFis656ZFmBHFoZ80N2
4K0U3+MdYVPsdNc3KaVSq/zGJwyafN6RTzJSx0D4fJpE5PFEhddA+BBWZjjojSdu
82uCkccFRIzlB5tL5eeExQ8XSN0nZIR/3Ici7fO+leOEZ5dBIUQlYxmFxSWxVnmg
gMvjNGoQlk+0uRpe/YLguAYdxSlV26WVbOiqUuRKvkynlXr3K0oohDdZuY1Hs8Lk
mU2Y8lfAw+udO2BofoZU3zMoMytQtmzfdGhxKL+mv949YL+HrAl7FvgMc/I5tvpv
xPbBT5ToLc3UpT7PJ/Zkmoek9e8+c/VQPOijVR7iDx7mcHGwqbEuonb1R21Pbln+
r3dHTT/9oRdySZxC6KAOLDXG0JRPyOPnyWuTCytTmuBTM8dWmkfWgUHmpK6Wvyj9
C8qKWmVXqpgSV32kIaqbGBAlRAzaDhpMjVUSxKRfWjV7vFPpIk3I2fT4/uZdnPzo
Gem+bj0XydWX91Oa/Ja45cAjQF+1KUg58uNYAaju/RD2m4r8aWoKQRZDD1aMstwX
C9qr4NG9+6HiAerSaiFefxW9ma3swE63o5Mb6Wr+czJ+/EljXwuoShfPnuvxIqCR
Qvp6iFUx8Lg=
=Ppft
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
