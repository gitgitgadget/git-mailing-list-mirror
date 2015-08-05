From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] tests: fix cleanup after tests in t1509-root-worktree
Date: Wed,  5 Aug 2015 11:43:51 +0200
Message-ID: <1438767831-1620-2-git-send-email-ps@pks.im>
References: <1438767831-1620-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMvF3-0002wz-GA
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 11:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbbHEJoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 05:44:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47781 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbbHEJoC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 05:44:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CA2BF204A5
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 05:44:01 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 05 Aug 2015 05:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FFJo
	WswF7rUku5yC9k1GXvM2KNo=; b=So45LXCNNeGvubvq2fjNCeOhKSpn7IQCqKrF
	Re7p3i8seZ1jINS4L7UCNwg6SRNVVZJ0WeQhgAgKwVjKRVHXbqTRLr7xs/uCuM3y
	STMk5gAT6SgZTBHRkN5/zRra81Sr0R6jEMgqA9VJCywD1tcnTsOXgjJSeIHJOf4F
	qOqVd28=
X-Sasl-enc: D2hpuzm0akCmRC2iLDP1hj2gnntKZlcAxwHBtHGNQLxd 1438767841
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 65CDBC00021;
	Wed,  5 Aug 2015 05:44:01 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438767831-1620-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275361>

During cleanup we do a simple 'rm /*' to remove leftover files
from previous tests. As 'rm' errors out when there is anything it
cannot delete and there are directories present at '/' it will
throw an error, causing the '&&' chain to fail.

Fix this by explicitly removing the files.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1509-root-worktree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 0c80129..553a3f6 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -242,7 +242,7 @@ say "auto bare gitdir"
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
 	rm -rf /refs /objects /info /hooks &&
-	rm /* &&
+	rm -f /expected /ls.expected /me /result &&
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-- 
2.5.0
