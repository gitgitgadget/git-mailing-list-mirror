From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH] Windows: Remove dependency on pthreadGC2.dll
Date: Sun, 24 Jan 2010 10:10:30 +0000
Message-ID: <1264327830-4204-1-git-send-email-michael.lukashov@gmail.com>
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 11:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYzQd-0001WI-AA
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 11:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab0AXKKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 05:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177Ab0AXKKm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 05:10:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50491 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab0AXKKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 05:10:41 -0500
Received: by bwz27 with SMTP id 27so1999115bwz.21
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 02:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1Gt1q18qHJGr3+pubVHyue8sOrV7NzWsQ4vt61k/4x4=;
        b=R89plZTBirZ+4yw7QaQBKA9BdcPQEslNyTdvXfFpidioEVBfzPZoEB6Uo2B7Om879s
         FQi9hcwKX53SLlhmkct6n5TDIQaTKg9o+Om7fYnUiKuUwipTYVCO2zIZTYe4Wzvf9Pe/
         r7KZvfgX7R8BwIM16AziFpJ+Y/8kUJOESK9PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hDM/QOOKQIHEAByZmHvbJUnUhLh3FhXyvwUpLqZeftQHImxQNcXj3GlIhGJ/T8d6jd
         0rXIBewJm/TV8PtRDpK5gBoVXJo3nB7My5+vf7A3jL9IVuMKqff78kML9gJIoYe3jQFT
         UhGhinznndRqSlM3NoMwzwVXbjBQ1mzlZ07w8=
Received: by 10.204.36.197 with SMTP id u5mr2954003bkd.119.1264327839758;
        Sun, 24 Jan 2010 02:10:39 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 14sm1720549bwz.9.2010.01.24.02.10.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 02:10:39 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1599.gaed1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137888>

Commit 44626dc7 (MSVC: Windows-native implementation for subset
of threads API, 2010-01-15) introduces builtin replacement of
pthreadGC2.dll functionality, thus we can completely drop
dependency on this dll.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c0dbee2..af08c8f 100644
--- a/Makefile
+++ b/Makefile
@@ -994,6 +994,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	PTHREAD_LIBS =
 	lib =
 ifndef DEBUG
 	BASIC_CFLAGS += -GL -Os -MT
@@ -1036,11 +1037,12 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
 		compat/win32/pthread.o
 	EXTLIBS += -lws2_32
+	PTHREAD_LIBS =
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	htmldir=doc/git/html/
-- 
1.6.6.1599.gaed1a
