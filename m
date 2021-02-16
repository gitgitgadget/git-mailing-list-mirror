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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D368C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BE464DFF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBPMCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhBPL7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF4C06178C
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so12621741wry.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMpZ+Z1bLctXjkvVjyxSZMlzXdmuZWhBRV5Bf/61Onk=;
        b=MCFkR6eGqC00Q7wo8PA6WkD7uSCDIhfimhWMeP10WqL8/67ePuqG2mUP0pkxlk8Ct+
         aUDwvhbTLyUv+fYJKgQ3/YRZayio8eOObV0BlnuPdAcnxJ4cYPVt8/yp3qfihTkjinQE
         7J6iOA3KC7n2xvdKlDlhyR+ENtBhvKeftNK6P3xJT6nAVIfKR/m12nGnBkAOxiROPsvO
         H1sIFtOcVFWxJPcBS2bQdYQumgsuGutsYj5B827t+XgOS/yirD0eBoDbHsWLC6vmzADS
         7+YRbS8dXfTBjgfObjDdjxNxqjft+sU7V/2nWANetd7IjvGj+4BiAsGow53go5uNc6ZA
         pHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMpZ+Z1bLctXjkvVjyxSZMlzXdmuZWhBRV5Bf/61Onk=;
        b=mhral7aGYgUH0zM+FxO2NvncSC+PXaUaXjl192fv/8bvwmFOHMrZdDWigI8L+CTwP/
         6KKwqUcCIr7sP797J8swRK+wrfBsCRiaXep+wHR3zSbioJEnRPrdjiX/TPOZv6wPpFSD
         44aqwva3v5l/VenqOkA/mhxP4cFufzOdY3kBOk4OE14/IAbm1AdTanlnJHkn0MBoqtoh
         kNc6/h4NSxKiL8XxWT55SbmBEpuor15+QuFRk7erYyythvGT480TuxQYI64B8fWUKd1n
         QX2OseNc8UrItYBn5rLvSSlylXSrqKRXPSPzreGzmjpUbxd7aE6UBKgPhKJVpDmjBnrC
         xHtA==
X-Gm-Message-State: AOAM533a4E5YR1SHNcvH9ncHEO37EhGHyPm01Uf3Qiup8T61svlRBvWG
        0HyZ5GqNXx+XKiXGWjhYRtDmc3SK7/S4DA==
X-Google-Smtp-Source: ABdhPJwG0hn+2Pl+6XDFVE7E3RT3uEHaPMb1rVKh8nfEojutTpf9Ib53ANoHbDZ9WzUYvNVHAb/vgg==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr23686220wrt.346.1613476698888;
        Tue, 16 Feb 2021 03:58:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/22] pickaxe tests: add test for "log -S" not being a regex
Date:   Tue, 16 Feb 2021 12:57:46 +0100
Message-Id: <20210216115801.4773-8-avarab@gmail.com>
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
 t/t4209-log-pickaxe.sh | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index e5fa84816a5..c6b4751d5b6 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,11 +106,18 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
-test_expect_success 'setup log -[GS] plain' '
+test_expect_success 'setup log -[GS] plain & regex' '
 	test_create_repo GS-plain &&
 	test_commit -C GS-plain --append A data.txt "a" &&
 	test_commit -C GS-plain --append B data.txt "a a" &&
-	test_commit -C GS-plain C data.txt "" &&
+	test_commit -C GS-plain --append C data.txt "b" &&
+	test_commit -C GS-plain --append D data.txt "[b]" &&
+	test_commit -C GS-plain E data.txt "" &&
+
+	# We also include E, the deletion commit
+	git -C GS-plain log --grep="[ABE]" >A-to-B-then-E-log &&
+	git -C GS-plain log --grep="[CDE]" >C-to-D-then-E-log &&
+	git -C GS-plain log --grep="[DE]" >D-then-E-log &&
 	git -C GS-plain log >full-log
 '
 
@@ -118,7 +125,24 @@ test_expect_success 'log -G trims diff new/old [-+]' '
 	git -C GS-plain log -G"[+-]a" >log &&
 	test_must_be_empty log &&
 	git -C GS-plain log -G"^a" >log &&
-	test_cmp log full-log
+	test_cmp log A-to-B-then-E-log
+'
+
+test_expect_success 'log -S<pat> is not a regex, but -S<pat> --pickaxe-regex is' '
+	git -C GS-plain log -S"a" >log &&
+	test_cmp log A-to-B-then-E-log &&
+
+	git -C GS-plain log -S"[a]" >log &&
+	test_must_be_empty log &&
+
+	git -C GS-plain log -S"[a]" --pickaxe-regex >log &&
+	test_cmp log A-to-B-then-E-log &&
+
+	git -C GS-plain log -S"[b]" >log &&
+	test_cmp log D-then-E-log &&
+
+	git -C GS-plain log -S"[b]" --pickaxe-regex >log &&
+	test_cmp log C-to-D-then-E-log
 '
 
 test_expect_success 'setup log -[GS] binary & --text' '
-- 
2.30.0.284.gd98b1dd5eaa7

