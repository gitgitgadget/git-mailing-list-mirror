From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] unexpected Make output (e.g. from --debug) causes build failure
Date: Tue, 25 Sep 2007 08:42:16 +0200
Message-ID: <877imftfef.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 08:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia47p-0001Sp-2i
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbXIYGmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXIYGmS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:42:18 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42432 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbXIYGmR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 02:42:17 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8EB7669903
	for <git@vger.kernel.org>; Tue, 25 Sep 2007 08:42:16 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7E625672D7
	for <git@vger.kernel.org>; Tue, 25 Sep 2007 08:42:16 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 684035044A; Tue, 25 Sep 2007 08:42:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59098>

Without this, the extra output produced e.g., by "make --debug"
would go into $INSTLIBDIR and then cause the sed command to fail.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 0055eef..97ce687 100644
--- a/Makefile
+++ b/Makefile
@@ -805,7 +805,7 @@ perl/perl.mak: GIT-CFLAGS

 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
--
1.5.3.2.99.ge4b2-dirty
