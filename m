From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Simple test for "stg clean"
Date: Mon, 05 Nov 2007 04:14:48 +0100
Message-ID: <20071105031448.6108.90948.stgit@yoghurt>
References: <20071105030847.6108.44653.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IosQp-0002iZ-Tt
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbXKEDPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 22:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbXKEDPB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:15:01 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2139 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbXKEDO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:14:59 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IosQJ-0003Gd-00; Mon, 05 Nov 2007 03:14:47 +0000
In-Reply-To: <20071105030847.6108.44653.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63475>

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
