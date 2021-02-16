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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F50EC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB76764DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhBPMBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhBPL7j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD32C061793
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w4so8898853wmi.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqgI0Tv/6kHd+XWaf3dwiJuGrhCyOPA95Tl3tTqjr2s=;
        b=dPPFenaF0w/7ANU0iZcRRUMg0kKtrV4OWfiN4Ov2wWcxTOnN2+fR15J8fo5QuOvbSW
         dQQxzDGqohCDwi2I/iitmCy6HE1KiLkWioZPFxtk9ujNZB9fnqMODjULjYuft/aM4378
         EirYxCQ9V3CyBlG89NQPMtagOiY0NxgbLpj0BXuq+UhOqUv6hZFt5ukj4RIbDFnbhGNo
         KSmt/ypHDknGc2sgbbL8P+THFNZYctuXOy7N4L3bA9AWh10jQ0AflN6LiOpTgVctQ4sq
         OzSgy/+H6a1xnPR0V4NCuMIxwQtUHL6OfAD3R0U5uu9x0/zcz/dwvZdLU7ER+XDuUJo6
         IfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqgI0Tv/6kHd+XWaf3dwiJuGrhCyOPA95Tl3tTqjr2s=;
        b=WGorlXLREg317EONZm+GNCGZbkFyYzTZ4AxCH9gdBJrLtC3xMbyck7oYDkSwLEKZvz
         2IEbpgPQYCls0qVjTfXZeIAyILiOHkPSsGer/unfTrYFHCPntCfSHjsd1FcXLwcaBQD4
         gXT5CIahVLXn2l7zG42B+I3fGncx2cv8NZy35vVJOgwXcW3tRdS08d+T8Samo1UQ0ETg
         cbN9BF4fUiu/X9Fny79LNTDIGLNr8wErSWpudd2CaOPH1W1d4ld2Zj3050jPKcV9fEW5
         JVs8rzX0V9vKS1HNHYlUXWzzsZ/QIwzA6qXbfS4ZRsrtTxQattkuevAT9qZR4m3FSJ9M
         oD0Q==
X-Gm-Message-State: AOAM530x8mvDOcB9ZpqnSHs+WxEHN7ZHpFZl/tC9xNmWc0aKpLy2H55y
        nSnr5A8Dzd0TYaY+5tsD2/M8zprImCcq2A==
X-Google-Smtp-Source: ABdhPJygIdNnqLRaSxxhcZhMUrfVeyOCQx4xZt18xr4x7ytFhRSRuaB5sJMG5zRa3IWFPJG1d2kfTw==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr3107470wmo.30.1613476699699;
        Tue, 16 Feb 2021 03:58:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/22] pickaxe tests: test for -G, -S and --find-object incompatibility
Date:   Tue, 16 Feb 2021 12:57:47 +0100
Message-Id: <20210216115801.4773-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the options sanity check added in 5e505257f2 (diff:
properly error out when combining multiple pickaxe options,
2018-01-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index c6b4751d5b6..5ad4fad964c 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -55,6 +55,17 @@ test_expect_success setup '
 	git rev-parse --verify HEAD >expect_second
 '
 
+test_expect_success 'usage' '
+	test_expect_code 128 git log -Gregex -Sstring 2>err &&
+	test_i18ngrep "mutually exclusive" err &&
+
+	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
+	test_i18ngrep "mutually exclusive" err &&
+
+	test_expect_code 128 git log -Gstring --find-object=HEAD 2>err &&
+	test_i18ngrep "mutually exclusive" err
+'
+
 test_log	expect_initial	--grep initial
 test_log	expect_nomatch	--grep InItial
 test_log_icase	expect_initial	--grep InItial
-- 
2.30.0.284.gd98b1dd5eaa7

