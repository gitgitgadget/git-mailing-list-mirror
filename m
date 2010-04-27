From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 07/16] diff-defaults.patch
Date: Tue, 27 Apr 2010 13:57:15 +0000
Message-ID: <20100427135838.572763000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:59:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lJT-0002hJ-N4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0D0N6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:40 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61057 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:39 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id C9FDA5CDB
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:19:46 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com C9FDA5CDB
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id C6EC4ACB;
	Tue, 27 Apr 2010 13:58:38 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id BBCDC11D4D1; Tue, 27 Apr 2010 13:58:38 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=diff-defaults.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145911>

By default the testsuite calls 'diff -u' whenever a file comparison is
called for.  Unfortunately that throws a "diff: unknown option '-u'"
error for most non-GNU diffs.

This patch sets GIT_TEST_CMP to 'cmp' on all the architectures where
that happens.  The previous version of this patch forgot to export
GIT_TEST_CMP from t/Makefile, which is why 'make test' continued to
fail most tests on most architectures - test-lib.sh was falling back
on its default of `diff -u' for GIT_TEST_CMP.  This version of this
patch shows a vast improvement in testsuite results where either GNU
diff is in the path at configure time, or where Makefile knows that
GIT_TEST_CMP=cmp is required.
---
 Makefile   |    5 +++++
 t/Makefile |    1 +
 2 files changed, 6 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -815,18 +815,21 @@ ifeq ($(uname_S),SunOS)
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
@@ -903,6 +906,7 @@ ifeq ($(uname_S),AIX)
 	else
 		PTHREAD_LIBS = -lpthread
 	endif
+	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
@@ -957,6 +961,7 @@ ifeq ($(uname_S),HP-UX)
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
