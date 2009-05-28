From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile arguments
Date: Wed, 27 May 2009 21:17:06 -0500
Message-ID: <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 04:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9VBS-0001BF-OW
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 04:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbZE1CRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 22:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbZE1CRW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 22:17:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48230 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbZE1CRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 22:17:21 -0400
Received: by mail.nrlssc.navy.mil id n4S2HMGD009392; Wed, 27 May 2009 21:17:22 -0500
In-Reply-To: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 28 May 2009 02:17:22.0095 (UTC) FILETIME=[6F0C63F0:01C9DF3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120135>

From: Brandon Casey <drafnel@gmail.com>

This library is required on Solaris since hstrerror resides in libresolv.
Additionally, on Solaris 7, inet_ntop and inet_pton reside there too.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ba78077..32b28ea 100644
--- a/Makefile
+++ b/Makefile
@@ -91,6 +91,10 @@ all::
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
@@ -697,10 +701,10 @@ endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
+	NEEDS_RESOLV = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
 	OLD_ICONV = UnfortunatelyYes
 	ifeq ($(uname_R),5.8)
@@ -956,6 +960,9 @@ endif
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
