From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH v2 7/7] Add 'make test-text' core.autocrlf=true
Date: Wed, 13 May 2009 15:35:48 -0400
Message-ID: <1242243348-6690-8-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-3-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-5-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-6-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-7-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 21:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KFg-0005kd-9O
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbZEMTgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbZEMTgW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:36:22 -0400
Received: from krl.krl.com ([192.147.32.3]:59310 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833AbZEMTgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:36:11 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4DJaA4b006817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 15:36:10 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4DJaA4Q006816;
	Wed, 13 May 2009 15:36:10 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242243348-6690-7-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119096>

This will test with core.autocrlf=true by default and
test using a text mount in CYGWIN

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 Makefile |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6e21643..2d85972 100644
--- a/Makefile
+++ b/Makefile
@@ -1482,6 +1482,17 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
+test-text: all
+	@echo Test core.autocrlf=true
+ifeq ($(uname_O),Cygwin)
+	@echo Test text mode mount
+	mount -f -u -t $(shell sh -c 'cygpath -m -a t') $(shell sh -c 'cygpath -u -a t')
+	GIT_TEST_AUTO_CRLF=$${GIT_TEST_AUTO_CRLF:-true} $(MAKE) -C t/ all
+	umount -u $(shell sh -c 'cygpath -u -a t')
+else
+	GIT_TEST_AUTO_CRLF=$${GIT_TEST_AUTO_CRLF:-true} $(MAKE) -C t/ all
+endif
+
 test-ctype$X: ctype.o
 
 test-date$X: date.o ctype.o
-- 
1.6.3.15.g49878
