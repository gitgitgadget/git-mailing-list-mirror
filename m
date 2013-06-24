From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 02/16] bash prompt: use 'write_script' helper in interactive
 rebase test
Date: Mon, 24 Jun 2013 18:39:12 +0200
Message-ID: <1372091966-19315-3-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:43:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9r5-0002bL-HU
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab3FXQm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:42:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49651 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab3FXQm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:42:59 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mefy0-1UbgKw3a7k-00Olxt; Mon, 24 Jun 2013 18:42:51 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:Ilz5+CxXAI9CoFY5PPAdUWluEdLpLw01oMya+IptO1J
 9zioFJaLJsRXdlJmrvcNNS/qBu36CTEScGeNGEIVgi/f9fSiXr
 wPNsDc93eRaEuJwOxC7/jD3Uur8BECV0sDjY+MI7kEI3PkHoEh
 +Rx20N/X7B7kI4AFE1vn55k8qCzHg7vcvJkZiJuwcPeS6XDfW+
 GhUsX3Ax+NdShCXSTpUqJhsoJzWj3fUX+JTOZrRVGwHvynVRMd
 cVo6Ke1AsFibb6nDqcHzIWa0IZhDK8z9J2W54T3+B0FhjlGdNR
 8Pq//kymZtlW+tIIvYIRFGFfSbZZnbj2BzwedgdB3VvCdlYJLv
 ejrdhKwgizX65lN+IQQpzHd0y7cBp8Lx5aNpUpxhnzL/648OQx
 CWC16lUrT0wpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228853>

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 7c7f8b97..442b9a20 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -248,14 +248,12 @@ test_expect_success 'prompt - inside bare reposit=
ory' '
=20
 test_expect_success 'prompt - interactive rebase' '
 	printf " (b1|REBASE-i 2/3)" >expected
-	echo "#!$SHELL_PATH" >fake_editor.sh &&
-	cat >>fake_editor.sh <<\EOF &&
-echo "exec echo" >"$1"
-echo "edit $(git log -1 --format=3D"%h")" >>"$1"
-echo "exec echo" >>"$1"
-EOF
+	write_script fake_editor.sh <<-\EOF &&
+		echo "exec echo" >"$1"
+		echo "edit $(git log -1 --format=3D"%h")" >>"$1"
+		echo "exec echo" >>"$1"
+	EOF
 	test_when_finished "rm -f fake_editor.sh" &&
-	chmod a+x fake_editor.sh &&
 	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
 	git checkout b1 &&
 	test_when_finished "git checkout master" &&
--=20
1.8.3.1.599.g4459181
