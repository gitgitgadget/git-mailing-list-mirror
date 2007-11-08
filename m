From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH] Make it easier to run individual tests
Date: Thu,  8 Nov 2007 03:31:12 -0800
Message-ID: <1194521472-13172-1-git-send-email-ddkilzer@kilzer.net>
Cc: gitster@pobox.com, David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 12:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq5be-0003tD-GP
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 12:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509AbXKHLbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 06:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbXKHLbP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 06:31:15 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:51642 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbXKHLbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 06:31:14 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id BD40F1870AB9;
	Thu,  8 Nov 2007 03:31:13 -0800 (PST)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id A2B0E28050;
	Thu,  8 Nov 2007 03:31:13 -0800 (PST)
X-AuditID: 11807134-a5403bb000003395-07-4732f3814c75
Received: from localhost.localdomain (unknown [17.151.78.62])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 268F42804C;
	Thu,  8 Nov 2007 03:31:13 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63997>

The following commands now work from the top-level source directory:
$ make t/t0001-init.sh
$ T=t0001-init.sh make test

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---
For the maint branch.

I'm so lazy I wanted a way to run tests from the primary Makefile.

 Makefile   |    3 +++
 t/Makefile |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e70e320..eb0f7da 100644
--- a/Makefile
+++ b/Makefile
@@ -961,6 +961,9 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
+t/t%.sh: all
+	T=`basename $@` $(MAKE) -C t/ all
+
 test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
diff --git a/t/Makefile b/t/Makefile
index 72d7884..ae25561 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -11,7 +11,7 @@ RM ?= rm -f
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
-T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
+T ?= $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
 all: $(T) clean
-- 
1.5.3.4
