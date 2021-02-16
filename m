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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1545C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D8864DA8
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBPL7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhBPL6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:58:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D75C061756
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n4so9612546wrx.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwYSy4eIokL+oXXGdhKmB4/bHOdVvXUfzs8vB1Dh13c=;
        b=qoMza1ycNS7T8SNmiBXvH7HG/QqojGmFsxnh5rTC2z9AAj+rpSOKW9l8cuJKuspJmZ
         ELQZyKgKnZKzzP4yuSPYJGc9s7mL1R8MnTcT7BFwh4ZSL7dcLB/eVMeSwG/3djQK3IYX
         ASOgT0hpjpqskgtsHKaeNgRhlNM0dce49Q+egAjybgiVpywpgHFQMxnO2BMbbvvwIu3m
         V1LnriRiwZk/55fDmX+G9MKeBHNkigT/mjVfniYfS5Zyw1M6MwNlYw7+sDLGMLypE2FF
         816q8PitKZj7dtkM4ErCabf9H9i4tCl2iBGTi3OFo6yEW5PaNH/lXzny1u2kvRVKtPa1
         07cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwYSy4eIokL+oXXGdhKmB4/bHOdVvXUfzs8vB1Dh13c=;
        b=r3u5is0ftzMXc333IXUcD0H2MKz5sbf9hZze2BAB+hytpLolL8Z//Lg6P1b9+CsGVr
         EX26o18BxxfzG4utqODprxd66ggT38TmEvHUDD30Dp0rEIIz1n/1bXK6Y2b9lM9kOKhD
         zoeIw75olTv/DR89YRYt8ehaoY9jrowSx84483RmAkL6O+eh/tq9fp0Nz7PpG3U+Mqx0
         +YniGASHU1MAruHnoJ4YNztcM7c/IrsWFggF4/l9oQIlmkdwBpYCjxsBe5CtGDOR7FsK
         Ao3fr6ui61UvJ3MNVDLmF3Ot/pE09OQZQVeNRkEoz7Xo8tAG6XNLxJe0PlTYCwbv0mU4
         TE/Q==
X-Gm-Message-State: AOAM530RGMblhxE9V5pi41tEUJhuozg/qutHPuTa2XZIzQEHotlaBb80
        2krA2Q3S4u73r7usZVSnTwaYObDRqFe6Zw==
X-Google-Smtp-Source: ABdhPJwgF/olzUCgmBvyDHajd0DYh6dJShqqFByuV0xnl3KDOsegqvxbqUStxFvR1HwsAWxxwnL0QQ==
X-Received: by 2002:adf:9504:: with SMTP id 4mr23343166wrs.306.1613476694018;
        Tue, 16 Feb 2021 03:58:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/22] grep/pcre2 tests: reword comments referring to kwset
Date:   Tue, 16 Feb 2021 12:57:40 +0100
Message-Id: <20210216115801.4773-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The kwset optimization has not been used by grep since
48de2a768cf (grep: remove the kwset optimization, 2019-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7816-grep-binary-pattern.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 60bab291e49..9d67a5fc4cf 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -59,7 +59,7 @@ test_expect_success 'setup' "
 	git commit -m.
 "
 
-# Simple fixed-string matching that can use kwset (no -i && non-ASCII)
+# Simple fixed-string matching
 nul_match P P P '-F' 'yQf'
 nul_match P P P '-F' 'yQx'
 nul_match P P P '-Fi' 'YQf'
@@ -78,7 +78,7 @@ nul_match P P P '-Fi' '[Y]QF'
 nul_match P P P '-F' 'æQ[ð]'
 nul_match P P P '-F' '[æ]Qð'
 
-# The -F kwset codepath can't handle -i && non-ASCII...
+# Matching pattern and subject case with -i
 nul_match P 1 1 '-i' '[æ]Qð'
 
 # ...PCRE v2 only matches non-ASCII with -i casefolding under UTF-8
-- 
2.30.0.284.gd98b1dd5eaa7

