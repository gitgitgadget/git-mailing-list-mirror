From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 1/2] Test update-index for a gitlink to a .git file
Date: Fri,  8 Jan 2010 22:36:40 -0500
Message-ID: <1263008201-27429-2-git-send-email-brad.king@kitware.com>
References: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 04:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTS8B-0008Ik-9x
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 04:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab0AIDgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 22:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507Ab0AIDgq
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 22:36:46 -0500
Received: from public.kitware.com ([66.194.253.19]:39430 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab0AIDgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 22:36:45 -0500
Received: by public.kitware.com (Postfix, from userid 5001)
	id CF91917EAD; Fri,  8 Jan 2010 22:27:32 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.kitware.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id DB90117EA6;
	Fri,  8 Jan 2010 22:27:31 -0500 (EST)
Received: by hythloth (Postfix, from userid 1000)
	id 2E5A24E3F1; Fri,  8 Jan 2010 22:36:41 -0500 (EST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <32541b131001081524g43d54a44i582dd286c1dfe7a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136511>

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
