From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 04/11] compat: add inet_pton and inet_ntop prototypes
Date: Thu, 26 Nov 2009 00:44:13 +0000
Message-ID: <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTN-00014J-5d
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbZKZAo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759945AbZKZAo1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:27 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46652 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759903AbZKZAo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:26 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so298499ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oQ6P9Of9YaasR1N0m5D0Bami39TmoSjcS/ppTj7zkGg=;
        b=SwoQeUPRkw/fFwQMAIMzEGNvQRErlaKXp2YsO2HJWXlTDwzSGc/uF1Nqb58vV5YfTB
         GuDY+wh1D4ICgR82o83X0TFb+ibEH/xQY8EvUTccuZ2NKwGnDZEqUIxfiUWeGa9Z8Gum
         SpGg8Rp/dXSgnx9+lnHZMjIXwmHziwjKauFRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fvwfkhfRusQLzr9R/HPKYP+xVru+cIZ5nKlWVzMI/feMMVkM8tvUR5jmZ0rtBzTUx7
         zJkZB+wQQZh7hdpMHqdHYGEtlgSiFSfYcjRgwMPnY6qCzPxz/i52QsPRc3BJP6xMAzk/
         tbf5ROE/Nfz4eg2tCFj9uyvOwx7Ra/0L3g0Qo=
Received: by 10.213.0.195 with SMTP id 3mr2065899ebc.81.1259196273107;
        Wed, 25 Nov 2009 16:44:33 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 24sm392465eyx.14.2009.11.25.16.44.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:32 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133734>

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
index 70cee6d..3b01694 100644
--- a/Makefile
+++ b/Makefile
@@ -1227,9 +1227,11 @@ endif
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
index 33a8e33..27fa601 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -340,6 +340,14 @@ static inline char *gitstrchrnul(const char *s, int c)
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
1.6.5.rc2.7.g4f8d3
