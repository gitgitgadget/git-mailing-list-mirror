From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 08/15] host-HPUX10.patch
Date: Tue, 16 Mar 2010 05:42:28 +0000
Message-ID: <20100316054337.190506000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjO-00038F-N9
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157Ab0CPFxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:46 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:60846 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab0CPFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 44DC45CD8
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:59 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 44DC45CD8
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 509A4DE8;
	Tue, 16 Mar 2010 05:43:37 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 4B39F11D4D5; Tue, 16 Mar 2010 05:43:37 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-HPUX10.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142311>

HP-UX 10.20 has no PREAD, and while it does support mmap(), there is
no system MAP_FAILED definition.
---
 Makefile          |    1 +
 git-compat-util.h |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -929,6 +929,9 @@ ifeq ($(uname_S),HP-UX)
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
+	ifeq ($(uname_R),B.10.20)
+		NO_PREAD = YesPlease
+	endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),Windows)
Index: b/git-compat-util.h
===================================================================
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -217,7 +217,6 @@ static inline const char *skip_prefix(co
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
-#define MAP_FAILED ((void*)-1)
 #endif
 
 #define mmap git_mmap
@@ -246,6 +245,10 @@ extern int git_munmap(void *start, size_
 
 #endif /* NO_MMAP */
 
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void*)-1)
+#endif
+
 #ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 #define on_disk_bytes(st) ((st).st_size)
 #else

-- 
Gary V. Vaughan (gary@thewrittenword.com)
