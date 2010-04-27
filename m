From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 10/16] host-HPUX10.patch
Date: Tue, 27 Apr 2010 13:57:18 +0000
Message-ID: <20100427135854.129844000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:59:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lJV-0002hJ-JO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab0D0N6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:55 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:51750 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab0D0N6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:54 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id F385B5CD9
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:01 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com F385B5CD9
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 45164ACB;
	Tue, 27 Apr 2010 13:58:54 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 3B57A11D4D1; Tue, 27 Apr 2010 13:58:54 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-HPUX10.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145908>

HP-UX 10.20 has no PREAD, and while it does support mmap(), there is
no system MAP_FAILED definition.
---
 Makefile          |    3 +++
 git-compat-util.h |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -971,6 +971,9 @@ ifeq ($(uname_S),HP-UX)
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
@@ -218,7 +218,6 @@ static inline const char *skip_prefix(co
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
-#define MAP_FAILED ((void*)-1)
 #endif
 
 #define mmap git_mmap
@@ -247,6 +246,10 @@ extern int git_munmap(void *start, size_
 
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
