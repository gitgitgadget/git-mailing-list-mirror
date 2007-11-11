From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] Simple test for "stg clean"
Date: Sun, 11 Nov 2007 20:43:37 +0100
Message-ID: <20071111194334.18868.87832.stgit@yoghurt>
References: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIix-0001Or-76
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbXKKTnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756809AbXKKTnn
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:43:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3883 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbXKKTnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:43:42 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IrIiX-0004bG-00; Sun, 11 Nov 2007 19:43:38 +0000
In-Reply-To: <20071111193545.18868.62490.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64501>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t2500-clean.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t2500-clean.sh


diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
new file mode 100755
index 0000000..3364c18
--- /dev/null
+++ b/t/t2500-clean.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description=3D'Run "stg clean"'
+
+. ./test-lib.sh
+
+test_expect_success 'Initialize StGit stack' '
+    stg init &&
+    stg new e0 -m e0 &&
+    stg new p0 -m p0 &&
+    echo foo > foo.txt &&
+    git add foo.txt &&
+    stg refresh &&
+    stg new e1 -m e1 &&
+    stg new e2 -m e2 &&
+    stg pop
+'
+
+test_expect_success 'Clean empty patches' '
+    [ "$(echo $(stg applied))" =3D "e0 p0 e1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "e2" ] &&
+    stg clean &&
+    [ "$(echo $(stg applied))" =3D "p0" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_done
