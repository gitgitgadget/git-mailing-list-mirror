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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72FC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D8464F72
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhBCDab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhBCD3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8098C061352
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so22606094wrx.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b9RieoyOdD0CIVbhSBytPUXJeqtwuDtxmewDnHnx70=;
        b=JjKb+ijz9T1Hbcqy1Ydsy8o34jY/n6bfaX4lk/1lP92oVuyyh6Ila/+2/U8znlR/3/
         fmh3TREBqGFYrxYJpG4y2l751Zt+V3qJ2wBfIoFpyrLNES3ImuT28Y7M3ogTGK9t82TU
         NGlle0cl4vaBy95EE2713aKafI/+kFuasDz+psK9bO5TLpodE05k5MsYUBl0DJ+Qht0Z
         2tvMrXECrtEr1+a+xMNFFYuZFMJrTIzj0I5VhyA/Ibl6j8lNZX5/eXUwsT0h6bEhf+K9
         ZQVDlTp/TKs/n14jB/Q+1ERLhHrBcu6kiUizdnKtY89MNtVvu7YjXPUzt4xkXOdISb8u
         Z4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b9RieoyOdD0CIVbhSBytPUXJeqtwuDtxmewDnHnx70=;
        b=nBmxMF4v0leH2eA5IEqC0M4wZ41fbqCvHstXw9cFhD13Tj9qxe9GbOlphw3Rt/ZXOn
         048ebdU++qkIXAEJpLodSvb71LABatD6UojIPS7fG6DMUPRiy7IFecgOFVLw2iUctO1U
         xOXiDWpYO5V3eSuuE2yZM78NrY2QsAdgQWQUP/zRpIpBJPghRKX2wQgbZGZCcxCHwG0H
         ZI2nes26PyUQbhp9sK50y4WbhEKw4eCQP1dkebI33iCy5UziPEFWjxzXWgpK5e9TOwh4
         uDi05XJmJd9g7AFsYs9B358YZ4pIs2Cz3dJwGdhhKdVrJHuyTNrfPJlvpKs4Ng6VGUfk
         Yc+Q==
X-Gm-Message-State: AOAM531tLigTKhXfPy3WOBq4nI2VmT83E91HKszZ5mhxTve4swamZXHE
        4rz1XK3Zo4M4RREx/kRogr1ZpVYkYUGHDA==
X-Google-Smtp-Source: ABdhPJyznwIb3bt0pJLAhR15GK3jtCti3jNnzbIlwhkuDPeW7lsOd/3fdSZeoHde7Jx234UeMcZ72g==
X-Received: by 2002:a05:6000:1547:: with SMTP id 7mr1045140wry.301.1612322913365;
        Tue, 02 Feb 2021 19:28:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/25] pickaxe tests: add test for diffgrep_consume() internals
Date:   Wed,  3 Feb 2021 04:28:02 +0100
Message-Id: <20210203032811.14979-17-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In diffgrep_consume() we generate a diff, and then advance past the
"+" or "-" at the start of the line for matching. This has been done
ever since the code was added in f506b8e8b5f (git log/diff: add
-G<regexp> that greps in the patch text, 2010-08-23).

If we match "line" instead of "line + 1" no tests fail, i.e. we've got
zero coverage for whether any of our searches match the beginning of
the line or not. Let's add a test for this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index bd42848871..ebd51f498b 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,6 +106,21 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
+test_expect_success 'setup log -[GS] plain' '
+	test_create_repo GS-plain &&
+	test_commit -C GS-plain --append A data.bin "a" &&
+	test_commit -C GS-plain --append B data.bin "a a" &&
+	test_commit -C GS-plain C data.bin "" &&
+	git -C GS-plain log >full-log
+'
+
+test_expect_success 'log -G trims diff new/old [-+]' '
+	git -C GS-plain log -G"[+-]a" >log &&
+	test_must_be_empty log &&
+	git -C GS-plain log -G"^a" >log &&
+	test_cmp log full-log
+'
+
 test_expect_success 'setup log -[GS] binary & --text' '
 	test_create_repo GS-bin-txt &&
 	test_commit -C GS-bin-txt --append A data.bin "a\na\0a\n" &&
-- 
2.30.0.284.gd98b1dd5eaa7

