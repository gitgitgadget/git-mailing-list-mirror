From: Jeff King <peff@peff.net>
Subject: [PATCHv2 01/13] test-lib: add test_config_global variant
Date: Tue, 6 Dec 2011 01:22:28 -0500
Message-ID: <20111206062228.GA29233@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoQH-0004Yy-L1
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab1LFGWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:22:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40040
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908Ab1LFGWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:22:30 -0500
Received: (qmail 1086 invoked by uid 107); 6 Dec 2011 06:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:29:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:22:28 -0500
Content-Disposition: inline
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186321>

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
1.7.8.rc4.4.g884ec
