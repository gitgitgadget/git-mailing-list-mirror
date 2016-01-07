From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Thu, 7 Jan 2016 23:44:55 +0000
Message-ID: <20160107234455.GB265296@vauxhall.crustytoothpaste.net>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Cc: Mike McQuaid <mike@mikemcquaid.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:45:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHKEu-0003QJ-0K
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcAGXpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:45:01 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34608 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752181AbcAGXpA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 18:45:00 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A7C28282CB;
	Thu,  7 Jan 2016 23:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1452210297;
	bh=LcKEIg4SXD/GdzbC+1wjMwir1Py1vnHqHG9r5LOVLNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMe5cnER0iab5Rt9BaWvENN7aJlAq/hD0urlHu+J+5CbvC4bdoRuvk3MGs3gHi+qN
	 YvI/whne0nYkuTOlgfnqdCrBW+bwnZIQ7NCKap03o11Qdc20rh+DVQAk4JaCB3IIJH
	 nEfZi2NqmH2AXRZZ4adMHyvHc4BZhpbN2pxTNIyjZfigXNRzswTuaUS/tP0/LliXo0
	 adA72DxqZXHflvYATdoaWYYlrGSy/skADaA8Zr91DUtkAvSt3IWEL46JW0AbwTJkBX
	 Tfd/wPHWCwZ+l2lZGAqQdHxgB05httpSnSuYQA+moIu/oQWJPvJ5XVWfumOcjK7S98
	 qLssl+nwpYHNrnZZwPi0rE2QMDnwlfaj+X9z01mJh+caUMrT6Rp1Vq7tdKKycaKtbQ
	 OAa51L+dZKNSYYI2FxPmKLlbj3pfYplPfsZfGW9T5W1XBfi+bsfBcj2STLKZtJAJVq
	 AZe8O8OD8MkGdXqolZ6xU+J6pQl1wWMdRoX3wW3KxUmNnLNr5DW
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Mike McQuaid <mike@mikemcquaid.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20160105150602.GA4130@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283520>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 10:06:02AM -0500, Jeff King wrote:
> Thanks for giving a clear example. This bisects to Duy's 57534ee (dir.c:
> don't exclude whole dir prematurely if neg pattern may match,
> 2015-09-21). AFAICT (and I don't recall looking over this patch
> previously), what you are seeing is the intended effect of the patch.
>=20
> Your final line unignores stuff inside of "a", so we're reporting it (if =
you gave
> "-uall", you'd see the actual file "a/b"). Older versions of git
> generally optimized out looking inside "a/" at all. This created a
> hassle when people wanted to do things like:
>=20
>     a/
>     !a/precious-file
>=20
> in their .gitignore.

I think there's still a bug in the code here.  If you do

  git init
  mkdir -p base/a/
  printf 'base/a/\n!base/a/b.txt\n' >.gitignore
  git add .gitignore
  git commit -m 'Add .gitignore'
  >base/a/b.txt
  git add base/a/b.txt
  git commit -m 'Add base/a/b.txt'
  >base/a/c.txt
  git status --porcelain

git status outputs base/a/c.txt as unknown, when it should be ignored.
We saw this in a repository at $DAYJOB.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWjvh2AAoJEL9TXYEfUvaLeHYP/jop5113HWlhlS/mj/eB+FUL
nXQkO4Lk9Ym2khP2Jg9im8OhZfhBK6VGMDwbahXut5Aj+WHHSlZu4wOwzrtBY6Op
Ci2TEwlpWZ4GVqiFZpFJqkFOOEecBPDHHE+51n/otAf3S4xCIfHPS3xBOsL68cbH
IEHR3VZ/wcBg7X9KpQOcieavZDT2BAZPJdNXbEO9CrRbhjAgxP9ZFJExA5MkYoUA
j5fyxSJopwkbVeIaLKzFwY/eRk/zah2qwFJ5ES4Od92FWjIopM50TAMSUm9TjDyO
eQlGkB3x+jiDYCqFVUbQSDnnuGFEP1X/cy1kQzqocO5e2zCkGZe9SUDyj1cdm90h
ZrvwFV4eoEZ2orpRH8NgymIyfufSYJo0k97mD2xX246ha7xHNP2BT6clOemkgVWV
VanCaH/9fLZ1sBTjc5tTndkZv590xgllBq75JX3dTyQu6WMa7WQ93zN+i6cxET1z
deV8g4NMyu//paT92H4YlJYfLVIz4FOZpAKS7HfcFaLywPLPPGWMnsjK/V/2nXSV
i+Golh5WYwLf+s0Be3un2/WjeFwXPP4mq0mVLaM+W+pkHTPQU8bPOf3aXiwAMdc8
LjrkSlW4t5Ey0n3sC6eQ0e/SKIXYgABXiyNMQvj2qqn/XmYQGO2lMfad9zK8i6L9
VdYqMTvDkEjYzCYKMXKc
=Lcne
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
