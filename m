Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3116C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 02:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhLGCu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 21:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLGCuY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 21:50:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6222C061354
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 18:46:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso1163295wmr.5
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 18:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hHIYjo4qBTFosohE3i7TJ7RTmFsSJH6YSE+/8DPvtLY=;
        b=BW042/rrF1mwlWSw4Ao025r3of6cTFBzwHxeMLlOMCtFiI6oLyf5yeDcjHjuzgT34y
         TChijgksVG4Z7o6M3IJE0njg8ZgH2eUGlFNuBc6Ux01LB1tzVYvV4lrgj6dEQvg9wR4R
         pA3OB4YteIe0k3SdZDWvsVAN0A0VZCt/VgoRzxO5i/nAu2M5DTUUqj2K4s7toTuB4EBG
         M8akw6tQ8bsj8UD3MmveLuIf6oydhPR7sNPAoQNXFGvn5R4PazQzZeMkUFcdac4Vqhh5
         HlgVJEYR6C9dVGpkmakMFK5Uaok4AGj5yrU2ikKiUrWASwIiNWDFxfu3a6oo157Vpvj/
         gZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hHIYjo4qBTFosohE3i7TJ7RTmFsSJH6YSE+/8DPvtLY=;
        b=bcmCigQ8gDE9v1PZgXVFX9HGFfYO7nR92+c+xHFAQPuVsEx1ZXBKWax082/o05nwJN
         CBmw73DrVdhP++IUR8vIbianU4+i9mf7gtYwS2IrlEP6kSWkgAT1KQa+QGBWEpJ2wFdH
         vlrIW4D/Eu+dvKP80y9bCgjPxVGgX0C6GYunagwQaGrMbUn0pm8ik/p8zk3iAsbLAiiB
         ESE6W1IK8GgsTdRcpx34YO06C/83SMUbMtAEbTOOB6iRE638TEb+TbFxTYu5aQy5t3of
         +lqB1UgAEkWgVZG/m8GFOJSI6f+mp34Oe+w50+lz/6VZZU9qr09sakFspJWa5u2xdOC6
         VIsg==
X-Gm-Message-State: AOAM530l+VfpqO1VbORfKnJh05/Db1z0eob7aCDX0LR2kkYPnvb/1YTu
        vRJivKvC7gxaqv/sTDJ54doHbsfJBTw=
X-Google-Smtp-Source: ABdhPJxFw08J1JNdLUfEXeKgJsvlsv3iBAJuZVIRw4Hh99lBsWofGodmvn34dUuyFkvWnmxktAQ+2A==
X-Received: by 2002:a1c:208b:: with SMTP id g133mr3319143wmg.128.1638845213155;
        Mon, 06 Dec 2021 18:46:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm16319411wrg.31.2021.12.06.18.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 18:46:52 -0800 (PST)
Message-Id: <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
        <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 02:46:49 +0000
Subject: [PATCH v2 1/3] core.fsyncmethod: add writeout-only mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit introduces the `core.fsyncmethod` configuration
knob, which can currently be set to `fsync` or `writeout-only`.

The new writeout-only mode attempts to tell the operating system to
flush its in-memory page cache to the storage hardware without issuing a
CACHE_FLUSH command to the storage controller.

Writeout-only fsync is significantly faster than a vanilla fsync on
common hardware, since data is written to a disk-side cache rather than
all the way to a durable medium. Later changes in this patch series will
take advantage of this primitive to implement batching of hardware
flushes.

When git_fsync is called with FSYNC_WRITEOUT_ONLY, it may fail and the
caller is expected to do an ordinary fsync as needed.

On Apple platforms, the fsync system call does not issue a CACHE_FLUSH
directive to the storage controller. This change updates fsync to do
fcntl(F_FULLFSYNC) to make fsync actually durable. We maintain parity
with existing behavior on Apple platforms by setting the default value
of the new core.fsyncmethod option.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt       |  9 +++++
 Makefile                            |  6 ++++
 cache.h                             |  7 ++++
 compat/mingw.h                      |  3 ++
 compat/win32/flush.c                | 28 +++++++++++++++
 config.c                            | 12 +++++++
 config.mak.uname                    |  3 ++
 configure.ac                        |  8 +++++
 contrib/buildsystems/CMakeLists.txt |  3 +-
 environment.c                       |  2 +-
 git-compat-util.h                   | 24 +++++++++++++
 wrapper.c                           | 56 +++++++++++++++++++++++++++++
 write-or-die.c                      | 10 +++---
 13 files changed, 165 insertions(+), 6 deletions(-)
 create mode 100644 compat/win32/flush.c

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..dbb134f7136 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,15 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsyncMethod::
+	A value indicating the strategy Git will use to harden repository data
+	using fsync and related primitives.
++
+* `fsync` uses the fsync() system call or platform equivalents.
+* `writeout-only` issues pagecache writeback requests, but depending on the
+  filesystem and storage hardware, data added to the repository may not be
+  durable in the event of a system crash. This is the default mode on macOS.
+
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
diff --git a/Makefile b/Makefile
index d56c0e4aadc..cba024615c9 100644
--- a/Makefile
+++ b/Makefile
@@ -403,6 +403,8 @@ all::
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
 #
+# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
+#
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
@@ -1881,6 +1883,10 @@ ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
 
+ifdef HAVE_SYNC_FILE_RANGE
+	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
+endif
+
 ifdef NEEDS_LIBRT
 	EXTLIBS += -lrt
 endif
diff --git a/cache.h b/cache.h
index eba12487b99..9cd60d94952 100644
--- a/cache.h
+++ b/cache.h
@@ -986,6 +986,13 @@ extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
+
+enum fsync_method {
+	FSYNC_METHOD_FSYNC,
+	FSYNC_METHOD_WRITEOUT_ONLY
+};
+
+extern enum fsync_method fsync_method;
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a6..6074a3d3ced 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -329,6 +329,9 @@ int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
 #endif
 
+int win32_fsync_no_flush(int fd);
+#define fsync_no_flush win32_fsync_no_flush
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/compat/win32/flush.c b/compat/win32/flush.c
new file mode 100644
index 00000000000..75324c24ee7
--- /dev/null
+++ b/compat/win32/flush.c
@@ -0,0 +1,28 @@
+#include "../../git-compat-util.h"
+#include <winternl.h>
+#include "lazyload.h"
+
+int win32_fsync_no_flush(int fd)
+{
+       IO_STATUS_BLOCK io_status;
+
+#define FLUSH_FLAGS_FILE_DATA_ONLY 1
+
+       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
+			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
+			 PIO_STATUS_BLOCK IoStatusBlock);
+
+       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
+		errno = ENOSYS;
+		return -1;
+       }
+
+       memset(&io_status, 0, sizeof(io_status));
+       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_FILE_DATA_ONLY,
+				NULL, 0, &io_status)) {
+		errno = EINVAL;
+		return -1;
+       }
+
+       return 0;
+}
diff --git a/config.c b/config.c
index c5873f3a706..c3410b8a868 100644
--- a/config.c
+++ b/config.c
@@ -1490,6 +1490,18 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fsyncmethod")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "fsync"))
+			fsync_method = FSYNC_METHOD_FSYNC;
+		else if (!strcmp(value, "writeout-only"))
+			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
+		else
+			warning(_("unknown %s value '%s'"), var, value);
+
+	}
+
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
 		fsync_object_files = git_config_bool(var, value);
 		return 0;
diff --git a/config.mak.uname b/config.mak.uname
index d0701f9beb0..774a09622d2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -57,6 +57,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	# -lrt is needed for clock_gettime on glibc <= 2.16
 	NEEDS_LIBRT = YesPlease
+	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	BASIC_CFLAGS += -DHAVE_SYSINFO
@@ -453,6 +454,7 @@ endif
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
@@ -628,6 +630,7 @@ ifeq ($(uname_S),MINGW)
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/configure.ac b/configure.ac
index 5ee25ec95c8..6bd6bef1c44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1082,6 +1082,14 @@ AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
 	[AC_MSG_RESULT([no])
 	HAVE_CLOCK_MONOTONIC=])
 GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
+
+#
+# Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
+GIT_CHECK_FUNC(sync_file_range,
+	[HAVE_SYNC_FILE_RANGE=YesPlease],
+	[HAVE_SYNC_FILE_RANGE])
+GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
+
 #
 # Define NO_SETITIMER if you don't have setitimer.
 GIT_CHECK_FUNC(setitimer,
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 86b46114464..6d7bc16d054 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -261,7 +261,8 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
-	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
+	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c
+		compat/win32/flush.c compat/win32/path-utils.c
 		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
 		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
 		compat/nedmalloc/nedmalloc.c compat/strdup.c)
diff --git a/environment.c b/environment.c
index 9da7f3c1a19..f9140e842cf 100644
--- a/environment.c
+++ b/environment.c
@@ -41,7 +41,7 @@ const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-int fsync_object_files;
+enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/git-compat-util.h b/git-compat-util.h
index c6bd2a84e55..cb9abd7a08c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1239,6 +1239,30 @@ __attribute__((format (printf, 1, 2))) NORETURN
 void BUG(const char *fmt, ...);
 #endif
 
+#ifdef __APPLE__
+#define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
+#else
+#define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
+#endif
+
+enum fsync_action {
+    FSYNC_WRITEOUT_ONLY,
+    FSYNC_HARDWARE_FLUSH
+};
+
+/*
+ * Issues an fsync against the specified file according to the specified mode.
+ *
+ * FSYNC_WRITEOUT_ONLY attempts to use interfaces available on some operating
+ * systems to flush the OS cache without issuing a flush command to the storage
+ * controller. If those interfaces are unavailable, the function fails with
+ * ENOSYS.
+ *
+ * FSYNC_HARDWARE_FLUSH does an OS writeout and hardware flush to ensure that
+ * changes are durable. It is not expected to fail.
+ */
+int git_fsync(int fd, enum fsync_action action);
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
diff --git a/wrapper.c b/wrapper.c
index 36e12119d76..1c5f2c87791 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -546,6 +546,62 @@ int xmkstemp_mode(char *filename_template, int mode)
 	return fd;
 }
 
+int git_fsync(int fd, enum fsync_action action)
+{
+	switch (action) {
+	case FSYNC_WRITEOUT_ONLY:
+
+#ifdef __APPLE__
+		/*
+		 * on macOS, fsync just causes filesystem cache writeback but does not
+		 * flush hardware caches.
+		 */
+		return fsync(fd);
+#endif
+
+#ifdef HAVE_SYNC_FILE_RANGE
+		/*
+		 * On linux 2.6.17 and above, sync_file_range is the way to issue
+		 * a writeback without a hardware flush. An offset of 0 and size of 0
+		 * indicates writeout of the entire file and the wait flags ensure that all
+		 * dirty data is written to the disk (potentially in a disk-side cache)
+		 * before we continue.
+		 */
+
+		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
+						 SYNC_FILE_RANGE_WRITE |
+						 SYNC_FILE_RANGE_WAIT_AFTER);
+#endif
+
+#ifdef fsync_no_flush
+		return fsync_no_flush(fd);
+#endif
+
+		errno = ENOSYS;
+		return -1;
+
+	case FSYNC_HARDWARE_FLUSH:
+		/*
+		 * On some platforms fsync may return EINTR. Try again in this
+		 * case, since callers asking for a hardware flush may die if
+		 * this function returns an error.
+		 */
+		for (;;) {
+			int err;
+#ifdef __APPLE__
+			err = fcntl(fd, F_FULLFSYNC);
+#else
+			err = fsync(fd);
+#endif
+			if (err >= 0 || errno != EINTR)
+				return err;
+		}
+
+	default:
+		BUG("unexpected git_fsync(%d) call", action);
+	}
+}
+
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
diff --git a/write-or-die.c b/write-or-die.c
index 0b1ec8190b6..0702acdd5e8 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -57,10 +57,12 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 
 void fsync_or_die(int fd, const char *msg)
 {
-	while (fsync(fd) < 0) {
-		if (errno != EINTR)
-			die_errno("fsync error on '%s'", msg);
-	}
+	if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
+		return;
+
+	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
+		die_errno("fsync error on '%s'", msg);
 }
 
 void write_or_die(int fd, const void *buf, size_t count)
-- 
gitgitgadget

