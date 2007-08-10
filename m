From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/2] New test: make sure that =?utf-8?q?StGIT=C2=A0can?=
	handle packed refs
Date: Fri, 10 Aug 2007 05:23:12 +0200
Message-ID: <20070810032312.19791.68367.stgit@yoghurt>
References: <20070810031949.19791.54562.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 05:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJL61-0000zv-Fe
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 05:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbXHJDX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 23:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbXHJDX0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 23:23:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2803 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbXHJDXO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 23:23:14 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IJL5l-0005Qg-00; Fri, 10 Aug 2007 04:23:13 +0100
In-Reply-To: <20070810031949.19791.54562.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55501>

It currently can't, which is why this test is needed. The situation
has recently taken a turn for the worse, since git-gc nowadays packs
refs by default.

---

 t/t1004-pack-ref.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t1004-pack-ref.sh b/t/t1004-pack-ref.sh
new file mode 100755
index 0000000..a5eb17c
--- /dev/null
+++ b/t/t1004-pack-ref.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Karl Hasselstr=C3=B6m
+#
+
+test_description=3D'Test that StGIT can handle packed refs'
+
+. ./test-lib.sh
+stg init
+
+test_expect_success \
+    'Pack refs and make sure that we can still see them' '
+    stg branch -c foo &&
+    [ $(stg branch -l | tee /dev/stderr | wc -l) -eq 2 ] &&
+    git pack-refs --all &&
+    [ $(stg branch -l | tee /dev/stderr | wc -l) -eq 2 ]
+'
+
+test_expect_success \
+    'Try to delete a branch whose ref has been packed' '
+    stg branch -d master
+'
+
+test_done
