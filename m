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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CAC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D2F61090
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhIWGEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhIWGEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 02:04:54 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDFC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:03:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a12so3535901qvz.4
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cR4BReCy7FJ42yfR9twDYPKEc1uByneblC9xfIqUI+s=;
        b=dE9jf9KJBbqoaxRP70+L6CA0CqATKRET5A7x2XkzXjC8F3FKvnpV/U4xNb5d9wkxbn
         YCvcEv0EeqE4XY4gEjU/Dc4dpJglWiH3pmDxvBg8jmyoVd6+SKaTSZNahlxeXOYo94xL
         2piPYsRLCuzpkeS6FoueVsJhjJ3ojzkk1st0hqKf6lcMERC0SUnxrGjieV342EB6hWml
         Pyp+FRVayFE0MYo1Gs78DlRtcBkmRzpTBOcEHsYOcmr4CwK7Kyxj1jSo9mrpjKlrtYEk
         qg/IEH8FIA3ZdkLW+/ZXIYGb3WjQ63Hkv0uOE+KO21sCvdUlo/uqkau+u4s+Yo0d0KMd
         Btxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cR4BReCy7FJ42yfR9twDYPKEc1uByneblC9xfIqUI+s=;
        b=g7JXWnJ50JMAnqKIZAxbH0yysa6lgP5gHfoP/Od80plDqxIMOtJduJC0P/TWyDipKw
         WJi2rZr+ZnSYbj+EoSokays7XVGB9aui3w2h4pn3HYLcB+WwkugeGEMby126MdnffcNz
         VOMy80UfoXeJcyOo1KbBNSBXCduYXPgx+bgWWXiUUR+4Fltg2moMLZ2sg6ielVDjZmuX
         638oJYIldJ0YoKExPTzc2PkVgEqiOT0sNPnRzxT2pIuDhdPEtBLetFb0cYj3u882FXOr
         kiBCsUctLYHnSkOWA1Xd+JndXU2Vrfa1p4jwS1kqCITdtcUtakgw5agERnAHlnG56FZf
         tFnQ==
X-Gm-Message-State: AOAM530CLQfnCjlOw6PlWZ+MRR3p/xnV9mMg4o6/33HYEFc7f26FsusL
        HN8tlJvWz44wUnJRZarRNc5Vt4ReBS8=
X-Google-Smtp-Source: ABdhPJxEMGmx5clTOk2oXyOu0l/pGCupiWwE5uddClvqFIkGHHh2r486IAFrac4oObZLFIt5gGymFg==
X-Received: by 2002:a05:6214:1394:: with SMTP id g20mr2493752qvz.21.1632377001531;
        Wed, 22 Sep 2021 23:03:21 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id x3sm3395256qkl.107.2021.09.22.23.03.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 23:03:21 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] lazyload.h: use an even more generic function pointer than FARPROC
Date:   Wed, 22 Sep 2021 23:03:06 -0700
Message-Id: <20210923060306.21073-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.911.gbe391d4e11
In-Reply-To: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
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

Additionaly remove the -Wno-incompatible-pointer-types temporary
flag added in 27e0c3c (win32: allow building with pedantic mode
enabled, 2021-09-03), as it will be no longer needed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/win32/lazyload.h | 9 ++++++---
 config.mak.dev          | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index dc35cf080b..26c80f7833 100644
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
+			proc->pfunction = (FARVOIDPROD)GetProcAddress(hnd,
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
-- 
2.33.0.911.gbe391d4e11

