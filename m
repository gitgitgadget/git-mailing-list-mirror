Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714FC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJUJpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJUJo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4875B715
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so4597064wme.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AvNC3ufAy6nz1AhQKG6yQlu93HAj7/vPoazT5NjMqM=;
        b=Cv+8CuvFFMoJOu7C14bhH2H+F8/vAqAHf1aPaygGC7rWvq0LaHRtTTAhQfDr23b74R
         p6AJW3pZwz1Kwp9iQ7dgcrZxoe3VZsR07qysOAnvXwGpM45zPHU6b+CvDE46VR3+s5bs
         XS6ZJ/mnAYyvwZ6EB0Nxn4Wl9aki4lz2CIYfw43nRA7LB/JrrGPqoAVvMZJCN/0bodcS
         iRPIPo37zeUQGJLYzAHrOECI+WhhMBjvzMptPmyxlM7MBtdBCnrj3i5uafPfKfett5cW
         25ZHd19jt03/99SZC1ZnBERpj8NFMXQgCVr+qH2PqFOslX7kL8PNCu4ZfeXUKYyxWQ01
         5lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AvNC3ufAy6nz1AhQKG6yQlu93HAj7/vPoazT5NjMqM=;
        b=sIdUpHrWeAMEi6asYm8WST6JfDOl+hY//0esggs4Xx6t2lMWOJ6UM1X+CIhVXLjcWg
         B5bem0Ek+9iIFGIofz2Nk//6Aj3kLq5IOEyXfR4XTObenGn0vyVCCd31/whkZ2KR4vGm
         d62WU3g00MDll1Zj/sq/KdBCGAh+IRHf+nMcJiVVCNiBSfA1yymmPAjP9foGkM7cwqlX
         y4GB9RaY8+0MpnaV0v6aYg/5Fc3yPAIHNvwKaq9dhZ4rBR7//sK43A4GzhBC8tO1F5nl
         /1z7nbPvUaj1cCfARedude8v/2QIoGSuDz2ODyAQsC1eYhi44tPImUor4e8i8epcxD6R
         X13g==
X-Gm-Message-State: ACrzQf0240mWjOEuahqycFSjLMn8cKiEXQ8wdSee9DN1fUsIwGLKy4cd
        hxbZVGsvpdq6I0TTCM2u/sV1uYKenQm5NA==
X-Google-Smtp-Source: AMsMyM4F1v/hGFFx1Jr4tWbjrANTEnf3HhSosVq4IznBnb+BlaxtwyrVtE86Gs4mq+Hvth9S8GqgaQ==
X-Received: by 2002:a05:600c:19cc:b0:3c6:fd74:cb2b with SMTP id u12-20020a05600c19cc00b003c6fd74cb2bmr12548065wmq.6.1666345492730;
        Fri, 21 Oct 2022 02:44:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:51 -0700 (PDT)
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
Subject: [PATCH 8/9] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Fri, 21 Oct 2022 11:44:21 +0200
Message-Id: <patch-8.9-56102c2a4bf-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
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
index 8e29e3f514b..4f5e43e0aad 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -860,6 +860,7 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
 execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/git-p4)
+file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-- 
2.38.0.1205.gcea0601d673

