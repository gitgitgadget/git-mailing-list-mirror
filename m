From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/4] mingw: avoid warnings when casting HANDLEs to int
Date: Fri, 15 Jan 2016 14:24:34 +0100 (CET)
Message-ID: <61a69db5495c2ea16f98fab58e160dc575f73179.1452864241.git.johannes.schindelin@gmx.de>
References: <cover.1452864241.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:24:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK4Mw-0003ar-MG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 14:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbcAONYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 08:24:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:61452 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161062AbcAONYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 08:24:40 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfTC1-1ZnAKY2Ell-00p3N9; Fri, 15 Jan 2016 14:24:35
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452864241.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TskMWBgdhRl1lm0kFo2FGOrpT5MlK0mTwypVsd8OEVYn0LTm+0x
 ZQTijZgNW5c9m76tEzgMhYX8V6RQjwQtGt/JZo74ztkmmapzRCUyALnfSjTVM9Y+lBea/Nw
 PZZLRQx9axn4jf+4uTjd5AKobQVAGb79LM1gp/5vp6EJuqiYJb4gxAY9fIG3vRqGv3/UIIt
 Q93xERCq2PBlGoVXflERQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QacZ2gjuAxs=:71kSDqQFg41pbSMlRp3qJ4
 WJLZK7ba54DpZKpw9gF4AvkBK5Wn4D4p9uNXY41bLROCJY/NFoN/UETg8TAk2toRwmTJ52Oq/
 r5I0m+hl7kr/RZP/0aAZa29m8bJK3Da/uCCSF5LJp5P2b4L76AklNL/aThnw74uEk+th1PQiI
 TgDlwYwMgL2GkAvroruGuzkL1lq6JOvtrDQIkseBSL+rSBBuHKRsE2FIU6msPcxB7UlYOyEF0
 TcxgKlCSltukEGRdfUo3Danzqt/z+3ozh7aoZaGiDoKFFJE8nnl9JvIsegbkeeOtADGlgK4Oy
 oP02mHeo8c8euXgj64THk+v+TjHiDcdI5AEijsiUp43/UgWtXZIVOXMjaOXk+V+aQFVmmbLnL
 eVUTHnMshhXbLy+h1e+95BF585WPhnXS3imj7ePnQ2EVP29+IcYzq0WAk7Ur3PoMKKFgEZruu
 AXk9BUXCtzIBww71mnxvfBchsLaL4eDCXJfjqm/HBLtTXvT5yIACekokLlTWZFLj7Qls4X2aA
 RLWgM+NrE8TS/BWpcxI+GcgWpN09AfAE+fOoNoZPFCOGGGLOqwDS+Fi4O3Wb5gl3kV6x/mUAP
 EGAx8sPxKKp4VcTEOg70FxYgniS4MDPBiVBOZNMwRRMNhvGD5SJbq53xzwmG0iwwnqkUFz1KM
 ufCjiMAwlhS2XKLWbchMDlPDpNvAhBoaS+1TzNA5j84ZtpOUcLz00bu0mmWBtq7pnrYrzcuG3
 y2hJizdrM1mcc8bcsaC5qM7Y0qH0ZNuN2nI2b6EVSyZveoDEfiboIWz9hs0rDCO6GK7PNSVu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284165>

HANDLE is defined internally as a void *, but in many cases it is
actually guaranteed to be a 32-bit integer. In these cases, GCC should
not warn about a cast of a pointer to an integer of a different type
because we know exactly what we are doing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c     | 9 ++++++---
 compat/poll/poll.c | 2 +-
 compat/winansi.c   | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1b3530a..8437c9a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -6,6 +6,8 @@
 #include "../run-command.h"
 #include "../cache.h"
 
+#define HCAST(type, handle) ((type)(intptr_t)handle)
+
 static const int delay[] = { 0, 1, 10, 20, 40 };
 
 int err_win_to_posix(DWORD winerr)
@@ -691,13 +693,13 @@ int pipe(int filedes[2])
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
-	filedes[0] = _open_osfhandle((int)h[0], O_NOINHERIT);
+	filedes[0] = _open_osfhandle(HCAST(int, h[0]), O_NOINHERIT);
 	if (filedes[0] < 0) {
 		CloseHandle(h[0]);
 		CloseHandle(h[1]);
 		return -1;
 	}
-	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
+	filedes[1] = _open_osfhandle(HCAST(int, h[1]), O_NOINHERIT);
 	if (filedes[1] < 0) {
 		close(filedes[0]);
 		CloseHandle(h[1]);
@@ -1846,7 +1848,8 @@ void mingw_open_html(const char *unixpath)
 		die("cannot run browser");
 
 	printf("Launching default browser to display HTML ...\n");
-	r = (int)ShellExecute(NULL, "open", htmlpath, NULL, "\\", SW_SHOWNORMAL);
+	r = HCAST(int, ShellExecute(NULL, "open", htmlpath,
+				NULL, "\\", SW_SHOWNORMAL));
 	FreeLibrary(shell32);
 	/* see the MSDN documentation referring to the result codes here */
 	if (r <= 32) {
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index db4e03e..b10adc7 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -76,7 +76,7 @@
 
 #ifdef WIN32_NATIVE
 
-#define IsConsoleHandle(h) (((long) (h) & 3) == 3)
+#define IsConsoleHandle(h) (((long) (intptr_t) (h) & 3) == 3)
 
 static BOOL
 IsSocketHandle (HANDLE h)
diff --git a/compat/winansi.c b/compat/winansi.c
index ceff55b..4549848 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -452,7 +452,8 @@ static HANDLE duplicate_handle(HANDLE hnd)
 	HANDLE hresult, hproc = GetCurrentProcess();
 	if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
 			DUPLICATE_SAME_ACCESS))
-		die_lasterr("DuplicateHandle(%li) failed", (long) hnd);
+		die_lasterr("DuplicateHandle(%li) failed",
+			(long) (intptr_t) hnd);
 	return hresult;
 }
 
-- 
2.7.0.windows.1.7.g55a05c8
