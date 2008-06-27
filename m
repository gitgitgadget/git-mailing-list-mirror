From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 14/15] Add new test case to ensure git-merge prepends the custom merge message
Date: Fri, 27 Jun 2008 18:22:07 +0200
Message-ID: <37b95171b8cb3b9db721bf5e854cc73d0b263536.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
 <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
 <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
 <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
 <3a8521edeb769e0fb85bec434daf064ce29edaa5.1214581610.git.vmiklos@frugalware.org>
 <2f3a41b78511ab22c31c2c2827b9b8a456462c83.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGkA-0004E3-8z
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760923AbYF0QWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760139AbYF0QWm
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:42 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45350 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760923AbYF0QWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:14 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id 67C281DDC6A;
	Fri, 27 Jun 2008 18:22:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7716918E832; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <2f3a41b78511ab22c31c2c2827b9b8a456462c83.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86589>

There was no test for this before, so the testsuite passed, even in case
the merge summary was missing from the merge commit message.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t7604-merge-custom-message.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100755 t/t7604-merge-custom-message.sh

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
new file mode 100755
index 0000000..6081677
--- /dev/null
+++ b/t/t7604-merge-custom-message.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing merge when using a custom message for the merge commit.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 > c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	echo c2 > c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2
+'
+
+cat >expected <<\EOF
+custom message
+
+Merge commit 'c2'
+EOF
+test_expect_success 'merge c2 with a custom message' '
+	git reset --hard c1 &&
+	git merge -m "custom message" c2 &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" > actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.5.6
