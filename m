From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 10/10] t5602: Work around path mangling on MSYS
Date: Wed, 18 Mar 2009 22:27:12 +0100
Message-ID: <cdfcd2b997d2f89c02b34aceb19d515d91df372c.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Jk-0004j4-9Q
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZCRV1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbZCRV1X
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:23 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46791 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8673A2C400F;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 421E160C30;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113672>

MSYS's bash rewrites /something/bin/... into a Windows path that looks like
c:/msysgit/something/bin/... before git sees it. But later the test case
verifies that the path was used and compares it to the unmangled version.
This fails, of course. This make the path relative so that the path
mangling is not triggered.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5602-clone-remote-exec.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index 82b1d1e..deffdae 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -18,8 +18,8 @@ test_expect_success 'clone calls git upload-pack unqualified with no -u option'
 '
 
 test_expect_success 'clone calls specified git upload-pack with -u option' '
-	GIT_SSH=./not_ssh git clone -u /something/bin/git-upload-pack localhost:/path/to/repo junk
-	echo "localhost /something/bin/git-upload-pack '\''/path/to/repo'\''" >expected
+	GIT_SSH=./not_ssh git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk
+	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected
 	test_cmp expected not_ssh_output
 '
 
-- 
1.6.2.1.224.g2225f
