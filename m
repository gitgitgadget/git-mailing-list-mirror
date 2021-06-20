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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE74C49361
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C61611AC
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFTUFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhFTUFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0BFC061766
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s6so16046228edu.10
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYgNFNHjmcT610XbsH5bluL7ypjAQ4ZkKa5yW83vHRY=;
        b=L3/1mGtXCA1zjaQr8HkweVPEnaEv+h307epXc6KHqsTx2Gt9j+RPpPlKwCxpVq6ZNU
         jnkRYT8Jki4xZ97KAI2k3gw/OxHkufXsIoIM8VsL8bgu9dB7MM71CAX0p9wabuN2wsK6
         uls0EjBL0k1P2/4QIukVkKZ27uuloXiVIJXECbQkNUPL8wamCLwjT1cQ+1wd3/3+3LSc
         +d2KtrMXoBmBvqzAvl8YQSrdKHF6V/EMxlc3UisnNhPogm/5GLFDKng4s3hup3zOtUWt
         Zuwmk+vPk90EvsN4F9nIK8/pQNoQUDwLvuqKvQ9LwIgLNcZVpoGxAI6rm0DOtMGd5clZ
         RfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYgNFNHjmcT610XbsH5bluL7ypjAQ4ZkKa5yW83vHRY=;
        b=bPSn6Uw6zC6GocBxSb4vB1CXLuV8dE7Z0vBdu2ytvubP5Uo+fg4xHUCEe39BjE2By6
         8Ka5JumpfhAkFKSycMaAg8dzD89tGEJUbsTZz3wgsMb8deuX0LJbyWeYl+RMlyhba4Fv
         E+HpKryyfM3FZ32S+ngyOq14HB/RhGhndcqtjV4nGAmeWuuADCWOx+bEI1Diqt77r9qP
         sP52ra0gIOGW2bEJ3vWJLM4fRTrm9eboBjCCQPLPYBAfvOx4q41buttg4ECM12Zdbqb6
         rrUZ7pLgIAFkUHBhCX+QWC7RwJk37cy6lwDCdeUlx6lQ9e6HHmXu6CANSZc2e2qV1TSC
         Sj8Q==
X-Gm-Message-State: AOAM530agtM3HYL1jOUi25crLBbsZwsPbPmGWp0YXhKRoOFjFVpNAyFI
        CTPqkQAP3ibfMo9T3erR3Heymrr/uwA=
X-Google-Smtp-Source: ABdhPJwco3uxNpCrgLqZ8HG2B5GurYcOrO95aZ72RfMMTqzQ70USpHUVqfMRhu8+0w4cafyjNDvLBQ==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr3483379ede.255.1624219399839;
        Sun, 20 Jun 2021 13:03:19 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged commits" progress line
Date:   Sun, 20 Jun 2021 22:03:00 +0200
Message-Id: <20210620200303.2328957-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final value of the counter of the "Scanning merged commits"
progress line is always one less than its expected total, e.g.:

  Scanning merged commits:  83% (5/6), done.

This happens because while iterating over an array the loop variable
is passed to display_progress() as-is, but while C arrays (and thus
the loop variable) start at 0 and end at N-1, the progress counter
must end at N.  This causes the failures of the tests
'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=1.

Fix this by passing 'i + 1' to display_progress(), like most other
callsites do.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2bcb4e0f89..3181906368 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 	ctx->num_extra_edges = 0;
 	for (i = 0; i < ctx->commits.nr; i++) {
-		display_progress(ctx->progress, i);
+		display_progress(ctx->progress, i + 1);
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
 			  &ctx->commits.list[i]->object.oid)) {
-- 
2.32.0.289.g44fbea0957

