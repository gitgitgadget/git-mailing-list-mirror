From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 03/14] compat: add inet_pton and inet_ntop prototypes
Date: Fri, 15 Jan 2010 22:30:22 +0100
Message-ID: <1263591033-4992-4-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlL-0005cC-6W
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368Ab0AOVbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758365Ab0AOVbN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:13 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42825 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758362Ab0AOVbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:12 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so568991ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d2kSqDnhESzSLpD4CnpROfS1JRZZW2n37tZX3+5CInU=;
        b=ssO11ODwK4IM2vSkvM+0520S4fqn+/OkxGkhq0cGItrLbVMnraeldjFDlI0fMNCS+l
         3dD+pz0PL/IhL4CYEEX7rcSHMLRV1fVqHTvpa1TG11IQWaadBm7rCUjhFDJnsmI2FJ7H
         EYlFI7lNKI2Ik8KOLIp9sgbIdmW09zHskEwXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BKH8mgu3WRDEZNNKN0JPFwAN78CjOF4hji54B4gf0lF/abjqMM0EVyd9BPQDpvRm+W
         2raZptM/cs4AOZvxbZdZ+ituNy6YqaXLNRRMAQdRiATIOhDRivVTpAx72PrFrXX04pak
         JV6V9yJLaR/FWZypbENoRj74Xo1p3++EW/Lz4=
Received: by 10.213.38.147 with SMTP id b19mr1095870ebe.86.1263591067986;
        Fri, 15 Jan 2010 13:31:07 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 13sm1809205ewy.9.2010.01.15.13.31.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:07 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137124>

From: Mike Pape <dotzenlabs@gmail.com>

Windows doesn't have inet_pton and inet_ntop, so
add prototypes in git-compat-util.h for them.

At the same time include git-compat-util.h in
the sources for these functions, so they use the
network-wrappers from there on Windows.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile           |    2 ++
 compat/inet_ntop.c |    6 +++---
 compat/inet_pton.c |    8 +++++---
 git-compat-util.h  |    8 ++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index ebaa75c..d81b392 100644
--- a/Makefile
+++ b/Makefile
@@ -1289,9 +1289,11 @@ endif
 endif
 ifdef NO_INET_NTOP
 	LIB_OBJS += compat/inet_ntop.o
+	BASIC_CFLAGS += -DNO_INET_NTOP
 endif
 ifdef NO_INET_PTON
 	LIB_OBJS += compat/inet_pton.o
+	BASIC_CFLAGS += -DNO_INET_PTON
 endif
 
 ifdef NO_ICONV
diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index f444982..e5b46a0 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -17,9 +17,9 @@
 
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+
+#include "../git-compat-util.h"
+
 #include <stdio.h>
 #include <string.h>
 
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 4078fc0..2ec995e 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -17,9 +17,9 @@
 
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+
+#include "../git-compat-util.h"
+
 #include <stdio.h>
 #include <string.h>
 
@@ -41,7 +41,9 @@
  */
 
 static int inet_pton4(const char *src, unsigned char *dst);
+#ifndef NO_IPV6
 static int inet_pton6(const char *src, unsigned char *dst);
+#endif
 
 /* int
  * inet_pton4(src, dst)
diff --git a/git-compat-util.h b/git-compat-util.h
index 30e6240..937fb1b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -341,6 +341,14 @@ static inline char *gitstrchrnul(const char *s, int c)
 }
 #endif
 
+#ifdef NO_INET_PTON
+int inet_pton(int af, const char *src, void *dst);
+#endif
+
+#ifdef NO_INET_NTOP
+const char *inet_ntop(int af, const void *src, char *dst, size_t size);
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 extern char *xstrdup(const char *str);
-- 
1.6.6.211.g26720
