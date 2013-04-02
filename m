From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] t3200: test --set-upstream-to with bogus refs
Date: Tue, 2 Apr 2013 15:02:53 -0400
Message-ID: <20130402190252.GA32316@sigill.intra.peff.net>
References: <20130402190134.GA17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6UQ-0005w6-6w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761533Ab3DBTC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:02:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52465 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760022Ab3DBTC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:02:57 -0400
Received: (qmail 12485 invoked by uid 107); 2 Apr 2013 19:04:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:04:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:02:53 -0400
Content-Disposition: inline
In-Reply-To: <20130402190134.GA17784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219829>

These tests pass with the current code, but let's make sure
we don't accidentally break the behavior in the future.

Note that our tests expect failure when we try to set the
upstream to or from a missing branch. Technically we are
just munging config here, so we do not need the refs to
exist. But seeing that they do exist is a good check that
the user has not made a typo.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3200-branch.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b08c9f2..09f65f8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -409,6 +409,18 @@ test_expect_success '--set-upstream-to fails on detached HEAD' '
 	git checkout -
 '
 
+test_expect_success '--set-upstream-to fails on a missing dst branch' '
+	test_must_fail git branch --set-upstream-to master does-not-exist
+'
+
+test_expect_success '--set-upstream-to fails on a missing src branch' '
+	test_must_fail git branch --set-upstream-to does-not-exist master
+'
+
+test_expect_success '--set-upstream-to fails on a non-ref' '
+	test_must_fail git branch --set-upstream-to HEAD^{}
+'
+
 test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.master.remote foo &&
 	test_config branch.master.merge foo &&
-- 
1.8.2.rc0.33.gd915649
