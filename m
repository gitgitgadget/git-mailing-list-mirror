From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/5] t4001-diff-rename: wrap file creations in a test
Date: Tue, 23 Feb 2016 18:44:55 +0100
Message-ID: <1456249498-3232-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYH1y-0001V8-KS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbcBWRpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:45:11 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47024 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639AbcBWRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:09 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj5de021470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:45:05 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6MV012979;
	Tue, 23 Feb 2016 18:45:07 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 18:45:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHj5de021470
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854305.83814@NNUs3kWOUubpLTzjsjRMwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287097>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t4001-diff-rename.sh | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..bfb364c 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -9,7 +9,9 @@ test_description='Test rename detection in diff engine.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-echo >path0 'Line 1
+test_expect_success 'setup' '
+	cat >path0 <<\EOF &&
+Line 1
 Line 2
 Line 3
 Line 4
@@ -24,6 +26,23 @@ Line 12
 Line 13
 Line 14
 Line 15
+EOF
+	cat >expected <<\EOF
+diff --git a/path0 b/path1
+rename from path0
+rename to path1
+--- a/path0
++++ b/path1
+@@ -8,7 +8,7 @@ Line 7
+ Line 8
+ Line 9
+ Line 10
+-line 11
++Line 11
+ Line 12
+ Line 13
+ Line 14
+EOF
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
