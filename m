From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Sun,  6 Jul 2008 17:22:50 -0400
Message-ID: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 23:23:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFbi1-0002Mw-MA
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 23:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbYGFVWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758013AbYGFVWx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 17:22:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52976 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627AbYGFVWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 17:22:52 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id 545F21FFC023;
	Sun,  6 Jul 2008 21:22:44 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.348.gcff8f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87558>

This makes rebase act a little more like merge when working on the
current branch.  This is particularly useful for `git pull --rebase`

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 ARG!  This is what v3 was supposed to be.  I should make sure I am sending in
 the correct patch.  (Tip: run format-patch again after a commit --amend.)  Bad
 weekend for me, apparently trying to do too many things at once.  Sorry for
 all the noise.

 To recap:

 If I followed the discussion correctly the first time I sent in this patch,
 the two issues were:

 - Ugly "echo > ORIG_HEAD" instead of pretty "git update-ref ORIG_HEAD"
 - Setting ORIG_HEAD at the wrong place

 This version (as opposed to v2, or the embarrassingly identital "v3")  uses
 the correct variable.  $orig_head looks like the right name, but it stores the
 branch.  $prev_head stores the actual SHA1, which is what I was looking for.

 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..1048f7e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -434,3 +434,4 @@ do
 done
 
 finish_rb_merge
+git update-ref ORIG_HEAD $prev_head
-- 
1.5.6.2.348.gcff8f.dirty
