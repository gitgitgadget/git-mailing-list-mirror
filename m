From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t5541: Improve push test
Date: Mon, 9 Dec 2013 21:03:28 +0100
Message-ID: <201312092103.29047.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 21:03:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq73R-0002ou-DR
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761333Ab3LIUDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Dec 2013 15:03:37 -0500
Received: from mout.web.de ([212.227.15.3]:65499 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761204Ab3LIUDg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Dec 2013 15:03:36 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lo0ZA-1VNg7S2ODY-00g1jP for <git@vger.kernel.org>; Mon,
 09 Dec 2013 21:03:34 +0100
X-Provags-ID: V03:K0:LlFhqK7u3SRBUAeEIzfcJC6JOHpqbmGZmlCxbP1fA0WD2I4ARLv
 JFLwiXbXfLQE2xrzIul53HSEjQmFOoma6XK4P/iVaOCMMIITsJFuZjoRqa+DTwjS/+vVfje
 XR0+eglwJrhe2faMsIWrU4Wx9AwiAuMn4gsxOp/wjIIelT8Lph9m4Iuc8obg3xpzJjr4oHv
 BIOwEv/i+Tg5GDWPn7UVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239084>

The old log-line looked like this:
 + 9d498b0...8598732 master -> master (forced update)
And the new one like this:
   9d498b0..8598732  master -> master

- Loosen the grep pattern by not demanding "(forced update)"
- Improve the grep pattern and check the new SHA id

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
The following revealed a weakness in t5541:
 commit f9e3c6bebb89de12f2dfdaa1899cb22e9ef32542
 Author: Felipe Contreras <felipe.contreras@gmail.com>
 Date:   Tue Nov 12 14:56:57 2013 -0600
    transport-helper: check for 'forced update' message
So don't look for forced update, but check for the SHA.

(I want to fix a missing "&&" as well, that is for the next commit)
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 470ac54..1468a07 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -168,7 +168,8 @@ test_expect_success 'push fails for non-fast-forwar=
d refs unmatched by remote he
 	test_must_fail git push -v origin +master master:retsam >output 2>&1'
=20
 test_expect_success 'push fails for non-fast-forward refs unmatched by=
 remote helper: remote output' '
-	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$=
" output &&
+	newsha=3D$(git log --oneline -n1 | sed -e "s/^\([0-9a-f]*\).*/\1/") &=
&
+	grep "\.\.$newsha *master -> master" output &&
 	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output
 '
=20
--=20
1.8.5
