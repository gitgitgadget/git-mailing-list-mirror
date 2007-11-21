From: Jeff King <peff@peff.net>
Subject: [PATCH] Revert "t5516: test update of local refs on push"
Date: Wed, 21 Nov 2007 02:19:34 -0500
Message-ID: <20071121071934.GA10112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:19:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujsI-00035L-VW
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbXKUHTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754211AbXKUHTi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:19:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3874 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbXKUHTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:19:37 -0500
Received: (qmail 4716 invoked by uid 111); 21 Nov 2007 07:19:36 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 02:19:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 02:19:34 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65607>

This reverts commit 09fba7a59d38d1cafaf33eadaf1d409c4113b30c.

These tests are superseded by the ones in t5404 (added in
6fa92bf3 and 8736a848), which are more extensive and better
organized.

Signed-off-by: Jeff King <peff@peff.net>
---
When Alex introduced t5404, I had the feeling I had written similar
tests before, but I failed to find them. I think starting t5404 was a
much more sensible organization, especially since these two tests don't
follow the style of the rest of t5516 very well.

 t/t5516-fetch-push.sh |   28 ----------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 86f9b53..4fbd5b1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -254,32 +254,4 @@ test_expect_success 'push with dry-run' '
 	check_push_result $old_commit heads/master
 '
 
-test_expect_success 'push updates local refs' '
-
-	rm -rf parent child &&
-	mkdir parent && cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one &&
-	cd .. &&
-	git clone parent child && cd child &&
-		echo two >foo && git commit -a -m two &&
-		git push &&
-	test $(git rev-parse master) = $(git rev-parse remotes/origin/master)
-
-'
-
-test_expect_success 'push does not update local refs on failure' '
-
-	rm -rf parent child &&
-	mkdir parent && cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one &&
-		echo exit 1 >.git/hooks/pre-receive &&
-		chmod +x .git/hooks/pre-receive &&
-	cd .. &&
-	git clone parent child && cd child &&
-		echo two >foo && git commit -a -m two || exit 1
-		git push && exit 1
-	test $(git rev-parse master) != $(git rev-parse remotes/origin/master)
-
-'
-
 test_done
-- 
1.5.3.6.1786.g2e199
