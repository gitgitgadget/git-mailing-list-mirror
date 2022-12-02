Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6704BC47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiLBL3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiLBL2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E1D3DF5
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so10954536ejh.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM99oAo0Mtr8NLyiiEiHiNzbagr/2Yxzh5P55+RLrDE=;
        b=BGxBXfcaKSjwB90pVT0+8xtgZ7BCFnfc3PUsJ+USMBWwyvmvwYAzyVj5BRa6JFZCa8
         O5g9cjmZScHbmRgF4l8AQqkcyGYvYGY3pXKaOtIBef+Ma9ttXo3EIVaAYJkbufup7iJr
         6NTzcCZ0xnZlYrLzsDxOyLQzdvQ8OEp6uLtbCGh6Vn4aralimDG25yk5eUBU9BxOzh0O
         7nXKKJrebR+3UFusqNjfqZ6qRioYL/c2ueEhSScgjHGN4qFh7CT9a/jOWee8LaC/shUg
         cqJ2C8ZYUJVkWgokIE75SQ8zCuscBMjtuY1brUPzY9LdVLk75m5H/kCGKoksFufWpCnJ
         V+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KM99oAo0Mtr8NLyiiEiHiNzbagr/2Yxzh5P55+RLrDE=;
        b=nPcFPshMqVsco5lJE5BqQxQiAFVCNd6P132GWzVFgOc3Q4uD5e+2dkUJ4Iov0xDMkm
         VYAR0TZvOBQlCBnS2e2NuHU6tH4H7w/PfEEcgCXl6DcRnd8Ofdx5WC3gIVmmowXPDdZy
         KxBFfQdL1eFKJ8DfuKH88XJbjzqV+8IFvT5qa5OazgpMQIe9GbGpV2jL3pKXhUOSTO7s
         aDDRz/YJPwKW0Ql6QoUwldWFsqQn7Q+kJfg313buA2BfgjGXMkKVqbJ3qLlpO2GvzM66
         WqsHgg4QM59K1ceaziFOuYd9nuSH4yISCxqGhK/pkHxUhPxwSY8Y8bn/Bz1FVpL74d4E
         FXJw==
X-Gm-Message-State: ANoB5pmj0f7ce4FXqo0lL5tgWjihAwTf/CQSpaiS5JBrzm/a5YdBhuTZ
        ThMfL3jmjjfdR6K6eh3Y4mgdbA77BvU9Cg==
X-Google-Smtp-Source: AA0mqf4auLRh9V7c8sfQFWIk8qc40ur0Wp6FhmQViaRTtkY+s7qRazq5SeGJIuDzbjvYB0mHEGDQxw==
X-Received: by 2002:a17:906:aec1:b0:7c0:a04b:6795 with SMTP id me1-20020a170906aec100b007c0a04b6795mr10006652ejb.16.1669980528160;
        Fri, 02 Dec 2022 03:28:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:47 -0800 (PST)
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
Subject: [PATCH v5 07/15] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Fri,  2 Dec 2022 12:28:28 +0100
Message-Id: <patch-v5-07.15-49645cb1643-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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
index 73b060a0385..5b3fb93120d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1099,6 +1099,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
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
2.39.0.rc1.981.gf846af54b4b

