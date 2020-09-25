Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C76C4727C
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098AB20936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSSjQSuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgIYO2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgIYO2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC7C0613D3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so3542016wmm.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LbzZ7rratphdzpKCzScQ0H87PZ4mOGWV8pJbumS/i3M=;
        b=QSSjQSuTZdmNQJ3+Ij6Ulwixb5tI0DU2Od5KnB5N0D2B8P9H8UexigLIgmpcpwI5Tm
         z+kDAvqzPM4CmqveR98lYHlKpsvxooCTQy/bIskPmn1f1WHnrdU39bKpctMAxf4k9ZEL
         M8oF5snBysUINTg7iR9QxbgF/aNbLPQC2rw9B40PMllDX5frANJvjdqme6tmN/lg0Ynq
         AX9JhEtNNgjiLyH09Ru2O/Yk2gMpxpvZZFtFiImf834WeV1cdaT9Jib0ZOXZD6Sqbvcs
         ScWxicZlAYqdur2s1xO3eeuUav5ejGrPyxeOzlxu4BnGdB1vTzxr4K28IvTGKHnBjuT+
         PNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LbzZ7rratphdzpKCzScQ0H87PZ4mOGWV8pJbumS/i3M=;
        b=CpCEviScRKLUXerdyKCsbpAbUdqDR8Tl3aK4QEMzkTg0JhefN94eVcn8/O53s8vOmF
         nLlvNRHa9rehjrvvGf0h4/xiMVZ3Mv/ziXlL/dkFYz9ixDHWYeXgNj5uTKNLalNEgF1f
         OOx7A9buQ5qxVBHaso1sMsblpYQ5X6F6PAS7Z0F35CHPQUX2Fok9QfmPmMy6gLXmWkv0
         wfBj+x/AUmfJRRPbmbtWqaYq+c/aLflDyVbayost4nqLmhkNsRtShG6Xgszb/ktclyDA
         39cH09Dh8WLVrwHOqXoYkX+LviDr7fPlpXOIpyE2vTj9ViaZrIXF9cdfUFEkFicK82gZ
         VVOw==
X-Gm-Message-State: AOAM5339V/sm7RzGQcK52tqBmLq8Rnu5Itv3t8fK7fYIEGlER/cN5uLs
        B62KLxIP3yHPo7rw6gXYU12+qbCMMlE=
X-Google-Smtp-Source: ABdhPJyssYx5fqQcoXycyJwYjJd4EctPWa0Nh2y2LkH7wQ7COhDqK69+Jq/jfCqoWp7nymmG2PJgig==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr3679754wmi.121.1601044124288;
        Fri, 25 Sep 2020 07:28:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z127sm3222309wmc.2.2020.09.25.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:43 -0700 (PDT)
Message-Id: <8b3500a07c67d07e0928e8d6638d618ab118e1eb.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:33 +0000
Subject: [PATCH 05/10] cmake: quote the path accurately when editing
 `test-lib.sh`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By default, the build directory will be called something like
`contrib/buildsystems/out/build/x64-Debug (default)` (note the space and
the parentheses). We need to make sure that such a path is quoted
properly when editing the assignment of the `GIT_BUILD_DIR` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index acb197fba5..e66ae137c2 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -952,7 +952,7 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
 		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
 		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
-		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY\\\"/../${BUILD_DIR_RELATIVE}\" content \"\${content}\")\n"
+		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
 		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
 	#misc copies
 	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
-- 
gitgitgadget

