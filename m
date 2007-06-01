From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH] catch asciidoc failures
Date: Thu, 31 May 2007 23:23:57 -0700
Message-ID: <11806790373908-git-send-email-slamb@slamb.org>
Cc: git@vger.kernel.org, Scott Lamb <slamb@slamb.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 08:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu0WD-0001ce-CQ
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 08:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbXFAGVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 02:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbXFAGVl
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 02:21:41 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:45032 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbXFAGVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 02:21:41 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id 9A7B898038;
	Thu, 31 May 2007 23:21:38 -0700 (PDT)
X-Spam-Score: -3.9
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.001-+--H*RT:rdns, 0.001-+--H*RT:intl
X-Spam-Status: No, score=-3.9 required=4.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
X-Spam-Spammy: 0.988-+--H*r:sk:hobbes., 0.980-+--procedure
Received: from localhost.localdomain (rosalyn.vpn.slamb.org [172.16.0.2])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Thu, 31 May 2007 23:21:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48844>

If pipefail is available (GNU bash >= 3.00), fail when asciidoc returns
error rather than possibly later during XSLT.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
This is my first git patch, so please let me know if I got the procedure
wrong.

 Documentation/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f92783..48c245c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -111,6 +111,7 @@ clean:
 
 %.html : %.txt
 	rm -f $@+ $@
+	set -o pipefail 2>/dev/null; \
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -o - $< | \
 		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
@@ -121,6 +122,7 @@ clean:
 
 %.xml : %.txt
 	rm -f $@+ $@
+	set -o pipefail 2>/dev/null; \
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -o - $< | \
 		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
-- 
1.5.2
