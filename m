From: "Sverre Rabbelier" <sverre@rabbelier.nl>
Subject: [PATCH 3/3] Hook up the result aggregation in the test makefile.
Date: Sun,  8 Jun 2008 16:04:35 +0200
Message-ID: <1212933875-29947-3-git-send-email-sverre@rabbelier.nl>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5LwA-0004Rw-VD
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbYFHOaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbYFHOaq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:30:46 -0400
Received: from olive.qinip.net ([62.100.30.40]:58499 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbYFHOap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:30:45 -0400
X-Greylist: delayed 1591 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Jun 2008 10:30:45 EDT
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id 750DCFBF3;
	Sun,  8 Jun 2008 16:04:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.214.g82ce2.dirty
In-Reply-To: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84269>

From: Sverre Rabbelier <srabbelier@gmail.com>

This patch makes 'make' output the aggregated results at the end of each build.
The 'git-test-result' file is removed both before and after each build.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/Makefile |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index c6a60ab..f9ff933 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -14,18 +14,25 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
-all: $(T) clean
+all: pre-clean $(T) aggregate-results clean
 
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+pre-clean:
+	$(RM) -f test-results
+
 clean:
 	$(RM) -r 'trash directory'
+	$(RM) -f test-results
+
+aggregate-results:
+	./aggregate-results.sh
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
-.PHONY: $(T) clean
+.PHONY: pre-clean $(T) aggregate-results clean
 .NOTPARALLEL:
-- 
1.5.5.1.214.g82ce2.dirty
