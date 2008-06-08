From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 11:07:11 -0600
Message-ID: <Pine.LNX.4.64.0806081100310.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
 <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com> <7vzlpyouwf.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0806062015440.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062316270.19665@iabervon.org>
 <Pine.LNX.4.64.0806072143230.18454@xenau.zenez.com> <7vy75gl68y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 19:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ONm-0004Ve-97
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 19:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYFHRHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 13:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbYFHRHO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 13:07:14 -0400
Received: from zenez.com ([166.70.62.2]:12131 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbYFHRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 13:07:13 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 5BC1DE5E41; Sun,  8 Jun 2008 11:07:12 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 4DC0CE5E40;
	Sun,  8 Jun 2008 11:07:12 -0600 (MDT)
In-Reply-To: <7vy75gl68y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84295>


This patch adds support to compile git on 12 additional platforms.
The platforms are based on UNIX Systems Labs (USL)/Novell/SYS V code base.

This patch also adds support for Novell UnixWare 2.x.x, UnixWare 7.1.4 and 
older, OpenServer 5.0.7 and older OpenServer 6.0.X, and 
SCO pre OSR 5 platforms to build and run git.


This is with suggestions and modifications from

Daniel Barkalow <barkalow@iabervon.org>
Junio C Hamano <gitster@pobox.com>
Thomas Harning <harningt@gmail.com>
Jeremy Maitin-Shepard <jbms@cmu.edu>

Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

---
        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

---
Makefile

Add changes for System V, UnixWare, SCO OS's

---
git-compat-util.h

__USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
compiler and/or some SysV based OS's.

__M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
of the SCO OS's.  It is used just like Apple and BSD, both of these
shouldn't have _XOPEN_SOURCE defined.

diff --git a/Makefile b/Makefile
index cce5a6e..026de2f 100644
--- a/Makefile
+++ b/Makefile
@@ -564,6 +564,45 @@ endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 endif
+ifeq ($(uname_S),UnixWare)
+	CC=cc
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/local/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	BASIC_CFLAGS += -Kthread
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	INSTALL = ginstall
+	TAR = gtar
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+endif
+ifeq ($(uname_S),SCO_SV)
+	ifeq ($(uname_R),3.2)
+		CFLAGS = -O2
+	endif
+	ifeq ($(uname_R),5)
+		CC=cc
+		BASIC_CFLAGS += -Kthread
+	endif
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+	INSTALL = ginstall
+	TAR = gtar
+endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 01c4045..c04e8ba 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,7 +39,7 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if !defined(__APPLE__) && !defined(__FreeBSD__)
+#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
1.5.2.4


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
