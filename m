From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 2/4 v2] Integrate remote-svn into svn-fe/Makefile.
Date: Fri, 29 Jun 2012 09:58:56 +0200
Message-ID: <2647822.XIsT94IYqY@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1374057.qfvOg1c6C6@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 10:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkW8q-0002qL-F0
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 10:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab2F2IBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 04:01:13 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50678 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab2F2IBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 04:01:09 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so2723356bkc.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=OLZr5LMsRptDKwCS+rWGd1BavL5DXl5ukwwuMl94bgs=;
        b=PuwLO3MfdBeGYUYeaIqJn26irqUIgflKfMqnS4O47xrTHxlcIWIFzOhrAH/5WvmzHu
         DP9yrkjXA3vdPayQpw9eGSVkTL1q97kZaQR/0OxiW+ZesjIRGjty8ctrZmA05kHFW6FP
         cZTQDsGYQ+8Ee0toq39ui4J9jp45ee+30/SyA5F7jAPILLhjxKSd+pqela7r/hYEdZht
         X1cG5fYDxF2fATSHAbgvH/u/RVPFwr9004+9WUuVndKQOEzSByRoFKdE/U4bSD1mPIiZ
         adzgLYH1p/pOcp3LGqkBje5/G/7bBhoy5oKc9h5XmDwBfBeRwnfppUlnc5nFuWa5P4AK
         oKNQ==
Received: by 10.204.151.211 with SMTP id d19mr212812bkw.63.1340956868972;
        Fri, 29 Jun 2012 01:01:08 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id gw6sm1818927bkc.16.2012.06.29.01.01.07
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jun 2012 01:01:08 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-26-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1374057.qfvOg1c6C6@flobuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200807>

Requires some sha.h to be used and the libraries
to be linked, this is currently hardcoded.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
diff: add  -Wdeclaration-after-statement to CFLAGS

 contrib/svn-fe/Makefile |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..49b91e6 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -1,14 +1,14 @@
-all:: svn-fe$X
+all:: svn-fe$X remote-svn$X
 
 CC = gcc
 RM = rm -f
 MV = mv
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' -Wdeclaration-after-statement
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS =
+EXTLIBS = -lssl -lcrypto -lpthread ../../xdiff/lib.a
 
 GIT_LIB = ../../libgit.a
 VCSSVN_LIB = ../../vcs-svn/lib.a
@@ -37,8 +37,12 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
 
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+remote-svn$X: remote-svn.o $(VCSSVN_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ remote-svn.o \
+		$(ALL_LDFLAGS) $(LIBS)
+		
+%.o: %.c ../../vcs-svn/svndump.h
+	$(QUIET_CC)$(CC) -I../../vcs-svn -I../../ -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
-- 
1.7.9.5
