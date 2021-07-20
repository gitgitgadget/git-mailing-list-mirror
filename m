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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE39C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CD661029
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhGTK7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbhGTK71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47068C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f9so25630587wrq.11
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZ2EUNo9uPQsosjVpZ9cN4m5uape3nl0KcyFzD4FU2o=;
        b=PwVs4uFP6yssoY4L182OHWNbgBr9T6uovdPhaYiWYYw15t5a6d/0PoKEaphrqLGZv3
         YVrCudHXH/q/h1OXCdc8ybCko9Tf5DGUWMBT7U9548ZJzo8oOBQuvA+5xVoOipO1uX57
         YtK7CekKi34J1enxZIR4u3GNCGnENQhbpEJTrABgfn0isPbiif5Ct0JrPQ6a/yAu7h7T
         6iaDUMOvRPz4Rm81InyX22u8RYrVXLBac6CWAlVCiO+LrtN8FYjtpXQo7yiHN0O4O0UP
         T+LZFcrVCtwVLRgzCgevMTxmiYg2lQJpadPxIhX24DXpNhHFxiFEGZalBoY/CmUKSmrZ
         XKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZ2EUNo9uPQsosjVpZ9cN4m5uape3nl0KcyFzD4FU2o=;
        b=tk/rrQcGE63wiyGkdLttvxTMKZw8Eu89T1eQFMM7olO7gfbAeHxoF/5vGKu/s5jnGm
         wtZUakndOI5FePJtdS4uBxQfwXa8uoj0Uk+GyVr3hXeU4Ke4XY8tKyza7gYx+V9o8WDb
         buFx4CIegd1M2axfqbREyoeVJK+a406Wg4aoOQUrt4lzPo3nt1JJqNcC/eZQ62+LRKCV
         I1guPWt+j2dn/DVFMPXxqRGrGUhf+ktmfiA/GkGCBSIhjWVJWIb0iJ7PW1XgoTG2uGPp
         sd7wdVyJSN/NNq0qHdL9nc3kBIXF4C5L34CjgGK9pqXAsFH5pde+LQO8Iue1e9UGccE5
         OqhQ==
X-Gm-Message-State: AOAM531+pJgvpa7xBoQPvd+N47s6hjgLhxxS94YhJXNO0sxC1TrZK2Wx
        Ou+b0wkJmOX8I1DHCVxUaRWe9UybkyVKWA==
X-Google-Smtp-Source: ABdhPJwNcEB0EfJx+DndVbhLAPZ/HWpBnnI/JssjgJ4HZous6ixVHJIGRPc1gWk561j4+gGrTca/DQ==
X-Received: by 2002:a5d:4812:: with SMTP id l18mr35842945wrq.68.1626781203652;
        Tue, 20 Jul 2021 04:40:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:40:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] commit-graph: define common usage with a macro
Date:   Tue, 20 Jul 2021 13:39:40 +0200
Message-Id: <patch-1.6-1b9b4703ce2-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
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
 builtin/commit-graph.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd863152216..5af3cd7178f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,26 +9,29 @@
 #include "progress.h"
 #include "tag.h"
 
-static char const * const builtin_commit_graph_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
-	   "<split options>"),
+#define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
+
+#define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
+	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
+	   "<split options>")
+
+static const char * builtin_commit_graph_verify_usage[] = {
+	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
 	NULL
 };
 
-static const char * const builtin_commit_graph_verify_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
+static const char * builtin_commit_graph_write_usage[] = {
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
2.32.0.874.ge7a9d58bfcf

