From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Test case for "git diff" outside a git repo
Date: Mon, 23 Jul 2007 06:22:48 -0700
Message-ID: <20070723132248.GA24122@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 15:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICxsD-0004hE-P8
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 15:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbXGWNWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 09:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbXGWNWt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 09:22:49 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:51118
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1754624AbXGWNWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 09:22:49 -0400
Received: (qmail 24499 invoked by uid 1001); 23 Jul 2007 13:22:48 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53435>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
	git-diff --quiet is pretty broken right now. If you do
	"strace git diff --quiet file1 file2" you will see that
	it never calls open() on either file! And it always
	returns a zero exit code whether or not the files are
	different.

	I'm trying to follow the code to figure out what's going on,
	but meanwhile, here's a test case. Perhaps someone more
	familiar with the diff code will beat me to a fix.

 t/t4021-diff-norepo.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100755 t/t4021-diff-norepo.sh

diff --git a/t/t4021-diff-norepo.sh b/t/t4021-diff-norepo.sh
new file mode 100755
index 0000000..dfee3d7
--- /dev/null
+++ b/t/t4021-diff-norepo.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='test git diff outside a repo'
+
+. ./test-lib.sh
+
+rm -rf .git
+
+test_expect_success setup '
+
+	echo content1 >file1a &&
+	echo content1 >file1b &&
+	echo content2 >file2
+'
+
+test_expect_success 'zero return value with --quiet for different files' '
+
+	git diff --quiet file1a file2
+'
+
+test_expect_success 'nonzero return value with --quiet for identical files' '
+
+	! git diff --quiet file1a file1b >/dev/null
+'
+
+test_done
-- 
1.5.3.rc2.4.g726f9
