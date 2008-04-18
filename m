From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/1] Add tests for `branch --[no-]merged`
Date: Fri, 18 Apr 2008 18:30:15 +0200
Message-ID: <1208536215-11921-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 12:37:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmtTb-0001mf-8F
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 18:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbYDRQ32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 12:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbYDRQ32
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 12:29:28 -0400
Received: from mail45.e.nsc.no ([193.213.115.45]:39191 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbYDRQ31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 12:29:27 -0400
Received: from localhost.localdomain (ti0025a380-0176.bb.online.no [88.89.68.176])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m3IGT3n0022554;
	Fri, 18 Apr 2008 18:29:04 +0200 (MEST)
X-Mailer: git-send-email 1.5.5.74.g74a72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79879>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

A bit late, but here's a testscript for the new options (shamelessly based
on t3201).

 t/t3202-branch-merged.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100755 t/t3202-branch-merged.sh

diff --git a/t/t3202-branch-merged.sh b/t/t3202-branch-merged.sh
new file mode 100755
index 0000000..2710923
--- /dev/null
+++ b/t/t3202-branch-merged.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='branch --merged/--no-merged'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git branch side &&
+
+	echo 1 >file &&
+	test_tick &&
+	git commit -a -m "second on master" &&
+
+	git checkout side &&
+	echo 1 >file &&
+	test_tick &&
+	git commit -a -m "second on side" &&
+
+	git merge master
+
+'
+
+test_expect_success 'side: branch --merged' '
+
+	git branch --merged >actual &&
+	{
+		echo "  master" &&
+		echo "* side"
+	} >expect &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'side: branch --no-merged' '
+
+	git branch --no-merged >actual &&
+	>expect &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'master: branch --merged' '
+
+	git checkout master &&
+	git branch --merged >actual &&
+	{
+		echo "* master"
+	} >expect &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'master: branch --no-merged' '
+
+	git branch --no-merged >actual &&
+	{
+		echo "  side"
+	} >expect &&
+	test_cmp expect actual
+
+'
+
+test_done
-- 
1.5.5.74.g74a72
