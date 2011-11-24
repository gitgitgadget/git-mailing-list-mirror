From: Jeff King <peff@peff.net>
Subject: [PATCH 01/13] test-lib: add test_config_global variant
Date: Thu, 24 Nov 2011 05:58:51 -0500
Message-ID: <20111124105851.GA6195@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 11:59:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX19-0002uK-45
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 11:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1KXK6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 05:58:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49630
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab1KXK6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 05:58:54 -0500
Received: (qmail 10034 invoked by uid 107); 24 Nov 2011 10:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 05:59:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 05:58:51 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185896>

The point of test_config is to simultaneously set a config
variable and register its cleanup handler, like:

  test_config core.foo bar

However, it stupidly assumes that $1 contained the name of
the variable, which means it won't work for:

  test_config --global core.foo bar

We could try to parse the command-line ourselves and figure
out which parts need to be fed to test_unconfig. But since
this is likely the most common variant, it's much simpler
and less error-prone to simply add a new function.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..160479b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -379,6 +379,11 @@ test_config () {
 	git config "$@"
 }
 
+test_config_global () {
+	test_when_finished "test_unconfig --global '$1'" &&
+	git config --global "$@"
+}
+
 # Use test_set_prereq to tell that a particular prerequisite is available.
 # The prerequisite can later be checked for in two ways:
 #
-- 
1.7.7.4.5.gb32a5
