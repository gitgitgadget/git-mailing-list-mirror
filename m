From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/6] tests: fix cleanup after tests in t1509-root-worktree
Date: Wed, 29 Jul 2015 17:51:12 +0200
Message-ID: <1438185076-28870-3-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdj-0000rQ-VH
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbbG2PvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47433 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbbG2PvX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 37F1D20937
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:23 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Jul 2015 11:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FFJo
	WswF7rUku5yC9k1GXvM2KNo=; b=MG/7XDQvqf1H6jM3DgpT9KM/ZwN6jOA4VEru
	NoFdBe/jeCOXQl1MzqiglLhXfF4/Mxop6ZdOM5ToLTFhLbkHo3J7PjUObvqEdTMF
	qgzcQUaiQIU42tTJpm8fnJbGBDlq3xEnwupSFY+Mg9+rxgrTO0AIvBxsAriqHfn/
	xwDABWk=
X-Sasl-enc: 1kJZ87UvyqKvCwBki3uE8u50BHJAbssjMxPxpj0pjTwx 1438185082
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id C6BC9C00012;
	Wed, 29 Jul 2015 11:51:22 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438185076-28870-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274905>

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
