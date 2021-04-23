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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC80C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28F8613B0
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbhDWHWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbhDWHWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28EC06138C
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so72407851ejc.10
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPSUHzZZL/xBCnSrflKB6XEtFMD8Ya2BEQX9miZhu5Q=;
        b=Tv0BSbCNXgQQXpaWMP+F1c/Gh4FdgY/YNR5jPP7v9GLGwBx4OtZhPv00FOUwgBH+Cn
         eSJDt4J0taRRRD5tQf18aXUTiaq1EWi1QC+P7viL5kZbkC9smVGxGQ1E7K4SySaPUgRT
         DHFBkZDSLzTQVPM6JhJkZ/moSNPpoOkC8wEfJww9sKrc61UZCe4Bvc8BrlYIs0qSml/z
         TrPSbKMpkblo8AMIptCFLYxev8Wm6Uz1p8IJl1OGzxJ7fjHk1jbdux/iwfml5LuCLA/V
         5AZIzsyCHk8TxuQfyujHOTsvqxlr2cWb+4OK2TiTcapaJKcby3Fy8SaVXOzZFIUMr1IG
         7ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPSUHzZZL/xBCnSrflKB6XEtFMD8Ya2BEQX9miZhu5Q=;
        b=uCQP8y7PmIm8tjNB6SFpJWpSgMPy2bSefRdDlGvnV8nvvWXpHgLj+QE0YEmmJ1oFyc
         7tODZNb371D6njpl0T0bTYxz1LZnlho+zYSFd8NjXUTvByIv8J5PsuKGyO0J+oLPCMtq
         XrDnOlaZj9hlB7xFQFGXL0r0JlHdnQEgwbXsAT1ixV5NhI0DG+Ch2QWzFBkfckhwNDzp
         9jqET4c+qwarVX/zu3wcXjvAB3+itLaxYOKg8jqFUqbknk82sjh/HSFLESQOz/y+RmYX
         byfDj3E/MeMB64fNBpQSinVLjwkNV7Kvagx4tgqEyhh7nKDFc+/t4qX2kk7gq1kogb4W
         wosQ==
X-Gm-Message-State: AOAM5327s5E7XIg/ueZhEQr8otbejBEjBHe9a6yKF+XPTUP86CLfnq/z
        EaGTUmt1kIhpbigf34kV6xR5lzAlpdRJMQ==
X-Google-Smtp-Source: ABdhPJwg5Ip14mRA8GZn9t/WrHI3A0zfB1/RlDcIe5fvFJzMP68K1fNRjedSZndMfYnIkMyrSvphfg==
X-Received: by 2002:a17:907:3f9f:: with SMTP id hr31mr2648806ejc.349.1619162490205;
        Fri, 23 Apr 2021 00:21:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:29 -0700 (PDT)
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
Subject: [PATCH v5 09/11] test-lib: reformat argument list in test_create_repo()
Date:   Fri, 23 Apr 2021 09:21:13 +0200
Message-Id: <patch-09.11-f67245ba40d-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reformat an argument list changed in 675704c74dd (init: provide useful
advice about init.defaultBranch, 2020-12-11) to have the "-c" on the
same line as the argument it sets. This whitespace-only change makes
it easier to review a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 701518f5fd3..7101030f042 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1250,8 +1250,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
-			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
+			-c init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
 			init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
-- 
2.31.1.737.g98b508eba36

