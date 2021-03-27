Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE8C433EA
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672536198B
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhC0XGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhC0XGa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:06:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069BCC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so9120700wra.2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zYrVP6IDFHlUPnzgKlGqYKbYIHQcNhsU+1TSWXFUAWQ=;
        b=o7XrSyav0hTvzxgbFp5k4gfMYIAs71saMELpzj63gqCZJtiiJVnBkjKKS/uXot9/G2
         Rzz4AMPiBDx0fZKmekDmJ/ElV42km6Xhz8YzwYdyT3iB7yAn1YD0thRvgT5X9EtJPtAy
         5tsgsjB1Tlui7tgD+H0njgM+E90Vl6ZXqrb5Cof9Y3GDlq0fWNkHH0TdTn20fxXBvyUo
         XVyI3J+JM8betJKwNSvN6ESAq5SxxfrY1FfJVFxhc/74O6IyrvwZnM+PGCZ5s3qV4Bkl
         LJnn24+6fJh4PxowavklR3RQs5rxwvgSM2AOOHbTPjZViLUS2e2XgQNNlxNKg+4sytJw
         ZWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zYrVP6IDFHlUPnzgKlGqYKbYIHQcNhsU+1TSWXFUAWQ=;
        b=tQ1vg1aVrM/GDE20hHIZorHJJL5cgtpwqJV/lFCa32caM1wyirL65i7IIx40ZV50dS
         X4Ww0bEjRDqMSd6L/Pd5e+uabOMOo/+itNAaR1atlXXtts3ivPh5zgaJXWjCF628tG55
         Jd5UEoFjqpXIhoWXJlz/j/6RRnRiAiu/RTD9r8ROmpnG0vVEBF+ny1dXAlSY/Fs9e5Vy
         0z42BX8V95Bw+moTUwkKqcroSL9htawuQo2ZLGx1ywHOIM5HZPykFU60O9S+BTshedrp
         kk/NDzUXSw6SCeXLJy5iLv2OpYQzi0kUNlpApHmiR6s2/DmEiEuev/95HShMpaZvNDw2
         QpMw==
X-Gm-Message-State: AOAM530yFJCh0GGMQWgH5HF6aI9zypegcAmfdUzliwKgCaJ5M9cLmlLO
        kykxVEbAwl82m8vdlbuP2wTZGRxy42k=
X-Google-Smtp-Source: ABdhPJwfqvOxytYWUHHSrGsTqJ7wEEMpwXwkhakjPKnCYaAb1g8L7tIqIiGClDaRVmWSTAr5i6O9Yg==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr20994000wrc.138.1616886388800;
        Sat, 27 Mar 2021 16:06:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm21625072wrx.7.2021.03.27.16.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 16:06:28 -0700 (PDT)
Message-Id: <69856f278645ebe1a9779aaa0a6894db33e22b3a.1616886386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.git.1616886386.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 23:06:23 +0000
Subject: [PATCH 2/4] cmake(install): fix double .exe suffixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

By mistake, the `.exe` extension is appended _twice_ when installing the
dashed executables into `libexec/git-core/` on Windows (the extension is
already appended when adding items to the `git_links` list in the
`#Creating hardlinks` section).

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 12c40a72bfff..da2811ae3aad 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -832,12 +832,12 @@ install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell${EXE_EXTENS
 
 foreach(b ${git_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
+	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
 endforeach()
 
 foreach(b ${git_http_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
+	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
 endforeach()
 
 install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
-- 
gitgitgadget

