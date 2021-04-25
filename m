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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A94C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4953613BE
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhDYJMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 05:12:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FEC061756
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:11:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so232291wmq.3
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqU+TI4OTxVNs6ILQw7UpQTINa8L95W5Qe5B1cm+/2k=;
        b=hGhPTrDxh8fx/0Jh6pPr3uc6xswFxqeRs4xdWotfjUQ978OMVR9NsLMyFv6YqE7PKI
         tNcZIONHuA7iRgR80zzMAzMRlQ2T132HZ46I9bfX3kUwAcKDrd2egO3Eh8OQKG76Qm1J
         IwBj5aBPZEgx5dxjVv2YaKyFW0fm4uiGTuuOL/ktsbHVL24BnTbA2pqFjrhuxpZAupjS
         8KLj5LX4BfMy6zzfNb+q3uqySGUZjytbU44bFtInvIPwTKd1yHa350s1+hoWXkltdmj0
         LFVV9ix4wzXvMXohC3donyOFjUFD9tJgyjybNuJsbolM56YbK76tVZTjEvECjNrjQIUn
         OwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqU+TI4OTxVNs6ILQw7UpQTINa8L95W5Qe5B1cm+/2k=;
        b=gGVCuWKnZ7cNMUzua1yOYvX/Rq671ZVxNY/aVsscr8mdKtOnvGJKVkutijE5ycbrSO
         6i6dZ6TqyFESOVbfFIYLLdxsffXqvNJ6SIckDXmDqGMiw4wH1Cy7M8WfwTuzVs1g7dRz
         HSevj2YjUCiW5DFJgknRPWhTh3MS86Cvt9sIlvj95efQdW4526odUINwAObpJiAYYI3s
         hjkD7yWfVVJ8idpJz6NDX1Ni291f5WTfO/hAH00jnvzhafl6NSe6OfK5MRBWbyE2DwDp
         EYdR4145GOUryT26CwyvO7iwa2HpH6J9vbNWnUCvx548g+UTubYDz+k103OAGswy7OTw
         W2UQ==
X-Gm-Message-State: AOAM530juMpwe+gudIAwOBV/ZVsZd+GyYjO5p1FRLE0nCNV3aQzNNAvm
        Xkfy+tBqoPY2Oz/X6x189PBNJttxkfw=
X-Google-Smtp-Source: ABdhPJxsOtrrSqKMc0P2CTNgzpM5omeFGgeDA2Ex0E1dml/6tzoJAazCxC6xunVTsSFDnBVcELR2Cg==
X-Received: by 2002:a1c:c3d4:: with SMTP id t203mr13469266wmf.32.1619341896932;
        Sun, 25 Apr 2021 02:11:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f11sm15693707wmc.6.2021.04.25.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 02:11:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Beat Bolli <bbolli@ewanet.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] pretty tests: simplify %aI/%cI date format test
Date:   Sun, 25 Apr 2021 11:11:32 +0200
Message-Id: <patch-1.2-4a90e4a141a-20210425T090506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.g8d26f61af32
In-Reply-To: <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com> <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a needlessly complex test for the %aI/%cI date
formats (iso-strict) added in 466fb6742d7 (pretty: provide a strict
ISO 8601 date format, 2014-08-29) to instead use the same pattern used
to test %as/%cs since 0df621172d8 (pretty: provide short date format,
2019-11-19).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index cabdf7d57a0..0462115ac5c 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -527,8 +527,7 @@ test_expect_success 'strbuf_utf8_replace() not producing NUL' '
 
 # ISO strict date format
 test_expect_success 'ISO and ISO-strict date formats display the same values' '
-	git log --format=%ai%n%ci |
-	sed -e "s/ /T/; s/ //; s/..\$/:&/" >expected &&
+	git log --format=%ad%n%cd --date=iso-strict >expected &&
 	git log --format=%aI%n%cI >actual &&
 	test_cmp expected actual
 '
-- 
2.31.1.734.g8d26f61af32

