From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 5/5] New tests to check rebase with preserve merges
Date: Sat, 22 Mar 2008 15:08:27 +0100
Message-ID: <1206194907-3340-5-git-send-email-joerg@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-2-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-3-git-send-email-joerg@alea.gnuu.de>
 <1206194907-3340-4-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 15:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd4RG-00053I-B2
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYCVOKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 10:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbYCVOKE
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:10:04 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1554 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353AbYCVOJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:09:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 6580CEC061; Sat, 22 Mar 2008 15:09:46 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4OZ-0002M0-Gz; Sat, 22 Mar 2008 15:08:27 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4Oa-0000sc-PS; Sat, 22 Mar 2008 15:08:28 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206194907-3340-4-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77810>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8a801a0..2172065 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -215,6 +215,33 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) =3D B
 '
=20
+test_expect_success 'preserve merges with -p (case 2)' '
+	test_tick &&
+	EXPECT_COUNT=3D3 FAKE_LINES=3D"1 3 2" git rebase -v -i -p branch1 &&
+	test $(git rev-parse HEAD^2) =3D $(git rev-parse to-be-preserved) &&
+	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
+	test $(git show HEAD~2:file1) =3D B &&
+	test $(git show HEAD~1:file1) =3D C
+'
+
+test_expect_success 'preserve merges with -p (case 3)' '
+	test_tick &&
+	EXPECT_COUNT=3D3 FAKE_LINES=3D"3 1 2" git rebase -i -p branch1 &&
+	test $(git rev-parse HEAD~2^2) =3D $(git rev-parse to-be-preserved) &=
&
+	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
+	test $(git show HEAD~1:file1) =3D B &&
+	test $(git show HEAD:file1) =3D C
+'
+
+test_expect_success 'preserve merges really uses fast forward' '
+	head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D3 git rebase -v -i -p branch1 2>pm-ff-err &&
+	cat pm-ff-err &&
+	test $(grep "^Fast forward" pm-ff-err | wc -l) -eq 3 &&
+	test $(git rev-parse HEAD) =3D $head
+'
+
 test_expect_success 'no merges without preserve merges' '
 	head=3D$(git rev-parse HEAD) &&
 	test_tick &&
--=20
1.5.4.4
