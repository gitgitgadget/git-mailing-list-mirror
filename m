From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Documentation: mention ORIG_HEAD in am, merge, and rebase
Date: Tue,  8 Jul 2008 00:12:22 -0400
Message-ID: <1215490342-46590-1-git-send-email-benji@silverinsanity.com>
References: <35BBB0D4-B3E1-4097-AF11-E0F6223125EA@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:13:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4Zu-0006Ra-AQ
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbYGHEMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbYGHEMZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:12:25 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44819 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYGHEMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:12:24 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id BA3A11FFC023;
	Tue,  8 Jul 2008 04:12:12 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <35BBB0D4-B3E1-4097-AF11-E0F6223125EA@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87702>

Merge has always set ORIG_HEAD but never mentioned it, while we
recently added it to am and rebase.  These facts should be reflected
in the documentation.

git-reset also sets ORIG_HEAD, but that fact is already mentioned in
the very first example so no changes were needed there.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 Documentation/git-am.txt     |    6 ++++++
 Documentation/git-merge.txt  |    4 +++-
 Documentation/git-rebase.txt |    3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 3863eeb..88ca5f1 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -145,6 +145,12 @@ directory exists, so if you decide to start over from scratch,
 run `rm -f -r .dotest` before running the command with mailbox
 names.
 
+Before any patches are applied, ORIG_HEAD is set to the tip of the
+current branch.  This is useful if you have problems with multiple
+commits, like running 'git am' on the wrong branch or an error in the
+commits that is more easily fixed by changing the mailbox (e.g.
+errors in the "From:" lines).
+
 
 SEE ALSO
 --------
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 62f99b5..019e4ca 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -81,7 +81,9 @@ Otherwise, merge will refuse to do any harm to your repository
 (that is, it may fetch the objects from remote, and it may even
 update the local branch used to keep track of the remote branch
 with `git pull remote rbranch:lbranch`, but your working tree,
-`.git/HEAD` pointer and index file are left intact).
+`.git/HEAD` pointer and index file are left intact).  In addition,
+merge always sets `.git/ORIG_HEAD` to the original state of HEAD so
+a problematic merge can be removed by using `git reset ORIG_HEAD`.
 
 You may have local modifications in the working tree files.  In
 other words, 'git-diff' is allowed to report changes.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f3459c7..37382c4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -26,7 +26,8 @@ of commits that would be shown by `git log <upstream>..HEAD`.
 
 The current branch is reset to <upstream>, or <newbase> if the
 --onto option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or <newbase>).
+`git reset --hard <upstream>` (or <newbase>).  This includes setting
+ORIG_HEAD to the pre-rebase tip of the branch.
 
 The commits that were previously saved into the temporary area are
 then reapplied to the current branch, one by one, in order. Note that
-- 
1.5.6.2.393.g45096
