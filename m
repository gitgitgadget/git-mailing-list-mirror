Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C3C433FE
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiJ0D1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiJ0D1I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1BFA00E
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n14so40492wmq.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT1uAv+ZzsACAirCy388QuCYpGC0avA/0jDSVjGvWU8=;
        b=GYt2T5UvSjJ4gp23BMGui0eXrjUyZECFeZVx13KIknxv8aysfQip2e8/i53PoovlFi
         6m7UGW5F4YfIetGwrMuyULM1ewFrPA3Uwr1tY69734kP8czvw6EY/k2Id5Tl3cRaj0Dk
         N/0UYutHnCQHCc1IAVOvd7ZMgNJz06vBZfOgtsrJRwp3mEYuI7iDbeM0vOtaReMAyYwU
         Itx4DiirJWvLMtLlfNFiWo2xP9hoeTVt9r9JXSCZGB29KtXGzZjin+ILyT50dcGsieeR
         HC+18HWYxlG+jupJFH7QhNDd2Lss2R64CBG7qX/CEqH72wuHSIwRrlDGCibLR4RJOsPC
         7Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT1uAv+ZzsACAirCy388QuCYpGC0avA/0jDSVjGvWU8=;
        b=xVSKysLgLM2KC8cruShn78pq5gdZ+8H7Rf2DzD5aYnXeKWuEhp6TOPOz0eb9tG1SbO
         V5RZOsjNWIztbg5QKISDsIxskyL44whZzRLIOFOYit8f51iP7fqhNJaqnH5SRoM3glHq
         piBTJ7jGJYSpcWz1V8HJ56T6QwtlAaielOJRxC/v/daRvBoj0rZEcgP4n0sO6XiYmMLq
         Mj2xKqE30m9XQ9CQk+5dLbns1mG67r3wVrSbsHAVyk7vH+G1QSe60swuGiZA5D4h8mkN
         f8KPGe0iQiJcBc5rQmqsTVpzHUXWQoYoJliRQISFT8+HuSmicOE5bVEYyT9DkrJDx11J
         YEAw==
X-Gm-Message-State: ACrzQf3/QV1dJ+i8x1pS3I7DyrSce9UqtrI9UO7IpxZ9FJcSyRanEzGq
        m8cNf7tIuCVLlsNYUsG/Fh8pTqhPo5qIPg==
X-Google-Smtp-Source: AMsMyM4i552X7WNzT61GP3wHvdYgg7HCYQMN6t701ANtkjg0aa3hvHaAUQPK25erf8ERurDp+IYoBw==
X-Received: by 2002:a05:600c:4fd2:b0:3c6:db8a:4d2a with SMTP id o18-20020a05600c4fd200b003c6db8a4d2amr4222533wmq.178.1666841224894;
        Wed, 26 Oct 2022 20:27:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:27:04 -0700 (PDT)
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
Subject: [PATCH v2 06/11] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Thu, 27 Oct 2022 05:26:47 +0200
Message-Id: <patch-v2-06.11-29a9811857f-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
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
index 1c271395ed0..e9f979c4e5c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1091,6 +1091,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
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
2.38.0.1250.ge066ede4da3

