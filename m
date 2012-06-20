From: Jeff King <peff@peff.net>
Subject: [PATCHv3 08/11] Makefile: do not replace @@GIT_VERSION@@ in shell
 scripts
Date: Wed, 20 Jun 2012 14:32:10 -0400
Message-ID: <20120620183209.GH30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:32:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPht-0008Kk-RI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397Ab2FTScP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:32:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39028
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386Ab2FTScN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:32:13 -0400
Received: (qmail 26979 invoked by uid 107); 20 Jun 2012 18:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:32:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:32:10 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200327>

No shell script actually uses the replacement (it is used in
some perl scripts, but cmd_munge_script only handles shell
scripts). We can also therefore drop the dependency on
GIT-VERSION-FILE.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 957b6a6..b977903 100644
--- a/Makefile
+++ b/Makefile
@@ -2016,7 +2016,6 @@ $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
-    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
@@ -2062,7 +2061,6 @@ gitweb:
 git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
@@ -2111,7 +2109,6 @@ configure: configure.ac
 
 # These can record GIT_VERSION
 version.o git.spec \
-	$(patsubst %.sh,%,$(SCRIPT_SH)) \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
-- 
1.7.11.5.gc0eeaa8
