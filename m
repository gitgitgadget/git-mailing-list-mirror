From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 3/5] Makefile: add NEEDS_LIBGEN to optionally add -lgen to compile arguments
Date: Fri, 10 Jul 2009 12:10:45 -0500
Message-ID: <39niBtmtFs5Sy_fjtaztVs0m0Z6eHu_U8OSsTLFxj4rzNA1wRn0zCZA2fZ7PNTjvs9tczSQBvpc@cipher.nrlssc.navy.mil>
References: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVmZBc5gMLjrIQhevVkHr5EAuPYiuRd5i__yABkFEZOZNG-W8HrgSclE@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVioF-DSUgPaeb2z2kLxvo9ZK1x9ZQKe11vCjlSyOtjKf_tm_u4WsJQY@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJdx-0004x3-RN
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbZGJRL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754348AbZGJRL4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:11:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57308 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbZGJRLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:11:55 -0400
Received: by mail.nrlssc.navy.mil id n6AHBrbj024338; Fri, 10 Jul 2009 12:11:53 -0500
In-Reply-To: <39niBtmtFs5Sy_fjtaztVioF-DSUgPaeb2z2kLxvo9ZK1x9ZQKe11vCjlSyOtjKf_tm_u4WsJQY@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Jul 2009 17:11:53.0834 (UTC) FILETIME=[85A914A0:01CA0181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123070>

From: Brandon Casey <drafnel@gmail.com>

Commit 003b33a8 recently added a call to basename().  On IRIX 6.5, this
function resides in libgen and -lgen is required for the linker.

Update configure.ac too.
---


configure.ac changes are untested.

-brandon


 Makefile     |    5 +++++
 configure.ac |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 311ce7d..faaab5e 100644
--- a/Makefile
+++ b/Makefile
@@ -61,6 +61,8 @@ all::
 #
 # Define NO_LIBGEN_H if you don't have libgen.h.
 #
+# Define NEEDS_LIBGEN if your libgen needs -lgen when linking
+#
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
@@ -1019,6 +1021,9 @@ ifdef NEEDS_LIBICONV
 	endif
 	EXTLIBS += $(ICONV_LINK) -liconv
 endif
+ifdef NEEDS_LIBGEN
+	EXTLIBS += -lgen
+endif
 ifdef NEEDS_SOCKET
 	EXTLIBS += -lsocket
 endif
diff --git a/configure.ac b/configure.ac
index 1885674..74d0af5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -485,6 +485,12 @@ AC_CHECK_LIB([resolv], [hstrerror],
 AC_SUBST(NEEDS_RESOLV)
 test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 
+AC_CHECK_LIB([gen], [basename],
+[NEEDS_LIBGEN=],
+[NEEDS_LIBGEN=YesPlease])
+AC_SUBST(NEEDS_LIBGEN)
+test -n "$NEEDS_LIBGEN" && LIBS="$LIBS -lgen"
+
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
 #
-- 
1.6.4.rc0.5.g76f7cf
