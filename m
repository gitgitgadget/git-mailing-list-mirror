From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Try "stg sink" without applied patches
Date: Mon, 30 Jun 2008 00:45:41 +0200
Message-ID: <20080629224541.9267.19258.stgit@yoghurt>
References: <20080629224440.9267.3591.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5fz-00056f-Of
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbYF2WqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 18:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYF2WqX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:46:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2450 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbYF2Wpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:45:46 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KD5eQ-0003UN-00; Sun, 29 Jun 2008 23:45:42 +0100
In-Reply-To: <20080629224440.9267.3591.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86841>

It doesn't work, neither with an implicit nor an explicit patch to
sink. This is bug 11887 in the bug tracker.

(The implicit sink testcase actually passes, but that's just because
the test suite can't distinguish between a program bug and an orderly
abort.)

The test was adapted from the script attached to the bug report,
written by Erik Sandberg.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1501-sink.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100755 t/t1501-sink.sh


diff --git a/t/t1501-sink.sh b/t/t1501-sink.sh
new file mode 100755
index 0000000..3872c4b
--- /dev/null
+++ b/t/t1501-sink.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description=3D'Test "stg sink"'
+
+. ./test-lib.sh
+
+test_expect_success 'Initialize StGit stack' '
+    echo 000 >> x &&
+    git add x &&
+    git commit -m initial &&
+    echo 000 >> y &&
+    git add y &&
+    git commit -m y &&
+    stg init &&
+    stg uncommit &&
+    stg pop
+'
+
+test_expect_success 'sink without applied patches' '
+    ! stg sink
+'
+
+test_expect_failure 'sink a specific patch without applied patches' '
+    stg sink y &&
+    test $(echo $(stg applied)) =3D "y"
+'
+
+test_done
