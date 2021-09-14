Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C251C433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EBD60EE9
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhINDkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbhINDkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:40:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE068C061760
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d6so17779442wrc.11
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NC71VbTzrZPn0zp8bz9ysLYt9G/SzmNk6M7k9SXUgm8=;
        b=k74Oh0w0qozYywoF/dn0/SJ64Sxzcq6TxFxsOTXldEGsK5WxvJdYX+POdWuYX6VOAq
         mOHiruU7e78ulHuaKUXOoxG479+4v1UAMcCSH+7ZcCKMLJCLs+amS1UyW0bNhKkNPVHB
         dD6fAZp2eTyh4oWQXa6z338smcBcSAcOA8ZlHq+qNs0mPySyciIbwS/ZBbJNFpfYo9+e
         Lj8reHw21+r+OZALEp22BcsLMZphtIQFDMCPWbodKsRvfs20MbNCAe6zgiCy8D4ycWsD
         DJy76+E5qFAK2Lxg5uLp5HY1UqLbjLtL4KXqli0D5qVlNFdnZC+bKF9k+ceqG6VldS0i
         8OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NC71VbTzrZPn0zp8bz9ysLYt9G/SzmNk6M7k9SXUgm8=;
        b=WQB1S9xF1Y3uWFcB7GRo95wkqeg+65szp7QV43GsmjgnuU+mF5ztZUJOPqeSVO7gYo
         eoILIsYJN6l+NtdYbBT9v9DoAkMWY1L3h8TmUo5UhDlvqNvQCFhhMDFXdeJFAr+rSERd
         Rujo4Ii4GeiHFJoW4MRifCc3uno59NOLT16W4r/qRZX41/SEmRtuVuLaWn1LEYehVD9v
         TPDCD8cDEclbFQ9qUMTfVBMwqITNvquXvu0BbKC3HyYcVhggx2e3I284JKMb471ywFBi
         gNLWuVs2BdB+exChuyy4hlj3rCTFBCHlXcYRkVfp0Njvs0oTKRtQaBdWNEa85vGqYVrn
         +tMA==
X-Gm-Message-State: AOAM530LU72zO2YLYXzpvbC1sXTx9pqHbXmfvVGiL/uK++C2GNBYRv7O
        Denzy7atWUdP7giC9vxLqS+bjqCPtE8=
X-Google-Smtp-Source: ABdhPJyaEKNTEfpOUuGIHf8n5aGTscbrXoAvJqBvUw19EH16lrS1CIRZOLxfe4UqqRJV5b3VV3I09g==
X-Received: by 2002:adf:fe82:: with SMTP id l2mr11403983wrr.268.1631590728499;
        Mon, 13 Sep 2021 20:38:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm2184378wrl.94.2021.09.13.20.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:38:48 -0700 (PDT)
Message-Id: <815a862e22940690b3db9a6fbbbda35029c88f66.1631590725.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 03:38:42 +0000
Subject: [PATCH v3 3/6] core.fsyncobjectfiles: add windows support for batch
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit adds a win32 implementation for fsync_no_flush that is
called git_fsync. The 'NtFlushBuffersFileEx' function being called is
available since Windows 8. If the function is not available, we
return -1 and Git falls back to doing a full fsync.

The operating system is told to flush data only without a hardware
flush primitive. A later full fsync will cause the metadata log
to be flushed and then the disk cache to be flushed on NTFS and
ReFS. Other filesystems will treat this as a full flush operation.

I added a new file here for this system call so as not to conflict with
downstream changes in the git-for-windows repository related to fscache.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/mingw.h                      |  3 +++
 compat/win32/flush.c                | 29 +++++++++++++++++++++++++++++
 config.mak.uname                    |  2 ++
 contrib/buildsystems/CMakeLists.txt |  3 ++-
 wrapper.c                           |  4 ++++
 5 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 compat/win32/flush.c

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
index 00000000000..c013920ce37
--- /dev/null
+++ b/compat/win32/flush.c
@@ -0,0 +1,29 @@
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
+       /* See https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntifs-ntflushbuffersfileex */
+       memset(&io_status, 0, sizeof(io_status));
+       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_FILE_DATA_ONLY,
+				NULL, 0, &io_status)) {
+		errno = EINVAL;
+		return -1;
+       }
+
+       return 0;
+}
diff --git a/config.mak.uname b/config.mak.uname
index e6d482fbcc6..34c93314a50 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -451,6 +451,7 @@ endif
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
@@ -626,6 +627,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 171b4124afe..b573a5ee122 100644
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
diff --git a/wrapper.c b/wrapper.c
index cffe24d307a..a9647018b68 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -565,6 +565,10 @@ int git_fsync(int fd, enum fsync_action action)
 						 SYNC_FILE_RANGE_WAIT_AFTER);
 #endif
 
+#ifdef fsync_no_flush
+		return fsync_no_flush(fd);
+#endif
+
 		errno = ENOSYS;
 		return -1;
 	}
-- 
gitgitgadget

