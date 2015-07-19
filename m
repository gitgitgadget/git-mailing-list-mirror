From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash prompt: test untracked files status indicator with untracked dirs
Date: Sun, 19 Jul 2015 13:28:05 +0200
Message-ID: <1437305286-23587-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 13:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGmmS-0007SL-AJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 13:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbbGSL3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jul 2015 07:29:10 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59586 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752794AbbGSL3J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 07:29:09 -0400
Received: from x4db1a734.dyn.telefonica.de ([77.177.167.52] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZGmmG-0008IM-Bx; Sun, 19 Jul 2015 13:29:05 +0200
X-Mailer: git-send-email 2.5.0.rc2.15.gd82f7f6
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1437305345.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274208>

The next commit will tweak the way __git_ps1() decides whether to displ=
ay
the untracked files status indicator in the presence of untracked
directories.  Add tests to make sure it doesn't change current behavior=
,
in particular that an empty untracked directory doesn't trigger the
untracked files status indicator.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 49d58e6726..6b68777b98 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -397,6 +397,31 @@ test_expect_success 'prompt - untracked files stat=
us indicator - untracked files
 	test_cmp expected "$actual"
 '
=20
+test_expect_success 'prompt - untracked files status indicator - empty=
 untracked dir' '
+	printf " (master)" >expected &&
+	mkdir otherrepo/untracked-dir &&
+	test_when_finished "rm -rf otherrepo/untracked-dir" &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		cd otherrepo &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - non-e=
mpty untracked dir' '
+	printf " (master %%)" >expected &&
+	mkdir otherrepo/untracked-dir &&
+	test_when_finished "rm -rf otherrepo/untracked-dir" &&
+	>otherrepo/untracked-dir/untracked-file &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
+		cd otherrepo &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - untracked files status indicator - untra=
cked files outside cwd' '
 	printf " (master %%)" >expected &&
 	(
--=20
2.5.0.rc2.15.gd82f7f6
