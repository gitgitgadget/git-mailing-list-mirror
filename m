From: y@vger.kernel.org
Subject: [BUG] apply: test for trailing whitespace & no new line bug
Date: Mon, 22 Jun 2009 13:49:26 +0200
Message-ID: <21854.439963545$1245671417@news.gmane.org>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 13:50:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIi2M-0005Sj-4B
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 13:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbZFVLt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 07:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbZFVLt6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 07:49:58 -0400
Received: from francis.fzi.de ([141.21.7.5]:14523 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750886AbZFVLt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 07:49:57 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 22 Jun 2009 13:49:56 +0200
X-Mailer: git-send-email 1.6.3.2.370.g6bb4.dirty
In-Reply-To: <y>
X-OriginalArrivalTime: 22 Jun 2009 11:49:56.0478 (UTC) FILETIME=[902EF9E0:01C9F32F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122028>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

If a patch adds a new line to the end of a file and this line ends
with trailing whitespace but has no newline, then 'git apply
--whitespace=3Dfix' does not remove the trailing whitespace from that
line.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Noticed last week, but couldn't fix it myself during the weekend.

 t/t4124-apply-ws-rule.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index f83322e..0db9b59 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -148,4 +148,22 @@ do
 	done
 done
=20
+create_patch () {
+	sed -e "s/_/ /" <<-\EOF
+		diff --git a/target b/target
+		index e69de29..8bd6648 100644
+		--- a/target
+		+++ b/target
+		@@ -0,0 +1 @@
+		+A line with trailing whitespace and no newline_
+		\ No newline at end of file
+	EOF
+}
+
+test_expect_failure 'trailing whitespace & no newline at the end of fi=
le' '
+	>target &&
+	create_patch | git apply --whitespace=3Dfix - &&
+	git diff --check -- target
+'
+
 test_done
--=20
1.6.3.2.370.g6bb4.dirty
