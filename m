From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 17:51:29 +0400
Message-ID: <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:52:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Welyu-00049p-6z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbaD1Nvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:51:53 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56166 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaD1Nvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:50 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyE-0004qo-Mx; Mon, 28 Apr 2014 17:51:46 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247335>

To ease cross-compilation process, introduce a single variable
with the prefix to all compiler-related executables.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 Makefile         | 13 +++++++++----
 config.mak.uname |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 74a929b..24befc2 100644
--- a/Makefile
+++ b/Makefile
@@ -350,6 +350,10 @@ all::
 #
 # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
 # return NULL when it receives a bogus time_t.
+#
+# Define CROSS_COMPILE to specify the prefix used for all executables used
+# during compilation. Only gcc and related bin-utils executables
+# are prefixed with $(CROSS_COMPILE).
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -361,7 +365,6 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-STRIP ?= strip
 
 # Among the variables below, these:
 #   gitexecdir
@@ -401,8 +404,11 @@ htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
-CC = cc
-AR = ar
+AR = $(CROSS_COMPILE)ar
+CC = $(CROSS_COMPILE)cc
+GCOV = $(CROSS_COMPILE)gcov
+STRIP = $(CROSS_COMPILE)strip
+
 RM = rm -f
 DIFF = diff
 TAR = tar
@@ -415,7 +421,6 @@ XGETTEXT = xgettext
 MSGFMT = msgfmt
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
-GCOV = gcov
 
 export TCL_PATH TCLTK_PATH
 
diff --git a/config.mak.uname b/config.mak.uname
index 5d301da..6c2e6df 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -511,7 +511,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
-	RC = windres -O coff
+	RC = $(CROSS_COMPILE)windres -O coff
 	NATIVE_CRLF = YesPlease
 	X = .exe
 	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
-- 
1.9.1
