From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC] Add basic syntax check on shell scripts
Date: Sun, 2 Dec 2012 14:17:24 +0100
Message-ID: <201212021417.25525.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 14:18:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf9Qu-0000c1-LQ
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 14:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab2LBNRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 08:17:32 -0500
Received: from mout.web.de ([212.227.17.12]:50730 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2LBNRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2012 08:17:31 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MBTQo-1TWvwl3Jva-00AA0T; Sun, 02 Dec 2012 14:17:29 +0100
X-Provags-ID: V02:K0:qDR7Q9/lYA/UYzuhFY3ivAVbKXHVXy/Gc26NGw3RziD
 3TgCM3h78Z/UaQSF254UfOOJvzchiiCcDn49R+P1EZXigHRgc2
 rp5CsCP+npnNDiLX5KYJ0pXTuX0LG5KhgXQ8GzIvvYa+w0K/BK
 h/TAxP241kfBozNPnaswU+BYmc+8eNcSKURs+8frLv+flUxnw5
 xandJyFCZGWYZMwOJdEaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211012>

The test suite needs to be run on different platforms.
As it may be difficult for contributors to catch syntax
which work on GNU/linux, but is unportable, make a quick check
for the most common problems.
"sed -i", "echo -n" or "array in shell scripts"
This list is not complete, and may need to be extended

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
We add 1 second test execution time
Is this a useful idea at all?
=20
 t/t99999-syntax-check.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 t/t99999-syntax-check.sh

diff --git a/t/t99999-syntax-check.sh b/t/t99999-syntax-check.sh
new file mode 100755
index 0000000..c4a9289
--- /dev/null
+++ b/t/t99999-syntax-check.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description=3D'Basic check if shell syntax is portable'
+
+. ./test-lib.sh
+
+
+test_expect_success 'No arrays in shell scripts' '
+	>expected &&
+	(grep -i -n "^[	 ]*declare[	 ][	 ]*" ../*.sh ../../git-* >actual 2>&1=
 || : ) &&
+	test_cmp expected actual &&
+	rm expected actual
+'
+
+test_expect_success 'No sed -i' '
+	>expected &&
+	(grep -n "^[	 ]*sed[	 ][	 ]*\-i" ../*.sh ../../git-* >actual 2>&1 || =
: ) &&
+	test_cmp expected actual &&
+	rm expected actual
+'
+
+test_expect_success 'No echo -n' '
+	>expected &&
+	(grep -n "^[	 ]*echo[	 ][	 ]*\-n" ../*.sh ../../git-* >actual 2>&1 ||=
 : ) &&
+	test_cmp expected actual &&
+	rm expected actual
+'
+test_done
--=20
1.8.0.197.g5a90748
