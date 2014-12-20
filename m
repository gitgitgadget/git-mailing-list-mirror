From: Loic Dachary <loic@dachary.org>
Subject: git update-ref --stdin : too many open files
Date: Sat, 20 Dec 2014 11:24:04 +0100
Organization: Artisan Logiciel Libre
Message-ID: <54954E44.1080906@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Lw7JTQ0CALGXWKJ3Onwi5WxPFGFgIigAG"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 11:30:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2HIV-0007Ed-GE
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 11:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaLTKaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 05:30:02 -0500
Received: from mail2.dachary.org ([91.121.57.175]:56063 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbaLTKaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2014 05:30:00 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Dec 2014 05:30:00 EST
Received: by smtp.dmail.dachary.org (Postfix, from userid 65534)
	id 0B83D42B47; Sat, 20 Dec 2014 11:24:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on dmail.dachary.vm.gnt
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 97EE1420AF
	for <git@vger.kernel.org>; Sat, 20 Dec 2014 11:24:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261601>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lw7JTQ0CALGXWKJ3Onwi5WxPFGFgIigAG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Steps to reproduce:

$ git --version
git version 1.9.1
$ wc -l /tmp/1
9090 /tmp/1
$ head /tmp/1
delete refs/pull/1/head
create refs/heads/pull/1 86b715f346e52920ca7c9dfe65424eb9946ebd61
delete refs/pull/1/merge
create refs/merges/1 c0633abdc5311354c9729374e0ba25c97a89f69e
=2E..
$ ulimit -n
1024
$ git update-ref --stdin < /tmp/1
fatal: Unable to create '/home/gitmirror/repositories/Ceph/ceph/refs/head=
s/pull/1917.lock': Too many open files
$ head -20 /tmp/1 | git update-ref --stdin
$ echo $?
0

The workaround is to increase ulimit -n

git update-ref --stdin should probably close some files.

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Lw7JTQ0CALGXWKJ3Onwi5WxPFGFgIigAG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSVTkQACgkQ8dLMyEl6F22BmwCgqFUx80oFYIHp1BbMMUe677B5
zl0AnAqPG7b2gyU1oCMxRLE5YkWNSzSV
=ExX/
-----END PGP SIGNATURE-----

--Lw7JTQ0CALGXWKJ3Onwi5WxPFGFgIigAG--
