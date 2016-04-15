From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Default authentication over https?
Date: Fri, 15 Apr 2016 23:02:17 +0000
Message-ID: <20160415230217.GC140502@vauxhall.crustytoothpaste.net>
References: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
 <20160413223613.GB10011@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604141142190.23813@tvnag.unkk.fr>
 <CAPf1peDf_YbDsaz1ykvzKLkdUWtSqrHT7yrgfUgjE4R1eS4r6g@mail.gmail.com>
 <20160415222120.GA24777@sigill.intra.peff.net>
 <20160415224334.GA32160@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Cc: Isaac Levy <isaac.r.levy@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arynS-0004Cg-6w
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbcDRCUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 22:20:11 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52832 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbcDRCUC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:20:02 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ECA14282AB;
	Fri, 15 Apr 2016 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460761341;
	bh=Yfg6U1NZYPorugqLl1oV8Tq3w/qdDvxSlYMDzgXHBcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gn/3ecw5GoT63SB/s8AbcQboWBtmOCYtabqIDrpt5kq0d6HQnEL5hEN195b/lR9I7
	 Xh2qM+nXgs/R/XUkdCEonFENaQL/9yp8Rmz9ebIN7N00NVKVep6lLCsyF7WGuQAcc9
	 YeIYIRFvvzOymb5z1V97zzX87E2MdPyD3HuPPvnjndb+1B4UFhq9F7XdAsg3PatAC1
	 hf4chf4CrMJnFmRMGc5ydpi1wGdRliBewTmtBagnznGO8d+kXopuzBVk/eIq+LjWoa
	 NKRBWc2Nu+jxhFRMSJl3zQCL32E4zdAnw+LVPaRgRu8Ir1w+IbrmW8OYwS4UOw/ZeK
	 nAUTjHgJaVtexCS6hqO7trjcnbmKdBgqXetkSujMBXPxt21I+ikyuT1IWp/xx8YQsm
	 4HZYRbgh77fUnqvXHRHGlCkq/7akgCPNwdSayrT92vtEvkSi+impo+AT8V8INrwx26
	 /7rTyE1XFTptwtOsKu8JD/v0m6txzDY9x9H4FGsMhPBFjmz9CRZ
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Isaac Levy <isaac.r.levy@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160415224334.GA32160@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.4.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291791>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 06:43:35PM -0400, Jeff King wrote:
> Hmm. Looks like we already pull this out of the curl result for other
> reasons, but we never feed it back in to the next request. So if I do
> this:
>=20
> diff --git a/http.c b/http.c
> index 9bedad7..add9bf2 100644
> --- a/http.c
> +++ b/http.c
> @@ -1132,6 +1132,8 @@ static int handle_curl_result(struct slot_results *=
results)
>  			return HTTP_NOAUTH;
>  		} else {
>  #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +			if (results->auth_avail)
> +				http_auth_methods =3D results->auth_avail;
>  			http_auth_methods &=3D ~CURLAUTH_GSSNEGOTIATE;
>  #endif
>  			return HTTP_REAUTH;
>=20
> that drops my test case down to two requests: once to find out that we
> need auth via the 401, and then we feed curl sufficient information to
> do the followup in a single request (the GSSNEGOTIATE thing there is a
> hack from 4dbe664, which we can ignore for now).
>=20
> Interestingly, curl _does_ reuse the connection this time. I'm still not
> sure why it didn't in the original case. But this means the whole thing
> is happening over a single TCP session, which is good (and I didn't have
> to change my config at all).

This looks fine from my point of view.  GSS-Negotiate and Digest are
going to require at least one round-trip because they need the token or
nonce to authenticate.  Basic shouldn't, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJXEXL5AAoJEL9TXYEfUvaLR1sP/0BTnuVmwEzKT+eGj1paExg2
2SQ+tGh7XLd5Jguv0DR/oeJdavGKQNekcSRfRn0t6uJP9tXJu1sP2t1Z2IdybgZe
cCabFPcAEBGkjBN2PCP4QOvIywJt1yW2lOeE6mQK4yINQP2MjINy5unFwX6KMEp2
hXPGS3eKZNVfJZNuezdAjjbJstR8KylVtQguTRVZWTKlOLpZaBhadAWBeE/ex9Hb
yrTaRaD9mnmXzV3czQNdpjd6U88z/hQjQPfx5eJcqYqOsU9BNvzn+aC7f8suyvfF
O+0I3HVI/qUk1P42u084lm3dddMfo3sIrk1yCrNyFNlPfI5+iuCGaRvOguNdZE8H
0Ki5Z+ldSyQcyReRFXWsgbA8b6XvnyKM5GX8cUsHqpAxurhLem3hekI5RE5TFH/o
Z42a9zHej9FC/vI7HENvi+OSY5rS9jU5eqdO1JCwE5+x57aGmOmu4pGg8PVcG5mZ
YMESQiqBo4v70gOOx0Xn3fOox/MBC+ki8+gLadQr6XjbvUYQPOfCX+4VrcSp748a
XhN8wSuaIf1YA26/mif1KtjCVvvPAY6eBufuysAoKWKqIhJAHhWx16lIv6c/fftR
RdiEpXIVmUGli8vGAdLhXiLcxSQJ8EAtKydsqCWedTs0CiIUbOMsMflRZhA2eHsL
Hllj8meehn87mSyXdOYz
=4o+Y
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
