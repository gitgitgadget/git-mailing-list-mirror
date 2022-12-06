Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20487C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiLFCKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiLFCKF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:10:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C10D2497F
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n20so2952720ejh.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viJsghI/3Fk8umUZECXDvvJadMIoRX7tU11djF1A+sc=;
        b=AstlsQSHWuQ8XajSy0l2gpZHCBjFZnlwZE41PudiAzBpDyP68EM/itNqOXbrTvGatr
         qITO0rPaxQN3cgWIpMZnASNkvRPtd9kpOyLx9qtnf48jEHJNY0YB+97IDL24qM2r3/pm
         C3UOANHZHnoZnqvVQAJEH3Qd9fe6DlqQLvhJwPOWbKOag4QoT2LZKz7OXT829U2c0ukI
         vusSRl6kA1eovI7pnGF+vAUecL/o2Rt3ObjHR+mjB380V9dYmbIyxkmYGPlxxAbqVVnM
         +CCfLOjwsxyW5MgjbzsWRR5mbQOB1OAm9fD61/FC6Sz5uC9A0FGujO9fGpvGs0mkeMFg
         +Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viJsghI/3Fk8umUZECXDvvJadMIoRX7tU11djF1A+sc=;
        b=WX7AjvPbFS8w21rGSpHOjU+paP6Sy/XgtcvoGAhoGywQx1NWWKfQEppTuSlusg11zJ
         BbWvcFP4qKBHyGCvItEhSLHeDa6rtMIpxmAeMPANlLD/byDZlzb9TqYCmdsTGALHU9An
         n75pGfGlrVHvKnCUoyyolmb4kYzBijcqo4rPIfBdF3wbsmsttfhH451+LfKj5DKzglC7
         l3+DOrrHmovFBQYvBjtijIYdbHy95NU3Yag0o296BKVVp9bS1jKIX9ebrcySKW+kGscL
         xbg/YKwNeLu/TslROfq7oBhM6DN3tJvPh4mRcuRboDQzWMjZcPgUQg4ZtY2yWk4EGQob
         7ycg==
X-Gm-Message-State: ANoB5pkuPKShEY2FuPV8e6Xj0jQGSkhTDGw38xhpSyC7cArytcTBwfvP
        lqrOqVyIUmubNKdlsZ/8YO0A+egvMFq2Kg==
X-Google-Smtp-Source: AA0mqf5qC0c0EvEgvZpm+NvSisENIhPBfRbO3JcyYRJ+Psr30Gy8hkB7VNEfowA5tifHsmfhBwu5ug==
X-Received: by 2002:a17:906:a082:b0:7bd:1fdf:ac09 with SMTP id q2-20020a170906a08200b007bd1fdfac09mr41674835ejy.287.1670292579509;
        Mon, 05 Dec 2022 18:09:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:38 -0800 (PST)
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
Subject: [PATCH v6 12/15] cmake: increase test timeout on Windows only
Date:   Tue,  6 Dec 2022 03:09:10 +0100
Message-Id: <patch-v6-12.15-4905ce5321d-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
index 034ab2c879a..139498c5d5b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1206,8 +1206,10 @@ if(NOT GIT_CTEST_SETS_BUILD_DIR)
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
2.39.0.rc1.1006.gb4c675778ba

