Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DEC636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685536113D
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhGRIBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhGRIBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6236C061764
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso8965742wmc.1
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0/pq5ELG1v1AddUu0d034ambNU6TsAVgAEVaPkEce4=;
        b=QD55wopE41EMhuhA2vWgfwEWNaZ6BX4fLKCxggDI/aq7e/CL5twGyQvHpm0gBdC8Fn
         vM4j3YOYV/KH4vmkaPtKUs/NccXzxjmRil9JWYnUJufFu6x0lds9hg8ls8hvDwJZILHH
         tvpXWI26RYEgx9nPqFKMrzus6/8jwiUhjpydRTUjb6VN6ot6MHM4PqLHmbMk4PgL7y1+
         SLezCHkZ4EpLFKeAUh47P45KfPx2NnLiiRdsC21vpUAY0nT5Ue5SgRAvpKOUL4HbfO4q
         dxvSE3ZPSy4iu520nrnTrTvNIajN0hNXezdsTCU8g05n6ZJvmloRtnhAYpNReMs3ekRe
         Dg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0/pq5ELG1v1AddUu0d034ambNU6TsAVgAEVaPkEce4=;
        b=KTbBirGH8IE41s8bHvC6im0yjJdDqF1mcT4DG1X0wx7RdXxzcEzpQn6adI1gpPwz9Y
         TH81xdTvK7nDBzocEdJYBOANE5wS5J0AI3J+AVqzYImKP/8PGtKeUoNwEEdGnN0LhSWu
         S5skRLc1yvs7qojLqJw0MNc2rHm4Pee4YHNTJukafbbDeOC00nbaX3TepT/lkfNsvfj3
         N8wlGVV668XkFCHx9KmrTDn4cSf5GJAe3znODNfBXGbSBTH2foDBotVLK7jeUXzBA8Pq
         yn9sM161GTsnLLADcBnwQkDeZNbJxJAtRamGDRT6O7DwQUisoCpJZ5LGiV1DsOXw/TkY
         zlCQ==
X-Gm-Message-State: AOAM5310kNfGeFA/t8iOZ1vxwDGj5WUtUSXxN4n4+URtu/R52q4fh8fq
        KvIkGt9spomuZSCrjAN2LS0Z3+Vjtc2n5A==
X-Google-Smtp-Source: ABdhPJwirWMy/Q1fHbxjfTB08w4pLWnJ4D8akuyze9gbD4fVlipIWL+5L5ccS49TIbNZER+7aLQRnw==
X-Received: by 2002:a1c:9d46:: with SMTP id g67mr26477378wme.188.1626595096302;
        Sun, 18 Jul 2021 00:58:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm15904685wrt.55.2021.07.18.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 00:58:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] commit-graph: early exit to "usage" on !argc
Date:   Sun, 18 Jul 2021 09:58:08 +0200
Message-Id: <patch-4.5-d776424e8c8-20210718T074936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.873.g94a0c75983d
In-Reply-To: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
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
index ff125adf2d5..16d2c517e72 100644
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
2.32.0.873.g94a0c75983d

