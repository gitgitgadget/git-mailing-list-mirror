From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH 3/3] Improve failure test for preserve merges
Date: Sat, 22 Mar 2008 22:44:26 +0100
Message-ID: <1206222266-29179-3-git-send-email-joerg@alea.gnuu.de>
References: <1206222266-29179-1-git-send-email-joerg@alea.gnuu.de>
 <1206222266-29179-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: B.Steinbrink@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 23:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdBlQ-0000JT-EI
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 23:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbYCVV7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbYCVV7p
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 17:59:45 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1312 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469AbYCVV7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 17:59:44 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id A48B9488033; Sat, 22 Mar 2008 22:59:42 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBVu-0003Pp-6i; Sat, 22 Mar 2008 22:44:34 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBVs-0007b5-Dn; Sat, 22 Mar 2008 22:44:28 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206222266-29179-2-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77854>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 014b036..eaa2fc0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -213,11 +213,13 @@ test_expect_success 'preserve merges with -p' '
 '
=20
 test_expect_failure 'preserve merges with -p (case 2)' '
-	old_head=3D$(git rev-parse HEAD) &&
 	test_tick &&
-	EXPECT_COUNT=3D4 FAKE_LINES=3D"1 4 3 edit 2" git rebase -i -p branch1=
 &&
-	git rebase --continue &&
-	test $(git rev-parse HEAD) !=3D $old_head
+	EXPECT_COUNT=3D4 FAKE_LINES=3D"1 4 3 edit 2" git rebase -i -v -p bran=
ch1 &&
+	git rebase --continue
+	test $(git rev-parse HEAD^^2) =3D $(git rev-parse to-be-preserved) &&
+	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
+	test $(git show HEAD:file1) =3D B &&
+	test $(git show HEAD~2:file1) =3D C
 '
=20
 # clean-up from the above test
--=20
1.5.4.4
