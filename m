From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 11:50:43 -0400
Message-ID: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 17:51:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpLfb-0005wj-HM
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 17:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934087Ab2GLPuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 11:50:54 -0400
Received: from mail.windriver.com ([147.11.1.11]:33939 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab2GLPux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 11:50:53 -0400
Received: from yow-pgortmak-d1.corp.ad.wrs.com (yow-pgortmak-d1.wrs.com [128.224.146.65])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q6CFopAd020696;
	Thu, 12 Jul 2012 08:50:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201363>

If git am wasn't run with --reject, we assume the end user
knows where to find the patch.  This is normally true for
a single patch, but if the user is processing a mbox with
many patches, they may not have a single broken out patch
handy.  So, provide a helpful hint as to where they can
find the patch to do the manual fixup before eventually
continuing with "git add ... ; git am -r".

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/git-am.sh b/git-am.sh
index f8b7a0c..32e6ac0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -854,7 +854,10 @@ did you forget to use 'git add'?"
 	fi
 	if test $apply_status != 0
 	then
-		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
+		eval_gettextln "Patch failed at $msgnum $FIRSTLINE
+You can try running the following command:
+   patch -p1 --dry-run < $dotest/patch
+in order to possibly get more information on why it failed."
 		stop_here_user_resolve $this
 	fi
 
-- 
1.7.9.7
