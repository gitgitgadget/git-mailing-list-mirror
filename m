Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69561C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiJUJpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJUJo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3895B120
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1596064wmb.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYcE6xGeUwBbeECJtV5C8gwPnWc3fhgSUo3uW37+SmY=;
        b=p58YkrXaVzUdsFZ3vSbecTRZ5404nzawsl7KlKpZWKXIc4TZFCs1AatqL6+8OpNq2A
         0kTTHLC96LYMQkjTTonSoFrzqgwqJ/ezoRP/2iIHoU2jyahMVOcKLp2IKxN+48Y2tRrj
         u85cJN/qeg1RdBhRGFveeXHsnRFI+7aG1zLWNVEESX6vU4aRoXbc4SPhRzxOolvfO1xy
         i/jUH8px7oKhx2hkxCq/pLJ9prbmKdtAPm84T2CtnVtvvnqsnDKQzErMj4/y9i17uDSu
         2zm9BTWOgtsr/+E+YCiVypmaxEY3BrtSBVCFRlRDcD8m+SotQMcQGgP8cFLwy9Ti6v4t
         TgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYcE6xGeUwBbeECJtV5C8gwPnWc3fhgSUo3uW37+SmY=;
        b=0zIg84UXQJn64t8Igb88GQTOcaQaWaefh58jqhLHt7rWziIHiiLKxXuCr7+0TYTTE9
         sx9EwxzmUt/CgdV7JjYypSGmN4HHHHgWHhJQYGfX9tUhQhFMPmbQLCG5PGLplNzBrf1h
         msxmUqu4iM2eiye+dQuUWaympsa692CzmGrVM7LccvvUURj7DxRcRJKcmj58O9t9hl7n
         oUBtKGXrpVoibZ0aA88uVhbAAl2iNaWGxrFFIrw/atMPTYXAAj9wXS7I1HF/PHDUlIl9
         Ysm5b5/jXzwSCpu4k3XgOJM7Y7puwS/ZA4AAX/6HwaL7SKCEOwlkYKqB5vDk0mulnq/x
         3N3A==
X-Gm-Message-State: ACrzQf3+DAepYzzGSjsvTR0D1b6T3v48R5g6HFBIy8Wx/efMuVZ3jK1p
        83p/OkGD9MVMmlwE+EewxHwJLbKGQLR+3Q==
X-Google-Smtp-Source: AMsMyM4YhIDE6ehGDvtY1QtZduQXDzBCEEXNCH/b/1F5FAw0pmn0EjfbBoQ6PAIz7/GJQwpWq40cWA==
X-Received: by 2002:a05:600c:3d8e:b0:3c6:e58d:354f with SMTP id bi14-20020a05600c3d8e00b003c6e58d354fmr25257912wmb.176.1666345491442;
        Fri, 21 Oct 2022 02:44:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:50 -0700 (PDT)
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
Subject: [PATCH 7/9] cmake: support using GIT_TEST_OPTS from the environment
Date:   Fri, 21 Oct 2022 11:44:20 +0200
Message-Id: <patch-7.9-fc9f036695f-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get "GIT_TEST_OPTS" from the environment, and use it to pass arguments
to tests. This allows for passing arguments to tests with e.g.:

	GIT_TEST_OPTS="--verbose --debug" cmake .; ctest -R t0001 --verbose

There's some overlap with this and what was suggested in [1], but as
noted there we're not passing "--verbose" and friends unconditionally,
so a plain "ctest" invocation without a "cmake" re-build won't pick up
the options.

1. https://lore.kernel.org/git/356b2e9a1007bcd1382f26f333926ff0d5b9abe2.1666090745.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 91b7009f4fd..8e29e3f514b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1083,9 +1083,11 @@ endif()
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
+set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
+separate_arguments(GIT_TEST_OPTS)
 foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
-		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh}
+		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
-- 
2.38.0.1205.gcea0601d673

