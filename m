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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF4C43460
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90322611AC
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhDQMyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhDQMyN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7470C06175F
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so29220112wrw.10
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mhhppVr96y0Y4r/oO9icbPs9zxQ2sxOzpsUQBag77I=;
        b=NAzQ89KjqDx7v6RSUsFfaSBaIZ6Qhaxxk6DmmcwblvN/LGf+x2scu36n7gAQ9BebXw
         ZtZdMSkHYFw2IeDW2Ha7HX14CC5O1Qu/ZqKeWOnS1BslUYn0iWif6aYfAVIG4xDaQALE
         Nj0NZj2jLkMiwGBpkOJ33fKzeE9Tvq5T6kcaImy+1RX8yGFxwlqvzG7azEIPUf/X+aie
         P51o91xGwg/RaP76ZM9oDwclqkoOFJA4VcefGr+thLsL6d07EehlLEdLoGFWt1HMeZ4d
         /tl4XeuwgACuAK+8BrYwVkbvZId4PH4TmQeaiYTLIy92rLnwzngZDBWymv/d1+MP6/T4
         yevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mhhppVr96y0Y4r/oO9icbPs9zxQ2sxOzpsUQBag77I=;
        b=aCYLf6APVFFs4LEwNxx/Tpd372OlNbm0IY2qRCobv/AxgH0BRgbhjFZoKKvsLm028a
         osOQpxo2weLq/Bi0GiUf/ugqNAOHx44TisXoLRjCUXjk+jAmUF5q+V468/+386CSNYME
         EiP1zgt3bVzb5x6UEeRhR+wndKQErucai/nfIdbfLdjPV/6hyqq28llh06nzALaOj67x
         QVM2qSwydwbZYPdQ3ZFBRiYr0wWNCmIkfFVl970lVa0sB3EmS2bfrh7UGXuj6NEYv9Vf
         7m0p4FXplYL0FYPPqvWJBoEgiln7amZRBlWJaJNEQnYjn/SRH5Q6Og1rkYFs05kOh20u
         2+yg==
X-Gm-Message-State: AOAM532j+0vnSxQLaN/J0noyzGMzNwtCKcJGxTid2hyR7/DmuY/TbZmA
        tudh1hzUVLt+fWlD3svPUCPNODR7u9rnKQ==
X-Google-Smtp-Source: ABdhPJzdQkaDAqYEyfNMq8jqNKiCgfwkDXvinlG8GjzMvtsqkk5sXx2MH2K284rVmj/i7tU1YdVLvA==
X-Received: by 2002:a5d:47c1:: with SMTP id o1mr2824467wrc.216.1618664024459;
        Sat, 17 Apr 2021 05:53:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:43 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/12] test-lib: reformat argument list in test_create_repo()
Date:   Sat, 17 Apr 2021 14:52:43 +0200
Message-Id: <patch-10.12-e0a1e2fd529-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
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
index dbeb3d92628..21271020c79 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1257,8 +1257,8 @@ test_create_repo () {
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
2.31.1.722.g788886f50a2

