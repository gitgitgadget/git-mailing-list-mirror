From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] [BUG] Add a testcase for "git mv -f" on untracked files.
Date: Wed,  4 Feb 2009 10:32:07 +0100
Message-ID: <1233739928-19895-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1233739928-19895-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 04 10:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUeCW-0001sn-QQ
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbZBDJgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZBDJgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:36:16 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:37586 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbZBDJgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:36:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n149WMle025105;
	Wed, 4 Feb 2009 10:32:22 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LUe77-0006SY-0y; Wed, 04 Feb 2009 10:32:09 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LUe76-0005BW-Un; Wed, 04 Feb 2009 10:32:08 +0100
X-Mailer: git-send-email 1.6.1.2.321.g68da9
In-Reply-To: <1233739928-19895-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 04 Feb 2009 10:32:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108328>

This currently fails with:
git: builtin-mv.c:217: cmd_mv: Assertion `pos >= 0' failed.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7001-mv.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e4dfe95..52a47b5 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -58,6 +58,14 @@ test_expect_success \
      test ! -f path0/untracked1 &&
      test ! -f path0/untracked2'
 
+test_expect_failure \
+    'checking -f on untracked file with existing target' \
+    'touch path0/untracked1 &&
+     git mv -f untracked1 path0
+     test ! -f .git/index.lock &&
+     test -f untracked1 &&
+     test -f path0/untracked1'
+
 # clean up the mess in case bad things happen
 rm -f idontexist untracked1 untracked2 \
      path0/idontexist path0/untracked1 path0/untracked2 \
-- 
1.6.1.2.321.g68da9
