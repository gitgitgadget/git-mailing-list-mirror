Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E0C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiLFCJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLFCJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04B240AF
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i15so10168000edf.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk70038QGUKRvLLL96iHcoMx8OQgkP6oieI2vM16bcQ=;
        b=qubI2IkTkNsJgtiahXUZuQpp+7dLWo/X9mSEVw7ZZfDmBpqvvS4ygBlyufMcuWvwXA
         +FhUc6dQaHFDF1Aj1Ya4+YAnxakLMmYayI1t76bKY6gCrs40ndpuMiOvI5mvZsgQrMQ1
         CBnmVaqYko6w4+hifiernN13G4RWudSrjjx/c5Qc2L9wGAm4pP2hYmmd9YT4Z0aErnSE
         LaSmpRs16o/QElhpe9yPV14zptuXogRZ+omI5in7svr4Dw1b0l9DPujzN6MNsMf8wXhm
         8Io95oZic4AZox5QFTtRACVu7WWBX53o98YRRWt/dSs5bsJVNEVGRN7BNTSLFKYKfrva
         EUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk70038QGUKRvLLL96iHcoMx8OQgkP6oieI2vM16bcQ=;
        b=tuTvyBZRvN8e3k1GA0r9T6gGj6ue6WgyvSZ5IhZbJrrzU5Yv5Ifo5Lk1fnduoYMn83
         9TBQsl6ux52MfMitjvLLnMS4ycr5VmzJCttAm6jmwtVJwCbynaXbD5YS+9pBRcKDuZwi
         j0qC1XxSY6SmdiqdwapO4pJaDrta+J/hkfhPpTZ382LjuYsZ/3k7t+Fq1UBRaYi2k0Yz
         6+zPvOMtnMePZoWpZrytaGVwjnKFvxwWhoNK11FGy3vPd/9ZMVkFsGF+IASAcxwewcZ4
         iFAzemAeglIEBpTSMTcyotMTt9hrDn3XfLbrT9Z/sWZZzwCAqSxXc6Yrf/mJ3nd5x7ia
         hl/A==
X-Gm-Message-State: ANoB5pkn28pE2fUf9XDA461PM3WbX3E4MV4kkh7hhCMtDEpuvXeAmBlh
        HiUklI/9kYBhOJEGKj3yJX1VJj+DEhC4eA==
X-Google-Smtp-Source: AA0mqf585oW4pv7GdwWg8v/c8KdP8OqO3ftVDzNAGiLZsnvZuKZUEhOCHlNTAxYLt7IHnCYUl61S0Q==
X-Received: by 2002:a05:6402:5406:b0:467:4b3d:f2ed with SMTP id ev6-20020a056402540600b004674b3df2edmr59232271edb.101.1670292569632;
        Mon, 05 Dec 2022 18:09:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:28 -0800 (PST)
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
Subject: [PATCH v6 02/15] cmake: use "-S" and "-B" to specify source and build directories
Date:   Tue,  6 Dec 2022 03:09:00 +0100
Message-Id: <patch-v6-02.15-1a11aa233a3-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than the multi-line "mkdir/cd/cmake" recipe provide an
equivalent one-liner using the "-S" and "-B" options, and then suggest building with "make -C <build-dir>".

The rest of these instructions discuss e.g. running tests from our
top-level "t/" directory, so it's more helpful to avoid changing the
user's current directory.

The "-S" and "-B" options were added in cmake v3.13.0, which is older
than the version we have a hard dependency on[1].

As an aside, the "-p" flag to "mkdir" in the pre-image wasn't needed,
as "contrib/buildsystems" is tracked

1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8f8b6f375f7..5b22a9b217f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -16,9 +16,7 @@ though, therefore the `File>Open>Folder...` option is preferred.
 
 Instructions to run CMake manually:
 
-    mkdir -p contrib/buildsystems/out
-    cd contrib/buildsystems/out
-    cmake ../ -DCMAKE_BUILD_TYPE=Release
+    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
 
 This will build the git binaries in contrib/buildsystems/out
 directory (our top-level .gitignore file knows to ignore contents of
@@ -36,8 +34,8 @@ NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual St
 this option is ignored
 
 This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
-Run `make` to build Git on Linux/*BSD/MacOS.
-Open git.sln on Windows and build Git.
+Run `make -C contrib/buildsystems/out` to build Git on Linux/*BSD/MacOS.
+Open contrib/buildsystems/git.sln on Windows and build Git.
 
 NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
 to use another tool say `ninja` add this to the command line when configuring.
-- 
2.39.0.rc1.1006.gb4c675778ba

