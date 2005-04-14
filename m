From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Plug memory leak in update-cache.c
Date: Thu, 14 Apr 2005 10:53:50 +0200
Message-ID: <1113468830.23299.85.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PNAiL1+C2Le8jEwp2uNu"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Apr 14 10:48:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM00R-0000yk-V5
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVDNIu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDNIu2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:50:28 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:42147 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261473AbVDNIuM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 04:50:12 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id B86FF6893
	for <git@vger.kernel.org>; Thu, 14 Apr 2005 10:50:03 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id D372D3A26DB
	for <git@vger.kernel.org>; Thu, 14 Apr 2005 10:56:07 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29971-01 for <git@vger.kernel.org>; Thu, 14 Apr 2005 10:56:00 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id C30C33A26DA
	for <git@vger.kernel.org>; Thu, 14 Apr 2005 10:56:00 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-PNAiL1+C2Le8jEwp2uNu
Content-Type: multipart/mixed; boundary="=-lRyufvPwzvyNKe9/nDSP"


--=-lRyufvPwzvyNKe9/nDSP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Might not be that an big an issue as it should be freed on exit, but
might cause problems with big trees.

----

Plug memory leak in update-cache.c.

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

update-cache.c:  22f3ccd47db4f0888901109a8cbf883d272d1cba
--- 22f3ccd47db4f0888901109a8cbf883d272d1cba/update-cache.c
+++ uncommitted/update-cache.c
@@ -202,6 +202,7 @@
                        printf("%s: needs update\n", ce->name);
                        continue;
                }
+               free(active_cache[i]);
                active_cache[i] =3D new;
        }
 }


--=20
Martin Schlemmer


--=-lRyufvPwzvyNKe9/nDSP
Content-Disposition: attachment; filename=git-plug-leak-in-update_cache.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=git-plug-leak-in-update_cache.patch; charset=UTF-8

dXBkYXRlLWNhY2hlLmM6ICAyMmYzY2NkNDdkYjRmMDg4ODkwMTEwOWE4Y2JmODgzZDI3MmQxY2Jh
DQotLS0gMjJmM2NjZDQ3ZGI0ZjA4ODg5MDExMDlhOGNiZjg4M2QyNzJkMWNiYS91cGRhdGUtY2Fj
aGUuYw0KKysrIHVuY29tbWl0dGVkL3VwZGF0ZS1jYWNoZS5jDQpAQCAtMjAyLDYgKzIwMiw3IEBA
DQogCQkJcHJpbnRmKCIlczogbmVlZHMgdXBkYXRlXG4iLCBjZS0+bmFtZSk7DQogCQkJY29udGlu
dWU7DQogCQl9DQorCQlmcmVlKGFjdGl2ZV9jYWNoZVtpXSk7DQogCQlhY3RpdmVfY2FjaGVbaV0g
PSBuZXc7DQogCX0NCiB9DQo=


--=-lRyufvPwzvyNKe9/nDSP--

--=-PNAiL1+C2Le8jEwp2uNu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXi+eqburzKaJYLYRAuR3AKCL+Rz04ut6wACkKKHaSu/vRNayGwCdH9KH
wHlFGvaD/Qh6FRjt9pAaXEQ=
=piXH
-----END PGP SIGNATURE-----

--=-PNAiL1+C2Le8jEwp2uNu--

