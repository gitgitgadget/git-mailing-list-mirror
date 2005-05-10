From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Mon, 9 May 2005 19:11:05 -0700 (PDT)
Message-ID: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 10 04:04:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVK6I-000560-Q1
	for gcvg-git@gmane.org; Tue, 10 May 2005 04:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVEJCLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 22:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVEJCLL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 22:11:11 -0400
Received: from web41213.mail.yahoo.com ([66.218.93.46]:64110 "HELO
	web41213.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261436AbVEJCLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 22:11:06 -0400
Received: (qmail 53986 invoked by uid 60001); 10 May 2005 02:11:05 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=p3CXKvB1j8IbKMYJv0J1bkXXldG1AWyGg+DWyNZk0Pqzpt4BfqpOWDTp0jOnGMS2YzjK8YSPNVuzYUK0ogTlbBgjqk7uyC1K8SoD/9d1HAtrZasfek/G3Fx2+BJJtJDDAU8vSuHwIueVRolizAi8+HDWWDNZXKDVLz8gDI0UgqY=  ;
Received: from [66.41.38.150] by web41213.mail.yahoo.com via HTTP; Mon, 09 May 2005 19:11:05 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Darwin puts all of the openssl functionality into libcrypto not libssl. Also, gcc
complains about the st.size return value in local-pull.c if it's not cast explicitly as a
long.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>

Index: Makefile
===================================================================
--- 972d8624458936868e6f392b40858b7c362af8cd/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -80,7 +80,11 @@
        LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 else
        SHA1_HEADER=<openssl/sha.h>
-       LIBS += -lssl
+       ifdef DARWIN
+               LIBS += -lcrypto
+       else
+               LIBS += -lssl
+       endif
 endif
 endif
 
Index: local-pull.c
===================================================================
--- 972d8624458936868e6f392b40858b7c362af8cd/local-pull.c  (mode:100644)
+++ uncommitted/local-pull.c  (mode:100644)
@@ -71,7 +71,7 @@
                close(ofd);
                if (status)
                        fprintf(stderr, "cannot write %s (%ld bytes)\n",
-                               dest_filename, st.st_size);
+                               dest_filename, (long) st.st_size);
                else
                        pull_say("copy %s\n", hex);
                return status;
