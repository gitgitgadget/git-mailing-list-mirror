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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3BC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794E06124A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbhIUCWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhIUBuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FF3C07E5C1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w29so33732184wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4TwjEERCBTdTIk5k03nSoPU6aP7qbN6anXF+SduK7kA=;
        b=EH1uYVXdPuCHVtvmEDbd9j249I2/KSQnGQA/2Re4CQT6LtsC+49W0f8jh3fGl1DC18
         M6QPCPss21LGoac7vJwu8dV1HqoyoBCvQCFi4aBZa+fsTBlsWdK9VACFLA4CY6mTZDIA
         gpViQmTWxAaLiMco2txIh61uFzuTf1MHiDJYElEkw9e2fKy8x69nDHJtITd6Ge52kpLB
         0slmkFKFZo8oMGTPNr9qt4TSyXw6KSlXPw0wM9H59jQqhIVx2CGjhpRYA3/dzVSMTBAj
         A/g2GHfETA+iiOHODaelaw9GFRmFc6l0/Ls5tpRGmKhXsR3nwiDIch6omHXp8BFTA2V5
         2JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4TwjEERCBTdTIk5k03nSoPU6aP7qbN6anXF+SduK7kA=;
        b=YQ4P3fRg6HD9FBLHZPhnx/6XPW9eB0npBVebCki4omZBfwCKNNf1A/7gpQ2TfvCvXZ
         onsDOXyeI6EreGihhrowpKdXDLtahowa/fkKG+ueCWAXpVWnBRNeiDOa9evbOu9q6wYv
         ZrcLPKoEkJo6ab4hG6kGz1gUMVhR4lHZGhMZCXAbzBrxs8Q2PQHrqL67SRkPHcCrAswe
         6KW4Hr2qyTp+Kmzbvc+NhClGt3BLiSZwdiRt3C6L+aicU8taQdR85a9lR/LSGMYYw8Zy
         vqDJNrSBCkasRxutTOS8+gnvsTKlx6SD4VcjWg3Ipvm0OucfRtw7RibwJn3ashWv5Ukh
         jf3Q==
X-Gm-Message-State: AOAM531bZHSdeJps9fyKREVqB6Zd0z5q6MgBia/QLzGn21L59u6i5jzV
        HKoQCxygAK7bXT7tYGwTz7vHRQldPsA=
X-Google-Smtp-Source: ABdhPJwgH6u8ml+idY8s1iPety3Y32BXB80hHsEQiI+C6anPFEvEKuzWz6ItfE7H3tabmc8lwA/bMA==
X-Received: by 2002:adf:e0cc:: with SMTP id m12mr30801604wri.62.1632176115037;
        Mon, 20 Sep 2021 15:15:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t23sm18071595wrb.71.2021.09.20.15.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:15:14 -0700 (PDT)
Message-Id: <a5b3e21b76208fba130e3313a3e70df45ab392af.1632176111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 22:15:08 +0000
Subject: [PATCH v4 3/6] core.fsyncobjectfiles: add windows support for batch
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index bb4f9f043ce..1a1e2fba9c9 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -567,6 +567,10 @@ int git_fsync(int fd, enum fsync_action action)
 						 SYNC_FILE_RANGE_WAIT_AFTER);
 #endif
 
+#ifdef fsync_no_flush
+		return fsync_no_flush(fd);
+#endif
+
 		errno = ENOSYS;
 		return -1;
 
-- 
gitgitgadget

