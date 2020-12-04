Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1515C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A79B22C9C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgLDTej (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDTej (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:34:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7FBC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:33:59 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so6386415wmc.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RiEN+Fpx8toneKn962EXutrFyieFsMuMtcvLdXRbZiY=;
        b=Dua0DM8SlZZiK6+getK+U+5XCwzZ2NETGsKIxPvCcpRV0ZFiiYzdvcafkX/oSqMbUA
         z5bkrt8JYTSS9W2bYjwDyn+cBI0axngLs0GLm9SQUG/o5+NmxKV0e+DVjfVljfchob6h
         vyPfU2vSpyI231HUM56VP4U8smYX+8Tu25wtPCQ//fMbCOi6uoOIn19hsoMaHA/LhBf7
         uzEf/Evc3FQUUe+Wh/UEkLLkgAIEQvRfTBZP+Zm8M42ysEV5Iycpv0pGGEkDM3xOJ2yH
         /lipQxBMGtrau3WY80oPUmBEJ6Lye98JXOjnMXWJdVJqe3VcNvAI3Owmv/naQeR+Ls0N
         tM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RiEN+Fpx8toneKn962EXutrFyieFsMuMtcvLdXRbZiY=;
        b=FprRcZZT+QAQz/fscxnzzj691AG/SJm0ZqX5ENmEELbQSTREuCCL9IcXyTkV3rh3NB
         OV7zkh1Oi12cU+V9sG9coh1cZ8TEYGjCp67ZQJgMQaXccBU5XgA+50igE+gknrvOwnDE
         XXumtJkfrbFvR8RwtV2zhRMddZyfaMCRiGWpmdiVaCWWxaJJdJMsMY00cV4CEic8YROG
         dtHOA+mkzbOqGE8wV2FrZSr1CurI6eMjup4oxP/c6VZmPnESTFSHJ60K52LzpndCrWwF
         XNsNvQmN4zhXUfzHrFcidLpfob13u4kOlaa1rVT1Xnqcoe1HuuMSUP/w683GTt0yh9ui
         bO5g==
X-Gm-Message-State: AOAM533Ifu2ZH4fLuEbXYrqgbVleYrNeSMfF4Q7pm8ZYhywOfDrbq5q0
        rf76q74qrpAUvg9k0G4x0ZcssLSawzo=
X-Google-Smtp-Source: ABdhPJzDPgDxI5BvVwbnES3Rxk3+DXzIYOOQa9v2Xg0eD2LdxP1N8/a+dp35vqzmV7TZqJ7ilD/OFA==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr6023850wme.168.1607110437647;
        Fri, 04 Dec 2020 11:33:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4sm4080513wmb.47.2020.12.04.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:33:57 -0800 (PST)
Message-Id: <pull.807.git.1607110436367.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 19:33:56 +0000
Subject: [PATCH] cmake: determine list of extra built-ins dynamically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 0a21d0e08902 (Makefile: mark git-maintenance as a builtin,
2020-12-01), we marked git-maintenance as a builtin in the Makefile, but
forgot to do the same in `CMakeLists.txt`.

Rather than always play catch-up and adjust `git_builtin_extra`
manually, use the `BUILT_INS` definitions in the Makefile as
authoritative source and generate `git_builtin_extra` dynamically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: fix the vs-build job after adding git maintenance
    
    Together with https://github.com/gitgitgadget/git/pull/805, this should
    fix the vs-build job in the CI build of seen.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-807%2Fdscho%2Fcmake-and-extra-builtins-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-807/dscho/cmake-and-extra-builtins-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/807

 contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index df539a44fa..c151dd7257 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -114,6 +114,16 @@ macro(parse_makefile_for_scripts list_var regex lang)
 	endif()
 endmacro()
 
+macro(parse_makefile_for_executables list_var regex)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+= git-(.*)")
+	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
+	string(REPLACE "git-" "" ${list_var} ${${list_var}}) #strip `git-` prefix
+	string(REPLACE "\$X" ";" ${list_var} ${${list_var}}) #strip $X, ; is for converting the string into a list
+	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
+	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
+endmacro()
+
 include(CheckTypeSize)
 include(CheckCSourceRuns)
 include(CheckCSourceCompiles)
@@ -673,10 +683,7 @@ if(CURL_FOUND)
 	endif()
 endif()
 
-set(git_builtin_extra
-	cherry cherry-pick format-patch fsck-objects
-	init merge-subtree restore show
-	stage status switch whatchanged)
+parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
 
 #Creating hardlinks
 foreach(s ${git_SOURCES} ${git_builtin_extra})

base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
-- 
gitgitgadget
