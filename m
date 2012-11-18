From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] USE CGYWIN_V15_WIN32API as macro to select api for cygwin
Date: Sun, 18 Nov 2012 16:16:52 -0500
Message-ID: <1353273412-4164-1-git-send-email-mlevedahl@gmail.com>
References: <7va9ufjqu1.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 18 22:17:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaCFL-0008Q9-TR
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 22:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab2KRVR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 16:17:26 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55738 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2KRVRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 16:17:25 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4463956vbb.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 13:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=23cJ7wSYqGYR5KOrybGYPiM+bojhrmVkZY+nYSySROs=;
        b=W4X8EnVrvEA3qDDpwcKvs2AGgtj2FMTnjU7thxkYioaDJs6cK5SNJlAAXh3KNZa0Rx
         THfAXl0gAFSEy4++QR5WFjynvflS1Yg0A7esQpRSsJnWY+T61HIzC8Pb1xrQq+bc6AjL
         9FtLZNPVn0MKFZRkJP+pU/W/4+vksJR6nMNb8TsT/D0ItlneFogCmVR4HRFtvSG6iD1H
         7w3M6dpQtVWvzGdRHLm3GCR3/esiikj+od6n2TK/wXw4WdXFxM1WcM/KQ3Y/VdfpPJP+
         An+U4qIT+5bZIacr0w28Dqcy4i0z113stYufrJEGS+O/H2H+SMeY45xD3TpOlZvfWxZr
         ly9Q==
Received: by 10.52.19.20 with SMTP id a20mr4431044vde.26.1353273444741;
        Sun, 18 Nov 2012 13:17:24 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-107-139.washdc.fios.verizon.net. [173.79.107.139])
        by mx.google.com with ESMTPS id dp6sm4235304vec.11.2012.11.18.13.17.22
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 13:17:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0.0.0.14
In-Reply-To: <7va9ufjqu1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210037>

The previous macro was confusing to some, and did not include "cygwin" in
its name. The updated name more clearly expresses a choice of the
win32api implementation that shipped with version 1.5 of cygwin.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Makefile        | 6 +++---
 compat/cygwin.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index cf0ecde..9731c85 100644
--- a/Makefile
+++ b/Makefile
@@ -1091,7 +1091,7 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
-		V15_MINGW_HEADERS = YesPlease
+		CYGWIN_V15_WIN32API = YesPlease
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
@@ -1906,8 +1906,8 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
-ifdef V15_MINGW_HEADERS
-	COMPAT_CFLAGS += -DV15_MINGW_HEADERS
+ifdef CYGWIN_V15_WIN32API
+	COMPAT_CFLAGS += -DCYGWIN_V15_WIN32API
 endif
 
 ifdef USE_NED_ALLOCATOR
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 59d86e4..5428858 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,5 +1,5 @@
 #define WIN32_LEAN_AND_MEAN
-#ifdef V15_MINGW_HEADERS
+#ifdef CYGWIN_V15_WIN32API
 #include "../git-compat-util.h"
 #include "win32.h"
 #else
-- 
1.8.0.0.0.14
