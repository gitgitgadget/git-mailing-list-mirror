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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86553C4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A26137D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhHWMbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhHWMbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDEC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f10so10430287wml.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eS96Q99bfUpICgKxez5/zucE8Gusp74fs94f0Yih1GY=;
        b=JNvTa4kcbKelC2nzV64pVSR4paiXbCcqKdFQ53LdnWDg5xrmXk740+dpimHefoppbv
         eTGIHTJ5hYyCnagDKz4ZCbfata4F9uhDC8iWgsI6IaMrUmqE93pAHgBLCgcvqU/oU/ut
         pKERgiP9cMCZB+6zoFX5V/whCutrebdZO2llEM/PUID3V/KxXW5ydEfpZ8CUNlzyTznf
         lt3YiHzpjCuZVlp/n23DgXNQ87WMYe1RtD19nDX0qZOBcyZDfwyZBDM2HvBvCfsmg+Ze
         z8PfU/FkrJu2POh9UGegEtu0r2IqgQxOHWFb0Ay5hMpvviF4ZVqCwX4KbpPssHpVntui
         lyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eS96Q99bfUpICgKxez5/zucE8Gusp74fs94f0Yih1GY=;
        b=A2AWD5ugVFBrsgZ0704pDQabXQGoXfGhmtWaUhtRHVgMpmrg9pGpfpA5wX6lJXi5tC
         cgGhkZ7O/ZVX/hD4QNAbqJluZqa40g2atV+fK60/1POc0MbSUsVEHUHXipKXR82BoiHM
         8WZqr6upZ1pQjMeH9C3hykRSvlEyRhHB06R/GQk9RSF2MdiVjKYRh1XOb8Mcdbn7ZQPW
         dCLWkc1jZsy4jU4/WnKP4UMVH/RKpatYF6BJCkgizMrHJZXOvQeTjlABvnwxDgx28AXV
         de8ofSL41J7Gx1LXKnOUWL6GD8SYWE8Ao/hKYVyFvokCSKA6SCTrF81SvDjCwXAvL6zm
         BPxQ==
X-Gm-Message-State: AOAM531MG2zvot/wuF+gRVSmSTZX56PXI3e7U9ZOMhcij2uGeha+hD6o
        +XF8qdHT3W8Bu9flqFE3gOyAqXEe/MKlQRDe
X-Google-Smtp-Source: ABdhPJzbvyADAB3KV8JzAzTGca6hnDJnfcso58Nl9iQHTlZXlbKveJXk91rHQQyG9Dt57eHG2Lt9PA==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr2236852wmo.41.1629721825251;
        Mon, 23 Aug 2021 05:30:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:24 -0700 (PDT)
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
Subject: [PATCH v4 1/7] commit-graph: define common usage with a macro
Date:   Mon, 23 Aug 2021 14:30:15 +0200
Message-Id: <patch-v4-1.7-ef37a8243c8-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
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
2.33.0.662.gbc81f8cbdca

