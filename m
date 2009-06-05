From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/8] On Solaris choose the OLD_ICONV iconv() declaration based on the UNIX spec
Date: Fri,  5 Jun 2009 18:36:12 -0500
Message-ID: <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCj19-0003L7-JE
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbZFEXjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbZFEXjp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:39:45 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42260 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbZFEXjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:39:41 -0400
Received: by mail.nrlssc.navy.mil id n55NaS11019262; Fri, 5 Jun 2009 18:36:28 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:28.0208 (UTC) FILETIME=[7299E300:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120848>

From: Brandon Casey <drafnel@gmail.com>

OLD_ICONV is only necessary on Solaris until UNIX03.  This is indicated
by the private macro _XPG6 which is set in /usr/include/sys/feature_tests.h.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |    3 ---
 utf8.c   |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 40642f7..375cf2a 100644
--- a/Makefile
+++ b/Makefile
@@ -714,9 +714,6 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
-	ifneq ($(uname_R),5.11)
-		OLD_ICONV = UnfortunatelyYes
-	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
diff --git a/utf8.c b/utf8.c
index ddfdc5e..db706ac 100644
--- a/utf8.c
+++ b/utf8.c
@@ -354,7 +354,7 @@ int is_encoding_utf8(const char *name)
  * with iconv.  If the conversion fails, returns NULL.
  */
 #ifndef NO_ICONV
-#ifdef OLD_ICONV
+#if defined(OLD_ICONV) || (defined(__sun__) && !defined(_XPG6))
 	typedef const char * iconv_ibp;
 #else
 	typedef char * iconv_ibp;
-- 
1.6.3.1.24.g152f4
