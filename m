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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBAC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E647604DB
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhHWMbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhHWMbM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1CC0613C1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so26056601wrr.9
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/k7XR1RTq0MsRi0MceWmd+PL+5wTKhx3oIzIjx55faU=;
        b=qtqUdiazYBk6kvhmMbzhMx3oasDDDqIVA9SsCetzqttw7oo4QlvMeVhpuWgq5LZU2l
         /sTDtkVuZdKOmZLu2LMCJ9eW8otabzbqrD45OCvdsTZIGXV6//IrnvQvrgrnDtjkfvo4
         PrAhD/Ei0mDCdT50yN0PkNe8DUXYkJU1E9bz7eoJhG2LG8yrwtWg9gZBcC9ZwHPQtwy+
         u6R94ZtbFCzI3RPahbqfHI1opwuPaQPca1wVNcmPjmw24qOUp0Jqgpwz8gUp+bkt2TTP
         jzKyXMCqShVW2vHziMqBFiSy9zOFuELtRLSGpmFmWeftyAOQBqKimeVvBC6htoq8t5Vp
         ggBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/k7XR1RTq0MsRi0MceWmd+PL+5wTKhx3oIzIjx55faU=;
        b=VNJYaE8NITMpB0rrdbkw348S6/A9l+3xKPWVGQm7NOv+xZ70m7ML/N1/p9ZRt3Z5qo
         QKtUJXJY/YeJcoh+i9qpot8qPECd04Bo7+JWW6kPfOSzivtkuYuEiXuOPGV3TGeg1FHi
         CWZdALEZgfSKAg1FES8ihVrw+UjxjQUCDOrWdYT+921r9rAEfq3U+//TacXVzvxHAK76
         6lgreINtD/Y/Jjs6G9y8+AeiNSQswykdw/OVOX9EC5OJSLJL9Jn+BV/o8E+sL6sfK5HY
         uBT2XK9l8pnisL7OS8b1Lbke+fd1WDkETYtGb3peL9utTvlDGcwl32CF+ao1YCOOeT8O
         L+6w==
X-Gm-Message-State: AOAM5317fxuiNNuyEWAvFUJLaKm87LDI8IIoKGo/XHqk8G55AOQec2tr
        pTuVRVNvAhzdI2256nC+d+/xX9UoFFTKbmCD
X-Google-Smtp-Source: ABdhPJzAnplEPgZihVamQW4UA1/8fKT++NeRQLVwCaGf3G9wTZZLy6sRZ67YIsrz8DBxsJy0+MvbTQ==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr12976078wrp.378.1629721828719;
        Mon, 23 Aug 2021 05:30:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/7] commit-graph: early exit to "usage" on !argc
Date:   Mon, 23 Aug 2021 14:30:19 +0200
Message-Id: <patch-v4-5.7-2983e16ba69-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than guarding all of the !argc with an additional "if" arm
let's do an early goto to "usage". This also makes it clear that
"save_commit_buffer" is not needed in this case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 6e49184439f..bf34aa43f22 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -331,16 +331,17 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     builtin_commit_graph_options,
 			     builtin_commit_graph_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		goto usage;
 
 	save_commit_buffer = 0;
 
-	if (argc > 0) {
-		if (!strcmp(argv[0], "verify"))
-			return graph_verify(argc, argv);
-		if (!strcmp(argv[0], "write"))
-			return graph_write(argc, argv);
-	}
+	if (!strcmp(argv[0], "verify"))
+		return graph_verify(argc, argv);
+	else if (argc && !strcmp(argv[0], "write"))
+		return graph_write(argc, argv);
 
+usage:
 	usage_with_options(builtin_commit_graph_usage,
 			   builtin_commit_graph_options);
 }
-- 
2.33.0.662.gbc81f8cbdca

