From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: http.c (curl_easy_setopt and CURLAUTH_ANY)
Date: Sat, 29 Aug 2015 00:33:18 +0000
Message-ID: <20150829003318.GA469190@vauxhall.crustytoothpaste.net>
References: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Cc: git@vger.kernel.org
To: Stephen Kazakoff <sh.kazakoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 02:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVU5N-0006VO-DP
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 02:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbbH2Ad2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 20:33:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49577 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899AbbH2Ad1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2015 20:33:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 84D8328094;
	Sat, 29 Aug 2015 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1440808403;
	bh=R2yG0gXeZA4V8SQTRw62q0bslaFN+7w1ibT65Pg5kK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/H8EAE6BkKFbon8xZvfkvzo07pqoTdj5Pg+qQpZ1OHlu/uRmFiKYFGqSgyGOO4O3
	 dUVi8sVTV1YCcz3KiQ5yldnDwOaJKxQ8cS8rl4DGnjHVA26G1tn2TNneyn8rgtMsu4
	 +M9KNRfkBgjue1IXDJk9mBYKWYhpDaJVkG1Pc3E2HFa74oQao4diBuz2ygAK7IasCV
	 ScKm2nYWIANJ++pWld7EcVmNjY60mKvPOUgmzIsrqrxF1RUATJWQyjuIjoQ16Qr+NP
	 pK/lUe3AOl9XE8vUWng+q77bFJD5l1hjzPE05nhCAQWO/GZxZCgbkJ71/oBV8ecjIg
	 TBtKNTPso+0KPKloS2uVMc2OdiPHR47cieEOsHzX6E75pS97F++W8e6pf6Qe47NxtY
	 1QKGUiEkSMpDyfxV1/qObazPg2RfpbYDL+TqV/DD9S9yKPy0fjqqkaJI5zbuRJcJff
	 OTf8z3st/NJOZyv+r4VLlsMm7K3uuFPtoPkhh+MoQcUkLticSHc
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stephen Kazakoff <sh.kazakoff@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.1.0-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276763>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 04:07:36PM +1000, Stephen Kazakoff wrote:
> Hi,
>=20
> When I'm behind a proxy (with BASIC authentication), I'm unable to
> perform a git clone.
>=20
> I managed to fix this by editing http.c and recompiling. The change
> I'd like to propose is to line 452.
>=20
>=20
> From:
>=20
> curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>=20
> To:
>=20
> curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_BASIC | CURLAUTH_NTL=
M);

Assuming it's supported upstream, I suspect this would break people who
are using GSSAPI (or Digest) authentication for their proxy.  This would
be a logical thing to do where Kerberos is used.

It might be worth checking exactly which bits cause problems for you;
perhaps your proxy might be misconfigured to suggest a type that it
doesn't support.

> I did however find the CURL documentation
> (https://secure.php.net/manual/en/function.curl-setopt.php) slightly
> conflicting. On one hand, "CURLAUTH_ANY" is effectively the same as
> passing "CURLAUTH_BASIC | CURLAUTH_NTLM". But the documentation for
> "CURLOPT_PROXYAUTH" says that only "CURLAUTH_BASIC" and
> "CURLAUTH_NTLM" are currently supported. By that, I'm assuming
> "CURLAUTH_ANY" is not supported.

This looks like the documentation for PHP.  The libcurl documentation[0]
doesn't mention a limitation.

[0] http://curl.haxx.se/libcurl/c/CURLOPT_PROXYAUTH.html
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.7 (GNU/Linux)

iQIcBAEBCgAGBQJV4P3OAAoJEL9TXYEfUvaLMKwQAJ8Hhzc6p9zwLeZmEeNqjwWk
ZRNPkcExO4WXmDdtGmEaWySl6r5y3NiROx/E0gs3pzVF4AAeFP6E9nziaKfSrs+F
kG3sgYc6MElEP7DK9IG2n20QvwWDeJU8ah1Ysm2jiKS/6XqYoc6QiQuyxeNwwRde
3RdPadrhd37dfDccO1435BkQsc6ImS35e6KuPswKmZZqNj5Gsuukbcp0Jz8etCvN
bkC935akajAjit3RO+LOmNXPCxfKYkE5y9TJnI2NkK9QepMr7JQ4m+uXIyUTSIV2
svzO6J17Jtg/jwTQGShf3L0AtifdRSHkwfwmZ4vOJT05q1UNs2W17fqHNSv0rWYn
josiJN8zVWZrDmrs7+pGaiRfvybV6j39YhKRfQxE5Mqap4DkVNTUD5VDmoEd9ItS
LyDXXo26JKg8m3yDaHKwLJcIn9Dkxao4zXiJNbMCnoWKQABkvi711CMg8YWOAkmt
wadSwK2yWj7qLfd2a/8g6jwcJGPL3HnXRfakwcXRHLvf4u4egb45gh5AU13wId+e
cMRMXiWh/adqUw5qu4Dn66aAas/G4b29N0+HA0VJN8HKyY00tZG5nsZeEv1PB52Z
jH1P+2molLJo80iR2sfcIUo9Ox84BTX4Xlgxb45ybkqG29XZlMm3aM93GChS+hLB
ayQ/N0Vya9ywUIMaOH5L
=PqnC
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
