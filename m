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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9028EC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587F961447
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhDUKQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhDUKQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0FCC06138E
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w186so17342105wmg.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugYBEu6VR1aRMDQbiOeT1vLNAj5nVEwDlRbxpvxk3oA=;
        b=oKFUETPSRDWzcfxnYA7DkvXpwPeGgJhToL2YA8LP+hDp0WHhuZieLE2salN3vA+59P
         pyiRX0Eq3bVlMNI6LSFH4zkKZUqDZpxgcjvtjki7BiH6XLWvTLUoq+h1RgABNpDkYUMC
         8CTwiBpdx1jvExbq5wt/dRPlHJqd6VpR6HNKmOTYOgx7cp7ADDNY2YBV81U8LqSval1K
         Tmc6ePkO4toRyThTvBlbxb6o9DhkANl7V1NWVZ1YV3gfoy8j1RJxLU6Ht148nJ0oxtyE
         MsgNwsnUOjZIQh5SD1AgjvPGs6AGJI0yoQWpfq6h3ZAKCAmgsEJom1kfId9o14D6igE6
         pZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugYBEu6VR1aRMDQbiOeT1vLNAj5nVEwDlRbxpvxk3oA=;
        b=e5NQEuHq0E2NerEBv3AyTRSG9PCd3HTCV2ErhwcD4bNaYMmBRX9reFDd4zECnFRQgq
         exvLZy+rTkVj9Ieb9v7AXTC4gEi9AIrXzak2RZ4n8Le+SV1wmigoWMRLBU/xrE7nQrNy
         SpTJ+9aejqt9t3ElkWAcyw7RVIRWluFIW92X2/4lfwGmU+MsYEBlQvmXVM5HtEfSxXmx
         taW6+eRxyCCl7rbYAT6uCGfe8AQZhhFjmHC8iQvkiwb/8x1WK89sHyY8y2+9OT+LSg2V
         Jo9pCroWiS1VvfVTZE1zhKdfoZryQnZrckfwZExb4ICTnLQ2fHmKCvdO3FS3uQN+ZXIW
         UwmQ==
X-Gm-Message-State: AOAM533qfCKSLoVa6j7YaIPyK++nPTnILl+eZWLLPnfmo7bNUlewRQ0d
        OufdnxeinFxVGNpgugFVEhPcbRQBeyu/0Q==
X-Google-Smtp-Source: ABdhPJxpWGtfyOlnejpCBlaVYdgZHC73cKqnmrr/IueGJm7kx1tHK8SBXF0wOTgRSew5F4zD0iD+Wg==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr9055887wmi.178.1619000127016;
        Wed, 21 Apr 2021 03:15:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:26 -0700 (PDT)
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
Subject: [PATCH v4 09/11] test-lib: reformat argument list in test_create_repo()
Date:   Wed, 21 Apr 2021 12:15:14 +0200
Message-Id: <patch-09.11-9ee13ee71b-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
index dbeb3d9262..21271020c7 100644
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
2.31.1.721.gbeb6a21927

