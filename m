From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 02/13] bash prompt: fix here document indentation in
 interactive rebase test
Date: Tue, 18 Jun 2013 04:16:55 +0200
Message-ID: <1371521826-3225-3-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:17:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolUL-0005Rb-13
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab3FRCRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:17:37 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:65506 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab3FRCRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:17:36 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LiJAx-1U1SE00bo3-00nCN6; Tue, 18 Jun 2013 04:17:35 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:jJMtrjq8pXWZtqpxeJQpTyebp6ZtHV3uQd9EYy/36qp
 fn/Lo/XBrKxlZzOpDdiqPyL0rLHFswbwhTcZApRJ3yITgw2+J6
 FCxbTY1/Wezm+waSsgAw+OzfnKCwWJRQu0R+eGl+XIoT5ol+mW
 /Pa4twXdQ7qW6KVHGEO9p3naASq9LlDL9CxFLtBjyHMYUsAkUC
 QEXHTZ5hZXF+gQGJ3RyUU92wMs7ZZ734jDycY8DMOe/qgJSxWW
 MdNcDAsp9/1o49AdvzRzksYlK9pUa3MJish6cyh9Pl+XUYWbAT
 PCDpMwIlzL/+bkIQJCPhfIDnHc5zI+lyODC6noOC6F5FGPBV4C
 yrq/3bL+bs1iuSTxfYjoUC8ojWay3jr4MaPM5WT3NzONFk4JF1
 D5y1PcVX8DCEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228134>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Also move the shebang line into the here document.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 7c7f8b97..b0af5d5f 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -248,12 +248,12 @@ test_expect_success 'prompt - inside bare reposit=
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
+	cat >fake_editor.sh <<-EOF &&
+		#!$SHELL_PATH
+		echo "exec echo" >"\$1"
+		echo "edit \$(git log -1 --format=3D"%h")" >>"\$1"
+		echo "exec echo" >>"\$1"
+	EOF
 	test_when_finished "rm -f fake_editor.sh" &&
 	chmod a+x fake_editor.sh &&
 	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
--=20
1.8.3.1.487.g8f4672d
