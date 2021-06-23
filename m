Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D699C49EA6
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA966100A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFWWAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWWAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A4C061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f15so4267412wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3D8BMjegV2qbTaQtZk4OAWOaU+VkgmsYqsmzrsKsNA=;
        b=mWd5nMVuAhzb3PJ62B4BG10I5rdFIigG+lemDVrTnuMgKovLBxuBo8qhZm/5MqMoJQ
         sBSail8gAFhZqF6NGA5vv9FTZkQWaycR5jjs9VFWZcG7YkdgZqSBhC0prMJd9okDv+Ic
         7XWk8dSVZMfumGX3ciJwZEzvRodk7X+drwkOSK57z/9vBCWGpysDgqq9B+ioVZCghJvZ
         M70Rltmub6+Lr7sHvDJP2yZdn0hmN4C/FR90A/SG+3CihGI80guMfpoHo8TiWGYGY9C9
         Lhp9J3zFXzbPxsyogHGn00iTbxzvOez2JRUmQ7YfVB1WSHmm0yLnT6jlEJw8cjKR3yQG
         XBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3D8BMjegV2qbTaQtZk4OAWOaU+VkgmsYqsmzrsKsNA=;
        b=CeMnY0wYTfF7VvdPeWjEauHvJG8RSM/91labLn3b0V3o3NXWW+3atXyCF+6OJ9BFX8
         Y2lfZ49Ywql5GbKtE0Eolwq8AaVHbtm/HdEu7KYTpivMpJcS0RkHetL4uaJoIT2RXCST
         eBMZFaDnV7caFydEJtJx8WLOZohiwZ4GynkKKGB80wSz9PkWw8zXq5i2febMW4E+V627
         xEQD2074FJxM7goSUJvEQJo6Xp8Zjrp9Bq3fKxmcviqrgPM3q26xHTXzaOwn3WrXlxop
         e49lmjF4K0Yp2OJbCsRi8JUC62ELgfaP0bRSYYhHqtXY4gQ0UvxlZTqaZ80t5U2VRhNV
         670Q==
X-Gm-Message-State: AOAM530qWbhq8TA5ybnFA2p2It0sogDIEohXwGofohoZC/1PCqDqSkvd
        url4D6gIyxp0HZmpOszZKYRYqowfYec=
X-Google-Smtp-Source: ABdhPJwGCVG/p9bLlILJfVn9WFKnYNbc6fB6glM1zgCWT2rT3rFfCP84uNWAJsux9Im4JoregoqrsA==
X-Received: by 2002:a5d:480e:: with SMTP id l14mr319482wrq.33.1624485467666;
        Wed, 23 Jun 2021 14:57:47 -0700 (PDT)
Received: from localhost.localdomain (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id q11sm1192348wrx.80.2021.06.23.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:57:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] read-cache: avoid overlapping progress lines
Date:   Wed, 23 Jun 2021 23:57:35 +0200
Message-Id: <20210623215736.8279-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210623215736.8279-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Refresh index" in refresh_index() in 'read-cache.c' vs. "Refreshing
index" in preload_index() in 'preload-index.c'.
---
 read-cache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c3fc797639..692a69f2db 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1567,10 +1567,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int t2_sum_lstat = 0;
 	int t2_sum_scan = 0;
 
-	progress = start_delayed_progress_if_tty(_("Refresh index"),
-						 istate->cache_nr,
-						 flags & REFRESH_PROGRESS ? -1 : 0);
-
 	trace_performance_enter();
 	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
 	deleted_fmt    = in_porcelain ? "D\t%s\n" : "%s: needs update\n";
@@ -1583,6 +1579,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 * we only have to do the special cases that are left.
 	 */
 	preload_index(istate, pathspec, 0);
+
+	progress = start_delayed_progress_if_tty(_("Refresh index"),
+						 istate->cache_nr,
+						 flags & REFRESH_PROGRESS ? -1 : 0);
+
 	trace2_region_enter("index", "refresh", NULL);
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-- 
2.32.0.289.g44fbea0957

