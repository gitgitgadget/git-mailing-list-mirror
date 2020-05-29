Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5519DC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3517A20776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT7Nul9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgE2Ivs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgE2Ivq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE0C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n5so2470618wmd.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAartjGCZZ1D2UpyUna/mR81dwpkMcQdphefIU4DvJU=;
        b=HT7Nul9FfiiyKDB5O5Fd9/FRAIDCZoffzI8FSZ3H93zE7lhKei27gjVyLSlvJY/c8j
         Bu37H52377HCUcelgA761A53/P55ZYMZszVUZq9CsgAEJ3vHEMz7iYcBH9ldX0oV9Uam
         ChKIK3aLW9BrV68Sl6wcFNLt08krhC2x+ruX81tzIS4WLpQBYFc0zMlkC+t2ov8Bnweo
         tWMR4hTuKd0d0vB2lafJWl6AnFqD/TAMAUoQw8oahWZhqcvrZSiu+0kNWeqZxl7DZjf7
         ecdaCbN5zuJhyztzi/GbKdL0TKJBQsoa7brCxNjPcy5yxGedGN2c1C+wFnktGkkyb9H3
         kG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAartjGCZZ1D2UpyUna/mR81dwpkMcQdphefIU4DvJU=;
        b=R5cT/byL7Fj5Gs6WK84uPcz1ukcz9u/vwRkOFP7W6CDyHFX6jeF6EL2pl8eVKPgDz3
         gyXLDs1QVofdAFIBTtIPOp1XmJVbp4DeFr3s8i//PElW1SNoQzwAD0gK2k3VzlhYcJAH
         GrmYwEz4SYijCW5a6AzkqobYoUetYe6Wgg99bnHLt71dA3+Bw7ofX4uB6YVMUVfw2UjW
         V3XWxxJJhQhtFRG1rKmHpI6j5v52SmVMKVZUfxLac0+RnUTLLpcWo8VapcVyH5B3N78B
         rvms0J1VWfpyzNSbk5unafno4sJFVUcvE1/imSAZezxMCMmpWRiK506rRKszeNxML0T3
         yd/A==
X-Gm-Message-State: AOAM530zIeArul8MFY9r8jvG0hB5wUuZdNHwpvBQm9ImGsVTc9moiLSp
        pTpyWw81dhX0B5p9xAPSlMv/M6vE
X-Google-Smtp-Source: ABdhPJzLcYO0tXT9bvSYQ6o98DHWBoJYXL/9GGlsi9cw3j/eEl2u6HXuFquGKmV1T+Jy7kR32jDsOQ==
X-Received: by 2002:a1c:5606:: with SMTP id k6mr7909237wmb.10.1590742304049;
        Fri, 29 May 2020 01:51:44 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:43 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 30/34] commit-graph: move write_commit_graph_reachable below write_commit_graph
Date:   Fri, 29 May 2020 10:50:34 +0200
Message-Id: <20200529085038.26008-31-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 commit-graph.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b5cd4c863a..4cbfce61bf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1901,21 +1901,6 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir,
-				 enum commit_graph_write_flags flags,
-				 const struct split_commit_graph_opts *split_opts)
-{
-	struct string_list list = STRING_LIST_INIT_DUP;
-	int result;
-
-	for_each_ref(add_ref_to_list, &list);
-	result = write_commit_graph(obj_dir, NULL, &list,
-				    flags, split_opts);
-
-	string_list_clear(&list, 0);
-	return result;
-}
-
 static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 				struct string_list *pack_indexes)
 {
@@ -2784,6 +2769,21 @@ int write_commit_graph(const char *obj_dir,
 	return res;
 }
 
+int write_commit_graph_reachable(const char *obj_dir,
+				 enum commit_graph_write_flags flags,
+				 const struct split_commit_graph_opts *split_opts)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int result;
+
+	for_each_ref(add_ref_to_list, &list);
+	result = write_commit_graph(obj_dir, NULL, &list,
+				    flags, split_opts);
+
+	string_list_clear(&list, 0);
+	return result;
+}
+
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
 
-- 
2.27.0.rc1.431.g5c813f95dc

