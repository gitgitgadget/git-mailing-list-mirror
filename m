From: Jeff King <peff@peff.net>
Subject: [PATCHv2 5/8] Makefile: do not replace @@GIT_VERSION@@ in shell
 scripts
Date: Tue, 19 Jun 2012 19:27:28 -0400
Message-ID: <20120619232728.GE6496@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7pe-0004qq-2x
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab2FSX1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:27:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33151
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089Ab2FSX1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:27:30 -0400
Received: (qmail 15851 invoked by uid 107); 19 Jun 2012 23:27:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:27:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:27:28 -0400
Content-Disposition: inline
In-Reply-To: <20120619232231.GA6328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200270>

No shell script actually uses the replacement (it is used in
some perl scripts, but cmd_munge_script only handles shell
scripts). We can also therefore drop the dependency on
GIT-VERSION-FILE.

Signed-off-by: Jeff King <peff@peff.net>
---
Probably not a big deal, since building scripts is relatively fast, but
it should make the output much shorter. :)

 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index c95a70c..c0bf3ad 100644
--- a/Makefile
+++ b/Makefile
@@ -2015,7 +2015,6 @@ $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
-    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
@@ -2061,7 +2060,6 @@ gitweb:
 git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
@@ -2110,7 +2108,6 @@ configure: configure.ac
 
 # These can record GIT_VERSION
 version.o git.spec \
-	$(patsubst %.sh,%,$(SCRIPT_SH)) \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
-- 
1.7.11.rc3.5.g201460b
