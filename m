From: Jeff King <peff@peff.net>
Subject: [PATCH 01/12] t/Makefile: stop setting GIT_CONFIG
Date: Thu, 20 Mar 2014 19:13:21 -0400
Message-ID: <20140320231321.GA8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:13:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQm9W-0005II-0o
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031AbaCTXNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:13:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:43556 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760025AbaCTXNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:13:23 -0400
Received: (qmail 27591 invoked by uid 102); 20 Mar 2014 23:13:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:13:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:13:21 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244602>

Once upon a time, the setting of GIT_CONFIG in the
environment could affect how tests ran. Commit 9c3796f (Fix
setting config variables with an alternative GIT_CONFIG,
2006-06-20) unconditionally set GIT_CONFIG in the Makefile
when running tests to give us a known starting point.

This is insufficient for running the tests outside of the
Makefile, however, and 8565d2d (Make tests independent of
global config files, 2007-02-15) later set GIT_CONFIG
directly in test-lib.sh. At that point the Makefile setting
was redundant, but we never removed it. Let's do so now.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 2373a04..8fd1a72 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -36,11 +36,11 @@ test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
 prove: pre-clean $(TEST_LINT)
-	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
-	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
-- 
1.9.0.560.g01ceb46
