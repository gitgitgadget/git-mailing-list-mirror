Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ACDC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999C36147F
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhEJPQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhEJPNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABBC0515F4
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so16885939wry.1
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4sF2WvJXZgXu6d+L/kpeRGKg6tZYXro4M4z+qhuE/w=;
        b=igJ/3r2UZE9rvfi5x2fpMmICzNLkxgeYmZ4PCd7Nfbva4yNnLSNQPkGLhwnaz2MrNL
         ZvPg4faV80YZ+ZNCsthCvFMqg/EF/rb/mzakf3+jWwWJgjWneZmeHuj3xY2+RJ+U3eC1
         XdVml05dPvjnmeSs8uxDZ5q0e6BMBeZzfvGZ3tHVRBSXqAxF6//4kqWK7Qj06Jm6ZPQa
         Wl7acen6ljnN+gHcH5jhILEqlie+SJ8nV7Ll2UY8RmZnHBnU1srZIFojs6kNW5acQvkl
         CDDqMnAYRJ09L6tlP3AaRGMHHos+P7Oz3Maz4cCEdR/gbHTeKomglhmUbE+VNynKZGAG
         GwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4sF2WvJXZgXu6d+L/kpeRGKg6tZYXro4M4z+qhuE/w=;
        b=k2zWz5MtUt4GNHEokc5qT3w9Q+ebY6Vi2RZBrlTwJihzY5//2cRLf/gaFBGUsevutI
         4lmG5pJrtNmpudpxH4WoPGDnvMLCuVa4GiIP1G3wA4VNm867jSHoBRBbuWMy1HkS1dLT
         Y3Ew2TAgdCeK/f1zegOtoAHvoCcbKMNa/yWO41vqWdJn50mA+UcTvbsSc+fzpgd+3Lev
         DCeHH2qb/enEfYc9UJyOJF4fqIN32BmsTtEt+24Lxmc9y4PDJORIM611wg6aycTvxdHW
         QLaQVVi9TLiwqiBVq1qciD759+FL6AsbvE6EEB0geuK2pHeabT/874xs91gTYWijmrY6
         smgw==
X-Gm-Message-State: AOAM533fCky6Ki4AlRtIaM9uKxg06ojuqaUA2ue59xuJgf54tPTquwA1
        pXJKoEkZrr7cFdrMFVy801CulZ2slmofag==
X-Google-Smtp-Source: ABdhPJxCeMu+LS/iSvlqS6VFrcyBox9445mSyfZZ4YSifcX96uysdtq1P91T9/jF/ysxZd7k4zv/Bw==
X-Received: by 2002:adf:ec4a:: with SMTP id w10mr31165209wrn.388.1620657141978;
        Mon, 10 May 2021 07:32:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:21 -0700 (PDT)
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
Subject: [PATCH v6 09/11] test-lib: reformat argument list in test_create_repo()
Date:   Mon, 10 May 2021 16:19:08 +0200
Message-Id: <patch-09.11-c806f3888c5-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
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
index b242ecf5cd2..661597e9192 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1252,8 +1252,8 @@ test_create_repo () {
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
2.31.1.838.g924d365b763

