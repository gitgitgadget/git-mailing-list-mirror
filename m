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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B06C433F1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB5F6196B
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhC0XGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhC0XG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:06:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF91C0613B2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y124-20020a1c32820000b029010c93864955so6659178wmy.5
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mBomVH3n81sCIinB/7VwuVE+KhoqAwdBvQfxo7+GDEo=;
        b=UuJQjAHdxRrid3IUvnGvukxq32I8eCkEVwdC2jDT2uLgbCuF1RIYRC+mgm689I04pu
         TQr6hfuTWSPS1SvMCrc6ujkPAuf1a07koOo/Llt37/chzRFrXGXZ7aAHRqdvxjXeXwJ8
         NP4S9tC60+E/11Iac3BcFhr5m8ZxmQ1LCGW7zT71MMW7CR+E43oOjsn6gCTUGFgcss0w
         VVdI/QrJZLgKO7lFjJm8V6pifXn+HsmecaBgWipaSGkAx03lqu4b2CGwEGeQclam/q8l
         n3x0XB4d6h1TausE2Q2P++NsTUHI/Mjd5JoZ5bODSy6aHf6HFMGuisMirumWBj7lrxjx
         ySwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mBomVH3n81sCIinB/7VwuVE+KhoqAwdBvQfxo7+GDEo=;
        b=rOrDrQvpKqCyhzB5XON60a5T8dUdmy+TbpTTRNdmkYo8jv65CGscY5tU4sI35HUjlz
         GyKjdKf9G6u5xaMvwNl6laKyyzDAnfNdvwTZRJLCoM5ZfvKPwLWHU2KgrbgOopTxhu3M
         kA0dkQ82SKU9bXKrzqcZFzUlqyI7nNfbtsSxjBWe2YmN3e57YAdpYqAlT3RqeWqbsWjs
         7P0s7icdURndB1pthH00pxslpFhuFKUwMswpJIgPcad8a60uJOMvwTQKY1HIOnfemMnu
         P8GtqU/iQi94Vtphd9J5/j5wAsgOOJ5cH3nk79lEuHGG9JhM19IQPYmx2wQVuq8mBqq1
         uP3Q==
X-Gm-Message-State: AOAM531tdHtvuylWjrvkbjBhpTJ/owfQxI5BMkZzJN8OC0R024VdMyQS
        g9S7arGYSmtKiTwjOvIr4rUk0qM1Tkg=
X-Google-Smtp-Source: ABdhPJzF73M/buEXHCYDoaCWYcWMvwxwP/pOsFDOvSGODSoAGBQhGhX1sXCTcL+Zo7itxc33lLqBQQ==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr19000676wmq.168.1616886388219;
        Sat, 27 Mar 2021 16:06:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm19419793wrr.78.2021.03.27.16.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 16:06:27 -0700 (PDT)
Message-Id: <ff7e8121d7a47e318954c2c115f281b56f8be21f.1616886386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.git.1616886386.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 23:06:22 +0000
Subject: [PATCH 1/4] cmake: support SKIP_DASHED_BUILT_INS
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

