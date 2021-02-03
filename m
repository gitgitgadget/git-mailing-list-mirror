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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB5C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2CE64F75
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhBCDbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhBCDaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:30:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E19C061353
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c12so22583518wrc.7
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PisAbqgdNAJawXaeTXA0FBQ4IO1QJAnJIepbN9A4z4=;
        b=nxlrLUkya72r2YETasdSGocV51aDgPKk1CDhm7V2auIhiym0RCbz8k35ZtnmoKInN7
         AwqBNaf1aNNjVWrqq1XrY0fyXv3BwlD0n22lN0pZ89lBODPBk74323QDJfG4E3HgBcuk
         NaM/3iDLEx2cLA51deDPteJbvgw2OKjQW1LKifVX+1rsEo8fq7e8GGymmhRBNbz3hm8c
         SruvXYFP3XLwJeAL8SVIIJM9XcqXOI7+5lan5sfFsjiXIQZwO4po8pZ6yfEyeG5iba+E
         xgYNXX4/2W/2c9weZq9ymcM3deEXRlg/BqIG11KCSc4Pn8hsGscLrHWP4MuO4dqe5niU
         FOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PisAbqgdNAJawXaeTXA0FBQ4IO1QJAnJIepbN9A4z4=;
        b=nqbX8vhJFHv0nPgPMwkyAtCbNQcpwKX6mu/L3/kZA8CFQiZ5INXZ73yfi7XIUTT0Jk
         m0n9b9kGCufElmLzx/REgqtKyG6mcc2GGh6sq/o28hrEPDnwq+QULJf9Xj2KUxMCA/ad
         QC5NRGH/U0zryezIvUlxR8CqkPkMZv5DYeKIOLTyMYZodTHxKzSFmWwDriIhSaGaEQsK
         bCF3vZeXC+kMQbYw6SYn3epwJsIps4ut5JD81+b/Vy0vRQtAk4gdiH846Eow6nQ2ALUd
         BcF77PEGrT/yU0y84KRPgT7g0CD1hoYM3sFNRk9yzOv2mHFrRQNtzsndfKRptSHRr//J
         esTA==
X-Gm-Message-State: AOAM5320Cx+eVJiU6DeZEtQCQGpQsJEO3/gd7ZwBnM5urvNAsTgjzqm0
        L+i7/r5sSdgs4+4ULXhE9Hfc9RmWYjnTfA==
X-Google-Smtp-Source: ABdhPJyBi1m+sK4l2cEdh5eEX/QrJzte3rFv0IbGcBgZAh6QcJjQ6fz6sXcuMhs9VtNkcISDVbc4ng==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr1034956wrx.91.1612322914330;
        Tue, 02 Feb 2021 19:28:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/25] pickaxe tests: add test for "log -S" not being a regex
Date:   Wed,  3 Feb 2021 04:28:03 +0100
Message-Id: <20210203032811.14979-18-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No test in our test suite checked for "log -S<pat>" being a fixed
string, as opposed to "log -S<pat> --pickaxe-regex". Let's test for
it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index ebd51f498b..b59aaecc68 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -121,6 +121,17 @@ test_expect_success 'log -G trims diff new/old [-+]' '
 	test_cmp log full-log
 '
 
+test_expect_success 'log -S<pat> is not a regex, but -S<pat> --pickaxe-regex is' '
+	git -C GS-plain log -S"a" >log &&
+	test_cmp log full-log &&
+
+	git -C GS-plain log -S"[a]" >log &&
+	test_must_be_empty log &&
+
+	git -C GS-plain log -S"[a]" --pickaxe-regex >log &&
+	test_cmp log full-log
+'
+
 test_expect_success 'setup log -[GS] binary & --text' '
 	test_create_repo GS-bin-txt &&
 	test_commit -C GS-bin-txt --append A data.bin "a\na\0a\n" &&
-- 
2.30.0.284.gd98b1dd5eaa7

