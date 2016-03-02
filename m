From: Joey Hess <id@joeyh.name>
Subject: bug: git submodule add in of nested submodule handles relative path
 wrong
Date: Wed, 2 Mar 2016 12:52:40 -0400
Message-ID: <20160302165240.GA17654@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 17:53:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abA1E-0006Z4-9P
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 17:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbcCBQwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 11:52:50 -0500
Received: from kitenet.net ([66.228.36.95]:59806 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbcCBQws (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 11:52:48 -0500
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=C7rp8m6a;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1456937560; bh=FvldFkPsjiD/RY/2yUUsh/JiW84Wht/VaaQtfIXiUsc=;
	h=Date:From:To:Subject:From;
	b=C7rp8m6arx2Q01S/ySzRCR9ZWEGut53ysK6e7R/6cZs62LTLuaE14AUQy9T+UuKl5
	 hSXaMqLyc/bRBF4zPUNmnYyOCGRWegvt5puVpPpmSSqOSjbSgCfAUKs35RurU0Vh9p
	 Mx4aSeKXLrFZaJCkQZH/Ihd2pIdEMWV7ZOBnTVOQ=
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-94.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288130>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

joey@darkstar:/tmp/empty>git init sub1
Initialized empty Git repository in /tmp/empty/sub1/.git/
joey@darkstar:/tmp/empty>git init sub2
Initialized empty Git repository in /tmp/empty/sub2/.git/
joey@darkstar:/tmp/empty>cd sub1
joey@darkstar:/tmp/empty/sub1>date > f1 ; git add f1; git commit -m add -q
joey@darkstar:/tmp/empty/sub1>cd ..
joey@darkstar:/tmp/empty>cd sub2
joey@darkstar:/tmp/empty/sub2>date > f2 ; git add f2; git commit -m add -q
joey@darkstar:/tmp/empty/sub2>cd ..
joey@darkstar:/tmp/empty>git init repo
Initialized empty Git repository in /tmp/empty/repo/.git/
joey@darkstar:/tmp/empty>cd repo
joey@darkstar:/tmp/empty/repo>git submodule add ../sub1 1
Cloning into '1'...
done.
joey@darkstar:/tmp/empty/repo>cd 1
joey@darkstar:/tmp/empty/repo/1>ls
f1
joey@darkstar:/tmp/empty/repo/1>git submodule add ../../sub2 2
fatal: repository '/tmp/sub2' does not exist
fatal: clone of '/tmp/sub2' into submodule path '2' failed

Like the bug I filed yesterday, this is caused by git submodule add's
chdir into .git/modules.

Workaround is to pass absolute paths to git submodule add.

Note that this could be an exploitable security hole under some unusual
circumstances. In the example above, any other local user could create a
/tmp/sub2 containing something nasty, and git would check it out
accidentially.

git version 2.7.0

--=20
see shy jo

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVtcaWMkQ2SIlEuPHAQIJeBAAg6wWNSFFXRIMBIyrNEeRMzNylHJcnGE5
0Su813dQJvnUdENCqiG2AdgZExPU+9pMvjK6ZjQXWPtGlkH+lhN2o4vyizmkGNY7
xtmGhRD3m5CZSuDjKkfQDDjJuS3/dcYNi2xb68RdJOxBg94OFh3fq5KDeIE+5p1X
e7k+SR7Xk+ml3zdnoqHXlHNmfmV6WamlaF2p6PiKPlfRQMG2e50zmGOUClz5tLhS
+ummgYfw5LUmkMdYZawG5DeaoZ0p6hIuVW7fu2xWd2ESLvAhvll9s2VC7tKJa9xi
9qjixmzU0opywVGcL2iFgrRS76sE/Mv5GUev33f5C4ktKz87O6yeNK8rKAppao4V
xplL4pXB2jBeT8CLPD6WrA5671CX2Ec7zEF6iYinBmeHqXz6uO0xUx7aZF8JMPA9
+BVLRl58dZMqSVVb3qCE691MbxGx7nuC281FloML3l3Pz8AMImIykRlfR62NQbMm
nyYjvgks9quE06tB/obC5Qiquy2035uXs+Qh+jQWRgy/7t7j0Bawl8rY2yp8tzVt
hTT9a/AGdqDHt2kZrX6zX34KzzGn5N9kL/JPMGYN39OdDJ1CaiTeMd4G7PIdWiFW
kgL/WsQjO4ZOREhVIkDB55rgOXtFAAkMT+Fo+0a5UE8KxbYuWLDOqYJlwxTQxkjV
tXYvW6GUj+g=
=L3yv
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
