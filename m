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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE448C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D99611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhFWRv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhFWRvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716B3C061226
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a11so3545026wrt.13
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kU0wfntVDLR1fLy4xzeXX68ih9tj8uqq0ttXSxcZJCw=;
        b=ke2IrUNE9tKR5wTO3ZmJLfVSQZr9aus80+2GMxB+9ff5QLCXoQ1ISa7vwup0EWairK
         8Y1hgtFIxYO/kDVRBRBQrEMux016p4Uc4HAsv+Gf7Os7DgigTtDFYfMhaeMHrx4EAURw
         WpJEoOl3UFnB/hVLlfYMeMyanugcqQgWMNUafMjGldOE5/nRPm6ps6eYCwLdtD7v0++u
         fvLn21T5jmsc78Kk0Uy+/T4/GnFrrVHBNPM6oNt0a3KuhvkQMnsJk8qP7ZfeDU5ulrsD
         JLuGqXKeaVSe/elKSTrIb4oqlT8gHMtKdVoXns/P4SaUoTzB/h38HDn/XX4PqUN7ZVQ9
         VV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kU0wfntVDLR1fLy4xzeXX68ih9tj8uqq0ttXSxcZJCw=;
        b=OT/jlHY77QWj3+tT9SPO1Ik2pSElYy5XEAnROShF9ml7tnJtPI6FbPB5umH8fDJ32I
         3yq0JipZLgfAT1AY7toI8G9ufW+yP9VoKrFDUNy5qsgiMevd7MUPxvYt8cFovEsEvK55
         w/HolADQ6QBgThuN9J1HN98PBtqNAj1Ky748r7LpyV2ykMzvJFWerd4NHXtXqWoBS0d+
         iCqXFMvv1DUkW0g6Y6Y2vrOTldRkYFPtRIKPD80HJjjM3DyIcdLnjNcCPpR0ZmJ8WH5K
         ypvH0m4+OKC7YWCwXrqlt0XmRkNS6N8ACBG1sCVbwnq4+lRsaQoQr1SNiTFRLno0rgDh
         zzUw==
X-Gm-Message-State: AOAM531iMLM6ExPJlfrGq94HrGdg5erfCmFsolwCusuV4YZkKCc7hhY7
        7n3mwX4EwNogXwFUkAuoIAOLaeK/lXIGyQ==
X-Google-Smtp-Source: ABdhPJzpKYGOs/bTQcPRCrypRJD0R1z4WnNaHtJBfxqRr1kjg8S2munuMJfnhbzLPETjQD23JveBkg==
X-Received: by 2002:a05:6000:18ca:: with SMTP id w10mr1428796wrq.55.1624470522915;
        Wed, 23 Jun 2021 10:48:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/25] commit-graph: fix bogus counter in "Scanning merged commits" progress line
Date:   Wed, 23 Jun 2021 19:48:19 +0200
Message-Id: <patch-19.25-26a6e93717e-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2bcb4e0f89e..3181906368d 100644
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
2.32.0.599.g3967b4fa4ac

