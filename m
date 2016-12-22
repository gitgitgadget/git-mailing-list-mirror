Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7A020968
	for <e@80x24.org>; Thu, 22 Dec 2016 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941872AbcLVXRF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:17:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:58734 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757389AbcLVXRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:17:04 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaaVn-1czsjm1yql-00mK2i; Fri, 23
 Dec 2016 00:16:57 +0100
Date:   Fri, 23 Dec 2016 00:16:56 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 3/3] mingw: replace isatty() hack
In-Reply-To: <cover.1482448531.git.johannes.schindelin@gmx.de>
Message-ID: <2ce6060b891f8313cc63a95a9cba9064b7f82eb8.1482448531.git.johannes.schindelin@gmx.de>
References: <cover.1482426497.git.johannes.schindelin@gmx.de> <cover.1482448531.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gYGZvXDj21fMf8a4OgmcHft+HqlFixMrlZgqT15usFRsBAT/P7g
 9560/gqCgqcLwWwIbP8QFCMghBfIH3ekkck5jeQjJEuFCAa9x+JSsj3PD5NEgn4d2mmmpxa
 slC6Zq0VlccYB5jNq9qj403/R6sk1ra4TQp69JYTbuUlQ7JOiY0mGwbpsNSSlP+021gGPnP
 abldRInUv+JasrR7xYHwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YYz6huYOT7U=:B5myNm9qabuu76isJQDh0A
 A6pVjFEhO7yTY07M7dfb+JYntDEYMifl9is+zfRMcjNB9nQ6AfxWUvFbfA04qns2g1zHl4G1U
 BDPkzZzg+eVTi+8fax1/m0Y3g3NJre3hXPlYLlj160dQSdyI8zpwEAyGqxr+k50bqYl0pKYgg
 +Eco8ZtclZLTVuA1ytkFt339hJKFj6ICIJ3/RfqoDfwMN1HO62kYtBsQG4Dn8p1AsNEZms23g
 yaUD2qzxNiZfRX0f8RP4io5YghOAVPibZNCNgzxuvz3ax3T6mvh3BIz0yse7S1R67d6WBlh+j
 zVzC1Af/w4TgykDIwDr0yOWLAzN2C1lxLMCski338No/Prcfalb+9JLSL1NlaU3xwRcGQ6y69
 riy9cE9tgl/a9H0Sn38QPYcX7sCTewq6G+DHGglKd+JM9DYx2Lse77pd/L9ENvEI8GXugdq5p
 Gh3500ulhWe8y3cVjTU1lVtVMhg8DiVxCGVCt0hxNQwrSFybqxiQfaLN4onyOZ8hecmDA3jhq
 zpAiB734namC7dp1KVDggOtV0zCwqgaJfDODcUdBK8KzaWh+Bn2ZKARkGmQGQdcW0owmCy8TA
 luDJXYUmQ4yz3BUzVeWzKiAfXu6+ci42aVCJDz4T+MYl7MhDtkHSIZHmV0lt8sXHvVMUgQR2p
 E3fJ8lnRODjCikJBd/olK0TJzpyUydAJUVdTcw7ApzOqhIJxiB0yGlyOmDuWPXe26hfJYJ+fD
 tuwMuDWndj9gcJpVqwdzJcEezKnHorjXPNDDPQ1f0J6BStn3eWvK7Dga5PqGUoswZLd87gH3P
 0Jc0RvC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Git for Windows has carried a patch that depended on internals
of MSVC runtime, but it does not work correctly with recent MSVC
runtime. A replacement was written originally for compiling
with VC++. The patch in this message is a backport of that
replacement, and it also fixes the previous attempt to make
isatty() tell that /dev/null is *not* an interactive terminal.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Tested-by: Beat Bolli <dev+git@drbeat.li>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 181 +++++++++++++++++++++----------------------------------
 1 file changed, 70 insertions(+), 111 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index fa37695fca..56658ec4f8 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -6,9 +6,12 @@
 #include "../git-compat-util.h"
 #include <wingdi.h>
 #include <winreg.h>
+#include "win32.h"
 
-/* In this file, we actually want to use Windows' own isatty(). */
-#undef isatty
+static int fd_is_interactive[3] = { 0, 0, 0 };
+#define FD_CONSOLE 0x1
+#define FD_SWAPPED 0x2
+#define FD_MSYS    0x4
 
 /*
  ANSI codes used by git: m, K
@@ -105,6 +108,9 @@ static int is_console(int fd)
 	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
+	if (fd >= 0 && fd <= 2)
+		fd_is_interactive[fd] |= FD_CONSOLE;
+
 	/* initialize attributes */
 	if (!initialized) {
 		console = hcon;
@@ -466,76 +472,47 @@ static HANDLE duplicate_handle(HANDLE hnd)
 	return hresult;
 }
 
-
-/*
- * Make MSVCRT's internal file descriptor control structure accessible
- * so that we can tweak OS handles and flags directly (we need MSVCRT
- * to treat our pipe handle as if it were a console).
- *
- * We assume that the ioinfo structure (exposed by MSVCRT.dll via
- * __pioinfo) starts with the OS handle and the flags. The exact size
- * varies between MSVCRT versions, so we try different sizes until
- * toggling the FDEV bit of _pioinfo(1)->osflags is reflected in
- * isatty(1).
- */
-typedef struct {
-	HANDLE osfhnd;
-	char osflags;
-} ioinfo;
-
-extern __declspec(dllimport) ioinfo *__pioinfo[];
-
-static size_t sizeof_ioinfo = 0;
-
-#define IOINFO_L2E 5
-#define IOINFO_ARRAY_ELTS (1 << IOINFO_L2E)
-
-#define FPIPE 0x08
-#define FDEV  0x40
-
-static inline ioinfo* _pioinfo(int fd)
-{
-	return (ioinfo*)((char*)__pioinfo[fd >> IOINFO_L2E] +
-			(fd & (IOINFO_ARRAY_ELTS - 1)) * sizeof_ioinfo);
-}
-
-static int init_sizeof_ioinfo(void)
-{
-	int istty, wastty;
-	/* don't init twice */
-	if (sizeof_ioinfo)
-		return sizeof_ioinfo >= 256;
-
-	sizeof_ioinfo = sizeof(ioinfo);
-	wastty = isatty(1);
-	while (sizeof_ioinfo < 256) {
-		/* toggle FDEV flag, check isatty, then toggle back */
-		_pioinfo(1)->osflags ^= FDEV;
-		istty = isatty(1);
-		_pioinfo(1)->osflags ^= FDEV;
-		/* return if we found the correct size */
-		if (istty != wastty)
-			return 0;
-		sizeof_ioinfo += sizeof(void*);
-	}
-	error("Tweaking file descriptors doesn't work with this MSVCRT.dll");
-	return 1;
-}
-
 static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 {
-	ioinfo *pioinfo;
-	HANDLE old_handle;
-
-	/* init ioinfo size if we haven't done so */
-	if (init_sizeof_ioinfo())
-		return INVALID_HANDLE_VALUE;
-
-	/* get ioinfo pointer and change the handles */
-	pioinfo = _pioinfo(fd);
-	old_handle = pioinfo->osfhnd;
-	pioinfo->osfhnd = new_handle;
-	return old_handle;
+	/*
+	 * Create a copy of the original handle associated with fd
+	 * because the original will get closed when we dup2().
+	 */
+	HANDLE handle = (HANDLE)_get_osfhandle(fd);
+	HANDLE duplicate = duplicate_handle(handle);
+
+	/* Create a temp fd associated with the already open "new_handle". */
+	int new_fd = _open_osfhandle((intptr_t)new_handle, O_BINARY);
+
+	assert((fd == 1) || (fd == 2));
+
+	/*
+	 * Use stock dup2() to re-bind fd to the new handle.  Note that
+	 * this will implicitly close(1) and close both fd=1 and the
+	 * originally associated handle.  It will open a new fd=1 and
+	 * call DuplicateHandle() on the handle associated with new_fd.
+	 * It is because of this implicit close() that we created the
+	 * copy of the original.
+	 *
+	 * Note that we need to update the cached console handle to the
+	 * duplicated one because the dup2() call will implicitly close
+	 * the original one.
+	 *
+	 * Note that dup2() when given target := {0,1,2} will also
+	 * call SetStdHandle(), so we don't need to worry about that.
+	 */
+	if (console == handle)
+		console = duplicate;
+	dup2(new_fd, fd);
+
+	/* Close the temp fd.  This explicitly closes "new_handle"
+	 * (because it has been associated with it).
+	 */
+	close(new_fd);
+
+	fd_is_interactive[fd] |= FD_SWAPPED;
+
+	return duplicate;
 }
 
 #ifdef DETECT_MSYS_TTY
@@ -570,45 +547,25 @@ static void detect_msys_tty(int fd)
 			!wcsstr(name, L"-pty"))
 		return;
 
-	/* init ioinfo size if we haven't done so */
-	if (init_sizeof_ioinfo())
-		return;
-
-	/* set FDEV flag, reset FPIPE flag */
-	_pioinfo(fd)->osflags &= ~FPIPE;
-	_pioinfo(fd)->osflags |= FDEV;
+	fd_is_interactive[fd] |= FD_MSYS;
 }
 
 #endif
 
+/*
+ * Wrapper for isatty().  Most calls in the main git code
+ * call isatty(1 or 2) to see if the instance is interactive
+ * and should: be colored, show progress, paginate output.
+ * We lie and give results for what the descriptor WAS at
+ * startup (and ignore any pipe redirection we internally
+ * do).
+ */
+#undef isatty
 int winansi_isatty(int fd)
 {
-	int res = isatty(fd);
-
-	if (res) {
-		/*
-		 * Make sure that /dev/null is not fooling Git into believing
-		 * that we are connected to a terminal, as "_isatty() returns a
-		 * nonzero value if the descriptor is associated with a
-		 * character device."; for more information, see
-		 *
-		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
-		 */
-		HANDLE handle = (HANDLE)_get_osfhandle(fd);
-		if (fd == STDIN_FILENO) {
-			DWORD dummy;
-
-			if (!GetConsoleMode(handle, &dummy))
-				res = 0;
-		} else if (fd == STDOUT_FILENO || fd == STDERR_FILENO) {
-			CONSOLE_SCREEN_BUFFER_INFO dummy;
-
-			if (!GetConsoleScreenBufferInfo(handle, &dummy))
-				res = 0;
-		}
-	}
-
-	return res;
+	if (fd >= 0 && fd <= 2)
+		return fd_is_interactive[fd] != 0;
+	return isatty(fd);
 }
 
 void winansi_init(void)
@@ -619,6 +576,10 @@ void winansi_init(void)
 	/* check if either stdout or stderr is a console output screen buffer */
 	con1 = is_console(1);
 	con2 = is_console(2);
+
+	/* Also compute console bit for fd 0 even though we don't need the result here. */
+	is_console(0);
+
 	if (!con1 && !con2) {
 #ifdef DETECT_MSYS_TTY
 		/* check if stdin / stdout / stderr are MSYS2 pty pipes */
@@ -662,12 +623,10 @@ void winansi_init(void)
  */
 HANDLE winansi_get_osfhandle(int fd)
 {
-	HANDLE hnd = (HANDLE) _get_osfhandle(fd);
-	if (isatty(fd) && GetFileType(hnd) == FILE_TYPE_PIPE) {
-		if (fd == 1 && hconsole1)
-			return hconsole1;
-		else if (fd == 2 && hconsole2)
-			return hconsole2;
-	}
-	return hnd;
+	if (fd == 1 && (fd_is_interactive[1] & FD_SWAPPED))
+		return hconsole1;
+	if (fd == 2 && (fd_is_interactive[2] & FD_SWAPPED))
+		return hconsole2;
+
+	return (HANDLE)_get_osfhandle(fd);
 }
-- 
2.11.0.rc3.windows.1
