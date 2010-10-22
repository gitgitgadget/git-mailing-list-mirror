From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 02/15] compat: add inet_pton and inet_ntop prototypes
Date: Fri, 22 Oct 2010 02:05:31 +0200
Message-ID: <1287705944-5668-2-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com, Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P959a-0004NN-0o
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab0JVAGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:06:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56736 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314Ab0JVAGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:06:31 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so355721ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JsLYgsnoWOBRlX2ZTsnMQ/YqcCq02KuL3OEcPlL/lV0=;
        b=fbNTmEiJkLqx3vHI/5Rua7O0h+VGTzJJoLbZnklEXGVKXGl9/ZVDl0a/d7AAg0n4gx
         uHFoVtEmMP0t8ykbAmjZ5hUcsZYfpAwRbRmxN9qhX0h/RLoiAyl/lZOhBF+eF0AVHn7x
         0K62jnXfOfFec1jFdHyQ0RLipLTTR4/y7quWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aHwYXMtCEzdckCiOYXD7wJ5IjfFe0DtB7vNVqzmBL9Y68QC5yWczxe/7ww05ggoo3U
         Z4+crvzXw9/6iYkg5TbDCwZ2VoHcQ6RkweYNUDKq+SvZuuC20fooRoJASEH4EqxCWgKA
         beawVC03v5uK18mOuU+woqkJNsNjce/i9AbME=
Received: by 10.213.27.132 with SMTP id i4mr2517016ebc.43.1287705990663;
        Thu, 21 Oct 2010 17:06:30 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q51sm2464236eeh.22.2010.10.21.17.06.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159593>

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
index d9d9419..2aa067a 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,9 +1398,11 @@ endif
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
index e192831..56dce85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -387,6 +387,14 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
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
 
 typedef void (*try_to_free_t)(size_t);
-- 
1.7.3.1.199.g72340
