From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] rebase -i: use full onto sha1 in reflog
Date: Thu,  9 Aug 2012 18:05:59 +0200
Message-ID: <89f79049a5fd737716ad51630a8c1ee4a27d747e.1344528082.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 18:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzVFS-0007lz-Li
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 18:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031438Ab2HIQGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 12:06:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41131 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031418Ab2HIQGD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2012 12:06:03 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 97A0520BBA
	for <git@vger.kernel.org>; Thu,  9 Aug 2012 12:06:01 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 09 Aug 2012 12:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=fIcMcWSC1cQ9kgVgoKQxpXwIYd8=; b=uJH4RdUobmFjKWKFEmN1
	RT3BvhHpU4c9wwDGQUR2fpDveRMS5bTVMCpuGQ2GFph1CCwZvusZnjlbiSq1M1Sj
	r0hYzi1Lsx0hG/7APH3VEcXpNtVoifCPS8C5NTENTN6GvyDcrlyDj+2jnNmyp6lm
	eELfaNqbjR7H7TwBDPFJLJI=
X-Sasl-enc: 4/qEWZvtDy1kGZlfgHW6dTCbVJwhYZlbS+Yp94Y4Yq3A 1344528361
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 293DC4824E5;
	Thu,  9 Aug 2012 12:06:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.245.g4f94e02
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203162>

'git rebase' uses the full onto sha1 for the reflog message whereas 'git
rebase -i' uses the short sha1. This is not only inconsistent, but can
lead to problems when the reflog is inspected at a later time at which
that abbreviation may have become ambiguous.

Make 'rebase -i' use the full onto sha1, as well.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I don't remember having sent this out before but have been running with
it since (including tests). I don't see it on the list either.

While not for 1.7.12 obviously, it might still be good to have.

 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0d2056f..dbc9de6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -573,7 +573,7 @@ do_next () {
 	newhead=$(git rev-parse HEAD) &&
 	case $head_name in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
+		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
 		git update-ref -m "$message" $head_name $newhead $orig_head &&
 		git symbolic-ref \
 		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
-- 
1.7.12.rc2.245.g4f94e02
