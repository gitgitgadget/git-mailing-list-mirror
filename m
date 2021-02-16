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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC3C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5E864DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBPMBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhBPL7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BBC06178B
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r21so12546991wrr.9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xO6YaabHz+fW0JTg9kq/ZrOKjs1k89A7hMnefudwrG4=;
        b=fYt50uZDnyr2tCAXPNThXHxkejukGh3XXPImM1/2iTXct5+S2TNy/GR2H6s4v0jHhh
         wG3CYeKmNwKfkKOa8a9G8gUNFcdNEq4ZZrf8fa944RjnzMXjTPgzxZcC10Hw05R4b8kt
         nm+UOZEzCueGdF7AyLJ0tO89cZG6JKJM92i28iZ5fDr0lZbJCts8zMb0+opJ1PAAT6YR
         aqQLu2PR3SvCEtKVkbwysrxlNoBysQ0NhKnLarewyNQnGZPqFBhOQ0SDH8m9m7/epY7g
         1HnQ3t384RuWQnebx8c7nzZtYnEdGyWZDbvFNkfuKRnMgVTz9Htd/u3chLcYm2oOEL+3
         idCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xO6YaabHz+fW0JTg9kq/ZrOKjs1k89A7hMnefudwrG4=;
        b=Ps+Ntcn7Er6yFwEw8/WI/uhHuLNRJ9aJVkwnNlDIOfru+c6S/zunirJesl3mlxGDI0
         R7+0qWcz3v+08K4sbkoLdIebGMYPbMNHEDoBfTIRmHj26MuiSHC/amp3rtfEEV3mzZKw
         FvJ6lJCKjpaq4pTRaOn8h6QAlZS9yHi8XnOIGmpNiSYaYExbTxihtmDSs4Rxc7b26nbF
         2hhtgQbA8uFJeMjUpPuYnOC2LNwgGLP9Vg9v2zI81TaytgjdZXPvLrTmvhZZ877wpLOT
         KsoCvfCyHWhv6Fjqmq1i+WodEbQQmEFsqbQI3bf9cLslfFFCvez0jmas4BQqBa9yJxwn
         w6Bw==
X-Gm-Message-State: AOAM530RocmCsWseBI26BqlMw4omXe9nSi3Uwv5Yg+OSzvaCuYC7enQE
        kbT4m+boCqOQwXOf3VgtS3Uo/Kl+3MIB7Q==
X-Google-Smtp-Source: ABdhPJw9Aj7rO8r3KKD7XL6CjdG8GxHOwLu7bcI2V0kwqLOVQZDsL+eZq1k93mraeX2qlc0jYQWvJg==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr24193985wru.111.1613476698080;
        Tue, 16 Feb 2021 03:58:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/22] pickaxe tests: add test for diffgrep_consume() internals
Date:   Tue, 16 Feb 2021 12:57:45 +0100
Message-Id: <20210216115801.4773-7-avarab@gmail.com>
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
index 298b25265f4..e5fa84816a5 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,6 +106,21 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
+test_expect_success 'setup log -[GS] plain' '
+	test_create_repo GS-plain &&
+	test_commit -C GS-plain --append A data.txt "a" &&
+	test_commit -C GS-plain --append B data.txt "a a" &&
+	test_commit -C GS-plain C data.txt "" &&
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
 	test_commit -C GS-bin-txt --append --printf A data.bin "a\na\0a\n" &&
-- 
2.30.0.284.gd98b1dd5eaa7

