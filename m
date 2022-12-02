Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0567C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiLBL3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiLBL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FDD49E7
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id o13so10901450ejm.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3AL3TONhIIaL9Tkhp/AMidqKGTuXHjzWM8iEgbe56Y=;
        b=M6WyqD0MP22obmEaC/vE7t969pJplrAwVQMcniL2COhTeVwk63B7cha8JsJcVCs10z
         T+/ma3xl0CTkH5is17Iz5HBxyEEIKk3TkIKWe5/8KrOFUIXZyQEKao94giBnO/3zdoYw
         +75h+on95uL/j85i7l7TlmSFY9Akco4htgaMYFa828L7WaXMYCtcLTaIV6aFfVtX4i30
         S2STW/SdO/6VDGU+f0kc4oXqKRHbxAggCz9p4dUM/mYUqUxRQBlKHJcUEFr0+cx6EuPM
         kFMYnbm2mh8B6N4S7UodSg0U5ZDz7b3/LUW+piA3P229sQJKSH7jQZhgS/ZBZpDKsJw9
         4CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3AL3TONhIIaL9Tkhp/AMidqKGTuXHjzWM8iEgbe56Y=;
        b=tZc/nr1cUViPVviq+uid/ez7ZbB5d4l6nTswokR+E4tCRGmsASLysL3qw/RyyZpLH5
         sfUtui7Q0Huj1tlSHwn6dFJKmuCZOfU4A/JRbijAPlbSyen3oPM4PK7sMg5rrSZuk7hT
         TRIp610iReWMbnzO9GzFKKZNu8q+12bAfbqTDVk3CP59/ExNXleMbDsy/MRDpz0Haqbw
         cxD/A9T2GBatmoBcpznEryPYMRp+Mbz/UuIrjCOpyhdgE5Up/ZXvj8PB7kmbR1abpy0p
         xa9VKoj+J6rhgJUiWNqkpejmHg40xi2kK7KPqbL7x8coEQTC1OTVskAmGlW4bHwpu9H+
         oZhg==
X-Gm-Message-State: ANoB5plQhV3jyaBYv8Jdn0qI/pM4rD32XK/oF0KYSuT1t0VsA7djgnZN
        KsM1IEV6j2wvvGoQ0s1jXQA/e+DYEuZ1ZA==
X-Google-Smtp-Source: AA0mqf45Lq8huAj+pWRW4TTP+td51CETRHAXiWjSex8aNrNKn/nMld33kccPfeMxwZ+oXk3JptyJEw==
X-Received: by 2002:a17:906:99d6:b0:7c0:c91c:5d38 with SMTP id s22-20020a17090699d600b007c0c91c5d38mr1274317ejn.50.1669980533920;
        Fri, 02 Dec 2022 03:28:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:53 -0800 (PST)
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
Subject: [PATCH v5 12/15] cmake: increase test timeout on Windows only
Date:   Fri,  2 Dec 2022 12:28:33 +0100
Message-Id: <patch-v5-12.15-c9d550b8558-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per c858750b41c (cmake: increase time-out for a long-running test,
2022-10-18) the reason to set a custom timeout for
t7112-reset-submodule.sh is Windows-specific. Let's only do that on
Windows then.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index cfe8126d939..712caffe8f1 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1204,8 +1204,10 @@ if(NOT GIT_CTEST_SETS_BUILD_DIR)
 endif()
 endforeach()
 
-# This test script takes an extremely long time and is known to time out even
-# on fast machines because it requires in excess of one hour to run
-set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
+if(WIN32)
+	# This test script takes an extremely long time and is known to time out even
+	# on fast machines because it requires in excess of one hour to run
+	set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
+endif()
 
 endif()#BUILD_TESTING
-- 
2.39.0.rc1.981.gf846af54b4b

