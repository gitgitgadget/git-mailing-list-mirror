Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0709C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9276134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhDLLJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbhDLLJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE72C06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p6so5759922wrn.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUVrMUDo9yDe6nCWrB6hmxvw6riSKT5gYrc2KiZY3kA=;
        b=AZEjhRY4xGyc9o7WVOE5gM5r4Z+GcyzsZpXbc9RBVNMr3vc12sTKb3EvyH0/cO5v3l
         ecDS5/t8C5JZXA5Tf8ELQYz//0pL+X2lPoiVGEUaBY0vK2Gis/WgvUhvNZqDDSWIzL6B
         1Q7dIkBLCW2+IK6x+nKEDHDAfutK4XYjw3EYdBpioD7HzGsDspdruGF2olouZafJTVKB
         cq64i3eZbGlDJ9k25d9kZOTh0bv5vZFsleOXAfo5Ztn85jSIXHPN5IaLsOEmFnJ2QGtN
         HIDa+blIxi7VM16Tnk3/9L/TqOH/rAxgqDojwTbkRyxRH16rzS77yQHPJW2ltKXVBIlx
         uV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUVrMUDo9yDe6nCWrB6hmxvw6riSKT5gYrc2KiZY3kA=;
        b=b1QG/3KkcAZbtAJApLm6QTGh5hZYepNilHO/lBkvaSX0L/aP40Jdd8O5Wb24OLg7O0
         +khHASirr/OoqynZrJcKRQj8K409xGuf3M35ZK80LUiu3GKagKB3g/w3AvwPkjXtaj1e
         0SFEDm1I9S0amPDKzYlD4wwq4OWxUpO3UOlrzJwTEAVKTmlmELa4SI3CaNSsxxRYTkdV
         5Q0PvaOJasagmyr/BhlETC2kqZd2HU8D3zACl+mVPB7Gc4Ee39ZvzFwxGtgrXAsKbrDe
         aght4rf2ULRTwwKggQnP+FnYjSmajqCeguwDznJn42zrlO2+dU+PrD6nlc5VmfV2AYLJ
         hypw==
X-Gm-Message-State: AOAM532ZneDuUVRlFDSW0+qzMWQ/khdjRkRpMJazfcMZ+iN2sC7CSGNZ
        lP3CpE2uFa7Jo8mSZugilWqdjijVO1qqGw==
X-Google-Smtp-Source: ABdhPJzMfrwnDjFZ6VQkt0iVydHsBzMjLd7+WykcEl0Iq6o7bvUrHxIPJ5lQueDR8b16c2yaLhdn+Q==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr7322141wrj.328.1618225758099;
        Mon, 12 Apr 2021 04:09:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/16] test-lib: reformat argument list in test_create_repo()
Date:   Mon, 12 Apr 2021 13:08:59 +0200
Message-Id: <patch-10.16-634038c3a8d-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
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
index a90a6b2cc27..674b865a20d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1258,8 +1258,8 @@ test_create_repo () {
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
2.31.1.634.gb41287a30b0

