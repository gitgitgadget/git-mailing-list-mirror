From: tboegi@web.de
Subject: [PATCH v8 04/10] convert.c: ident + core.autocrlf didn't work
Date: Fri, 29 Apr 2016 17:01:58 +0200
Message-ID: <1461942118-16060-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9rJ-0006oF-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbcD2O5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 10:57:31 -0400
Received: from mout.web.de ([212.227.15.4]:64886 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906AbcD2O52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:57:28 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MXHoz-1bA3gB1165-00WH9J; Fri, 29 Apr 2016 16:57:26
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:MpoKe93mv+HtGZJCCCpDyZJWkQ+ZxVxV9cCWitfJe8yEEkYE7QU
 t6MPvj1SlN9qHATDTmQwBwlTCvkvLjpP+W+E+nBEvt4lFLyGcPULXg01hQ9e3YFUcOPT/vm
 Tzr2l60eNG8lIjcKKuBsC83fRC5wXeMYph6yLVD4q+o31TgE+CephSbLB1viDmSvzgu5kgR
 0RrDjmq9JCH1hnVinUkvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k3iW2N7PdUw=:x7s1c4kg522YJJwiEpA/jS
 BNfm+WvhebazX53nCvKG3weLya2LegGuMc1ZsGMg3cYG4Bk40cDwvyj32xJGHkezW5gv7IiGF
 Xam8CCR+vWzVDMyw9gRC//d5Zx9XO3sgXH/32gtAxW2PCuisNmgS4Ewds8AMRqH64MwRtuPlG
 4DdIaPaYfXYsajLpw7DOhiQUz3+7EeQkqOfFtKtQy72DixSOAb8ZitdfrlXOZTMBjiTDIdQ0w
 asXYsWBU3Qw178IhFf/xNSucdSFN9H2ySHG8ld1Jvge8pczQdH9DZmvd9DmxIB+mScx2b7v5W
 E83DG+pYQnhjECTuJTKBDIUeme4lVmjzVEcNgM4OsAt2ah85KM7NlPKdeyvOHtZ8zSAHfr6tO
 uVgqQqWU/cTYxSo086vXpeUalo6nUJwdGnQVJV6Ouv1iIg+iPz8xz/liJ6/KyEHaEWAQD4+5a
 EJB4BtI0lpI71bWW2j/1YMCHv+bjhGQgvehqlaQM2oyCGplx+xb9sFCJ2zI71PBCCI1A68CYK
 DhUeTfkSlOMdznO2Vcg3qrkqyd0SBxavhD15Dd7VDX5u/TN/T2EIGY7+rcfsfBErZMLRIx/ls
 E0MCDPaPiUPuw20kJ6YWuLTWlGJYwkiVKhQ2YqFzd0UCsks79wDql1wbWgUIfkkqsGsrA+DF3
 w8kIYbVhfSjM6G/8Y3yZerYq0YpxkF8jEU7gIEeGJxfnjo5DMgI5WrUElqYrKCvG6nJaApL1X
 dazv7Zu3MnN7uhmA5g9tq0G453WKIGE3hVpXmpIr51BV8uw8iY9T+FZ/WVKf0ztFipERDpps 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293009>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When the ident attributes is set, get_stream_filter() did not obey
core.autocrlf=3Dtrue, and the file was checked out with LF.

Change the rule when a streaming filter can be used:
- if an external filter is specified, don't use a stream filter.
- if the worktree eol is CRLF and "auto" is active, don't use a stream =
filter.
- Otherwise the stream filter can be used.

Add test cases in t0027.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c            | 19 +++++++------------
 t/t0027-auto-crlf.sh |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index f524b8d..b1614bf 100644
--- a/convert.c
+++ b/convert.c
@@ -1380,27 +1380,22 @@ static struct stream_filter *ident_filter(const=
 unsigned char *sha1)
 struct stream_filter *get_stream_filter(const char *path, const unsign=
ed char *sha1)
 {
 	struct conv_attrs ca;
-	enum crlf_action crlf_action;
 	struct stream_filter *filter =3D NULL;
=20
 	convert_attrs(&ca, path);
-
 	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
-		return filter;
+		return NULL;
+
+	if (ca.crlf_action =3D=3D CRLF_AUTO || ca.crlf_action =3D=3D CRLF_AUT=
O_CRLF)
+		return NULL;
=20
 	if (ca.ident)
 		filter =3D ident_filter(sha1);
=20
-	crlf_action =3D ca.crlf_action;
-
-	if ((crlf_action =3D=3D CRLF_BINARY) ||
-			crlf_action =3D=3D CRLF_AUTO_INPUT ||
-			(crlf_action =3D=3D CRLF_TEXT_INPUT))
-		filter =3D cascade_filter(filter, &null_filter_singleton);
-
-	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
-		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_CRLF=
))
+	if (output_eol(ca.crlf_action) =3D=3D EOL_CRLF)
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
+	else
+		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
 	return filter;
 }
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index fd5e326..9372589 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -493,7 +493,7 @@ fi
 export CRLF_MIX_LF_CR MIX NL
=20
 # Same handling with and without ident
-for id in ""
+for id in "" ident
 do
 	for ceol in lf crlf native
 	do
--=20
2.7.0.992.g0c2c796
