From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] check-non-portable-shell: echo -e is not portable
Date: Thu, 25 Apr 2013 20:48:04 +0200
Message-ID: <201304252048.04553.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 20:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRDN-0007JA-4I
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759444Ab3DYSsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 14:48:12 -0400
Received: from mout.web.de ([212.227.17.11]:51968 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759441Ab3DYSsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 14:48:12 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lj2TO-1V4DX225V8-00dZcd for <git@vger.kernel.org>; Thu,
 25 Apr 2013 20:48:10 +0200
X-Provags-ID: V02:K0:cRD9PatUTNyiAZV8eTQgTMj86/qV2iiIEspdMw8iZdi
 wK65uyX6iQ5NnbzbHyK96WeRlF4nyuEqx0mrXkfDkPNYB2XNHB
 zOaWpk16nAY7l6xdNs2+7tpZy2DReJ1CBPxpRuncP86coYtUNA
 7WhmY2ol/K5n2Od+UlrW+pWqZ7yRzJc0S6Nsa89qhlksWIgNvH
 FjLFqGoPvTPBtoyR4ox1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222409>

Depending on the implementation, the echo command may
support options like -n -e -E or no options at all.

The only portable usage of echo is without any options,
which means that no parameter may start with a hyphen.

check-non-portable-shell.pl checks if echo -n is used.
Improve it to reject any parameter starting with a hyphen
and recommend the usage of printf instead

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index 8b5a71d..ff87611 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -17,7 +17,7 @@ sub err {
 while (<>) {
 	chomp;
 	/^\s*sed\s+-i/ and err 'sed -i is not portable';
-	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)'=
;
+	/^\s*echo\s+-(\S)\s+/ and err "echo -$1 is not portable (please use p=
rintf)";
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
 	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (pl=
ease use =3D)';
--=20
1.8.2.1.614.g66d7af5
