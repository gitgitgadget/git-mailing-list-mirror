Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E1C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CA96195D
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhC0XHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhC0XGa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:06:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B8C0613B2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so9120709wra.2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w4z13lrFm8eQHtmeqHGeX7tukeDUIH5vi7ZPya4DiIQ=;
        b=ZwmZmdFWXPJBJ3adRUGryvfYBTRHTb0Klk4VsAW/pJkTvDvgohqFh8jlpgD4ZBW+NM
         unmjl8nZjFhDBzK0C0O4YnSpgTueLcObV8AZ2TI6w+JrQg/UIXvcE/xGVjSBBapgWEhi
         yYGHJPATWUldDAjqQtxwroFGopr1t6M7IVfl1JyPTa0ltrZw0ljlZ0dkTBqvP2WnF1KP
         bM/5IStFq+XpQro+kBZiL0DQNEOap2RtSPBj67cMWNjI4ZVM9Nm9/DncHh0y9FLXGKOX
         FTGJhkcCRHgmUd6/LQ1MuTVIyK73d8RxmTE7fQ5tmRlE5mptQZwL/CjxKrFp+kIJ/NeK
         Ld4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w4z13lrFm8eQHtmeqHGeX7tukeDUIH5vi7ZPya4DiIQ=;
        b=Z14CLet/zvM3UOrNUZQZLq641oPE/sE69mkg1TiRtpP5dc72ExBJwL981dg0MLf3v7
         OHMWz/lX5KO3Y6N+mJSQvmdQXp1SZxC2RKEG45Sdbe9n8bWEU1LNmFGRNqNkf0tS6Xu+
         78KGriwksOeBxr/0mlMrSoomRvsHCweH1LAXk8uHAPVczYgsGlXmrwMXBDYMvsGM/Wjq
         eE/HhPfDZis4J4e2kSHY/iDV+WVbL+kCyLgz5O99kYQhfH1ob+7o/elrWZiTuPfNtFZ3
         ttX5ZU8SbvU6SCa7YKe5eXETpBmmu2dnTKHMiXx8InMoqnAwa9OazIGtCoVf6xzbwO10
         IK6Q==
X-Gm-Message-State: AOAM531B7xc8McN5MCuGhc8fuZSb9iLq2usDX2qvmX9Uy2gSFlmUSICG
        jgnAFl7XSvoz+mn+LIIM9Dt2+IegzdQ=
X-Google-Smtp-Source: ABdhPJw2HQz3PC1J9uLlRgz08PIlZIvt6eMRNlQ1whiWQSrBYFvoTJIz3GR2+49LtxW1vhGPbGELbQ==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr20854307wro.11.1616886389306;
        Sat, 27 Mar 2021 16:06:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 81sm17891465wmc.11.2021.03.27.16.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 16:06:29 -0700 (PDT)
Message-Id: <543fd0f5d7e5ee297364d1d28091f2004a35f2d0.1616886386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.git.1616886386.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 23:06:24 +0000
Subject: [PATCH 3/4] cmake: add a preparatory work-around to accommodate
 `vcpkg`
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

We are about to add support for installing the `.dll` files of Git's
dependencies (such as libcurl) in the CMake configuration. The `vcpkg`
ecosystem from which we get said dependencies makes that relatively
easy: simply turn on `X_VCPKG_APPLOCAL_DEPS_INSTALL`.

However, current `vcpkg` introduces a limitation if one does that:
While it is totally cool with CMake to specify multiple targets within
one invocation of `install(TARGETS ...) (at least according to
https://cmake.org/cmake/help/latest/command/install.html#command:install),
`vcpkg`'s parser insists on a single target per `install(TARGETS ...)`
invocation.

Well, that's easily accomplished: Let's feed the targets individually to
the `install(TARGETS ...)` function in a `foreach()` look.

This also has the advantage that we do not have to manually cull off the
two entries from the `${PROGRAMS_BUILT}` array before scheduling the
remainder to be installed into `libexec/git-core`. Instead, we iterate
through the array and decide for each entry where it wants to go.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index da2811ae3aad..a166be0eb1b8 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -811,15 +811,19 @@ list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 
 #install
-install(TARGETS git git-shell
+foreach(program ${PROGRAMS_BUILT})
+if(${program} STREQUAL git OR ${program} STREQUAL git-shell)
+install(TARGETS ${program}
 	RUNTIME DESTINATION bin)
+else()
+install(TARGETS ${program}
+	RUNTIME DESTINATION libexec/git-core)
+endif()
+endforeach()
+
 install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver
 	DESTINATION bin)
 
-list(REMOVE_ITEM PROGRAMS_BUILT git git-shell)
-install(TARGETS ${PROGRAMS_BUILT}
-	RUNTIME DESTINATION libexec/git-core)
-
 set(bin_links
 	git-receive-pack git-upload-archive git-upload-pack)
 
-- 
gitgitgadget

