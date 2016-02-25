From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 02/21] completion tests: don't add test cruft to the test repository
Date: Thu, 25 Feb 2016 23:50:31 +0100
Message-ID: <1456440650-32623-3-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:51:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4lD-0005fJ-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbcBYWvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:51:47 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35729 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWvr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:51:47 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4l4-0007uU-Ek; Thu, 25 Feb 2016 23:51:43 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440703.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287451>

While preparing commits, three tests added newly created files to the
index using 'git add .', which added not only the files in question
but leftover test cruft from previous tests like the files 'expected'
and 'actual' as well.  Luckily, this had no effect on the tests'
correctness.

Add only the files we are actually interested in.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2ba62fbc178e..cec98a7e814c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -491,7 +491,7 @@ test_expect_success 'git --help completion' '
 test_expect_success 'setup for ref completion' '
 	echo content >file1 &&
 	echo more >file2 &&
-	git add . &&
+	git add file1 file2 &&
 	git commit -m one &&
 	git branch mybranch &&
 	git tag mytag
@@ -522,7 +522,7 @@ test_expect_success '<ref>: completes paths' '
=20
 test_expect_success 'complete tree filename with spaces' '
 	echo content >"name with spaces" &&
-	git add . &&
+	git add "name with spaces" &&
 	git commit -m spaces &&
 	test_completion "git show HEAD:nam" <<-\EOF
 	name with spaces Z
@@ -531,7 +531,7 @@ test_expect_success 'complete tree filename with sp=
aces' '
=20
 test_expect_success 'complete tree filename with metacharacters' '
 	echo content >"name with \${meta}" &&
-	git add . &&
+	git add "name with \${meta}" &&
 	git commit -m meta &&
 	test_completion "git show HEAD:nam" <<-\EOF
 	name with ${meta} Z
--=20
2.7.2.410.g92cb358
