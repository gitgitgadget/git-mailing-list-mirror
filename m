From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/5] t4001-diff-rename: wrap file creations in a test
Date: Thu, 25 Feb 2016 09:59:18 +0100
Message-ID: <1456390761-27015-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 10:00:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrmF-0007zy-2Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760198AbcBYI74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:59:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55613 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759422AbcBYI7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:59:38 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8xO1Y013641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:59:24 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8xP51010992;
	Thu, 25 Feb 2016 09:59:25 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 09:59:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8xO1Y013641
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456995565.29064@EN17yfzZJs3ZrnpsnFXGTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287352>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t4001-diff-rename.sh | 66 ++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..06b8828 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -9,21 +9,40 @@ test_description='Test rename detection in diff engine.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-echo >path0 'Line 1
-Line 2
-Line 3
-Line 4
-Line 5
-Line 6
-Line 7
-Line 8
-Line 9
-Line 10
-line 11
-Line 12
-Line 13
-Line 14
-Line 15
+test_expect_success 'setup' '
+	cat >path0 <<-\EOF &&
+	Line 1
+	Line 2
+	Line 3
+	Line 4
+	Line 5
+	Line 6
+	Line 7
+	Line 8
+	Line 9
+	Line 10
+	line 11
+	Line 12
+	Line 13
+	Line 14
+	Line 15
+	EOF
+	cat >expected <<-\EOF
+	diff --git a/path0 b/path1
+	rename from path0
+	rename to path1
+	--- a/path0
+	+++ b/path1
+	@@ -8,7 +8,7 @@ Line 7
+	 Line 8
+	 Line 9
+	 Line 10
+	-line 11
+	+Line 11
+	 Line 12
+	 Line 13
+	 Line 14
+	EOF
 '
 
 test_expect_success \
@@ -43,22 +62,7 @@ test_expect_success \
 test_expect_success \
     'git diff-index -p -M after rename and editing.' \
     'git diff-index -p -M $tree >current'
-cat >expected <<\EOF
-diff --git a/path0 b/path1
-rename from path0
-rename to path1
---- a/path0
-+++ b/path1
-@@ -8,7 +8,7 @@ Line 7
- Line 8
- Line 9
- Line 10
--line 11
-+Line 11
- Line 12
- Line 13
- Line 14
-EOF
+
 
 test_expect_success \
     'validate the output.' \
-- 
2.7.2.334.g35ed2ae.dirty
