Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD8C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLFCKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiLFCKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:10:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C324BD2
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m18so1275179eji.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oWX0AvD7Igjh+Ey8Euv0CCxaToxr6+bB0B5AWnxct8=;
        b=mAPhkhLVpiII1tp1IMkdDiq6KyDgVLBVblbbh5gpuJgMqXDAfNfM9N2I+VMZvJ+9NM
         WG+GxDojmuuyqEk4Yy/oydhJEsxp3FsU+jWqA/gR17RkukchbsoaOWI/Jppvks9crGog
         MVPCM9TDrsyysapJ4u2GvlMGmQTcQFnsaPCIKdqCvQyx2R2M6OIVUEcOqsr941vM+tw6
         AcJhUaTIwUclLKDJU4IB6Vz7PCTJ7eSzf7vGyuG5//pOOweAoQpPU/cCGkJ8j/G6HXfS
         QJ3LKZV67JchuKrC9H0CNUkOHILA69r0DeV2kAwgsu62OoqwFZU/tgfCNEHXUM3Vh+ee
         +RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oWX0AvD7Igjh+Ey8Euv0CCxaToxr6+bB0B5AWnxct8=;
        b=5ikDxBqADEzGUsKU7wXmP7Nzwvc2ZQ8Iu/u7KM7qQkh4UuAZBmJj+srf0HLgJy+i/y
         fmtaHFVZRsutEEptTCApxhTsVzNyGRhMMcfpJdJUfCA2D9WnfVJZKhHoZmHsZdG4QC0m
         06csalHuxeWe/bbWBaEvKxdtNTKdorv7yIh49nndamSZmDa4v6LfRII0NN9Dxn2Gb4Ud
         TQMUW3oXSrj/OjITA9DIzIZZYnSB7Gsmgw/u8tPSFdGjPyIcEc+2qRxckgqyVQdcDFkU
         FTrSdYIyG09rkRiTuxSXR6zcBIK9wwSBX5jP1n4nG/p/FbOFkXgcjJJ6wP6GzRp90jOw
         n1Eg==
X-Gm-Message-State: ANoB5pmrVIMfI0gORwl/LXWGKIlzWZc5bB5GOdM8YS/y9SXXIF33272w
        Wh1uQr+qS9IT3BtLJAQd/CEQv60NCPSt0Q==
X-Google-Smtp-Source: AA0mqf4sd6mLpqqojBorwf5IocHzx1AP/8m6hhhI3sWRsFIJRTCE1EKUQRm/0VqniLlMFLnYi+wpew==
X-Received: by 2002:a17:906:7d13:b0:7bc:addd:2c54 with SMTP id u19-20020a1709067d1300b007bcaddd2c54mr31181244ejo.24.1670292580518;
        Mon, 05 Dec 2022 18:09:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:39 -0800 (PST)
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
Subject: [PATCH v6 13/15] cmake: only look for "sh" in "C:/Program Files" on Windows
Date:   Tue,  6 Dec 2022 03:09:11 +0100
Message-Id: <patch-v6-13.15-6c6b530965d-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
index 139498c5d5b..9e3e46c93f5 100644
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
2.39.0.rc1.1006.gb4c675778ba

