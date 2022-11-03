Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C26C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiKCQnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiKCQkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1A1D0C4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a13so3989562edj.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va/F7ZdRX3ekJhd86cBZWpCg45QxWn1BXgr8D4iZAhg=;
        b=bYqkVEnERZXSJZ0IErsCLuG4Ra10Q5306JW7LP6lkhyBGZkSwykLqw2lE5eqBwmCJp
         CKQDdKcINA8fv+0P0wjMT1aSFISb3y/LE/hq9sevKLdzT6rquKZVw4GUuCHetbBtzalw
         OxLsojvKvJk3xe5Srpn3DKyzh2CAhVjTbXHvkciznp3LnXXKDMnjxRrK6LAukmvjjB7/
         KrF2HA9HPtQQhPgrh/TjpZp7su5uujdnb93lPR8aYN5om4AFbu0HuSAKVHLEeCD40NMq
         8BwImb4SF8go5QVrR5doficwobuB8xk1isk3WW3sPxI5XbO7PpLVQASjn7jNoIeMTBKR
         uBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va/F7ZdRX3ekJhd86cBZWpCg45QxWn1BXgr8D4iZAhg=;
        b=4jnrnuIfN4RBNGjjDsvtaGmGo5mQD7eFIAcNuMBIQF4ByNbqrlldiFgtFGzlh5vOjv
         QpSV7WqLipV8Vuaklihc7Q5O0oCtOTWx0yRqwSeF5byWquiMi/ndTDSPfCAsAbX7xYts
         FRuP9btsTvzpQ4OVuLlvYouJ+SOxPLLBM3Esvgm3PQjM+lE8tACFWBDYurpHYj/IBm0n
         KBz/qFE7uPZaG6nlOGRiqyNra6cehFz9Pl1ykwIicJ+Zr3NUFMdN0+dFW85FYuLgwoki
         iJB/gnHQB1midW0fxPphlzN/eS4p1RdDjOebOWpGzx6fTc8Ivd/K+WiPBP78mjxFlAhv
         LIfw==
X-Gm-Message-State: ACrzQf1PcSNwwck4PonruQkQ4TSLiYwE0LwB/kDD1fPeXga48u5XFVTK
        dOH05JBeetbOlNG0eEB+qef/TGeH7fLvxg==
X-Google-Smtp-Source: AMsMyM5RSk3k9iRn4aWYt3GUNCo2GdzeV3DcRJzFZxMCh6xyVxK9JqoyE7upH/Zf8PeO+yBM4kG9VA==
X-Received: by 2002:a05:6402:410:b0:451:ea13:4ed7 with SMTP id q16-20020a056402041000b00451ea134ed7mr32463809edv.262.1667493497415;
        Thu, 03 Nov 2022 09:38:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:16 -0700 (PDT)
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
Subject: [PATCH v4 11/14] cmake: increase test timeout on Windows only
Date:   Thu,  3 Nov 2022 17:38:01 +0100
Message-Id: <patch-v4-11.14-8ccf5c8c265-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index 4a832404da6..2b4e5a2f4b6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1174,8 +1174,10 @@ foreach(tsh ${test_scipts})
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
2.38.0.1451.g86b35f4140a

