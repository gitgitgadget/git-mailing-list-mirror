From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/5] MinGW: enable pthreads
Date: Thu,  7 Jan 2010 22:54:58 +0100
Message-ID: <0a6875ce0cbbd9452b5338cf2c3de4af826f2da6.1262895937.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0Lb-000271-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0AGV4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205Ab0AGV4m
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:56:42 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50898 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754203Ab0AGV4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:56:40 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A74302C400D;
	Thu,  7 Jan 2010 22:56:39 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3AEC719F610;
	Thu,  7 Jan 2010 22:55:52 +0100 (CET)
X-Mailer: git-send-email 1.6.6.115.gd1ab3
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136391>

If the MinGW build was built as part of the msysgit build environment,
then threading was already enabled because the pthreads-win32 package
is available in msysgit.

The previous patch added a minimal pthreads implementation for Windows.
Therefore, we can now enable code that uses pthreads unconditionally.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ed547d9..087c3fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1019,9 +1019,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	BLK_SHA1 = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
+		compat/win32/pthread.o
 	EXTLIBS += -lws2_32
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
@@ -1031,10 +1033,8 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	EXTLIBS += /mingw/lib/libz.a
 	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 else
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
 endif
 endif
 
-- 
1.6.6.115.gd1ab3
