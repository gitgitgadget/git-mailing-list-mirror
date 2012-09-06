From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/8] t0060: verify that real_path() works correctly with absolute paths
Date: Fri,  7 Sep 2012 00:41:02 +0200
Message-ID: <1346971264-23744-7-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:42:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9klw-0007lO-0r
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab2IFWlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:50 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:51591 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754463Ab2IFWln (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:43 -0400
X-AuditID: 12074414-b7f846d0000008b8-e8-504926a68d3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F0.F5.02232.6A629405; Thu,  6 Sep 2012 18:41:42 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJY025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:41 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLtMzTPAoPWSjkXXlW4mi4beK8wW
	T+beZba4vWI+s8X6RQ2sFt1T3jI6sHn8ff+ByWPnrLvsHg9fdbF7XLyk7PF5k1wAaxS3TVJi
	SVlwZnqevl0Cd8bsLZdZC6bwVHw+/oGlgbGbq4uRk0NCwETiUvtCRghbTOLCvfVsXYxcHEIC
	lxklvmxthXJOM0m8v3KDGaSKTUBXYlFPMxOILSKgJjGx7RALiM0scJ5R4s9NdhBbWCBK4vGb
	q2BTWQRUJd7unw5m8wq4SPyet4IFYpuixI/va4BmcnBwCrhKTFsgBxIWAiqZ9/422wRG3gWM
	DKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQoJLZAfjkZNyhxgFOBiVeHgn
	nvcIEGJNLCuuzD3EKMnBpCTK+0/JM0CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/EX0DlvCmJ
	lVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvNGqQEMFi1LTUyvSMnNKENJM
	HJwgggtkAw/QhgCQQt7igsTc4sx0iKJTjIpS4rxFIAkBkERGaR7cAFgaeMUoDvSPMG8QSBUP
	MIXAdb8CGswENFjkGcjpxSWJCCmpBsYpO3TnrFm18rEnO8PeDY5208JXFrht3//z4M3luvZR
	ngU3tBu2ffnQ7ct26oZtYrfTtxm/P1+at9lUoi6kIvsxx8ljMmdYywVe8fqvU3ihPL/5e/uj
	1k2/igwjTb5XMNZyPik03Lvp40zj3CPh983lnRjFg1K0vul82JqlHGgXOa/L/6ii 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204938>

There is currently a bug: if passed an absolute top-level path that
doesn't exist (e.g., "/foo") it incorrectly interprets the path as a
relative path (e.g., returns "$(pwd)/foo").  So mark the test as
failing.

These tests are skipped on Windows because test-path-utils operates on
a DOS-style absolute path even if a POSIX style absolute path is
passed as argument.

Adjusted for Windows by: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0060-path-utils.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index fab5ea2..3121691 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -148,7 +148,17 @@ test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-test_expect_success SYMLINKS 'real path works as expected' '
+test_expect_failure POSIX 'real path works on absolute paths' '
+	nopath="hopefully-absent-path" &&
+	test "/" = "$(test-path-utils real_path "/")" &&
+	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
+	# Find an existing top-level directory for the remaining tests:
+	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
+	test "$d" = "$(test-path-utils real_path "$d")" &&
+	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
+'
+
+test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
 	mkdir second &&
-- 
1.7.11.3
