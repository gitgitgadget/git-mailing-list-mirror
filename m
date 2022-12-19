Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DFC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiLSSjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSSjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718AFD9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so9619667wrm.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qZKS9KZO4t7xTf39n3XNGDUOoql58S1lsyjDtXgcg4=;
        b=gj4p6IbQAkrsAQMC/A4omB7lWefNfMy4E4PGSuS6EViMcVxA2Mr3knS5CIgPLqhc88
         e0r2wrFYhIwaobQJCDP5/6iaUO3m+S5qfoAcua/sFWdNjzcKUNhG3NVxK1dzXmXUShkx
         VH7J2RL3/kXOD7cK7SlOxerR9l9I2BicVTcFYe2SZORR4TxIrR0HqKvnndV0uoQI3wkz
         DZTXqxl1fNoS/K6eRIi+CuWPAV/yUhLihwVkxZPZ/azeNVyTFiWm7rqshNxP31ZuNM12
         mhs9CdMpFKxkbIjtRkp4fHjtgEEt0JuvN2RcXMwgkEoAht4y+UZ95Iwok4WwE7Qm2X1n
         wTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qZKS9KZO4t7xTf39n3XNGDUOoql58S1lsyjDtXgcg4=;
        b=mDjQJYSIgHi2MUWFoliaSxfrS8CqSAl8cnNQ8pYvWXH9GOGxqXUkdO91J2qZ2HRsN+
         cqmWIh8SQNsobgdH14ECtcONdj+YJNv8Xkt1YU2rW7Go3BB2xD/5mtJeznQQraAMz7LL
         Lh1ZThdUnNuImHqZbXWmYhW9wvFB1DuC4p5z8nTCtbks4Yc74KmJVMdbQ+XDLuqWmNso
         qHHx+VU+sag5nFule72kngECx/NukwEXtwXfd3SewwryAaXSe2q/92cq6/vNo/9olgDl
         kCYqkO0KiKB8ROooWdxoCjdPpGH41RYqlb+yuJfhcEYheHTz1+POtckem4qHeyc19qzK
         txOw==
X-Gm-Message-State: ANoB5pnd3ITc3q3TzgfgSzJwWiv5/JlxXN9u90ENEt/qzj3KUHK/10xU
        fH2GwSxjaTdb1PS4IyRyxshNhDND8ZBJyw==
X-Google-Smtp-Source: AA0mqf5gbMp6iFFDshodLy1BZIY/5Q0Jay1TzNoJO38Js8y7dYTSa6/PiolCkOhl5NoSEHWzZBII8A==
X-Received: by 2002:a05:6000:1004:b0:242:9e3:72b8 with SMTP id a4-20020a056000100400b0024209e372b8mr36453045wrx.31.1671475170713;
        Mon, 19 Dec 2022 10:39:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.29
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
Subject: [PATCH 1/6] cmake: don't copy chainlint.pl to build directory
Date:   Mon, 19 Dec 2022 19:39:19 +0100
Message-Id: <patch-1.6-95a6ce2f1c7-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When [1] made this copy of "chainlint.sed" the script was invoked in
the test-lib.sh as:

	[...] sed -f "$GIT_BUILD_DIR/t/chainlint.sed" [...]

But when [2] replaced "chainlint.sed" with a "chainlint.pl" it also
replaced that "$GIT_BUILD_DIR" with "$TEST_DIRECTORY", invoking it as:

	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0"

So this line could have been deleted in [2] but wasn't. Let's do that
now.

1. 7f5397a07c6 (cmake: support for testing git when building out of
   the source tree, 2020-06-26)
2. 23a14f30166 (test-lib: replace chainlint.sed with chainlint.pl,
   2022-09-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 80290edd72a..c641e9349c9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1106,7 +1106,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
 		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
 	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
 	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
 	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
-- 
2.39.0.1071.g97ce8966538

