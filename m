Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2861C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiKAWw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKAWwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:52:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2E1FFB4
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:52:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n12so40748583eja.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeQtozax5I/z+VgVUZXDbYJfoXJBUFT9fI2/59BB0NQ=;
        b=IEZk7Fyi2Sti8E2LVgQ9Th9u3JCXQLH2uUIweErWggvKi4Wokz0GapP/yd2Kl7MqF5
         kcO4MBtv/efThSvsnBLnadJF3UAgtcjjUPmvdpGbVGocQVy9Q+D5M9EMoRTP15QQ+gHC
         bxQ+yzyk4nhqFOXH6pfkpUHuqX2e+lDBAAInQE1QtSyuJ+ZBpYxZViW8Q+KJeLhYsL06
         k4qxTHHvV0bgGPfAnvF7nXV2TZDlm3++vB3rtNM70u8xjbzZDsfDwbmAj9WtTSPx1d7v
         qV+tSy37MsN8D1BARl1nKuaUDjyNeu6S/9lbZCg3H3bqaJhzSWiOkVTG80gHTqCisHuo
         M8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeQtozax5I/z+VgVUZXDbYJfoXJBUFT9fI2/59BB0NQ=;
        b=iiunJ6YXjP19LRpK4+4FIT8Ns3wJt3J4CZKjQoH5QxHs9CZ5MoRGo4KDTg407NGjXO
         RClIMCu/Ds485TqBbJe63SyP+IRLLyChxb1OHrexQygIMH+SdBMlAOrD1ap0axl2X7L0
         2ayLeuWV59/NbQo/2TIgoO4YVbCXDy7nL5qGmIe2gvo7gfoqfDW9NVb2yELdXsKUWwJD
         DmGQtRveq7Tm0T17cl8qbkxn7RbwZ+aafSlnL5/ao6HdOLVL001Oee8YB/MBSRdBPAOK
         j9ZZPLIfs2y/CD8sodcfN9vQNRWcKNyoL+WQZqUhA3W1b6U2Letd/7REGo4J6HZyK+vP
         Pyzg==
X-Gm-Message-State: ACrzQf38St834Z7AeGhpTv+0lCliF3Ltop6T9SPuqjV96uC0yxXYPtsA
        +2W2K7BMbmG94+RTrtAwjdLce5d0No1VrA==
X-Google-Smtp-Source: AMsMyM5+cMug3geI6Qoc0mfQwYftPCcQ2Ets8mC/dsEv/CaEBI2oj1ewYP870JzPWn65fFYqH/gx7A==
X-Received: by 2002:a17:907:7faa:b0:7ad:e8e4:6ac7 with SMTP id qk42-20020a1709077faa00b007ade8e46ac7mr7244795ejc.21.1667343118490;
        Tue, 01 Nov 2022 15:51:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:57 -0700 (PDT)
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
Subject: [PATCH v3 10/12] cmake: increase test timeout on Windows only
Date:   Tue,  1 Nov 2022 23:51:34 +0100
Message-Id: <patch-v3-10.12-966fec83b77-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
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
index 6a3240d4ffa..be5dce8ec69 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1161,8 +1161,10 @@ foreach(tsh ${test_scipts})
 		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
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
2.38.0.1280.g8136eb6fab2

