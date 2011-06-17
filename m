From: Jeff King <peff@peff.net>
Subject: [PATCH] t/Makefile: pass test opts to valgrind target properly
Date: Fri, 17 Jun 2011 04:29:57 -0400
Message-ID: <20110617082956.GA20414@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 17 10:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXURV-00008W-6q
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 10:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153Ab1FQIaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 04:30:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52324
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499Ab1FQIaB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 04:30:01 -0400
Received: (qmail 23787 invoked by uid 107); 17 Jun 2011 08:30:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jun 2011 04:30:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2011 04:29:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175943>

The valgrind target just reinvokes make with GIT_TEST_OPTS
set to "--valgrind". However, it does this using an
environment variable, which means GIT_TEST_OPTS in your
config.mak would override it, and "make valgrind" would
simply run the test suite without valgrind on.

Instead, we should pass GIT_TEST_OPTS on the command-line,
overriding what's in config.mak, and take care to append to
whatever the user has there already.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm attempting to run the whole test suite under valgrind for 1.7.6-rc2.
It's been a while since I've done a whole run, as there were some false
positives in strspn on recent glibc which I've finally addressed.

We'll see what it comes up with later today. :)

 t/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 47cbeb6..9046ec9 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -71,7 +71,7 @@ gitweb-test:
 	$(MAKE) $(TGITWEB)
 
 valgrind:
-	GIT_TEST_OPTS=--valgrind $(MAKE)
+	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
 
 # Smoke testing targets
 -include ../GIT-VERSION-FILE
-- 
1.7.6.rc1.38.g97f64
