From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t3503: test cherry picking and reverting root commits
Date: Thu, 12 May 2011 07:10:07 -0400
Message-ID: <20110512111007.GC5292@sigill.intra.peff.net>
References: <20110512110855.GA5240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 13:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKTmb-0006fS-8R
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 13:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab1ELLKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 07:10:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53680
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116Ab1ELLKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 07:10:09 -0400
Received: (qmail 12799 invoked by uid 107); 12 May 2011 11:12:07 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 07:12:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 07:10:07 -0400
Content-Disposition: inline
In-Reply-To: <20110512110855.GA5240@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173460>

We already tested cherry-picking a root commit, but only
with the internal merge-recursive strategy. Let's also test
the recently-allowed reverting of a root commit, as well as
testing with external strategies (which until recently
triggered a segfault).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3503-cherry-pick-root.sh |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index b0faa29..1f9ed67 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test cherry-picking a root commit'
+test_description='test cherry-picking (and reverting) a root commit'
 
 . ./test-lib.sh
 
@@ -27,4 +27,25 @@ test_expect_success 'cherry-pick a root commit' '
 
 '
 
+test_expect_success 'revert a root commit' '
+
+	git revert master &&
+	! test -f file1
+
+'
+
+test_expect_success 'cherry-pick a root commit with an external strategy' '
+
+	git cherry-pick --strategy=resolve master &&
+	test first = $(cat file1)
+
+'
+
+test_expect_success 'revert a root commit with an external strategy' '
+
+	git revert --strategy=resolve master &&
+	! test -f file1
+
+'
+
 test_done
-- 
1.7.5.1.12.ga7abed
