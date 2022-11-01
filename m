Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD1C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiKAWwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiKAWwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:52:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295DC1FFA4
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:52:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so40755482ejb.13
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE4udwG8KmPB/LbfQEK6H2sgJg2hW+Z0nCZ4rMk1tMU=;
        b=Ss8aFuJv1rsypueOl+j2khczfGnSeAWplfBTrRFhjDs2Susw/6qt0sP8UHne3ChgyH
         Wy2hl6Itg37GBinFxg7xYc4KhcCNMt0BgBM36RkiWvPKAWLTfsUjTGoqCmuo/08aIco6
         DbHsEeHln4cMXuru58Xvzis0kPBixXoAlwKrihUY0jBjdlJrFNWEMpdCZWPj7g/LWADf
         NNkQ3fbDYaQzoesdMGtYfqYdwon4gSiE06OUrsIXo3DEQgooagI27eUatH/DS7A68hbS
         d9VRN/s3EmxrRh4esKWbiz5bM/RlsvZKTlkVwCD+jRZtmIAXucveI9vvoePvQnTq3b8s
         +c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE4udwG8KmPB/LbfQEK6H2sgJg2hW+Z0nCZ4rMk1tMU=;
        b=F/OP40d9XT0OUkgTozSyO4tXinOEKg7Egx8GWhn/HTs23D9vJPZCeL7tDPNRjobg7g
         FTF+MYm/3FVH2CHERfyQ+74n4iPD8ReW+CtSa7rpH5NiwafldSsTMxWjfFfFK12vRrTG
         Qt3pOaDThBW1k+3rSx8KF17LA//l6uQfGfI67vbVXRoZyb8dChMnJbA5qNolsFDPd1Ww
         smwgB/VTOcTasL7qQSKYrgSshcq7ZqmSG4FkCj6hQEz4EivhX5glfNPTX8bxyYyzfyoP
         CACK00DN01rmrt/MhnawJIJtx1Z+jtU8FJgxfOQCh883dTzHQwGzcHH5wkcTD6Kii00/
         tAzA==
X-Gm-Message-State: ACrzQf0DVYkqyPvmC37cetjBbylpiruJtw0u/s4O2RTPcU3mOOPO71GF
        IiqN9EnZ8ziogrM2YOxtnSOtooxq+YYBjg==
X-Google-Smtp-Source: AMsMyM4GUQczJyubfobRzT+nvI2bWLy3wdDRhttiteIF0uUgNsLnVO4ObzQ/hkm+/qS9Tb3YLj8H5w==
X-Received: by 2002:a17:906:db07:b0:77b:82cf:54af with SMTP id xj7-20020a170906db0700b0077b82cf54afmr21105447ejb.666.1667343119443;
        Tue, 01 Nov 2022 15:51:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:58 -0700 (PDT)
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
Subject: [PATCH v3 11/12] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Tue,  1 Nov 2022 23:51:35 +0100
Message-Id: <patch-v3-11.12-aad17d8f858-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] two git-p4 tests have relied on there being a "git-p4.py" in
the build directory, but the cmake recipe was not updated to account
for this. Let's copy the "git-p4.py" over.

We could also change the test to e.g. grab the built "git-p4" and
alter its shebang, which would be friendly to GIT_TEST_INSTALLED, but
let's just do the bare minimum here to get cmake+ctest working without
altering the test itself.

The reason this hasn't been caught by "vs-build" and "vs-test" is
because those tests added in [2] invoke "cmake" with
"-DPYTHON_TESTS=OFF", and therefore we'd skip this part of the git-p4
tests before getting past the "do we have python?" check. Even if we
got past that the Windows CI wouldn't have a "p4" or "p4d" binary
installed, so we'd skip the tests anyway.

In a subsequent commit we'll run "cmake" and "ctest" in CI with
"ubuntu-latest", so we'll need this "git-p4.py" file.

1. f7b5ff607fa (git-p4: improve encoding handling to support
   inconsistent encodings, 2022-04-30)
2. 4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
   job, 2020-06-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index be5dce8ec69..2e299e933a6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -917,6 +917,7 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
 execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/git-p4)
+file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-- 
2.38.0.1280.g8136eb6fab2

