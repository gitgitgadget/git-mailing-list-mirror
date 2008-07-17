From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] cvsserver: Add testsuite for packed refs
Date: Thu, 17 Jul 2008 12:01:15 +0200
Message-ID: <1216288877-12140-4-git-send-email-lars@public.noschinski.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
Cc: fabian.emmes@rwth-aachen.de,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQS0-0006wH-0Y
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbYGQKKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755337AbYGQKKE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:10:04 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47413 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYGQKKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:10:03 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJQIc-0007y9-0e; Thu, 17 Jul 2008 12:01:22 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88826>

From: Fabian Emmes <fabian.emmes@rwth-aachen.de>

Check that req_update shows refs, even if all refs are packed.

Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 t/t9400-git-cvsserver-server.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e97aaa6..d181b5b 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -438,6 +438,20 @@ test_expect_success 'cvs update (-p)' '
     test -z "$(cat failures)"
 '
 
+cd "$WORKDIR"
+cat > get_update_modules <<EOF
+Root $SERVERDIR
+Directory .
+$SERVERDIR
+update
+EOF
+
+test_expect_success 'cvs update (module list supports packed refs)' '
+    git pack-refs --all &&
+    git cvsserver server < get_update_modules > out &&
+    grep "^M master[	 ]\+master$" < out
+'
+
 #------------
 # CVS STATUS
 #------------
-- 
1.5.6.2
