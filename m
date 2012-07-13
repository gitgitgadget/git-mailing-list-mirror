From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v2] git-am: indicate where a failed patch is to be found.
Date: Fri, 13 Jul 2012 11:51:30 -0400
Message-ID: <1342194690-31578-1-git-send-email-paul.gortmaker@windriver.com>
References: <7vobnkadsw.fsf@alter.siamese.dyndns.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 17:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spi9o-0004b4-AH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 17:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab2GMPvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 11:51:47 -0400
Received: from mail.windriver.com ([147.11.1.11]:52301 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab2GMPvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 11:51:47 -0400
Received: from yow-pgortmak-d1.corp.ad.wrs.com (yow-pgortmak-d1.wrs.com [128.224.146.65])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6DFpj7i019672;
	Fri, 13 Jul 2012 08:51:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.7
In-Reply-To: <7vobnkadsw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201408>

If git am fails to apply something, the end user may need
to know where to find the patch.  This is normally known for
a single patch, but if the user is processing a mbox with
many patches, they may not have a single broken out patch
handy.  So, provide a helpful hint as to where they can
find the patch to do some sort of manual fixup, if we
are processing a mbox with more than one patch in it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
[v2: drop text suggesting what to do with failed patch; only
 emit the help text if we are processing mbox with multi patches]

 git-am.sh |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index f8b7a0c..20b3b73 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -855,6 +855,11 @@ did you forget to use 'git add'?"
 	if test $apply_status != 0
 	then
 		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
+		if test $patch_format = mbox && test "$last" -ne "1"
+		then
+			eval_gettextln "You can find the copy of the patch that failed here:
+   $dotest/patch"
+		fi
 		stop_here_user_resolve $this
 	fi
 
-- 
1.7.9.7
