Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A7DC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434E3610D1
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhIWGy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbhIWGy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 02:54:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA845C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:52:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z12so3587628qvx.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLgEZ37He/o9rerk5wJIzUzXw11dgmXn7gYBxQvaO/0=;
        b=g9/tyuBv+Q43IAIL+phhYyNcky5TklIhWU8/5KZFQQQ5DdbKmcYSiWMygfkqFCKpAW
         bic5pkbx6W4oD5DDprMoAX5QfkX9Mf8VUe9LK/5AflS+q2r5TrUNa/Gz8KlvRJXwPNfH
         xDyYXRXHYTmIjA0GoBUIdVNwJpbEoKQX14csCN8Sb8ZZe0eSrv7xIVCrXBeT5pAwYi5e
         R9LhMmw7Fxxk140dz0xoAVTE6OCl/qd6GBKm5U4PbJlzFWdRZ2qQmeKhBCaibvYGGVg4
         v43KcFQ7RsOkqxJ3AfBRT6lvk2n6ul3XdzqkcPXKAN2BnZkx/5AWEmdz0gd2htNr8bf2
         b53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLgEZ37He/o9rerk5wJIzUzXw11dgmXn7gYBxQvaO/0=;
        b=LZDZx4TpnyCIoV//k9DUds/MnS6DU7RFp//TerqvijPGyoRmQciObkN7UrODm6q1Mp
         reptmYf3WULdF+cnH9RCd/obUiqXUvaSv5qLYc0zuD5nABeQElvodxW+XoQG5ygjozaB
         14+PqfWE8H4JWu2vLlih4CHg0tH0YB6FVPWEz0W24KYlBSCAEM3IDNgZl0qMN5tGiT0m
         BJbe+K9F6aUKcAG9fXv0JWRmECtu2MhWRiS2SvA7CiTVIM8EfcgewU5A0HjfpPiwlkx7
         YJlPrdfnkHFewW6fv+RZhj8QiE3fmGvl+iDSgylWmLoaYbC08wWwdGkQKHgO2sWHVZgv
         CrGg==
X-Gm-Message-State: AOAM531zVfgHOs4GUASk8dz1IFIhy1HD8kg9s9x2ix4ce0YshM2TPiin
        rZZJDFDX9PhPmOlWaIkkucusyjvDGlU=
X-Google-Smtp-Source: ABdhPJw+2J9YMSiwr2mmQx0iK2R8pWvZiEFVLQl023Mkxs7xojEr657u/d5vOlb6nrV94Mw5YKDdfg==
X-Received: by 2002:ad4:45c5:: with SMTP id v5mr2977276qvt.37.1632379976699;
        Wed, 22 Sep 2021 23:52:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f24sm2896365qtq.25.2021.09.22.23.52.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 23:52:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] lazyload.h: use an even more generic function pointer than FARPROC
Date:   Wed, 22 Sep 2021 23:52:51 -0700
Message-Id: <20210923065251.21363-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.911.gbe391d4e11
In-Reply-To: <20210923060306.21073-1-carenas@gmail.com>
References: <20210923060306.21073-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gcc will helpfully raise a -Wcast-function-type warning when casting
between functions that might have incompatible return types
(ex: GetUserNameExW returns bool which is only half the size of the
return type from FARPROC which is long long), so create a new type that
could be used as a completely generic function pointer and cast through
it instead.

Because of the way the function declaration was done in the previous
patch the order of variables that use it had to be adjusted so that
it is the last variable declared, as well.

Additionaly remove the -Wno-incompatible-pointer-types temporary
flag added in 27e0c3c (win32: allow building with pedantic mode
enabled, 2021-09-03), as it will be no longer needed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* fixes a silly typo in the previous one
* adds more places where -Wdeclaration-after-statement will trigger

 compat/mingw.c              | 4 ++--
 compat/win32/lazyload.h     | 9 ++++++---
 config.mak.dev              | 1 -
 t/helper/test-drop-caches.c | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097..d96fc39bf7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2183,10 +2183,10 @@ enum EXTENDED_NAME_FORMAT {
 
 static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
 {
-	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
-		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
 	static wchar_t wbuffer[1024];
 	DWORD len;
+	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
+		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
 
 	if (!INIT_PROC_ADDR(GetUserNameExW))
 		return NULL;
diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index dc35cf080b..c688e545ad 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -15,10 +15,12 @@
  *                        source, target);
  */
 
+typedef void (*FARVOIDPROC)(void);
+
 struct proc_addr {
 	const char *const dll;
 	const char *const function;
-	FARPROC pfunction;
+	FARVOIDPROC pfunction;
 	unsigned initialized : 1;
 };
 
@@ -38,7 +40,7 @@ struct proc_addr {
 #define INIT_PROC_ADDR(function) \
 	(function = (proc_type_##function)get_proc_addr(&proc_addr_##function))
 
-static inline FARPROC get_proc_addr(struct proc_addr *proc)
+static inline FARVOIDPROC get_proc_addr(struct proc_addr *proc)
 {
 	/* only do this once */
 	if (!proc->initialized) {
@@ -47,7 +49,8 @@ static inline FARPROC get_proc_addr(struct proc_addr *proc)
 		hnd = LoadLibraryExA(proc->dll, NULL,
 				     LOAD_LIBRARY_SEARCH_SYSTEM32);
 		if (hnd)
-			proc->pfunction = GetProcAddress(hnd, proc->function);
+			proc->pfunction = (FARVOIDPROC)GetProcAddress(hnd,
+							proc->function);
 	}
 	/* set ENOSYS if DLL or function was not found */
 	if (!proc->pfunction)
diff --git a/config.mak.dev b/config.mak.dev
index c080ac0231..cdf043c52b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -12,7 +12,6 @@ DEVELOPER_CFLAGS += -pedantic
 DEVELOPER_CFLAGS += -Wpedantic
 ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-pedantic-ms-format
-DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
 endif
 endif
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 7b4278462b..9dccda95b6 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -86,9 +86,9 @@ static int cmd_dropcaches(void)
 {
 	HANDLE hProcess = GetCurrentProcess();
 	HANDLE hToken;
-	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
 	SYSTEM_MEMORY_LIST_COMMAND command;
 	int status;
+	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
 
 	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
 		return error("Can't open current process token");
-- 
2.33.0.911.gbe391d4e11

