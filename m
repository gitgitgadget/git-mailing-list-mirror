From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/4] Add simple test for "stg branch --delete"
Date: Sat, 22 Sep 2007 10:46:36 +0200
Message-ID: <20070922084636.29884.36503.stgit@yoghurt>
References: <20070922084334.29884.60506.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:46:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0dV-0005ZG-9F
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbXIVIqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2007 04:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXIVIqn
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:46:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4117 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbXIVIqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:46:42 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZ0dJ-0001nf-00; Sat, 22 Sep 2007 09:46:37 +0100
In-Reply-To: <20070922084334.29884.60506.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58925>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1005-branch-delete.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 t/t1005-branch-delete.sh


diff --git a/t/t1005-branch-delete.sh b/t/t1005-branch-delete.sh
new file mode 100755
index 0000000..7a0872e
--- /dev/null
+++ b/t/t1005-branch-delete.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description=3D'Attempt to delete branches'
+
+. ./test-lib.sh
+
+stg init
+
+test_expect_success 'Create a branch (and switch to it)' '
+    stg branch --create foo
+    '
+
+test_expect_success 'Delete a branch' '
+    stg branch --delete master
+    '
+
+test_expect_success 'Make sure the branch ref was deleted' '
+    [ -z "$(git show-ref | grep master | tee /dev/stderr)" ]
+    '
+
+test_expect_success 'Make sure the branch config was deleted' '
+    [ -z "$(git config -l | grep branch\\.master | tee /dev/stderr)" ]
+    '
+
+test_expect_success 'Make sure the branch files were deleted' '
+    [ -z "$(find .git -type f | grep master | tee /dev/stderr)" ]
+    '
+
+test_done
