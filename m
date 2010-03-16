From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 06/15] diff-defaults.patch
Date: Tue, 16 Mar 2010 05:42:26 +0000
Message-ID: <20100316054326.850936000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjK-00038F-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981Ab0CPFxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:23 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:60846 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757345Ab0CPFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:58 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id F274D5CD6
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:48 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com F274D5CD6
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 00C38DE9;
	Tue, 16 Mar 2010 05:43:26 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id EC85C11D4D5; Tue, 16 Mar 2010 05:43:26 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=diff-defaults.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142315>

By default the testsuite calls 'diff -u' whenever a file comparison is
called for.  Unfortunately that throws a "diff: unknown option '-u'"
error for most non-GNU diffs.

This patch sets GIT_TEST_CMP to 'cmp' on all the architectures where
that happens.  As a matter of fact, the testsuite as a whole still
fails around 70% of all tests, but I'm able to clone a repository and
commit to a local branch on those machines, so I'm pretty sure that
the problem is the testsuite itself.
---
 Makefile |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -767,6 +767,16 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
+	ifeq ($(uname_R),5.6)
+		NO_IPV6 = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
+		GIT_TEST_CMP = cmp
+	endif
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
@@ -776,18 +786,21 @@ ifeq ($(uname_S),SunOS)
 		NO_STRLCPY = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
+		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
+		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
+		GIT_TEST_CMP = cmp
 	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
@@ -861,6 +874,7 @@ ifeq ($(uname_S),AIX)
 	else
 		PTHREAD_LIBS = -lpthread
 	endif
+	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
@@ -915,6 +929,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
+	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
Index: b/t/Makefile
===================================================================
--- a/t/Makefile
+++ b/t/Makefile
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+-include ../config.mak.autogen
 -include ../config.mak
 
 #GIT_TEST_OPTS=--verbose --debug

-- 
Gary V. Vaughan (gary@thewrittenword.com)
