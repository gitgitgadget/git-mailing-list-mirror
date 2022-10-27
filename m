Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F2CC38A2D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiJ0D2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiJ0D1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FBFC1D6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j15so89039wrq.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzA6JOxmbDWzmJV1+api+NdDHjBKmJKLw2WsxpcTinQ=;
        b=bt40hdI8VhBvJFbjNcnRPzoUODgxPZmuG01++dvO9cLnWPNWF9qPUCUL6TEQPEmJky
         v3Wy2rvnHX4QCAB7RegkNt9NwOj2ys1ZR6y77v2m4RbGk8t4Z0hCE0VQ9adP2sSOAw0L
         0LerL3GxnLRpsAhCU8GiZFLeJSm8xJ3Cu8rCbS+Ijri3ByTe87GPdIhjYZ70B8R3trec
         F+BEdxfJIWZBAqzksKtnSpQ2zY9JTdac3BpjFG4ESpORgRtMh78Q5HweMY5UIlsbBRRx
         z5mt2EccJ+EA5j6Sn+aL74xUAgf+rQNOolZa5zuVrp+UQuJoweEetHm9Nn2HlGEMiiuc
         HhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzA6JOxmbDWzmJV1+api+NdDHjBKmJKLw2WsxpcTinQ=;
        b=uHux3YRQcmBX16BLcyu9jLcSIl8l9F+fsDhyhCtfcZSaLU0Bb+yjy4l/XQFVyW6vLS
         Xv2EQaQx0RIYT/cggHeTn7DWljOVibpqF8PzaWXGOuAPHKJfoC2LCU0EU6UXSkLNL84v
         KRFZHYAT6Sa3pMNnyBDW8Qi0ehNSYhb1zN7TJTooDJgYnjzhs5vqwSemD9lOwQkcdgRF
         FycpvuKuD2evqL3wfMHi02LJcDaLSDAWFjOsgFZN1X9Wy/3hrMslJ6zqgqRD4oaX1ER6
         pnu+HHgT9Lw+F6rwLmTZ8iEhE0FP3SQGOr/m3WC6GCNHfgrki+ZC0lcCd8RJlw4apFzo
         KI6Q==
X-Gm-Message-State: ACrzQf0MN/HjveeZxgbRlNHTn8m+bVfnHrBYpS5LMvQTkCRFMAhr+DxS
        svgZ3Ymjd129oCpl/3mW5JY3MnquEML7lg==
X-Google-Smtp-Source: AMsMyM7Pvy0BUn6B25nCvmvNUdRcwNv71lX+mnNzgino0skI3Pxle9EllWk+qMogakf56QUCefWV8w==
X-Received: by 2002:a5d:5a96:0:b0:232:2e1:48f7 with SMTP id bp22-20020a5d5a96000000b0023202e148f7mr31364855wrb.694.1666841229573;
        Wed, 26 Oct 2022 20:27:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:27:08 -0700 (PDT)
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
Subject: [PATCH v2 10/11] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Thu, 27 Oct 2022 05:26:51 +0200
Message-Id: <patch-v2-10.11-ef6a304368c-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
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
index 35b12493cbc..6c5954aca25 100644
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
2.38.0.1250.ge066ede4da3

