Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4BCC433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiAHQCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiAHQCd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 11:02:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128DC06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 08:02:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so6521987wrb.13
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=cfJ/xK/4K+iV73GYdbG3XTgolmp4w+2qO3hAFyQxHFg=;
        b=gTXYc1O9JvdP8Tz+1p5diGLzcQSiEUorpLDlYmZZH9+u4kVWf5gXU89os3JNHJU+WT
         zbvFTeflBFuquL/Sb7EtmWe1VUM1k465puprqrxDCSdbHfZEGSPM09ZhBD3Edi7CUMs7
         bYNW461sXR1B3v0iZsHGP1cArczaGCLWuEvcGJ3VLi82GDT1pFL4lOkAnuUjnkkyOaIU
         FBNLusrM9tXh3gUE/iImm0QclQzwRVeFxG6RWLGaPLieV/TPE1BEekzp6TrBBH/suQMo
         uWmAAyGX11vlCowxTzCXC0e49+bJvhyLrC5wM3uok6HgkysCC6nOvEwk/unw1D9EfUct
         gF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cfJ/xK/4K+iV73GYdbG3XTgolmp4w+2qO3hAFyQxHFg=;
        b=G3E8g8vZjYiQuddGyHVEKGBPh+pHwa2mQ2UaFdWJKIry3CWlglCPa9CGeMxQcgqg2T
         e317k5tiST1QEBexob6q48rDZVYpkqYR0dOjHUZxgodKQDJp/KfMPVMsyNJUmuL/WzwS
         f62M8ZJMYFQYr199DCNZjuijBLNpkVfJguhsFXP9P+0n8ntGDZ2uhkAYz7YQDHhZAb9f
         cfQZZ9inFidBrmAlVTce00n1uMFbyXopHIejPOtZ4hP+AHFLNrKVMczBMOBF7zedYb2m
         BZX1a3Z6/c6V5E/DgdbhAJcoeuFuSkgWSjsuTLOKYg3C+t1txYbbZpAG0L/SZv84OLP4
         YEJA==
X-Gm-Message-State: AOAM533sSj4CbK+RRpEdVVfgdNxcqWD0lEsdwJMvOHqo0YlUyZQ5+0k4
        TrDTUmDrGgBitTAlu53A36PAca9yJrE=
X-Google-Smtp-Source: ABdhPJyLqrhf8qRuT1sDGq9RfwEA52GS4mR92skZNKjebaEs9zCY6RtGZfM3xU4xGTYzGFkTUXI0rA==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr58096554wrz.349.1641657751475;
        Sat, 08 Jan 2022 08:02:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm1938067wrf.93.2022.01.08.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:02:31 -0800 (PST)
Message-Id: <pull.1181.git.git.1641657750776.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 08 Jan 2022 16:02:30 +0000
Subject: [PATCH] lazyload: use correct calling conventions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     reiter.christoph@gmail.com,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

Christoph Reiter reported on the Git for Windows issue tracker[1], that
mingw_strftime() imports strftime() from ucrtbase.dll with the wrong
calling convention. It should be __cdecl instead of WINAPI, which we
always use in DECLARE_PROC_ADDR().

The MSYS2 project encountered cmake sefaults on x86 Windows caused by
the same issue in the cmake source. [2] There are no known git crashes
that where caused by this, yet, but we should try to prevent them.

We import two other non-WINAPI functions via DECLARE_PROC_ADDR(), too.

* NtSetSystemInformation() (NTAPI)
* GetUserNameExW()         (SEC_ENTRY)

NTAPI, SEC_ENTRY and WINAPI are all ususally defined as __stdcall,
but there are circumstances where they're defined differently.

Teach DECLARE_PROC_ADDR() about calling conventions and be explicit
about when we want to use which calling convention.

Import winnt.h for the definition of NTAPI and sspi.h for SEC_ENTRY
near their respective only users.

[1] https://github.com/git-for-windows/git/issues/3560
[2] https://github.com/msys2/MINGW-packages/issues/10152

Reported-By: Christoph Reiter <reiter.christoph@gmail.com>
Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
    lazyload: use correct calling conventions
    
    I wanted to get this out a lot earlier, but got distracted by a lot of
    work at $DAYJOB. I'm sorry about sending this this late in the 2.35.0
    cycle.
    
    This applies cleanly on master and maint, but CI produces some weird
    build failures that seem unrelated in both of those situations.
    
    On master the FreeBSD fails with
    
    > archive.c:337:35: error: '_Generic' is a C11 extension
    > [-Werror,-Wc11-extensions] strbuf_addstr(&path_in_archive,
    > basename(path)); ^ /usr/include/libgen.h:61:21: note: expanded from
    > macro 'basename' #define basename(x) __generic(x, const char *,
    > __old_basename, basename)(x) ^ /usr/include/sys/cdefs.h:329:2: note:
    > expanded from macro '__generic' _Generic(expr, t: yes, default: no)
    
    While on maint the CI / linux32 (daald/ubuntu32:xenial) job just
    straight up can't find make. I have no clue what's up with that, but I'm
    fairly certain I'm not the direct cause of either of those failures.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1181%2Frimrul%2Fwin-lazyload-calling-convention-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1181/rimrul/win-lazyload-calling-convention-v1
Pull-Request: https://github.com/git/git/pull/1181

 compat/mingw.c                           | 6 ++++--
 compat/win32/lazyload.h                  | 6 +++---
 compat/win32/trace2_win32_process_info.c | 4 ++--
 compat/winansi.c                         | 5 +++--
 t/helper/test-drop-caches.c              | 4 +++-
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097f..f38c4381123 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -8,6 +8,8 @@
 #include "win32/lazyload.h"
 #include "../config.h"
 #include "dir.h"
+#define SECURITY_WIN32
+#include <sspi.h>
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
@@ -1008,7 +1010,7 @@ size_t mingw_strftime(char *s, size_t max,
 	/* a pointer to the original strftime in case we can't find the UCRT version */
 	static size_t (*fallback)(char *, size_t, const char *, const struct tm *) = strftime;
 	size_t ret;
-	DECLARE_PROC_ADDR(ucrtbase.dll, size_t, strftime, char *, size_t,
+	DECLARE_PROC_ADDR(ucrtbase.dll, size_t, __cdecl, strftime, char *, size_t,
 		const char *, const struct tm *);
 
 	if (INIT_PROC_ADDR(strftime))
@@ -2183,7 +2185,7 @@ enum EXTENDED_NAME_FORMAT {
 
 static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
 {
-	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
+	DECLARE_PROC_ADDR(secur32.dll, BOOL, SEC_ENTRY, GetUserNameExW,
 		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
 	static wchar_t wbuffer[1024];
 	DWORD len;
diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index 2b3637135f6..f2bb96c89c7 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -4,7 +4,7 @@
 /*
  * A pair of macros to simplify loading of DLL functions. Example:
  *
- *   DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
+ *   DECLARE_PROC_ADDR(kernel32.dll, BOOL, WINAPI, CreateHardLinkW,
  *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
  *
  *   if (!INIT_PROC_ADDR(CreateHardLinkW))
@@ -25,10 +25,10 @@ struct proc_addr {
 };
 
 /* Declares a function to be loaded dynamically from a DLL. */
-#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
+#define DECLARE_PROC_ADDR(dll, rettype, convention, function, ...) \
 	static struct proc_addr proc_addr_##function = \
 	{ #dll, #function, NULL, 0 }; \
-	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
+	typedef rettype (convention *proc_type_##function)(__VA_ARGS__); \
 	static proc_type_##function function
 
 /*
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index 8ccbd1c2c6f..a53fd924340 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -143,8 +143,8 @@ static void get_is_being_debugged(void)
  */
 static void get_peak_memory_info(void)
 {
-	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo, HANDLE,
-			  PPROCESS_MEMORY_COUNTERS, DWORD);
+	DECLARE_PROC_ADDR(psapi.dll, BOOL, WINAPI, GetProcessMemoryInfo,
+			  HANDLE, PPROCESS_MEMORY_COUNTERS, DWORD);
 
 	if (INIT_PROC_ADDR(GetProcessMemoryInfo)) {
 		PROCESS_MEMORY_COUNTERS pmc;
diff --git a/compat/winansi.c b/compat/winansi.c
index c27b20a79d9..4fceecf14ce 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -45,8 +45,9 @@ typedef struct _CONSOLE_FONT_INFOEX {
 static void warn_if_raster_font(void)
 {
 	DWORD fontFamily = 0;
-	DECLARE_PROC_ADDR(kernel32.dll, BOOL, GetCurrentConsoleFontEx,
-			HANDLE, BOOL, PCONSOLE_FONT_INFOEX);
+	DECLARE_PROC_ADDR(kernel32.dll, BOOL, WINAPI,
+			GetCurrentConsoleFontEx, HANDLE, BOOL,
+			PCONSOLE_FONT_INFOEX);
 
 	/* don't bother if output was ascii only */
 	if (!non_ascii_used)
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 7b4278462bb..e37396dd9c2 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -3,6 +3,7 @@
 
 #if defined(GIT_WINDOWS_NATIVE)
 #include "lazyload.h"
+#include <winnt.h>
 
 static int cmd_sync(void)
 {
@@ -86,7 +87,8 @@ static int cmd_dropcaches(void)
 {
 	HANDLE hProcess = GetCurrentProcess();
 	HANDLE hToken;
-	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
+	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NTAPI, NtSetSystemInformation, INT, PVOID,
+		ULONG);
 	SYSTEM_MEMORY_LIST_COMMAND command;
 	int status;
 

base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
-- 
gitgitgadget
