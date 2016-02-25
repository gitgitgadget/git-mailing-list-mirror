From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 05/21] completion tests: check __gitdir()'s output in the error cases
Date: Thu, 25 Feb 2016 23:50:34 +0100
Message-ID: <1456440650-32623-6-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4ll-00060u-Kp
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbcBYWwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:52:21 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35756 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968AbcBYWwV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:52:21 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4lb-0007uU-3R; Thu, 25 Feb 2016 23:52:16 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440736.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287454>

The __gitdir() helper function shouldn't output anything if not in a
git repository.  The relevant tests only checked its error code, so
extend them to ensure that there's no output.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 447f57b89291..1e8794747efd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -215,8 +215,9 @@ test_expect_success '__gitdir - non-existing $GIT_D=
IR' '
 	(
 		GIT_DIR=3D"$ROOT/non-existing" &&
 		export GIT_DIR &&
-		test_must_fail __gitdir
-	)
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
 '
=20
 test_expect_success '__gitdir - gitfile in cwd' '
@@ -259,8 +260,9 @@ test_expect_success '__gitdir - not a git repositor=
y' '
 		cd subdir/subsubdir &&
 		GIT_CEILING_DIRECTORIES=3D"$ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
-		test_must_fail __gitdir
-	)
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
 '
=20
 test_expect_success '__gitcomp - trailing space - options' '
--=20
2.7.2.410.g92cb358
