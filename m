X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Bennett Todd <bet@rahul.net>
Subject: minor lib issue
Date: Fri, 23 Dec 2005 23:55:07 +0000
Message-ID: <20051223235507.GA22368@rahul.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
NNTP-Posting-Date: Fri, 23 Dec 2005 23:56:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EpwlU-0002vR-ON for gcvg-git@gmane.org; Sat, 24 Dec
 2005 00:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030494AbVLWXz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 23 Dec 2005
 18:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbVLWXz6
 (ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 18:55:58 -0500
Received: from og.latency.net ([64.21.79.2]:41994 "EHLO og.latency.net") by
 vger.kernel.org with ESMTP id S1030494AbVLWXz5 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 23 Dec 2005 18:55:57 -0500
Received: by og.latency.net (Postfix, from userid 1053) id 7549E13FC16; Fri,
 23 Dec 2005 18:55:54 -0500 (EST)
Received: from pic.bent.dom (localhost [127.0.0.1]) by og.latency.net
 (Postfix) with ESMTP id 964C313FBFD for <git@vger.kernel.org>; Fri, 23 Dec
 2005 18:55:52 -0500 (EST)
Received: (from bet@localhost, uid 500) by pic.bent.dom (femail 0.97) 23 Dec
 2005 23:55:08 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Not sure whether it's practical to fix this without autoconfiscating
the thing, but the logic for picking what libs to link against isn't
as robust as it might be, and the lib ordering (libcurl after
libcrypto) depends on dynamic linking to work.

I was able to build on Bent Linux (uClibc based, static linking
only) with the attached patch, which obviously is a one-off kludge
and not a reasonable fix for the problem.

-Bennett

P.S. In case anyone cares, I call Bent Linux my mid-life crisis
project. Unix as I grew to love her about 25 years ago, when she and
I were both a lot slimmer and healthier.
<URL:http://bent.latency.net/>

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-1.0.3-liborder.patch"
Content-Transfer-Encoding: quoted-printable

diff -ru git-1.0.3.orig/Makefile git-1.0.3/Makefile
--- git-1.0.3.orig/Makefile	2005-12-23 23:07:42.000000000 +0000
+++ git-1.0.3/Makefile	2005-12-23 23:09:36.000000000 +0000
@@ -422,8 +422,8 @@
 git-ssh-pull$X: rsh.o fetch.o
 git-ssh-push$X: rsh.o
=20
-git-http-fetch$X: LIBS +=3D $(CURL_LIBCURL)
-git-http-push$X: LIBS +=3D $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+git-http-fetch$X: LIBS +=3D $(CURL_LIBCURL) $(LIB_4_CRYPTO) -lssl -lcrypto
+git-http-push$X: LIBS +=3D $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) -lssl -lcrypto
 git-rev-list$X: LIBS +=3D $(OPENSSL_LIBSSL)
=20
 init-db.o: init-db.c

--3V7upXqbjpZ4EhLz--

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDrI5bHZWg9mCTffwRAl8bAJ4xOP/SZM1q7jBhttlNs2LzyUoXSgCgwaM7
ybde6cmGV0DSO6RNg35vRvw=
=aMyI
-----END PGP SIGNATURE-----

