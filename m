Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A9C4708E
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiLFCJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiLFCJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:37 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C7240B8
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n21so2787816ejb.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfShSiGhMf34r5bJqw+kCZtQun7H3mDsNB7fc00ugOc=;
        b=XCJNrp23ps0y1FieS4AsS0n9KTb39xjCdUXtMNbk0sjlHK6FYrt5YUBxKThPiX5W0b
         27ZayKRVaE4XorULWOivtMSig4E8NOO0nHdVs8CmFXFcHwL5pSt5ENAU324X6dLAUVJ/
         roW5PTfzjnMufltA3DoLWlgqiZEUMtdEHoHo7iQbS3MtK0BHK+3w3KTt0nUR+at95y2u
         fAq/+kYKcoz1voIhLEKgVNfeQ9H2Vye5DGMWaIobhC3IH52qcV9MxMUjvxfEzX09FBXG
         jjM7BlF+ro4K6xkdO1Y8Oc1FvOPQHnj2KKYjwY9FbH366zdPspWus4igaNOvDTAJj3+a
         CCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfShSiGhMf34r5bJqw+kCZtQun7H3mDsNB7fc00ugOc=;
        b=6dBG5d3fgCZ9GuUy5LEKNIbGqfVTgPBMd/jKSh+VnSrzm+DGWc1wl+4jVZnmnWuuJE
         B+TqH+rHFLux2zDWcvK+7dPk1VsSeXM5eOHeKufPbi2LTT34kEDbzxdNIQ7BefcdoW2k
         gbhqWSpLhSPejlvSVu21aQhzSrW9jjozblS3rteuOLnOuyjwQDDWWZS5wILDm/hQiU4d
         4lBUN9HrOjp1czyEeicRJ48Iy68jXtN/Gc/shGnnA0BH3uo7qdHGEjZQ7RoKajHNh6Zu
         NqACFYpVKv2+XGthtaKVbtTWKxN+zqUoPJ5r1q3/CPyQGIILTc54xjQwvoqrkJ1hhJLv
         Rjrg==
X-Gm-Message-State: ANoB5pkr+RI9Nw5RU0scjl17izgwukcxfeyzZs7nDLUnw6nlvmrn7dds
        wiY7dYhhUMZvvjLKf/jW/lQ5x9DtwWsO7Q==
X-Google-Smtp-Source: AA0mqf59rSn3s0ZIOM83X/25L8w5r/eCwAYfvdl0xmNHfxj9wSxoq5Sc5asiqTTtYiGPaQbqO54y7A==
X-Received: by 2002:a17:906:2481:b0:7b9:a749:e70b with SMTP id e1-20020a170906248100b007b9a749e70bmr48744828ejb.567.1670292574506;
        Mon, 05 Dec 2022 18:09:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:33 -0800 (PST)
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
Subject: [PATCH v6 07/15] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Tue,  6 Dec 2022 03:09:05 +0100
Message-Id: <patch-v6-07.15-973c8038f54-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we build with libpcre2 which cmake has supported since [1] we
need to set "USE_LIBPCRE2='YesPlease'" (or similar) in
"GIT-BUILD-OPTIONS".

Without this e.g. t7810-grep.sh will fail, as it has tests that rely
on the behavior of !PCRE2. The reason this hasn't been noticed is that
the Windows CI doesn't have access to libpcre2.

With this the remaining two failures we had left after the preceding
step are resolved, but note that that test run didn't include the
git-p4 tests, which a subsequent commit will address).

1. 80431510a2b (cmake: add pcre2 support, 2022-05-24)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ad47430f9be..2d66d471acb 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1101,6 +1101,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
+if(PCRE2_FOUND)
+	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "USE_LIBPCRE2='YesPlease'\n")
+endif()
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
-- 
2.39.0.rc1.1006.gb4c675778ba

