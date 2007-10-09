From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] New test: "stg diff"
Date: Tue, 09 Oct 2007 06:42:37 +0200
Message-ID: <20071009044149.26624.11429.stgit@yoghurt>
References: <20071008153450.GA12247@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 06:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If6vp-0003qM-9t
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 06:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXJIEmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 00:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbXJIEmm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 00:42:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4236 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXJIEml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 00:42:41 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1If6vW-0005vU-00; Tue, 09 Oct 2007 05:42:38 +0100
In-Reply-To: <20071008153450.GA12247@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60356>

A simple test to make sure that we can run "stg diff" without
arguments, just to list local changes.

Note that two subtests currently fail; these are due to plain "stg
diff" failing on a branch where "stg init" hasn't been run, which is
plainly a bug.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

On 2007-10-08 17:34:50 +0200, Karl Hasselstr=C3=B6m wrote:

> So, we don't have a single test that tries to run "stg diff". Duh.


 t/t2400-diff.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100755 t/t2400-diff.sh


diff --git a/t/t2400-diff.sh b/t/t2400-diff.sh
new file mode 100755
index 0000000..6d9ed98
--- /dev/null
+++ b/t/t2400-diff.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description=3D'Run "stg diff"'
+
+. ./test-lib.sh
+
+test_expect_failure 'Diff with no StGit data' '
+    stg diff
+'
+
+test_expect_success 'Make some local changes' '
+    echo foo >> foo.txt &&
+    git add foo.txt
+'
+
+test_expect_failure 'Diff with some local changes' '
+    stg diff
+'
+
+test_expect_success 'Initialize StGit stuff' '
+    stg init &&
+    stg new foo -m foo
+'
+
+test_expect_success 'Diff with some local changes' '
+    stg diff
+'
+
+test_expect_success 'Refresh patch' '
+    stg refresh
+'
+
+test_expect_success 'Diff with no local changes' '
+    stg diff
+'
+
+test_done
