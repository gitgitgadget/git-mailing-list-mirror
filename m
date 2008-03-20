From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] New test for preserve merges and squash
Date: Thu, 20 Mar 2008 01:03:52 +0100
Message-ID: <1205971432-12641-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 01:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8Is-0007uH-1u
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939547AbYCTAFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939539AbYCTAFQ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:05:16 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3163 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765776AbYCTAFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:05:10 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id C967E488025; Thu, 20 Mar 2008 01:05:07 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jc8Fz-0005Qb-3X
	for git@vger.kernel.org; Thu, 20 Mar 2008 01:03:43 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jc8G8-0003ID-9I; Thu, 20 Mar 2008 01:03:52 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77591>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

The current version of git fails this test. I think it's a bug, because
the patch is what I expect to happen. Or am I wrong?

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 62e65d7..05f3828 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -213,6 +213,26 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) =3D B
 '
=20
+# This test uses to-be-preserved from the test 'preserve merges with -=
p'
+test_expect_success 'squash and preserve merges' '
+	test_tick &&
+	git checkout -b squash-and-preserve-merges master &&
+	echo A > file1 &&
+	git commit -m SaPM-1 file1 &&
+	echo B > file1 &&
+	git commit -m SaPM-2 file1 &&
+	git merge to-be-preserved &&
+	echo C > file1 &&
+	git commit -m SaPM-3 file1 &&
+
+        EXPECT_COUNT=3D4 FAKE_LINES=3D"1 2 squash 4 3" \
+          git rebase -i -p --onto branch1 master &&
+	test $(git rev-parse HEAD^2) =3D $(git rev-parse to-be-preserved) &&
+	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
+	test $(git show HEAD:file1) =3D C &&
+	test $(git show HEAD~2:file1) =3D A
+'
+
 test_expect_success '--continue tries to commit' '
 	test_tick &&
 	! git rebase -i --onto new-branch1 HEAD^ &&
--=20
1.5.4.4
