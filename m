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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB6C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B716E64E05
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhBOSnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhBOSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:42:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E33CC061756
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o24so10207936wmh.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRCZ9LjHpNXwaAnK7I3Kark9db4GMPEf4le7QOKY7Do=;
        b=VCNfScE9T4C9iAfg+KXUJa+QyDOFHhgBacUghKqYvDRZ9BjSQnaQIkU8XaZbWfB47g
         gqA+ivn6+5AifsIDoOIywrEmuq+RZtfZWO1Y2CXRh3T6vnLZrBOpJVCLjc/vFoZGICTg
         RDgAhAlMXfkqc/Csjs75uMiS+o/xTwQdDhBx3I4TZIcc3Dkh/vnrax+WRPJqcJkBdL8o
         HmtD67gHFT+Kk9RD4otvs7hlemW4CW/HobTmhuV4anklGudmvDW/SEFzZXvrkJ7oom5Z
         u7T36vQF+OVq0HD1iHeGlbJOxmpIzVyV3vIQpTEBnRy8fZ/8w71g7v717HU2SsLWWadG
         Zc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRCZ9LjHpNXwaAnK7I3Kark9db4GMPEf4le7QOKY7Do=;
        b=uV1XDMsRdAWmqLTP8g9Q5IEROjtoaezxTeQTuOJc4gBk84jdBuVoxb42GvpYvENYis
         AXGNEKtlqYrPweoIP12OwMQmU2DAhKs/VZzXiqg5W7WstNz/X1jdAY5fgdQ0c9nbLWB9
         cPMDBvZD2ZpaY61Uin933b1umOdhShb+nzBVcy0xE62djO8i6qRHeLtPfbNldshHTb/9
         RFOx+ozZ4G3Kjh6TMfAEify9ZPj94mr8wPLNdML7s0CVbiUI4QOaCbU6WMob7f3nGdQW
         1Zw0Bh+4WzJYeu7BenP8PJnDU9d0W8Kc/mlnhi7J/wxLmO1/OejEWwfOzVKQCcvEO3o2
         LUMw==
X-Gm-Message-State: AOAM533MxRVsWJEr8wE0+EPzatGhmM6JGk+50nEVWsoitxem57jtKn0X
        aKrvX1Lwvsz5evaUvp7pGOnLxV2MEDfyPA==
X-Google-Smtp-Source: ABdhPJyHoooRzC+Zh5I5sxlb3Y1IhXLktIrHacfYs6m+ILKsywPlflGwr22TzmG86xrSG5Xp5drb4Q==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr218238wmg.12.1613414501828;
        Mon, 15 Feb 2021 10:41:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm11258979wrv.69.2021.02.15.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:41:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] commit-graph: define common usage with a macro
Date:   Mon, 15 Feb 2021 19:41:14 +0100
Message-Id: <20210215184118.11306-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd86315221..c3fa4fde3e 100644
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
2.30.0.284.gd98b1dd5eaa7

