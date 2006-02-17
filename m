From: Carl Worth <cworth@cworth.org>
Subject: [PATCH 3/3] New test to verify that when git-clone fails it cleans up the new directory.
Date: Fri, 17 Feb 2006 13:33:28 -0800
Message-ID: <11402120081238-git-send-email-cworth@cworth.org>
References: <1140212006127-git-send-email-cworth@cworth.org>
Reply-To: Carl Worth <cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 22:34:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADFG-0002yM-8b
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030652AbWBQVe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWBQVe1
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:34:27 -0500
Received: from theworths.org ([217.160.253.102]:32214 "EHLO theworths.org")
	by vger.kernel.org with ESMTP id S1751437AbWBQVe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 16:34:26 -0500
Received: (qmail 15666 invoked from network); 17 Feb 2006 16:34:25 -0500
Received: from localhost (HELO raht) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2006 16:34:25 -0500
In-Reply-To: <1140212006127-git-send-email-cworth@cworth.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16370>

Signed-off-by: Carl Worth <cworth@cworth.org>


---

 t/t5600-clone-fail-cleanup.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/t5600-clone-fail-cleanup.sh

0d8852c105e5f910ba53fc974a5d929a2136aecd
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
new file mode 100755
index 0000000..0c6a363
--- /dev/null
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (C) 2006 Carl D. Worth <cworth@cworth.org>
+#
+
+test_description='test git-clone to cleanup after failure
+
+This test covers the fact that if git-clone fails, it should remove
+the directory it created, to avoid the user having to manually
+remove the directory before attempting a clone again.'
+
+. ./test-lib.sh
+
+test_expect_failure \
+    'clone of non-existent source should fail' \
+    'git-clone foo bar'
+
+test_expect_failure \
+    'failed clone should not leave a directory' \
+    'cd bar'
+
+# Need a repo to clone
+test_create_repo foo
+
+# clone doesn't like it if there is no HEAD. Is that a bug?
+(cd foo && touch file && git add file && git commit -m 'add file' >/dev/null 2>&1)
+
+test_expect_success \
+    'clone should work now that source exists' \
+    'git-clone foo bar'
+
+test_expect_success \
+    'successfull clone must leave the directory' \
+    'cd bar'
+
+test_done
-- 
1.2.0.gf6e8
