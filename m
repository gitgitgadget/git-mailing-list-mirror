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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA4C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB7B22D5A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbhAETpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbhAETpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A637C0617A9
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r3so364686wrt.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0UJ+359V/LQdHfLW7yM0GtnBSIOEuMSuU1g6/NH5NI=;
        b=iuoi4WgnxQdKYbcZBPBqIR4e/0gAxulFdszI6Htp+B87TeLEz0VvflcOqMDhT2Hhq9
         UqPvqDT/5sfpIom7xQYetBmumdiRcQEfJa/u5HoNg2jDtX5RFONEdhPcF1m4Bbq5e1Q/
         FJ556asps3U7aGwXBn3JS2vfmaGhrzMjSyFonMKv5lasOwZn79KWhd2yi2uyZqa4uqDR
         BPYYOyGzfegQYy9OsGWCDt28ZdhsC0rgA7eF4zeYqnuXxg+9j5iq3+76NlAYnMN37LXd
         GwA/sl/L8GnAeZikOL1mwtol0HwPyoJD/vHxzqy2Ci62p+BhJjQkLNgct7AhLHd4CiFJ
         02vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0UJ+359V/LQdHfLW7yM0GtnBSIOEuMSuU1g6/NH5NI=;
        b=B8r+4UhwEre6CZmLZaGUnpPWb10ocRWTScZfhUpci6vdRAMGAG9RbZ9tMlBMB0YGBM
         KYeb7i8IphXAZ5qQDXk0F6M6PY5bwZihzDrZn7EdPew5EQ2PfaokKBZLlbJxUxUDdh2h
         G8jlZrbce/bcKiXA9qw+8+WWkDKz726JFSRhDHHhoOt4gr4YCaNSJLVhI+SIUDBoUL2e
         L6sQQIEurlFXqGa1LaD1Z98aVQY6IAIA0pmEU08qbEDqbH20JmyFcdnNzNRTj4C/sgLH
         hBPQp8MxsW2jQYJtX8HYC6U2kdSw3PynwVaTH291+dbOw9ion/lce2HaKShyk1GXw9GY
         xGsA==
X-Gm-Message-State: AOAM533Dbgoh+e1LHUY2pPK1gHX9M8LoB0dbLYzYEfJbZaPr7U+cK6oE
        G0/E/vOdUG0l6PTKNZgmXLpdGV9qoit8Vw==
X-Google-Smtp-Source: ABdhPJwJfC7g8CuYA8oCUV/n/LCuvTle6brQeFLEUY935ACyKrIXOYikG1tcMK0EST6vFS31ravSwA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr1078046wro.258.1609875822992;
        Tue, 05 Jan 2021 11:43:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/23] mktag: remove redundant braces in one-line body "if"
Date:   Tue,  5 Jan 2021 20:42:44 +0100
Message-Id: <20210105194252.627-16-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This minor stylistic churn is usually something we'd avoid, but if we
don't do this then the file after changes in subsequent commits will
only have this minor style inconsistency, so let's change this while
we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index ff7ac8e0e5d..97ca5f28b1b 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,9 +161,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 0) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
-	}
 
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
-- 
2.29.2.222.g5d2a92d10f8

