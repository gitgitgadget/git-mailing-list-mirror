From: Brad King <brad.king@kitware.com>
Subject: [PATCH 1/2] Test update-index for a gitlink to a .git file
Date: Fri,  8 Jan 2010 17:36:47 -0500
Message-ID: <1262990208-15554-2-git-send-email-brad.king@kitware.com>
References: <1262990208-15554-1-git-send-email-brad.king@kitware.com>
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 23:46:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNap-0004Mp-C0
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab0AHWqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 17:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139Ab0AHWqB
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:46:01 -0500
Received: from public.kitware.com ([66.194.253.19]:44063 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123Ab0AHWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 17:45:59 -0500
Received: by public.kitware.com (Postfix, from userid 5001)
	id 3384A17DC2; Fri,  8 Jan 2010 17:27:38 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 9EFA617DBB;
	Fri,  8 Jan 2010 17:27:37 -0500 (EST)
Received: by hythloth (Postfix, from userid 1000)
	id 97377D002F; Fri,  8 Jan 2010 17:36:48 -0500 (EST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1262990208-15554-1-git-send-email-brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136486>

Check that update-index recognizes a submodule that uses a .git file.
Currently it works when the .git file specifies an absolute path, but
not when it specifies a relative path.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 t/t2104-update-index-gitfile.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 t/t2104-update-index-gitfile.sh

diff --git a/t/t2104-update-index-gitfile.sh b/t/t2104-update-index-gitfile.sh
new file mode 100755
index 0000000..ba71984
--- /dev/null
+++ b/t/t2104-update-index-gitfile.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Brad King
+#
+
+test_description='git update-index for gitlink to .git file.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'submodule with absolute .git file' '
+	mkdir sub1 &&
+	(cd sub1 &&
+	 git init &&
+	 REAL="$(pwd)/.real" &&
+	 mv .git "$REAL"
+	 echo "gitdir: $REAL" >.git &&
+	 test_commit first)
+'
+
+test_expect_success 'add gitlink to absolute .git file' '
+	git update-index --add -- sub1
+'
+
+test_expect_success 'submodule with relative .git file' '
+	mkdir sub2 &&
+	(cd sub2 &&
+	 git init &&
+	 mv .git .real &&
+	 echo "gitdir: .real" >.git &&
+	 test_commit first)
+'
+
+test_expect_failure 'add gitlink to relative .git file' '
+	git update-index --add -- sub2
+'
+
+test_done
-- 
1.6.5
