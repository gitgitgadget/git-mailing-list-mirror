Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE4AC10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiLSSjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiLSSje (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B16194
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f18so9601366wrj.5
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqD9/NR2+RvjAnZkmSIxBt0Uq5+c6DPssxYU+WTk22Y=;
        b=RW6P8YoyecNj/oB5+fL93aQ4eU5pHZ9P3vYYeSfk61UmU1VyhpQhJIGdSMlEzdaZgL
         7w7dIkVBJRddMHiIWLohPvqYvX0Xl4dlQmEQp/60jHb3ZYxpqP79ByMiKSafnmvoQDc6
         4LDNa6d8pOoN/KG4BqMkU/8Gio0+4Lt+qQFazcupXT4Ci7moxjfgZIokV4Ium6cup0K1
         W9CCCydg5L1fLQLJr6p4rdBI+JRRWGDtmikx0xfb2JqFM1zBOeSkCzrio/lrvNMvTMsK
         /m6hLuU/clgckdE5lJ7DJlvMS1A28ZuK9SrwFvX6ccp2gwAWbvdMoboVj1/VVjgs4hvO
         XuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqD9/NR2+RvjAnZkmSIxBt0Uq5+c6DPssxYU+WTk22Y=;
        b=Gl6tvyu4Y9/gCXyayPeh1gSDdUwkGuBpEYKKkvNV65KCquY0M9oQY/51mmfM5307gK
         JsEkOkpB5ClXXXjOEpSvWmpkoZKIWehAjWkQ5LHsDt74O3WGEc55MMNHHwcDCLsg1Lgk
         z/O2nXq3arvCxENc/q6VCDv5X8jqByF2IJ0eqPVJd4aNMFoq5pAbJB1jYDxULQVHnHz8
         Hk4ZNab6ECVIVAvz0RbzNJFX3YomJr+5gtDL3YajcOr5x3rxRkgEAxjEjUr/f3NqCqyV
         ljJ0Z+B8L2DKqbZv/k646wnsVBg90QeH+QyxNv3pw50/rGcOq0JkbYvSZ1jMlis540BA
         uAFA==
X-Gm-Message-State: ANoB5pkwwFhFxbwETvMOOCgwR9yzOh2NpRiku3L6uAlB5AoMiFWBaAO2
        /FMGUwTjBZkdK/toSZBsi+Kbn2Bv4KSAzQ==
X-Google-Smtp-Source: AA0mqf7ufx2MSTZ8Rfc/mkxMpeq7aqWP9ZSkVR0p0v5M0/sJm6imvkwoUNcD8Sa88RljbFZPouZQDg==
X-Received: by 2002:a5d:4890:0:b0:241:fa43:d985 with SMTP id g16-20020a5d4890000000b00241fa43d985mr34770550wrq.12.1671475171567;
        Mon, 19 Dec 2022 10:39:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:39:30 -0800 (PST)
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
Subject: [PATCH 2/6] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Mon, 19 Dec 2022 19:39:20 +0100
Message-Id: <patch-2.6-a1653607aaf-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
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
index c641e9349c9..040f5f31230 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1086,6 +1086,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
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
2.39.0.1071.g97ce8966538

