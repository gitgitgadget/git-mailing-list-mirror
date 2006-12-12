X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Move Fink and Ports check to after config file
Date: Tue, 12 Dec 2006 12:01:47 -0500
Message-ID: <AF891711-02C9-414F-98CC-BC53DD24EDB3@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 17:02:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34112>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuB1h-0002ez-Nv for gcvg-git@gmane.org; Tue, 12 Dec
 2006 18:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932243AbWLLRBx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 12:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWLLRBx
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 12:01:53 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:60373 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932243AbWLLRBw (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 12:01:52 -0500
Received: from [192.168.1.2] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 17F741FFCECA for <git@vger.kernel.org>; Tue, 12 Dec 2006 17:01:50 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Putting NO_FINK or NO_DARWIN_PORTS in config.mak is ignored because the
checks are done before the config is included.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
  Makefile |   27 +++++++++++++++------------
  1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index a1861de..c1f1135 100644
--- a/Makefile
+++ b/Makefile
@@ -326,18 +326,6 @@ ifeq ($(uname_S),Darwin)
  	NEEDS_SSL_WITH_CRYPTO = YesPlease
  	NEEDS_LIBICONV = YesPlease
  	NO_STRLCPY = YesPlease
-	ifndef NO_FINK
-		ifeq ($(shell test -d /sw/lib && echo y),y)
-			BASIC_CFLAGS += -I/sw/include
-			BASIC_LDFLAGS += -L/sw/lib
-		endif
-	endif
-	ifndef NO_DARWIN_PORTS
-		ifeq ($(shell test -d /opt/local/lib && echo y),y)
-			BASIC_CFLAGS += -I/opt/local/include
-			BASIC_LDFLAGS += -L/opt/local/lib
-		endif
-	endif
  endif
  ifeq ($(uname_S),SunOS)
  	NEEDS_SOCKET = YesPlease
@@ -415,6 +403,21 @@ endif
  -include config.mak.autogen
  -include config.mak

+ifeq ($(uname_S),Darwin)
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			ALL_CFLAGS += -I/sw/include
+			ALL_LDFLAGS += -L/sw/lib
+		endif
+	endif
+	ifndef NO_DARWIN_PORTS
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			ALL_CFLAGS += -I/opt/local/include
+			ALL_LDFLAGS += -L/opt/local/lib
+		endif
+	endif
+endif
+
  ifndef NO_CURL
  	ifdef CURLDIR
  		# This is still problematic -- gcc does not always want -R.
--
1.4.4.1.GIT

