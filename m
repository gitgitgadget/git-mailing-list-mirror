From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Test "stg status" with renames
Date: Tue, 08 Jul 2008 21:54:25 +0200
Message-ID: <20080708195425.24866.58362.stgit@yoghurt>
References: <20080708195214.24866.61663.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGJHg-0004zL-F6
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbYGHTyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbYGHTyb
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:54:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1610 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYGHTya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:54:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KGJGb-0003xT-00; Tue, 08 Jul 2008 20:54:26 +0100
In-Reply-To: <20080708195214.24866.61663.stgit@yoghurt>
User-Agent: StGIT/0.14.3.194.gbf3df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87792>

Currently, it only works if -M is not passed to git diff-files, so the
second of the two tests fails.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t0002-status.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)


diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 43e1ca0..69c29a0 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -171,4 +171,20 @@ test_expect_success 'Status of disappeared newborn=
' '
     diff -u expected.txt output.txt
 '
=20
+cat > expected.txt <<EOF
+A fay
+D fie
+EOF
+test_expect_success 'Status after renaming a file' '
+    git rm foo/bar &&
+    git mv fie fay &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+test_expect_failure 'Status after renaming a file (with rename detecti=
on)' '
+    stg status --diff-opts=3D-M > output.txt &&
+    diff -u expected.txt output.txt
+'
+
 test_done
