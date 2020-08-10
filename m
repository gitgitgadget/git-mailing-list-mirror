Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39351C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 19:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D57222BF3
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 19:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkHuY4qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgHJTsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgHJTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 15:48:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C1C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 12:48:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so10947305ljk.6
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdE+5XtL58Z40jtNB8gBB2Zp8e3+1/1kRrqrx2W1Dn8=;
        b=PkHuY4qLx8pob08GcyLnK9b02h2SmTRMPME1qXnJasfXkAPxUS9WKo4Y4mtTZzNwUT
         adfgumgk82QknwZMwmd02CojfWO4yGZYNOeSdhUJYzfY398JuF8YPLYKB7Hbk06xXA47
         gkSmZeNGEI6YmtF89rk3FwccIutpLxzFCY/PuFnmAipoTDRqDywiDSyZO0bBv88qJVNL
         jdv4gqdedSpTzyLZuP/dC9rhaC47cwsuAdxKakaIGy6xHLCHDvndeSjg1o30o1c74iHW
         jmx3jJf7nNcysXXrTftIcqZF6bYtxfHMhvLXTCezRn7/bdtsuA7mnqJPAwYQaFjRSJZy
         rV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdE+5XtL58Z40jtNB8gBB2Zp8e3+1/1kRrqrx2W1Dn8=;
        b=GwNkQnBeT5ZHpq7VNqqSdLmi3NvNgYc8QV2d2bfOvuu7Mw/1hXbuuwdDmJ0LoIAmux
         LH4t7Gxq2vHBChSTxHMmeAdxpQE8vN7ti3fUzWbfx4HZdlZpsLV+DW9p2Xv4ntDYwNZS
         zE65ZIEjElgnSz0fTZhYwdIPSmSIcEakWptMYQzrDpBk+EziInAskeEhelL8S1VD8j0P
         FgdCwvR/r6r2sqpowLQhE19299xLxTK2unXyqcLAElmQVuEFVKxPBxg42VTXNjv/ek7f
         Y1dTDT2fwG5KK/PD8FSNJrC4AHIOTl2872mgdygzz6/UCjRC1nLMxjOU3fBWQC1CHOIW
         sn1Q==
X-Gm-Message-State: AOAM532dBe4ivXTtFdZSONOgZDiXFaG+o5MJoUCGwKIM+IzzrCwthukW
        vCM+/NC18ibgnGo3HzIzyif83TJP
X-Google-Smtp-Source: ABdhPJxVFf9AChDslTwSqIokZltCffn6MycGig4yY0K6PL0MhGLugA0aSRh+HhnuMUfVvyYYLbDWqA==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1235819lji.292.1597088886335;
        Mon, 10 Aug 2020 12:48:06 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id t20sm9437389ljd.12.2020.08.10.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:48:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH] progress: don't dereference before checking for NULL
Date:   Mon, 10 Aug 2020 21:47:48 +0200
Message-Id: <20200810194748.1483784-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In `stop_progress()`, we're careful to check that `p_progress` is
non-NULL before we dereference it, but by then we have already
dereferenced it when calling `finish_if_sparse(*p_progress)`. And, for
what it's worth, we'll go on to blindly dereference it again inside
`stop_progress_msg()`.

We could return early if we get a NULL-pointer, but let's go one step
further and BUG instead. The progress API handles NULL just fine, but
that's the NULL-ness of `*p_progress`, e.g., when running with
`--no-progress`. If `p_progress` is NULL, chances are that's a mistake.
For symmetry, let's do the same check in `stop_progress_msg()`, too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 progress.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 3eda914518..31014e6fca 100644
--- a/progress.c
+++ b/progress.c
@@ -319,9 +319,12 @@ static void finish_if_sparse(struct progress *progress)
 
 void stop_progress(struct progress **p_progress)
 {
+	if (!p_progress)
+		BUG("don't provide NULL to stop_progress");
+
 	finish_if_sparse(*p_progress);
 
-	if (p_progress && *p_progress) {
+	if (*p_progress) {
 		trace2_data_intmax("progress", the_repository, "total_objects",
 				   (*p_progress)->total);
 
@@ -338,7 +341,12 @@ void stop_progress(struct progress **p_progress)
 
 void stop_progress_msg(struct progress **p_progress, const char *msg)
 {
-	struct progress *progress = *p_progress;
+	struct progress *progress;
+
+	if (!p_progress)
+		BUG("don't provide NULL to stop_progress_msg");
+
+	progress = *p_progress;
 	if (!progress)
 		return;
 	*p_progress = NULL;
-- 
2.28.0.220.ged08abb693

