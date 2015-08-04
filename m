From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/6] tests: fix cleanup after tests in t1509-root-worktree
Date: Tue,  4 Aug 2015 13:29:53 +0200
Message-ID: <1438687797-14254-3-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQL-0006sg-J1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275AbbHDLaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45364 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933034AbbHDLaO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 222D620BBA
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:14 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 04 Aug 2015 07:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FFJo
	WswF7rUku5yC9k1GXvM2KNo=; b=AjxuvscHjQdQF/BOm8O6n5YMoJHpII3ULOdu
	WAgk3UySQrak1O3hLdpKn+bdiAL7jbmfCZ/q5lkOWru4dvcOlx28JiepZLYaBzTN
	DkwDsbCjU8Z+V9crPKz8NQh3EX9+I8TStjAK2WCDcizQaB4Sd74y/PwzfWKcFwDA
	d7i4Y6Y=
X-Sasl-enc: g4apcK0XGOItplEPSR3TtofSm1Vf9rMLBZqP/qt2ZRcn 1438687813
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9FBB768013B;
	Tue,  4 Aug 2015 07:30:13 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275245>

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
