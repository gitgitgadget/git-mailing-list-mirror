From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 3/3] Hook up the result aggregation in the test makefile.
Date: Mon, 12 May 2008 11:33:52 +0200
Message-ID: <1210584832-16402-4-git-send-email-srabbelier@gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Cc: dsymonds@gmail.com, Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 12:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUq8-0004Gn-9l
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757822AbYELKAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757801AbYELKAN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:00:13 -0400
Received: from olive.qinip.net ([62.100.30.40]:51894 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757721AbYELKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:00:07 -0400
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id 0CB92FB6A;
	Mon, 12 May 2008 11:33:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81844>

This patch makes 'make' output the aggregated results at the end of each build.
The 'git-test-result' file is removed both before and after each build.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 72d7884..3955ee8 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -14,13 +14,20 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
-all: $(T) clean
+all: pre-clean $(T) aggregate-results clean
 
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+pre-clean:
+	$(RM) -f /tmp/git-test-results
+
 clean:
 	$(RM) -r trash
+	$(RM) -f /tmp/git-test-results
+
+aggregate-results:
+	./key_value_parser.py
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
-- 
1.5.5.1.178.g1f811
