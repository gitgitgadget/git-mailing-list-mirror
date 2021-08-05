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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5431C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9346105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhHELBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbhHELBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 07:01:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE4C0613C1
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 04:01:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b11so5989430wrx.6
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+la2w+lMbY0cY3EYByvdNQodUCTwCYEk8ZH9qvZhDFk=;
        b=jiZupJU13CVgPsfYkRXTynl467bB3SEqSOFi0Rn3wc/b/jgrdM3ItBbULHLDBSu0F3
         egthL115vwIWdS8yua+BIQH7wvVb7kOeNuYnVKv0LeULjLlIYWghWVQTo+QXUoV19Rp+
         MTtN3kKbJTcDY4xfQT+HuaunfLvDlNCxKPDwoiQm4IRUtvMP7pPNbXlY/rIqIGBxkPCP
         nxEtjfncKoiDu/8udh50WN2fQQ29OZAXzJ/lSRTX6gNwt9PIOH7T14oZ5S9u+lXzxkJ9
         /NddhxAS9WA+q//RY0GfOmPvlFvfVSqyju47+UTg44eTClbKDzlHbvOnYm+H39gKqWD1
         e8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+la2w+lMbY0cY3EYByvdNQodUCTwCYEk8ZH9qvZhDFk=;
        b=ftAzd8ShDu8Ei7jf94Ma/125E4pv0XPxnecK+oxiBjkLHpSM+1gHY2Gqnnh4jNIWxC
         DoRi9VuY9wLrFwRYkAC1vZbXOwNwGnBh4pOwD5LMLvw5R/mfna//doin8BIvbcx8txFl
         v1A+OzxuDzLitjRjXZDnaZb00urWXgNKu3OWAAYuAvOPBW6k6ZOll0hhGOpU5m3eS8Ay
         +EUwAOTA2DS04ofFLDmRjyN15S7L+i6Vn2DFkI2DuGOIRyrz3YDMdFezBPPd+pcnRuEq
         eFbvtnBkR9ptIR0OO475MTwFcNdpiST1AcW/kjPMPH8iiiNQWeNGfrAyTzuEh7Il/QwC
         6RRQ==
X-Gm-Message-State: AOAM53335YHsseLHXXgEo2qeRk42mhQ+2ThVdcEmQ3tpqpI4Lx+LI55C
        UFz/ZDIewcDAAwtAl3geP2OYlmSmSWlT1A==
X-Google-Smtp-Source: ABdhPJyFCOniqPlZ39DD2nQQoJ7xVIRePRwz+gWXLLXGZsbhTBK1NpK7CWFu/O+VW2Ho67HIuZ/BZQ==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr4610856wrw.296.1628161277321;
        Thu, 05 Aug 2021 04:01:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i10sm8836641wmq.21.2021.08.05.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:01:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] commit-graph: fix bogus counter in "Scanning merged commits" progress line
Date:   Thu,  5 Aug 2021 13:01:11 +0200
Message-Id: <patch-v2-1.3-bcb13be500-20210805T105720Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com> <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
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
must end at N. Fix this by passing 'i + 1' to display_progress(), like
most other callsites do.

There's an RFC series to add a GIT_TEST_CHECK_PROGRESS=1 mode[1] which
catches this issue in the 'fetch.writeCommitGraph' and
'fetch.writeCommitGraph with submodules' tests in
't5510-fetch.sh'. The GIT_TEST_CHECK_PROGRESS=1 mode is not part of
this series, but future changes to progress.c may add it or similar
assertions to catch this and similar bugs elsewhere.

1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3860a0d847..9d18c1d87d 100644
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
2.33.0.rc0.635.g0ab9d6d3b5a

