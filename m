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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4959C636CB
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1A66113D
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhGRIBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhGRIBN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC612C061764
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso8965727wmc.1
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BebBrT1z13jZy4/OeyjVgLYbjRLRxnHQ74riD+1XFQ=;
        b=GKVTDlHaUBcD2C5dKn48uLqhxK0l/F1xQmdEwsKbv/ij6QoK01/zRK3moSrttryU0p
         Wyzlk3YsSrEFkR4P4k816NoBp5Sz3PeB723clS1L139txB71oC2NDloPjDA/YEsCRGr+
         u4q4bjjGaLe6bylTSuZhfWGUiDEEdP/hcR/Y1iQCBPjzrIZR+TbaviBODL2qaLILTTvD
         eOTd207CZ6A4HnyPQGPuoXx19AU391WrvBQ4lEr7AdCQMvffn4uVUOvcWytva/I02ODt
         4f5EykMzdJLFWesNAlUHumvu9eASyadBTZlfVu2QbIoSe1dwCpG1kTCQCg6BfkwZpSdc
         XXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BebBrT1z13jZy4/OeyjVgLYbjRLRxnHQ74riD+1XFQ=;
        b=bLOugB2v9GcZjnJmhY5aq/clgf7b/AKnvHPHL5DSDBArZepQUnj53CJeVP+k16O1oJ
         lZeicg0gJ9ZOGNCKtk27M8OImuJQtrYiaFMznx8qc/C8k5Jewzq0xSpA6X7XUAHQkilK
         PwlXhuMMu2P/it/XtwN4yhvsgA3qe3tMoaJTfJaJgYUgS3hfmm2OqmySznOs1l5iYILC
         5AIIAIgWNpQX029ZW4jLpue4SVfDAWoTT7KD/6mmtt9hdqe6vo3l2UJYeM2zG+nFxDU0
         s8a9JzZaS/uunR5rqElLeDcwpNhH0WCP7zUdW25g/uXMWD0oQFij0U4gmxx5Jm2dyMYu
         ywog==
X-Gm-Message-State: AOAM531cjdD6Igv/WHXqyi9DSPRVR3O0HBIiVRG9OCLIcqUKJZS0Cs1/
        Av4meSmmqna38TQ8I9zHH0oOTAJgtis=
X-Google-Smtp-Source: ABdhPJwTWTThRx3KTNs4rf9KG7SBw9k+GmNrlqJYOSVl4OgXZ4UCu1P/K9HnBrjWuung4ipgcIMGgQ==
X-Received: by 2002:a7b:ce05:: with SMTP id m5mr26673332wmc.64.1626595094145;
        Sun, 18 Jul 2021 00:58:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm15904685wrt.55.2021.07.18.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 00:58:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] commit-graph: define common usage with a macro
Date:   Sun, 18 Jul 2021 09:58:05 +0200
Message-Id: <patch-1.5-0b0bb04ecf5-20210718T074936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.873.g94a0c75983d
In-Reply-To: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Share the usage message between these three variables by using a
macro. Before this new options needed to copy/paste the usage
information, see e.g. 809e0327f5 (builtin/commit-graph.c: introduce
'--max-new-filters=<n>', 2020-09-18).

See b25b727494f (builtin/multi-pack-index.c: define common usage with
a macro, 2021-03-30) for another use of this pattern (but on-list this
one came first).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd863152216..c3fa4fde3e4 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,26 +9,27 @@
 #include "progress.h"
 #include "tag.h"
 
-static char const * const builtin_commit_graph_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
-	   "<split options>"),
+static const char * builtin_commit_graph_verify_usage[] = {
+#define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
+	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
 	NULL
 };
 
-static const char * const builtin_commit_graph_verify_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
+static const char * builtin_commit_graph_write_usage[] = {
+#define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
+	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
+	   "<split options>")
+	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
 	NULL
 };
 
-static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
-	   "<split options>"),
-	NULL
+static char const * const builtin_commit_graph_usage[] = {
+	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
+	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
+	NULL,
 };
 
 static struct opts_commit_graph {
-- 
2.32.0.873.g94a0c75983d

