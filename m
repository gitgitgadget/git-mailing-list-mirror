Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D48DC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiLSSjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiLSSjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2D2AA
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w15so9576289wrl.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPWjx7VXzMjv7wXvTfbMb1nd3NADOKkCpWsjFrSB1rc=;
        b=cBk8RrFuSu72A1pmzRciOLT898TawO1qRr7479tyRrHYuKth/IBBPrlnnfWi2FJ8aB
         J0etMFjAeg6XdNeOJb45lb+AP8WD8wMzn7x4zECGj86Fy7mi4N6ht/yTtsgr+yuGhd+X
         o4h61HHBR49AJ7JLblayv6XhbECPwt03ghjEzFTS0kCLPcZZMwLc6xWuTJR3WUl+iUaj
         dY2zV3i+REgklhzn0pV0LZuXpepPHBG30HgJhOSdAxOSqLSepvzTz9RoAcGa6mWrAPgO
         kKcm5kB1vQjy71Nw+nF4cT02oFNnqZFOxfEK42NPj9qc56Urzmsn+Jf+xFA5iW2P72AD
         bTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPWjx7VXzMjv7wXvTfbMb1nd3NADOKkCpWsjFrSB1rc=;
        b=CDE/m7QNecKrwZi2y7fE6/ORl2kvPHNMozKHsNTLTn/vVAUqyLkbYtGkKZcSewjGoe
         k0Bm7y0R2NudidnMZrsPRjlATCYo9q1xFUFyC6iY/Vt0kwOW7mliM22s/lpI8exZyRq7
         o3QSIHef5W8lJmLMARKoauGhcVLirMuJMPHA8fzeQp0vibcKi81JM0oVhRG1Cc7QsNQC
         oy6Zsuwruq/uTXBPWiL75IQojrsyjoLyH+kuAnI9E8KNiejg1uo7DC9kW5vK9l801Jwx
         0FTI+F3N8nZYuQra/jtxFHlH8pG77ACaOnbLDpL7b8Zo5k7MJBv3WgI0A7yVfjxeDPLp
         VFCQ==
X-Gm-Message-State: AFqh2krZ433GLBRfH3PG+JtOYoYBJLgFZ+EWSIrgMENZ9U3vsiST6slx
        uxrLZvtPi/CMDOYZYS4R7D7V6u5Dtc4CBA==
X-Google-Smtp-Source: AMrXdXvZg1xYZBytoExl1fse+GQzJaoh1HgTx3j/0tIKna3lNtceaI1Dz1d+x2uaF0gpfbgwp4MD3w==
X-Received: by 2002:adf:e410:0:b0:254:9b64:8883 with SMTP id g16-20020adfe410000000b002549b648883mr16655297wrm.21.1671475172514;
        Mon, 19 Dec 2022 10:39:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:39:32 -0800 (PST)
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
Subject: [PATCH 3/6] cmake: increase test timeout on Windows only
Date:   Mon, 19 Dec 2022 19:39:21 +0100
Message-Id: <patch-3.6-2b5a9d2c628-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
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
index 040f5f31230..d45b9c8e00a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1125,8 +1125,10 @@ foreach(tsh ${test_scipts})
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
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
2.39.0.1071.g97ce8966538

