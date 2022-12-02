Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D64C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiLBL3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiLBL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B173D4ADF
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z20so6029185edc.13
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SaaH49a18XvqwROcN7BX6dn5yt2Y9QtpQm6OfN6SV4=;
        b=jIT77XCr2LPXCCGfqZK5OJ+6bmnRZhconJ5ltCO+blAZkPcdWZHnkZApRY5NtE9Klt
         ommglG5FoLKXJroR2qoqqpUZd4zcFvmch9liqul/GEOpRX+c7yo+eA/jjFJ53Cxy++Ki
         R/P6X0PmqiJwPB3q6l426i7oFligAJsGm97yWFqCC06k7cBzzDy83an+J1Eh7pxRjZxa
         KnOer5jUCNHc0iJypg1jG6pQz5iyIXzA4AIy858oj6Roj4t1K5l2eXNwtqy0EcRJE0Jh
         Y3vEl2ilmb7A5wRgYUKWtV6mCoNQwW7RJKAiIWoZkLleVwMpg0LK4PCTvBo9FdSHIoXa
         5Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SaaH49a18XvqwROcN7BX6dn5yt2Y9QtpQm6OfN6SV4=;
        b=zrATZeiwNUimF1ji77CFNTejByuHS3GzPsM7ufEfnvDpnUUyjF84YbbpK63gqr1n1Y
         iDi5nnuf2E4xC/5HMPn8zPJ9QFu0xhSlmLZbD9JnaMPIvNuAUnjFQ9+7nQE30HZnFm2i
         my3i2JdxnuJUKoiZ2roWeMbsevEMHnJwHNbIfBTeCywGF26xKyf6+Y6EOFboL+1cayXl
         xKiM2G6hYYHk6tpgV1S7ts8X0vAA9Kn5/2CqG5AfNiLs0x9RmLHFZ0SjcGvMMJQYtW6h
         lCkrK9/a+53IBuQqo6OISpa6Y/zZxp2rBoe4E5aYNnjii233o5T9IRqh9/M1CNWy/XHk
         jypg==
X-Gm-Message-State: ANoB5pl2SY02+CJvHe4ws2cC/9/4NnJKz2ji8+YT3MNLIocJYjzI5S1g
        q2v/Wcx/U9ZaXHVkYb3NV9CGDZG+wAWwtg==
X-Google-Smtp-Source: AA0mqf5FfTbS5+Cn9CB2rV8Ijzgy4Jb7h7Nwvj3OOIydqRsNaCiHNEcQReWxkLMW9NEUiMbUclG87g==
X-Received: by 2002:a05:6402:10c4:b0:467:7827:232 with SMTP id p4-20020a05640210c400b0046778270232mr65994111edu.268.1669980535487;
        Fri, 02 Dec 2022 03:28:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/15] cmake: only look for "sh" in "C:/Program Files" on Windows
Date:   Fri,  2 Dec 2022 12:28:34 +0100
Message-Id: <patch-v5-13.15-7a5dd684d40-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guard the finding of "SH_EXE" in "C:\Program Files" with a check for
whether we're on Windows.

This Windows-specific code was first added in [1], and later expanded
on [2], but since some of that was added this build recipe has been
made portable outside of Windows.

1. 72b6eeb81b1 (cmake: do find Git for Windows' shell interpreter,
   2020-09-28)
2. 476e54b1c60 (cmake: support local installations of git,
   2022-07-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 712caffe8f1..da47d9c8397 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -138,10 +138,17 @@ if(USE_VCPKG)
 	set(CMAKE_TOOLCHAIN_FILE ${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake CACHE STRING "Vcpkg toolchain file")
 endif()
 
-find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin" "$ENV{LOCALAPPDATA}/Programs/Git/bin")
-if(NOT SH_EXE)
-	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
-			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+if(WIN32)
+	find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin" "$ENV{LOCALAPPDATA}/Programs/Git/bin")
+	if(NOT SH_EXE)
+		message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
+				"You can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+	endif()
+else()
+	find_program(SH_EXE sh)
+	if(NOT SH_EXE)
+		message(FATAL_ERROR "cannot find 'sh' in '$PATH'")
+	endif()
 endif()
 
 #Create GIT-VERSION-FILE using GIT-VERSION-GEN
-- 
2.39.0.rc1.981.gf846af54b4b

