Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63AC2018F
	for <e@80x24.org>; Sun, 17 Jul 2016 14:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbcGQOWG (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 10:22:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59142 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbcGQOWE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2016 10:22:04 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 203FD282AF;
	Sun, 17 Jul 2016 14:22:01 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468765321;
	bh=1ebeITZOR5GmbMUXdx1AKHv/bBipQgeCOsDupt+HFZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpstXVfLc/zzlSa5gN9ukVwAXcr6CrgaeK3JAO5rNZk48DzQispKg2/Pl4JOVOoNl
	 19zG9SdUk3Pa6RNaxNokATmZY2e7jPJ7x6H2ApEDFnIqgvNUxntAraduo8LsazH85h
	 Wx3uQ04644n1qNHnGxA8elNI2zOOqaDnS+EW6WDIHi1FqXIYlOAF6+QATgRShwFtd9
	 cvlwFoaL21FvfyCiTBIOwp+wxBvIjw1eT6kBIrdrKjXWADI0RtM+wCJCTk/PppaUnw
	 dHpAJl9wdvc9/TytzGxDE7v3AATK+AcSYOpobpcZ0ituadZXaqNhaUA5oU0PXWvTra
	 7KkOY00pZRK1/QZi2MuUnAmDbIY78AdY9IXzZyINNV1aOpa2WmKfGAnBT82ueNcMHZ
	 uok+I7v5fEgmTgXBaf8Dn0hsZFMjEhZbqdLWNBW+JSgcsFpID2NWBaYZsa5kp4pSrf
	 FRgthfJS0PDItI8N6nQoYxHu0zG1LR30h5B17UOslqIsmS3mGSu
Date:	Sun, 17 Jul 2016 14:21:57 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607170949360.28832@virtualbox>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 17, 2016 at 10:01:38AM +0200, Johannes Schindelin wrote:
> Out of curiosity: have you considered something like padding the SHA-1s
> with, say 0xa1, to the size of the new hash and using that padding to
> distinguish between old vs new hash?

I'm going to end up having to do something similar because of the issue
of submodules.  Submodules may still be SHA-1, while the main repo may
be a newer hash.  I was going to zero-pad, however.  I was also, at
least at first, going to force a separate .git dir for those, to avoid
having to try to store two separate types of objects in the same repo.

The other limitation with this is that it isn't immediately obvious what
hash is in use just because it has a certain length.  For example, I
plan on implementing SHA3-256, but it's also possible I might add
BLAKE2b-256 for people for whom SHA3-256 is too slow.  There's no way to
distinguish between those two algorithms.  Thus allowing multiple hashes
in the same repo won't work without a format byte.

What I might do, however, is add multihash-style format information to
the on-disk format for non-SHA-1 repos.  Then SHA-1 compatibility could
come in a future iteration.  That would be compatible with the existing
refactor.

> I guess that it would also possible to introduce an opt-in "legacy mapper"
> which would generate a mapping locally of all objects' SHA-1 to whatever
> new hash you choose. Generating it locally would side-step the security
> issues of the SHA-1 algorithm. We would need to teach Git to pick that
> mapping up if available and use it, of course.

I think that might be easier.  Considering the number of tests that
hard-code object names, I might need that for the testsuite.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXi5SFAAoJEL9TXYEfUvaL9yEP/3GSLATJvgzTdSSFEtHF2TOr
cZO7rnzphE34gRmAVLtIxxQoWJxaCp3ljWnRYXb5DywLzCxIxRckXgElrGbeA4z+
m21FP/+OheLG1yK2ArQr8g6mvy5/Do/CbqrK17SqlrFQuhvg0zXQty8JE7/dJgqI
pThuTOhxj88Y3+RPbjhKcXVe7HeWgaxWGkTXpxSN1uPPtOhdgTFjQafkO0RR5Hs1
0OYcPWJOASOsyQRfMFQeUAybWVfH0rM5kuzOc35+Ut5HiApwN7ovXgCiRK2Ua/f6
H5l12/WaRCMeqAHt1C8DCxrCUS+sweo1bRbRUB+j9RABvaUee0ehMccltX+hYI0s
1K46/hYHL8CZ+vPaWUywluV487ndOBbqRxEmnED2add3QD/P+R7wEdLEDFyu2Oz9
Xh2Be3Zq+7SYY5Nh00wIZ1oc++KtSAlpUr3sbUJKCBswXeWGTUMHIM9V8UJGaQgb
e8PFvWxRh5MvjpMn7ksnl1X+5TQl1D766ggCiqfcY6jbvN32n8EpC3ve8+RgUPny
Mg5K3qQLIvvwLjttctbUh95rpErgFVYRCYOc/aAEJ6xHZ8MXZycfpqWXNrFwgKP2
u1eBYcMz57udD6IFnuqT1Y23YVz8eAegcuNY8CBSic8GpbL0eppB7wFCXQFlII0E
9awjMOdDXJPnVQwPD8QL
=sJj9
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
