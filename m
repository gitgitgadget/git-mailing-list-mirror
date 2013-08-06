From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCH revised] git_mkstemps: add test suite test
Date: Tue, 6 Aug 2013 14:05:01 -0400
Message-ID: <201308061805.r76I51If026086@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 20:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6ld9-0003yq-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab3HFSFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 14:05:05 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:53370
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756550Ab3HFSFE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Aug 2013 14:05:04 -0400
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id 9RRG1m0010bG4ec57W524e; Tue, 06 Aug 2013 18:05:02 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id 9W521m00K1KKtkw3PW52mR; Tue, 06 Aug 2013 18:05:02 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r76I51tG026095;
	Tue, 6 Aug 2013 14:05:01 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r76I51If026086;
	Tue, 6 Aug 2013 14:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375812302;
	bh=JbBUQF3XaUcWceo08SzbyIx6D8jo0XGCkofGGrd7kR0=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=QSJcBnTnFjvLuM6bq7gMSwXYKu7obJbGSw4pCwdYqGFGtwGRIf9Fic0jGQtH+YRxz
	 meHY3ukTFgYvJnp7c3/p320BYpZRYHWH02msBSRDSjR0zt3SfdsExJ/Q7hVOOWEEEp
	 gNci8tDy3j6Sk17oLd6L7Zwltu2ZHCeEHaXHIJaj38z/YBEtWPX7k6MvZrBGw8EBUC
	 9s3e4nTMutbdsSUzSLcfA+Gw95Ihf3r+Xyl5zUILM3QdzZ28jfMt2NKxJYejeb8yda
	 t+5erZwhVgyzEIsAdolKQyzYsK19kD83J8FmfIb0UXrPwkBt5LH8DXxAlLfswAXNKU
	 0NEgrLyFnWCLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231770>

Commit a2cb86 ("git_mkstemps: correctly test return value of open()",
12 Jul 2013) fixes a bug regarding testing the return of an open()
call for success/failure.  Add a testsuite test for that fix.  The
test exercises a situation where that open() is known to return 0.

Signed-off-by: Dale Worley <worley@ariadne.com>
---
This version of the patch cleans up a number of errors in my previous
version (which were ultimately due to my faulty updating of my master
branch).  The commit that added the open() test is now correctly
described.  Since the test was not present in the test suite at all,
the patch is described as adding the test rather than improving it.

a2cb86 is on branch tr/fd-gotcha-fixes, but that has been merged into
master now.

(Thanks for your patience with this.)

Dale

 t/t0070-fundamental.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 986b2a8..d427f3a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -25,6 +25,13 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
 	grep "cannotwrite/test" err
 '
 
+test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
+	git init &&
+	echo Test. >test-file &&
+	git add test-file &&
+	git commit -m Message. <&-
+'
+
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
 	test-regex
-- 
1.8.4.rc1.24.gd407a5c
