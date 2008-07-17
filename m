From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] cvsserver: Add testsuite for packed refs
Date: Thu, 17 Jul 2008 19:00:28 +0200
Message-ID: <1216314030-10887-4-git-send-email-lars@public.noschinski.de>
References: <1216314030-10887-1-git-send-email-lars@public.noschinski.de>
 <1216314030-10887-2-git-send-email-lars@public.noschinski.de>
 <1216314030-10887-3-git-send-email-lars@public.noschinski.de>
Cc: lars@public.noschinski.de, fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 19:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWrg-0000Xh-33
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbYGQRAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbYGQRAl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:00:41 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:59531 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157AbYGQRAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:00:38 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJWqK-0007Q9-Im; Thu, 17 Jul 2008 19:00:36 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216314030-10887-3-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88881>

Check that req_update shows refs, even if all refs are packed.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 t/t9400-git-cvsserver-server.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e97aaa6..8120087 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -438,6 +438,13 @@ test_expect_success 'cvs update (-p)' '
     test -z "$(cat failures)"
 '
 
+cd "$WORKDIR"
+test_expect_success 'cvs update (module list supports packed refs)' '
+    GIT_DIR="$SERVERDIR" git pack-refs --all &&
+    GIT_CONFIG="$git_config" cvs -n up -d 2> out &&
+    grep "cvs update: New directory \`master'\''" < out
+'
+
 #------------
 # CVS STATUS
 #------------
-- 
1.5.6.2
