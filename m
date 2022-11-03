Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A381C43217
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiKCQmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiKCQkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B82DC0
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q9so6949336ejd.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF64uTo1eqtsOZs7T+Fet+viy/MkLGc/Inw/RZRunTo=;
        b=Mb36/NsBQkDmHjquuBow4XB3kf15a2MYnw2rYx5QajYfLjHnZ5RT9QEgF210pTRGrr
         4Y2Wa/ufIMWFTkse1uvZbPVp9NX+to9JVpsoqRFtBSIuTCpHr79dWk3d8QVF9FG95wGr
         9tOjpTbUYmWpo4lEAgR52wsNdIGn4fAcLoJLF/BEW6jNulH8DDnvXGNPxcXYR6eRUbNV
         2yIpgBZQgTMWr6SKQuT5u93bR34k8sq/Uu1iKeseBJLVB04XBKm4tT9F4f1IDYIn3yz3
         anSuRtBbRCEaeoWYvTj3yVyrQxnAVzvntlpPJMuUNeoUObEO1rnupty7rT8azpH5WW6m
         E8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF64uTo1eqtsOZs7T+Fet+viy/MkLGc/Inw/RZRunTo=;
        b=dnpWYZFn6a0cng5iPUazDCfJGxBNXCMFUMSy1QS215jm0MlFmv5LZMSnSf0K2GnbDB
         Ur2aAmjSipnGvpEvUBicrB6iO6zUi1cPg4pPJP/5y2myXiLCUSFVhuIuOP/j9H9aGhZQ
         6+E9VfRRu+G6qvWvM9LxdPLO4nPMFOwjl1/XrhjXsQSolqH26uq/kieQLHQRdEI02Yiz
         y/vi41skHQQmxxei/DduUGTRmdFmlbmxcDcwoS8a/IEjyy5+ztAIQR0X3wewfeAo3fes
         IgNZj9wOl4k1XU1PmsP1ldYdA1bEsKn+AGZTBJMwkSv7fLxh9h1pVvIF5NcDqENqG3lX
         JjMg==
X-Gm-Message-State: ACrzQf2bfeD3T7unwoG0aMMiqgyiF/L0AjB2MHg9e1THHjGOFC8p6hD7
        84YUdJjWWRGqriwI0bfvpAuzD4hto3lKKg==
X-Google-Smtp-Source: AMsMyM7CUT9TS+/vTTuaZduZmlg6rU3tk8fKA/NEc2Y5Zd5GEn00OUnEw81hCkkHm0fF0ng83PPH9A==
X-Received: by 2002:a17:906:dac8:b0:741:545b:796a with SMTP id xi8-20020a170906dac800b00741545b796amr29722584ejb.240.1667493488607;
        Thu, 03 Nov 2022 09:38:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:08 -0700 (PDT)
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
Subject: [PATCH v4 02/14] cmake: use "-S" and "-B" to specify source and build directories
Date:   Thu,  3 Nov 2022 17:37:52 +0100
Message-Id: <patch-v4-02.14-dd934b0597d-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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

As an aside The "-p" flag to "mkdir" in the pre-image wasn't needed,
as "contrib/buildsystems" is tracked

1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0a75898ca9f..463f55e5516 100644
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
2.38.0.1451.g86b35f4140a

