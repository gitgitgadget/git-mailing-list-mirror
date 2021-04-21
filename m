Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F910C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F15C6144D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbhDUO73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbhDUO7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0611BC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1406022wmi.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EsExcjIp7owzXlWpsf1OOJSOZ1CPO4ebGhp1WzAO1cQ=;
        b=WxqwtNIoCUd0kZ5PX9PBKJnHn2yBUp0xDpCCOau8Z+SjFmjvcZjsxk2K82rgthrw73
         S3FSkpIKQZY9wTd7nkMDkxSBOL5tiTVHbAwOr5fZEaPq9v4xFn+mWca5zklnCT1IAqPk
         87CoDWwHQ6hei3rRtGdFV6Ph5d6WxyokFKcGtdGdqpEEbSeG5ybBQO8jhPVqjSaptKzN
         6AN3vd/N9aPLcJpX0nvFTrzupCmQEWaDCmEu0u2knSnZJqAYMmzyzmcCRvf0CR9mji7b
         RXAbSxUugrbqQoLu/v3QoT59UjPIxc0SqA3dipVaJ8IgNo2T3hg77Y60BNSjBT4qsBxC
         N7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsExcjIp7owzXlWpsf1OOJSOZ1CPO4ebGhp1WzAO1cQ=;
        b=XyI/GHZXAYUQ3jutqKN/QuJLtLqQWMAMCVuEsmUZXyPEQwrWHaMiKdN1PBTGU+w8df
         NQ9+2CF+E98vI/GMhsM4ypEKR3H/U7+GOADYx3mJMg5OWFZniZ+G7+yTi9Hj/qmJtcTy
         BOcfzbWiutxPFTNX9dDcMQY2CThvy9S4KP/01NfnmU76JanIPRDe0NS34WMqaH473sZB
         /Br0gidb70uYorv29Lr5RVRaDd3M+LMYBqgeqg5lZt61neMJ/j74MDMri47x2+Cw59nl
         LrStZvM8yFsm5zKJwM+lGt52qxw190JCweBIVmYOmjzaQs4TL4wgi4NVqJQ9T8AWn/to
         i5YQ==
X-Gm-Message-State: AOAM531v89LNxehZ447ku2qfYczeVZKbHir1iJBXvGD4Ygtbxp9rAWlv
        9xtw64ccF3QI3H0EgCJW2uar+29CKy2mXg==
X-Google-Smtp-Source: ABdhPJxXngo0BDzOhH6WYXaBr8T4XIjoiBCi0wktE1lj+PXD07a8FzrL6ApEuJ7zloZWYdTAUqZE7A==
X-Received: by 2002:a05:600c:b47:: with SMTP id k7mr10172118wmr.109.1619017124484;
        Wed, 21 Apr 2021 07:58:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3394316wrd.69.2021.04.21.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:58:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] test-helpers: rename "path-utils is_valid_path" to "is-valid-paths"
Date:   Wed, 21 Apr 2021 16:58:37 +0200
Message-Id: <patch-4.5-ae5dc5d03b3-20210421T144921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g9a7f2f961d4
In-Reply-To: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com> <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename this utility added in d2c84dad1c8 (mingw: refuse to access
paths with trailing spaces or periods, 2019-09-05) to make it clear
that it expects N number of arguments, and for consistency with
dc2d9ba3187 (is_{hfs,ntfs}_dotgitmodules: add tests, 2018-05-12).

Let's also make it a dashed "is-valid-paths" instead of
"is_valid_path*" to make it easier to grep the helper v.s. the C
function it calls.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-path-utils.c | 2 +-
 t/t0060-path-utils.sh      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 3d7c0f1d19d..af7d7fd5454 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -423,7 +423,7 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc > 1 && !strcmp(argv[1], "protect_ntfs_hfs"))
 		return !!protect_ntfs_hfs_benchmark(argc - 1, argv + 1);
 
-	if (argc > 1 && !strcmp(argv[1], "is_valid_path")) {
+	if (argc > 1 && !strcmp(argv[1], "is-valid-paths")) {
 		int res = 0, expect = 1, i;
 
 		for (i = 2; i < argc; i++)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0ff06b5d1b3..e7fb748b19c 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -469,7 +469,7 @@ test_expect_success 'match .gitmodules' '
 '
 
 test_expect_success MINGW 'is_valid_path() on Windows' '
-	test-tool path-utils is_valid_path \
+	test-tool path-utils is-valid-paths \
 		win32 \
 		"win32 x" \
 		../hello.txt \
-- 
2.31.1.721.gbeb6a21927

