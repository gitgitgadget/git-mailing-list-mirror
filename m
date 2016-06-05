From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Coccinelle for automated refactors
Date: Sun, 5 Jun 2016 20:55:18 +0000
Message-ID: <20160605205518.GA153578@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 23:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9fBZ-0002QE-J2
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 23:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbcFEVCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 17:02:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39708 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbcFEVCM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 17:02:12 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jun 2016 17:02:12 EDT
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5272E282A8
	for <git@vger.kernel.org>; Sun,  5 Jun 2016 20:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465160125;
	bh=sr1q5P06XRR6TpT/EmCF+ximI4gbyDGAkSiSoYUqUv0=;
	h=Date:From:To:Subject:From;
	b=aGODCVXoshD+vDwRLkXVL0Xdz4Xb7qKWcCeBkoZLiicBSuFHRWIpxoFLmiE2IeJol
	 nzHnKPF9nBQKbwri6/EeG3UVKfeB/O5Bv0T7G+BMJOMJ9c+9WuuL9AixU+m4zyGQsM
	 IsJFu43AU9PVaPqNQQHYAtsu5pa63JK25QpUESJ8oW4zSoYxduWx7swRqajvoWRRBd
	 Y5b5WrC5OJv2nWwGRCfkdmJyIiwZidHzZsY+Eu3l0y2Wzpf+2vo7OGlj0cAgBOO3Zm
	 g+YRmTLXMTII54xjV2Srl82GGEtPVAkxoyE/bCRO5XZyjizginLU/MASMuSk/zFkD8
	 Tnz5DEdalmjY5xtXOS5Y1bj5o343FxInH6OcpyuUOvhWhYZKME72z91A7Z0fdQ53Y/
	 RrwN0VwsfKyWWjl4aqwrRzQEuHTucwTixEApGihMPe0GzhdQgDtRR6ahEpOW1dlZoc
	 pPTmoaBmEcwmVOrMzV99YMaSvfrEqDgmI1zRoKPYSqmtOkJghdm
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-trunk-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296481>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One thing that I've noticed with the struct object_id conversion is that
most of the work is mechanical transformations of a data member from one
type into another.  Doing this by hand is both boring and error-prone,
and it requires a tiresome review of nearly-identical changes.

I've noticed that Coccinelle[0], a tool for automated refactors, has
been used with great success on LKML, because it understands C well and
can perform the transformations precisely and rapidly.  It also does
nice things like indenting the code it modifies if necessary.

An example semantic patch looks like this:

@@
expression E1;
@@
- is_null_sha1(E1.hash)
+ is_null_oid(&E1)

@@
expression E1;
@@
- is_null_sha1(E1->hash)
+ is_null_oid(E1)

This does what you think it does: transforms calls to is_null_sha1 that
use the struct object_id hash member into calls to is_null_oid.

I'd like to use this for some of the struct object_id work if others
think this is a good idea.  I feel it's likely to reduce the reviewing
overhead and allow people to better reason about the quality and
behavior of the sent patches.  Of course, I would still review the
patches manually for errors and improvements, and would still accept
responsibility for the content of the patches.

If there's interest, I can send a patch with a set of basic object_id
transforms to make it easier for others to make those changes when
they're doing work elsewhere in the codebase.

[0] http://coccinelle.lip6.fr/
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.12 (GNU/Linux)

iQIcBAEBCgAGBQJXVJGsAAoJEL9TXYEfUvaL1tkP/iDyp/rsXoH6T55aRRK2qHiu
boNYX/QmRIaV7L/3zxnex9/g51/QMyDfpblDcs6Y+GcWlT2+GPL/rxP1q2UJpL4R
YsEl1ZntXpWWFgCKifg2FSQfX2nN76/YDVn2ysE/6OqISVpZqQOPT/tXNWPYvLB0
TQz7w39X+9sN98hBEFiyVZPrhtSLaBM7GYyWxMe2eALysDcgWMv9wbeQHBruYdoL
KEl2GqqJnf97GK2UrBO9luiAItoPgByqDpO4+1RPbbySWMpfqFM8oIT5j45I8SV2
1gEl71S//sowxk67l47LYi9t1K9pEYJb1lzB/dqKbiFG0wLVKh2EnVad7a09Yzyl
h773OXCHeEA9TUH/dgpaFhnm8ghAu1Qq6plvD8rbOugKCCzyQlitQTfI1aEH9Czw
0lIHyCQsCaS1xLZgJmPGhx16HNNQskV8lKzR8xxicDGjC/K5Reg3nH5Rw6JgOd1g
BdSfIWPELCr+6wzSnI6Tw5G7mhWUZ1156VaiEB/n4wS0T6U9RZxgK3MA3fzjRTlU
/M5scPVqa8wjDJnZTSuUeDtuxBRxakcMl8WwLEwmxLr1ZLCYzswrhFCEQrsvxkN7
B6L/04KQXBSFMHW6n6lZIdSiTxPeUvOMHfWGFtc4Pp7p5fOC4KhPqwO1OVwOBBXt
kzXWUjn9vkJt4JjJ+E5r
=Jj5p
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
