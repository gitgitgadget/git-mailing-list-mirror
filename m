From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] Test tracking of non-commit upstreams
Date: Mon, 11 May 2009 16:42:53 +0200
Message-ID: <1242052974-28184-2-git-send-email-git@drmicha.warpmail.net>
References: <1242052974-28184-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 16:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3WjB-0003qm-9a
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbZEKOnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbZEKOnJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:43:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57648 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756784AbZEKOnF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 10:43:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 743E7342540;
	Mon, 11 May 2009 10:43:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 11 May 2009 10:43:06 -0400
X-Sasl-enc: EDW8y8OxVSm4w0UY9lZ2xp4nAPzBwKVNqbQZ0ZJCxmRq 1242052985
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB1081856A;
	Mon, 11 May 2009 10:43:05 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.195.gad816
In-Reply-To: <1242052974-28184-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118805>

git-checkout and git-branch allow setting up an arbitrary committish as
the upstream reference for --track. In particular, tags are allowed. But
they and git-status barf on non-commit upstreams as soon as they are
asked for trackings stats.

Expose this shortcoming by adding two tests: annotated tags are affected
but lightweight tags are OK.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6040-tracking-info.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 3d6db4d..2397774 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -74,5 +74,19 @@ test_expect_success 'status' '
 	grep "have 1 and 1 different" actual
 '
 
+test_expect_success 'status when tracking lightweight tags' '
+	git checkout master &&
+	git tag light && 
+	git branch --track lighttrack light >actual &&
+	grep "set up to track" actual &&
+	git checkout lighttrack
+'
 
+test_expect_failure 'status when tracking annotated tags' '
+	git checkout master &&
+	git tag -m heavy heavy && 
+	git branch --track heavytrack heavy >actual &&
+	grep "set up to track" actual &&
+	git checkout heavytrack
+'
 test_done
-- 
1.6.3.195.gad816
