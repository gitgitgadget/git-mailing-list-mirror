From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] 0003 This patch is to allow 12 different OS's to compile
 and run git.
Date: Fri, 6 Jun 2008 19:25:11 -0600
Message-ID: <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 03:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4nC4-0006bh-JO
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 03:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759527AbYFGBZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 21:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbYFGBZP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 21:25:15 -0400
Received: from zenez.com ([166.70.62.2]:28707 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763946AbYFGBZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 21:25:14 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id E0869E5269; Fri,  6 Jun 2008 19:25:12 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id A7F43E5268;
	Fri,  6 Jun 2008 19:25:12 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84163>

On Fri, 6 Jun 2008, Daniel Barkalow wrote:

> On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:
> 
> > From db0574a7f89bb90b6ce02cd44053f8cec2c454cc
> > 
> > This patch has patches to
> > 
> > Makefile
> > git-compat-util.h
> > progress.c
> > 
> > This patch allows some older OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4,
> > and OpenServer 6.0.X to build and run git.  Applied suggestions from list.
> > 
> >         Developer's Certificate of Origin 1.1
> > 
> >         By making a contribution to this project, I certify that:
> > 
> >         (a) The contribution was created in whole or in part by me and I
> >             have the right to submit it under the open source license
> >             indicated in the file; or
> > 
> >         (b) The contribution is based upon previous work that, to the best
> >             of my knowledge, is covered under an appropriate open source
> >             license and I have the right under that license to submit that
> >             work with modifications, whether created in whole or in part
> >             by me, under the same open source license (unless I am
> >             permitted to submit under a different license), as indicated
> >             in the file; or
> > 
> >         (c) The contribution was provided directly to me by some other
> >             person who certified (a), (b) or (c) and I have not modified
> >             it.
> > 
> >         (d) I understand and agree that this project and the contribution
> >             are public and that a record of the contribution (including all
> >             personal information I submit with it, including my sign-off) is
> >             maintained indefinitely and may be redistributed consistent with
> >             this project or the open source license(s) involved.
> > 
> > Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
> > 
> > --
> > Boyd Gerber <gerberb@zenez.com>
> > ZENEZ   1042 East Fort Union #135, Midvale Utah  84047

OK made changes you recommended.

diff --git a/Makefile b/Makefile
index cce5a6e..000bf1f 100644
--- a/Makefile
+++ b/Makefile
@@ -165,6 +165,11 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
+ifeq ($(uname_S),SCO_SV)
+	ifeq ($(uname_R),3.2)
+		CFLAGS = -O2
+	endif
+endif
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -564,6 +569,42 @@ endif
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
+	BASIC_CFLAGS +=  -Kalloca -Kthread
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	INSTALL = ginstall
+	TAR = gtar
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+endif
+ifeq ($(uname_S),SCO_SV)
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	ifeq ($(uname_R),5)
+		CC=cc
+		BASIC_CFLAGS +=  -Kalloca -Kthread
+	endif
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
index 01c4045..b3cd7b3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,7 +39,12 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if !defined(__APPLE__) && !defined(__FreeBSD__)
+/* Added for __USLC__ for any Novell devrived Compiler and Some Sys V 
+   Added _M_UNIX for any XENIX/SCO UNIX/OpenServer less than or equal
+   OpenServer 5.0.7  This is do avoided compiler hell like the other
+   OS's __APPLE__ and __FreeBSD__ */
+#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !de
+fined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
diff --git a/progress.c b/progress.c
index d19f80c..55a8687 100644
--- a/progress.c
+++ b/progress.c
@@ -241,16 +241,21 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char buf[strlen(msg) + 5];
+		char buf[128], *bufp;
+		size_t len = strlen(msg) + 5;
 		struct throughput *tp = progress->throughput;
+
+		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
 			throughput_string(tp, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		sprintf(buf, ", %s.\n", msg);
-		display(progress, progress->last_value, buf);
+		sprintf(bufp, ", %s.\n", msg);
+		display(progress, progress->last_value, bufp);
+		if (buf != bufp)
+			free(bufp);
 	}
 	clear_progress_signal();
 	free(progress->throughput);

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
