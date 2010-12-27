From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Mon, 27 Dec 2010 08:03:43 +0000
Message-ID: <20101227080343.GA15026@orbis-terrarum.net>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 27 09:05:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX857-000762-Rh
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 09:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab0L0IDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 03:03:49 -0500
Received: from mail.isohunt.com ([208.95.172.20]:47863 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab0L0IDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 03:03:48 -0500
Received: (qmail 30081 invoked from network); 27 Dec 2010 08:03:44 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Mon, 27 Dec 2010 08:03:44 +0000
Received: (qmail 1177 invoked by uid 10000); 27 Dec 2010 08:03:43 -0000
Content-Disposition: inline
In-Reply-To: <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164214>


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If the user's shell in NSS passwd is /bin/false (eg as found during Gentoo's
package building), the git-rebase exec tests will fail, because they call
$SHELL around the command, and in the existing testcase, $SHELL was not bei=
ng
cleared sufficently.

This lead to false positive failures of t3404 on systems where the package
build user was locked down as noted above.

Signed-off-by: "Robin H. Johnson" <robbat2@gentoo.org>
X-Gentoo-Bug: 349083
X-Gentoo-Bug-URL: http://bugs.gentoo.org/show_bug.cgi?id=3D349083
---
 t/t3404-rebase-interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d3a3bd2..7d8147b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -71,8 +71,9 @@ test_expect_success 'setup' '
 # "exec" commands are ran with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=3Dzsh then ">file" doesn't work
 # to create a file. Unseting SHELL avoids such non-portable behavior
-# in tests.
+# in tests. It must be exported for it to take effect where needed.
 SHELL=3D
+export SHELL
=20
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAk0YSF8ACgkQPpIsIjIzwix90QCgthNZ1mwC5j1+xjW7/ZwoXLDc
nAIAoIKASRjBPAO+jsvfHStOQAyjgeCS
=NNm4
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
