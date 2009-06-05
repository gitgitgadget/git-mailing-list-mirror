From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/8] Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile arguments
Date: Fri,  5 Jun 2009 18:36:10 -0500
Message-ID: <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCixq-0002dR-09
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbZFEXgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbZFEXga
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:36:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51654 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZFEXga (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:36:30 -0400
Received: by mail.nrlssc.navy.mil id n55NaRhc019246; Fri, 5 Jun 2009 18:36:27 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:27.0849 (UTC) FILETIME=[72631B90:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120841>

From: Brandon Casey <drafnel@gmail.com>

This library is required on Solaris when compiling with NO_IPV6 since
hstrerror resides in libresolv.  Additionally, Solaris 7 will need it,
since inet_ntop and inet_pton reside there too.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index baa05f5..40642f7 100644
--- a/Makefile
+++ b/Makefile
@@ -95,6 +95,10 @@ all::
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 #
+# Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
+# Notably on Solaris hstrerror resides in libresolv and on Solaris 7
+# inet_ntop and inet_pton additionally reside there.
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
@@ -708,7 +712,6 @@ ifeq ($(uname_S),SunOS)
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	ifneq ($(uname_R),5.11)
@@ -726,6 +729,9 @@ ifeq ($(uname_S),SunOS)
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
+	ifdef NO_IPV6
+		NEEDS_RESOLV = YesPlease
+	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__
@@ -981,6 +987,9 @@ endif
 ifdef NEEDS_NSL
 	EXTLIBS += -lnsl
 endif
+ifdef NEEDS_RESOLV
+	EXTLIBS += -lresolv
+endif
 ifdef NO_D_TYPE_IN_DIRENT
 	BASIC_CFLAGS += -DNO_D_TYPE_IN_DIRENT
 endif
-- 
1.6.3.1.24.g152f4
