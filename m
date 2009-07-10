From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 2/5] git-compat-util.h: adjust for SGI IRIX 6.5
Date: Fri, 10 Jul 2009 12:10:44 -0500
Message-ID: <39niBtmtFs5Sy_fjtaztVioF-DSUgPaeb2z2kLxvo9ZK1x9ZQKe11vCjlSyOtjKf_tm_u4WsJQY@cipher.nrlssc.navy.mil>
References: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVmZBc5gMLjrIQhevVkHr5EAuPYiuRd5i__yABkFEZOZNG-W8HrgSclE@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJdc-0004l6-FC
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZGJRLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbZGJRLx
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:11:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57291 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbZGJRLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:11:53 -0400
Received: by mail.nrlssc.navy.mil id n6AHBqHf024189; Fri, 10 Jul 2009 12:11:52 -0500
In-Reply-To: <39niBtmtFs5Sy_fjtaztVmZBc5gMLjrIQhevVkHr5EAuPYiuRd5i__yABkFEZOZNG-W8HrgSclE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Jul 2009 17:11:52.0427 (UTC) FILETIME=[84D263B0:01CA0181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123067>

Don't define _XOPEN_SOURCE
Do    define _SGI_SOURCE

Defining _XOPEN_SOURCE prevents many of the common functions and macros
from being defined. _Not_ setting _XOPEN_SOURCE, and instead setting
_SGI_SOURCE, provides all of the XPG4, XPG5, BSD, POSIX functions and
declarations, _BUT_ provides a horribly broken snprintf(). SGI does have
a working snprintf(), but it is only provided when _NO_XOPEN5 evaluates
to zero, and this only happens if _XOPEN_SOURCE is defined which, as
mentioned above, prevents many other common functions and defines.
---
 git-compat-util.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9609eaa..913f41a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -52,7 +52,7 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
+#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #ifndef __sun__
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
@@ -62,6 +62,7 @@
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
 #define _NETBSD_SOURCE 1
+#define _SGI_SOURCE 1
 
 #include <unistd.h>
 #include <stdio.h>
-- 
1.6.4.rc0.5.g76f7cf
