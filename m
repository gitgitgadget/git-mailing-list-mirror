Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC7DC2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF78206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeqRwZ4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgELQvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgELQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DAC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m24so13016240wml.2
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qQWDqFKt19oATdY5WR3mGWmfA6Rc91pQh0LG5JmoHY=;
        b=VeqRwZ4u+CZ0xgVBlmhR0sPPE2NIgZ04J8IA7eaKXuTzDwSNz9KhEPEgdyNonvW0TV
         h8tov8HEmh3dYxHCiXj8yUKjRC7hIMa2OEHZBMl4Rd4lY2ZUYan05I4Dw1b2rnmsdfMp
         Adb4ZA2+j52Os/qeEcnXFeVjNEse9MrDA/uoqKzV7CUto85JYxjScuUNilcWldoI9LKi
         rPvUltjrVbv6HixJgZLtmdPlr1fqprUhvz6ipH8OLbJb/Y+Hngsvvbn9APYficvUQ6aM
         r81RboyjCT2egN24Pog3wUm0219F3fqDA7kYeZKh1EeDV6CBwnFBQW5RYHW4NwN0/uQA
         kImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7qQWDqFKt19oATdY5WR3mGWmfA6Rc91pQh0LG5JmoHY=;
        b=c+Bbk7GlRV+nzO+7VazoTW0gyVOybfTatdrJ4bKoLTthym240Km+0QLmI2Ti/7hQvD
         v+oW50se4YbbNd9Qs4yANRDUaq1YF9gCB3b+dtjELkeesxpL0TqahtaGCKXNIADjiU/4
         HQUZrtACwl0F1JLo9BZPjb23dhzydjWAsE9BB0IwGRqqyOz6mNT7v8U8IRkAIyanJQ5b
         eqf2yMr9geEmkS38SgiBIfBAj49Iwh5veYUYIDzeFNbt+LOXQyhbkOt3Viay2GJDR/iW
         +fIBGO/l/2H0wbFvXrHWz648SyNlnrWwIftWd7AaSB8jk26ofuQY4o5S9NlgApIHCYpu
         lMWw==
X-Gm-Message-State: AGi0PuaXOWjwftcaF8LiNzkUtnJIdORHYqdHz+LLAph/vWWnpriEj7KM
        v+osOhvwwhLj855WTU8VQhJR1Em5
X-Google-Smtp-Source: APiQypLScew1HV9d58JnJo+fIFvrUAifm/+c2maRYpw4V4e/9zR/i+XAEA16LeZDFr5uDEASWZq8kA==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr21757744wmk.112.1589302263220;
        Tue, 12 May 2020 09:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm25791378wmh.7.2020.05.12.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:02 -0700 (PDT)
Message-Id: <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:51 +0000
Subject: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

The CMake script now checks whether st_blocks is a member of struct stat
and set the compile definition NO_ST_BLOCKS_IN_STRUCT_STAT accordingly.

The check for whether ICONV_OMITS_BOM is also added as requested by Danh.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4353080b708..975791c8b89 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -22,6 +22,7 @@ project(git
 include(CheckTypeSize)
 include(CheckCSourceRuns)
 include(CheckCSourceCompiles)
+include(CheckCSourceRuns)
 include(CheckIncludeFile)
 include(CheckFunctionExists)
 include(CheckSymbolExists)
@@ -128,7 +129,7 @@ if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
 	include_directories(compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
-				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0 NO_ST_BLOCKS_IN_STRUCT_STAT
+				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
 	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
@@ -280,6 +281,11 @@ if(HAVE_CLOCK_MONOTONIC)
 	add_compile_definitions(HAVE_CLOCK_MONOTONIC)
 endif()
 
+#check for st_blocks in struct stat
+check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_STAT_HAS_ST_BLOCKS)
+if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
+	add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
+endif()
 
 #compile checks
 check_c_source_runs("
@@ -344,7 +350,6 @@ if(NOT HAVE_REGEX)
 	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
 endif()
 
-
 check_c_source_compiles("
 #include <stddef.h>
 #include <sys/types.h>
@@ -368,6 +373,56 @@ if(HAVE_BSD_SYSCTL)
 	add_compile_definitions(HAVE_BSD_SYSCTL)
 endif()
 
+set(CMAKE_REQUIRED_LIBRARIES ${Iconv_LIBRARIES})
+set(CMAKE_REQUIRED_INCLUDES ${Iconv_INCLUDE_DIRS})
+
+check_c_source_compiles("
+#include <iconv.h>
+
+extern size_t iconv(iconv_t cd,
+		char **inbuf, size_t *inbytesleft,
+		char **outbuf, size_t *outbytesleft);
+
+int main(){return 0;}"
+HAVE_NEW_ICONV)
+if(HAVE_NEW_ICONV)
+	set(HAVE_OLD_ICONV 0)
+else()
+	set(HAVE_OLD_ICONV 1)
+endif()
+
+check_c_source_runs("
+#include <iconv.h>
+#if ${HAVE_OLD_ICONV}
+typedef const char *iconv_ibp;
+#else
+typedef char *iconv_ibp;
+#endif
+
+int main()
+{
+	int v;
+	iconv_t conv;
+	char in[] = \"a\"; iconv_ibp pin = in;
+	char out[20] = \"\"; char *pout = out;
+	size_t isz = sizeof in;
+	size_t osz = sizeof out;
+
+	conv = iconv_open(\"UTF-16\", \"UTF-8\");
+	iconv(conv, &pin, &isz, &pout, &osz);
+	iconv_close(conv);
+	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
+	return v != 0xfe + 0xff;
+}"
+ICONV_DOESNOT_OMIT_BOM)
+if(NOT ICONV_DOESNOT_OMIT_BOM)
+	add_compile_definitions(ICONV_OMITS_BOM)
+endif()
+
+unset(CMAKE_REQUIRED_LIBRARIES)
+unset(CMAKE_REQUIRED_INCLUDES)
+
+
 #programs
 set(PROGRAMS_BUILT
 	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
-- 
gitgitgadget

