From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH 1/3] Add test for rebase interactive with preserve merges
Date: Sat, 22 Mar 2008 22:44:24 +0100
Message-ID: <1206222266-29179-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: B.Steinbrink@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 23:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdBlR-0000JT-2l
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 23:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYCVV7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 17:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbYCVV7q
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 17:59:46 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1310 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbYCVV7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 17:59:44 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 7F4BF488030; Sat, 22 Mar 2008 22:59:42 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBVt-0003Pn-U5; Sat, 22 Mar 2008 22:44:34 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBVr-0007ay-7O; Sat, 22 Mar 2008 22:44:27 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77853>

The intention of =E2=80=9Cedit =E2=80=A6 --continue=E2=80=9D is to ensu=
re the state is persistent
and not saved in internal variables.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 9cf873f..014b036 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -212,6 +212,17 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) =3D B
 '
=20
+test_expect_failure 'preserve merges with -p (case 2)' '
+	old_head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D4 FAKE_LINES=3D"1 4 3 edit 2" git rebase -i -p branch1=
 &&
+	git rebase --continue &&
+	test $(git rev-parse HEAD) !=3D $old_head
+'
+
+# clean-up from the above test
+git reset -q --hard
+
 test_expect_success '--continue tries to commit' '
 	test_tick &&
 	! git rebase -i --onto new-branch1 HEAD^ &&
--=20
1.5.4.4
