From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 5/7] t9300: do not run --cat-blob-fd related tests on MinGW
Date: Sat, 15 Oct 2011 15:05:18 +0100
Message-ID: <1318687520-19522-6-git-send-email-patthoyts@users.sourceforge.net>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4rv-0003yR-DA
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab1JOOFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:32 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:41519 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951Ab1JOOFa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:30 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140529.WPXT13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:29 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4rh-00025q-CL; Sat, 15 Oct 2011 15:05:29 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 13B1F207A7; Sat, 15 Oct 2011 15:05:29 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=wZGgiZ7Rm1IA:10 a=iJvaYlG91NKQvpCh8jsA:9 a=rRiUa_9rKVKWa3UtdEUA:7 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183656>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As diagnosed by Johannes Sixt, msys.dll does not hand through file
descriptors > 2 to child processes, so these test cases cannot passes when
run through an MSys bash.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9300-fast-import.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index bd32b91..438aaf6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2237,7 +2237,7 @@ test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
 	test_must_fail git fast-import --cat-blob-fd=-1 </dev/null
 '
 
-test_expect_success 'R: print old blob' '
+test_expect_success NOT_MINGW 'R: print old blob' '
 	blob=$(echo "yes it can" | git hash-object -w --stdin) &&
 	cat >expect <<-EOF &&
 	${blob} blob 11
@@ -2249,7 +2249,7 @@ test_expect_success 'R: print old blob' '
 	test_cmp expect actual
 '
 
-test_expect_success 'R: in-stream cat-blob-fd not respected' '
+test_expect_success NOT_MINGW 'R: in-stream cat-blob-fd not respected' '
 	echo hello >greeting &&
 	blob=$(git hash-object -w greeting) &&
 	cat >expect <<-EOF &&
@@ -2270,7 +2270,7 @@ test_expect_success 'R: in-stream cat-blob-fd not respected' '
 	test_cmp expect actual.1
 '
 
-test_expect_success 'R: print new blob' '
+test_expect_success NOT_MINGW 'R: print new blob' '
 	blob=$(echo "yep yep yep" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
 	${blob} blob 12
@@ -2288,7 +2288,7 @@ test_expect_success 'R: print new blob' '
 	test_cmp expect actual
 '
 
-test_expect_success 'R: print new blob by sha1' '
+test_expect_success NOT_MINGW 'R: print new blob by sha1' '
 	blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
 	${blob} blob 25
-- 
1.7.7.1.gbba15
