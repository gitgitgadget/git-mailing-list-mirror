From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] New test: try "stg refresh" in a subdirectory
Date: Mon, 08 Oct 2007 01:25:00 +0200
Message-ID: <20071007232500.13070.5063.stgit@yoghurt>
References: <20071007231949.13070.49517.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefVW-0004S3-Ag
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbXJGXZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbXJGXZG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:25:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1225 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbXJGXZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:25:05 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefUa-0000Qh-00; Mon, 08 Oct 2007 00:25:00 +0100
In-Reply-To: <20071007231949.13070.49517.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60255>

Currently, it doesn't work. Or rather, it does work for changes that
are already in the index, which is the case for newly added files; but
it doesn't work for changes that aren't in the index.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t2300-refresh-subdir.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t2300-refresh-subdir.sh


diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
new file mode 100755
index 0000000..d1c7168
--- /dev/null
+++ b/t/t2300-refresh-subdir.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+test_description=3D'Test the refresh command from a subdirectory'
+. ./test-lib.sh
+stg init
+
+test_expect_success 'Refresh from a subdirectory' '
+    stg new foo -m foo &&
+    echo foo >> foo.txt &&
+    mkdir bar &&
+    echo bar >> bar/bar.txt &&
+    stg add foo.txt bar/bar.txt &&
+    cd bar &&
+    stg refresh &&
+    cd .. &&
+    [ "$(stg status)" =3D "" ]
+'
+
+test_expect_failure 'Refresh again' '
+    echo foo2 >> foo.txt &&
+    echo bar2 >> bar/bar.txt &&
+    cd bar &&
+    stg refresh &&
+    cd .. &&
+    [ "$(stg status)" =3D "" ]
+'
+
+test_done
