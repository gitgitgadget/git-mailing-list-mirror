Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41581C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiKCQnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiKCQkm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79CF54
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d26so6758659eje.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imDMZm/4xLHCBLLHYKUBJhhi7PCmC9SOB0rjQoN5Sw4=;
        b=dYp73FNlRq7Z1ROwyxMABcfCe9jZlPEYqJktifRsHkMncq2dbPoW4lnw9TAQC+jn3i
         kfht0ksvU4Bf45ANn0s/IMtr1E50zqdpXpjh7KXZy1qhjzaAy4Hff9Md3TM2k1oksOAb
         xU6w4h3D/1FR37LM78r/+SlTx0pK1niHpv9aceBYeuvWfRlgWf39lFjgHpzyyvvjDik+
         MtxC1yu9EZpoewJGbz7NsobSghV7Fne5gIDWrxTVp//B57fVbQQovddlTAy0OI+AgEJu
         TBECc0N/5otqbnm0abVD6b3r2J+OE4J8rhtXBB7i6uogwQt5BfARROU9+66Jvxqw78sv
         Ts5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imDMZm/4xLHCBLLHYKUBJhhi7PCmC9SOB0rjQoN5Sw4=;
        b=SGms6cltyGee+gMqY7rM97gBydobF1etIgxHh+R/UPUOWeaDxDj5oy2dVQ04iH4/ny
         GJE7v76TgedanP5KkPrR0jmisj/atC9E/4SKMAaOo/vbZb/W0hFY0cPsIWAOcsagO5DI
         8tE6AdIkmAJUQ1Yn+QWIBkWFDCcj9lVD3poOk/VyjDDLJflCQfCsbX7Rg8XYm+lasVNF
         3r9ffDc/JkH6UlyHoHEpLhOoLQ1VwcNzeetkDZWQ9kiNvHBm5H9In11b1XYG3wCslKoU
         YReLcD4snIGdy4d6rWHaB5QZPqSlshxH4UBaXRKwF8YaU2JzIC5eVk/O+a3jSoVts2eR
         QeyQ==
X-Gm-Message-State: ACrzQf1GRn/GpkYGfMAJSr5c3zgxWOS8WCVscGIu+AHCpVLrGmYSpGeS
        id7xeahuB/cKO9IPkkdyBlesXHfxyzewaw==
X-Google-Smtp-Source: AMsMyM41tscKVsSTo4IxsvT+u6Jtk89p3ifBJjab72tl02Y+xkBYAJTVr2Y7amfwC77fWJJxmferEQ==
X-Received: by 2002:a17:907:a0c9:b0:7ad:dc98:d9d2 with SMTP id hw9-20020a170907a0c900b007addc98d9d2mr19489085ejc.310.1667493499275;
        Thu, 03 Nov 2022 09:38:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:18 -0700 (PDT)
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
Subject: [PATCH v4 13/14] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Thu,  3 Nov 2022 17:38:03 +0100
Message-Id: <patch-v4-13.14-0699e398e89-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index 88723b971c6..de855d953a9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -938,6 +938,7 @@ endforeach()
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
+file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-- 
2.38.0.1451.g86b35f4140a

