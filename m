Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EACA1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761006AbcLURyK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 12:54:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:51462 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760750AbcLURyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 12:54:08 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeQ43-1bwLcF3DHb-00QCYM; Wed, 21
 Dec 2016 18:53:44 +0100
Date:   Wed, 21 Dec 2016 18:53:43 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] mingw: replace isatty() hack
In-Reply-To: <cover.1482342791.git.johannes.schindelin@gmx.de>
Message-ID: <18174f0a7fbb4a0ccd8ca8380e00161826166a32.1482342791.git.johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VVYAb4rwo72Pt/REyw4J7qoo/9o0OEJtxLTr3MaqmAOa1hEbzOF
 v4IYRW/nQwMWr8gYR/zRwR1efbSVWyenA8VMqOtrJoMjeR9OAA3zwSR97AVmnsVS4mAzyxZ
 Th0Ggls7xeSlpN54O5FFRmzu6uOIExOp6ViSFshzSficRzw1vIBmDZg//8+Voz/ZdTNddR/
 1byf72lziGZRrWJ2qHs0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/qJckJOxPTM=:4c+GJwbLRN7LgB0sKB2d7J
 4fecuTFOaLvRcF+YMWsELjyHIHaQnUqMMepqyuv2oAPx/TIwhOtcabId8wEB1NlCxqNBn1eSk
 bq23hXy1cdDOwn8DfUm9Gpzg5oDRVnaU1kXK+iTkFPcM1NMvPZ/E1EtfOU70PGfS1ihMEWqFQ
 NvtS+fbs3eZfdAdhydzBcgol0y1vu5ExgawIldYfJlbBSgcR7MJ2VPkGJ2AGy8QAuOx1WJzth
 LS0c1f1T/eIkA0iVeV9Ni1S7RdcrVeHHojiPU6e0uP2sHCpyA61ngpCVQRwak65O1Clnv38RC
 MeAC0bHsnp3ykojRZZHUpeSlXskIB54N6FjmbgKoSClKBiWH/cq7EX48Ft62UgigFtlxo7idq
 H1n2z1pBQZ5KpwSR6zXtagP8T3YLHVUmW4fVYZIMHqgom1KAurF6gfZesU1yz0xRzwc1/LLyT
 SAOCdmK2/Hcyo0NtnYiKOiKKCKheHPoy/y/qft+RrLOIq/NOpgLWWyh7VWqebeQ+wFWuyta+1
 ip9gjESu7BpUIN1y+TiQv07hL9eMhyjTKCSr0ODUHxJ8JsSn3mIoZ6MMaTdlECU0yfk1nKOaQ
 LfFgyCVLeX2Llp3CAS11yB1WUCPPaaRjC1GlvQv5owdCi4ZqWdzOrc2zxsN/1KqWUGdRT/+bg
 uZ+63orCrWEypnnjC4kfLfqPnNsyq2ZdOa1MEBoCL7mKaEGLCIBBffVn9y/HeFk7uaK9IaYj5
 raaYGBIcNkstD1WyDcTU2vJSDe1CnNZBcMyveduIu4oDv2AlWzr6XTpZuR6mRqV4qc6sNX8D1
 jnfg5yg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

For over a year, Git for Windows has carried a patch that detects the
MSYS2 pseudo ttys used by Git for Windows' default Git Bash (i.e. a
terminal that is not backed by a Win32 Console).

This patch accesses internals that of a previous MSVC runtime that is no
longer valid in newer versions, therefore we needed a replacement for
that hack in order to be able to compile Git using recent Microsoft
Visual C++.

This patch back-ports that patch and makes even the MINGW (i.e.
GCC-compiled) Git use it.

As a side effect (which was the reason for the back-port), this patch
also fixes the previous misguided attempt to intercept isatty() so that
it handles character devices (such as /dev/null) as Git expects it.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 191 +++++++++++++++++++++++--------------------------------
 1 file changed, 78 insertions(+), 113 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 97a004b8ab..3bfad0d065 100644
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
 
+	if (fd >=0 && fd <= 2)
+		fd_is_interactive[fd] |= FD_CONSOLE;
+
 	/* initialize attributes */
 	if (!initialized) {
 		console = hcon;
@@ -466,76 +472,50 @@ static HANDLE duplicate_handle(HANDLE hnd)
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
+	 * Note that the OS can recycle HANDLE (numbers) just like it
+	 * recycles fd (numbers), so we must update the cached value
+	 * of "console".  You can use GetFileType() to see that
+	 * handle and _get_osfhandle(fd) may have the same number
+	 * value, but they refer to different actual files now.
+	 *
+	 * Note that dup2() when given target := {0,1,2} will also
+	 * call SetStdHandle(), so we don't need to worry about that.
+	 */
+	dup2(new_fd, fd);
+	if (console == handle)
+		console = duplicate;
+	handle = INVALID_HANDLE_VALUE;
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
@@ -562,49 +542,32 @@ static void detect_msys_tty(int fd)
 	name = nameinfo->Name.Buffer;
 	name[nameinfo->Name.Length / sizeof(*name)] = 0;
 
-	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
-	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))
+	/*
+	 * Check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX')
+	 * or a cygwin pty pipe ('cygwin-XXXX-ptyN-XX')
+	 */
+	if ((!wcsstr(name, L"msys-") && !wcsstr(name, L"cygwin-")) ||
+			!wcsstr(name, L"-pty"))
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
 
+/* Wrapper for isatty().  Most calls in the main git code
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
-		HANDLE handle = winansi_get_osfhandle(fd);
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
+	if (fd >=0 && fd <= 2)
+		return fd_is_interactive[fd] != 0;
+	return isatty(fd);
 }
 
 void winansi_init(void)
@@ -615,6 +578,10 @@ void winansi_init(void)
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
@@ -658,12 +625,10 @@ void winansi_init(void)
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
