From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 07/10] t7300: fix clean up on Windows
Date: Wed, 18 Mar 2009 22:27:09 +0100
Message-ID: <ffdd1bf27fc20055147db1573712acabc73f339c.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Ko-000574-6a
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZCRV1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbZCRV12
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46776 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3F3022C400D;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E8FE860F10;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113676>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, you cannot remove files that are in use, not even with
'rm -rf'.  So we need to run 'exec <foo/bar' inside a subshell lest
removing the whole test repository fail.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7300-clean.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 1636fac..929d5d4 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -373,9 +373,9 @@ test_expect_success 'removal failure' '
 
 	mkdir foo &&
 	touch foo/bar &&
-	exec <foo/bar &&
-	chmod 0 foo &&
-	test_must_fail git clean -f -d
+	(exec <foo/bar &&
+	 chmod 0 foo &&
+	 test_must_fail git clean -f -d)
 
 '
 chmod 755 foo
-- 
1.6.2.1.224.g2225f
