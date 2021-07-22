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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1354C63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CEF6135A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhGVLjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhGVLjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:39:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033BCC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c12so5722865wrt.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IB52K4uElWxhyC7O3EYkhvZc2px8s1OTgNN5XYuIkDo=;
        b=hnlYvac7C6Vdli4JljSEdlUb+uf2UBLRNIA0e6f1XQ5pws8T7Rvm3uqnxECEnfCaON
         mjGhbbHchiFDIBrc29cz7TF46oLllQCK3ZiiztdC9uzwnf6ZBkHoTCxxK+MWncRR246P
         XhYmYtrfEbobqJ4yJHGu6wpyto2R6MMJ3XHiTrg0nrp/PDhVdUOJWNX6LNBuhsX0eMLm
         KvWZ2PXWlxgLumtCFypSO0awMzy09IJL6PDJQ4CcGy3ewa865QsWS4jPmsT3Kd8tLDZ2
         vELBPwbJavTSbe/5KCjEGc5oy0/D4NjrXZJu0fNeglliKgppK7vFdoKJTVOs1rpfty4a
         vbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IB52K4uElWxhyC7O3EYkhvZc2px8s1OTgNN5XYuIkDo=;
        b=bkzQJfBw37h07hew+ewVdEJgQ5X/uBODVyu6jzQBojG0elZU9f5ZXTrYpxuJ0hjui9
         y7qrboby5hkc1NktX4WVON0xfAtfIvVHFkcwciDrUA1JVPuKAPSCDlOXLzb8H55SnxyR
         kQ+hC7C9/ZTJDI0uc2qOX1LpwmkhT9Bol8Wb8uFdqEgBEUBX9CRENIwqBQy5PM+jp+R1
         iMQt4PdJHPjJ4T/ds/1LKBxrB+JEJAXzYhZbZQsI1t1mfXAz3qn+R62Y5Fwp/hV9uDzc
         sZsSJKf/5DcbgHvo2DEvw+6GKyVMpphQcGP3b88jL7ejVYKfBUUHcjuRRU5fO2aeS+KW
         p2xQ==
X-Gm-Message-State: AOAM532haf2DmN4M/DxU26UyMniQkIhcuFFheC+LCsIkjDQ/EMnzvxgl
        ehluEo+E9q752mvkDYyHIYYhC++79PXKhQ==
X-Google-Smtp-Source: ABdhPJwFHP/ollK9+gdEwhKoV8LCsPaSKJgHecxmB/DtDkCKlQGRx0gBPGtzb+2ocp183MaHg6++dQ==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr47649442wrn.398.1626956420342;
        Thu, 22 Jul 2021 05:20:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n23sm23506991wms.4.2021.07.22.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:20:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] commit-graph: fix bogus counter in "Scanning merged commits" progress line
Date:   Thu, 22 Jul 2021 14:20:15 +0200
Message-Id: <patch-1.3-832a6c1f78-20210722T121801Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
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
index 1a2602da61..918061f207 100644
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
2.32.0.957.gd9e39d72fe6

