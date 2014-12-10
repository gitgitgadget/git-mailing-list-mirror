From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Poor push performance with large number of refs
Date: Wed, 10 Dec 2014 00:37:36 +0000
Message-ID: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 01:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyVHq-0004Ta-31
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 01:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaLJAhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 19:37:45 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55164 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748AbaLJAho (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 19:37:44 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E7EBA2808F
	for <git@vger.kernel.org>; Wed, 10 Dec 2014 00:37:41 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261183>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a repository that's just under 2 GiB in size and contains over
20000 refs, with a copy of it on a server.  Both sides are using Git
2.1.2.  If I push a branch that contains a single commit, it takes about
15 seconds to push.  However, if everything is up-to-date, it completes
within 2 seconds.  Notably, HTTPS performs the same as SSH.

Most of the time is spent between the "Pushing to remote machine" and
"Counting objects", running git pack-objects:

  git pack-objects --all-progress-implied --revs --stdout --thin --delta-ba=
se-offset --progress

Unfortunately, -vvv doesn't provide any helpful output.  I have some
suspicions what's going on here, but no hard data.  Where should I
be looking to determine the bottleneck?

  brianc no # time git push -vvv remote-machine:/tmp/testcase +HEAD
  Pushing to remote-machine:/tmp/testcase
  Counting objects: 1, done.
  Writing objects: 100% (1/1), 184 bytes | 0 bytes/s, done.
  Total 1 (delta 0), reused 0 (delta 0)
  To remote-machine:/tmp/testcase
   + 5059893...2db9804 HEAD -> test (forced update)
  git push -vvv +HEAD  12.35s user 1.61s system 91% cpu 15.337 total
 =20
  brianc ok # time git push -vvv remote-machine:/tmp/testcase +HEAD
  Pushing to remote-machine:/tmp/testcase
  To remote-machine:/tmp/testcase
   =3D [up to date]      HEAD -> test
  Everything up-to-date
  git push -vvv  +HEAD  0.50s user 0.22s system 51% cpu 1.408 total
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUh5XPAAoJEL9TXYEfUvaL1kkP/i/izrd66qdLgbWMpJlqEYpj
4qMjWhp6nHiT5LfLeYWOEceawXc9pUFf1cSlgAk5sATNhg+mZHI4XTBO9FYqguQG
Q3dvEinMcUEkLO8pOnA7Et+gSN+o/dJNPe4CYR9xujinF42JZbkM58xHPd0MddUp
rpczYK39k4bvPgjqkqsE0q8kjBBrD6e5Lv1ufjGClNmO6NwR4uxLAciolVso7S46
cgfs7OBXmITV4XuHbmMZTbDbVsf832TN02wcLA0cDbMM9SQUpfcnKWvkGczogAmD
zdKsCK/YypJ2tuGHQ73jF5dX5ow81tCfoHAXd0WkBR6R2Qu9r2vaduxWmu2eK6az
XY08yMr+Y5BDPo5q8Zi5WTdY4p0s8KWdU1Jlh/XapFNoTjGNyHpl2QC2L7HZI4I4
BZvvhwzLXtQQZczI/LRmC8q+Ac42nI8VYCPDkjdHKNWilHvPM7Hqi2on4qeAtQtZ
ESU9hgBxwVaI8T9oddpk4pexrEGFkP32B42wH8TN1got1DpQrpQsE/9Ro3LFwvgF
HaJRyf329G2kJMWqmo0x+OiYqFe7A8bnqcRdSRp040jhQ8eojxr0My6SXQ85u6Up
dliTYr+ZvnYmYQj6mzEZwD8UOCnpQY6ukd8uTKmyUYLAkld4J+kwROY8T9pQx+w9
y9yPflx+Z6LfzTLqh9IM
=U37l
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
