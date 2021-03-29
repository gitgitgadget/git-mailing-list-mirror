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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE43CC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFB961934
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhC2Mlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhC2Mlt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5EFC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j9so10989478wrx.12
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mBomVH3n81sCIinB/7VwuVE+KhoqAwdBvQfxo7+GDEo=;
        b=F+pTuVMvd6+Q+uuUIeElb/Kw9sIb1dBmThsMOB9yMGrmOt1QbguS99ejhDJb4mcCfk
         HcZY709FFCLusp7J7EHs1ixbglEEd0E2voYmUA2oB82p0f2YPbRU6VFmZfV5pa90fy79
         oROiZFRPRBpwTZU1C6rsjn2CSex1AL8S7lCpX65IFryJkHluHJXzwd3XB9ADWsTtV/iU
         aZCKMnJh2YSQUN+MKwDev3LIxew1ZtWsZeIfyACpctrB8XdZ4rFZw4fXhdH3Nfq/Ifln
         IZjkTmHzUM10Fj3SSw86w5OkSUmVBTnKpFyuf/5bcN5QZCwKs3VpWrvEY2/OgDIg8f/x
         DMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mBomVH3n81sCIinB/7VwuVE+KhoqAwdBvQfxo7+GDEo=;
        b=BkGF0Ix0pxn0BLeMlamUfcxd0A95KDqPCOYET05j4dMr2WTmUXMOUj/x+LxLiO4/Fy
         k/igL5N9+m8EU9ji+/w+r2qlrQg51r72kP5jE1ZkjeB/2hM4p7LifcPwO1GpSCp8ky0U
         /nIujma6s9oMZBHkAJnQ+CNf+fxaFFn8kvtRpf1pJu0a8OrNlIFuqvMy/8jOzTvnuDjJ
         OyIKa31I1js63UEFNzsMAm0yK9lzHINS4b5/ApFS0cpV286gUeDhTdyN4E7MYZ5kTgXL
         ac7haJZNYsZNWFqYoau0YC6tLI1FOof818yb+qcJA2OS1GgIzKbTo9MtKqp/7FAnfmHZ
         zjyg==
X-Gm-Message-State: AOAM532HL1o38zQJuJ2+TJryzjd57wuMXnVADAumm/f6KrPWE1pMV+7j
        RbpgqvkbojTtotF9hov8f9kcykeYJoU=
X-Google-Smtp-Source: ABdhPJx4jHUQLsVarYgOaH56nDBWz+UIwqypblvDt127awTOv6EyCzrxpFdF3A4AU/3XFby4Kauluw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr28523092wrq.143.1617021708133;
        Mon, 29 Mar 2021 05:41:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm29484020wrt.21.2021.03.29.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:41:47 -0700 (PDT)
Message-Id: <ff7e8121d7a47e318954c2c115f281b56f8be21f.1617021705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
        <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 12:41:42 +0000
Subject: [PATCH v2 1/4] cmake: support SKIP_DASHED_BUILT_INS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like the Makefile-based build learned to skip hard-linking the
dashed built-ins in 179227d6e21 (Optionally skip linking/copying the
built-ins, 2020-09-21), this patch teaches the CMake-based build the
same trick.

Note: In contrast to the Makefile-based process, the built-ins would
only be linked during installation, not already when Git is built.
Therefore, the CMake-based build that we use in our CI builds _already_
does not link those built-ins (because the files are not installed
anywhere, they are used to run the test suite in-place).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c151dd7257f3..12c40a72bfff 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -685,13 +685,17 @@ endif()
 
 parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
 
+option(SKIP_DASHED_BUILT_INS "Skip hardlinking the dashed versions of the built-ins")
+
 #Creating hardlinks
+if(NOT SKIP_DASHED_BUILT_INS)
 foreach(s ${git_SOURCES} ${git_builtin_extra})
 	string(REPLACE "${CMAKE_SOURCE_DIR}/builtin/" "" s ${s})
 	string(REPLACE ".c" "" s ${s})
 	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git${EXE_EXTENSION} git-${s}${EXE_EXTENSION})\n")
 	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s}${EXE_EXTENSION})
 endforeach()
+endif()
 
 if(CURL_FOUND)
 	set(remote_exes
-- 
gitgitgadget

