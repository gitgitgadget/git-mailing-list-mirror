From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Do git reset --hard HEAD when using git rebase --skip
Date: Thu,  8 Nov 2007 08:03:06 +0100
Message-ID: <1194505386-18156-1-git-send-email-mh@glandium.org>
References: <20071107222105.GA31666@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 08:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1R9-00017v-3k
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbXKHHEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbXKHHEG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:04:06 -0500
Received: from vawad.err.no ([85.19.200.177]:36941 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041AbXKHHEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:04:05 -0500
Received: from aputeaux-153-1-97-76.w86-217.abo.wanadoo.fr ([86.217.119.76] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Iq1Qg-0002ls-KA; Thu, 08 Nov 2007 08:03:57 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Iq1Pu-0004j9-FS; Thu, 08 Nov 2007 08:03:06 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <20071107222105.GA31666@glandium.org>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63939>

When you have a merge conflict and want to bypass the commit causing it,
you don't want to care about the dirty state of the working tree.

Also, don't git reset --hard HEAD in the rebase-skip test, so that the
lack of support for this is detected.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 git-rebase.sh          |    1 +
 t/t3403-rebase-skip.sh |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e3ad7de..8814be9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -158,6 +158,7 @@ do
 		exit
 		;;
 	--skip)
+		git reset --hard HEAD || exit $?
 		if test -d "$dotest"
 		then
 			git rerere clear
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index eab053c..becabfc 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -36,7 +36,6 @@ test_expect_failure 'rebase with git am -3 (default)' '
 '
 
 test_expect_success 'rebase --skip with am -3' '
-	git reset --hard HEAD &&
 	git rebase --skip
 	'
 test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
@@ -44,7 +43,6 @@ test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
 test_expect_failure 'rebase with --merge' 'git rebase --merge master'
 
 test_expect_success 'rebase --skip with --merge' '
-	git reset --hard HEAD &&
 	git rebase --skip
 	'
 
-- 
1.5.3.5
