Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F277C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiKCQnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKCQkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276CEBF
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z18so3888405edb.9
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWHKWxvqvnJYkER6g5yOQGwRERA49UT0Qky5XxzAupE=;
        b=Hco50JmyzBbGL5/igQY9KZ3geCrOsbJrR2o+YkOMlEvHwxx1/d18YhMm+kBPtf+69n
         V+t/sbfLwHd9OjwWlQ5mXQhjM+zYfs9MIVEF7ullieKRigJan07ukJB5/mv2RJh+1IZl
         D3r1Iq1xJEVa9nmJMrWc51qjn7f6NrGIaqk1jXW01djwNtvAb0w1CtXkYDGmaBfx+857
         aikyg1umnH/gHUFhNG67qi11VT+v6OU98komPuA92NEJ5fJdJcTcdZtspdlloc+H/ApD
         dc0p/w8K+FTKQjyoMOnNHRSUUE16b+/C2pAIXrzV+9ieMENEWEXOC1hx+oZe0kewNEhS
         KPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWHKWxvqvnJYkER6g5yOQGwRERA49UT0Qky5XxzAupE=;
        b=b8vVFWHe7GZFgAYr5FCKpTqTP3RULdyOATyiru2C0m0QEAbTWL9rXIFNBjv+idzRwl
         x+xeVJOagDaz05K+H3UXq6xFGjJ92tJV/8rGg224WPofuhH+HAdeWdHMZ1l4Sd1YVWj7
         lsISC+91mCaMuvchsNCyT+6lAMzHAiyvZ+4n/plX6rOAjiMTaGXYdjhP8MAy81rSuc/V
         4QBMTNXnxA9d9igRY2DzSTpiWCMZBEI8RcyT0es9ZjC39uWGV0S7cnx7YRTgt6T3usPh
         GnOWq+KEqax+1FgOTd/OTY8YzqmWlL/BRruTJmwTJFj6UnMDWls4ibLbF5T8r8b5SUxf
         7i4g==
X-Gm-Message-State: ACrzQf2IYFXMw4+teYPiJCy2cWCY/VwDQDIbsCOS/NvkmJ8jnMTK+UT7
        XLY/1XdKwOxtP2BRrA1BO/6RRJnoaR996A==
X-Google-Smtp-Source: AMsMyM6Lf49ax4w8xgm7eZ49xSXNqNCOVYCN3aRj1zObpgCya+5hMKlyXNwap2Y5hzHzaiXehip9+g==
X-Received: by 2002:a05:6402:3890:b0:45c:2b5:b622 with SMTP id fd16-20020a056402389000b0045c02b5b622mr32196152edb.69.1667493498396;
        Thu, 03 Nov 2022 09:38:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:17 -0700 (PDT)
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
Subject: [PATCH v4 12/14] cmake: only look for "sh" in "C:/Program Files" on Windows
Date:   Thu,  3 Nov 2022 17:38:02 +0100
Message-Id: <patch-v4-12.14-7b1f10eb4c0-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index 2b4e5a2f4b6..88723b971c6 100644
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
2.38.0.1451.g86b35f4140a

