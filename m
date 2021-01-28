Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D30C433E9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F5D64DED
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhA1QZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhA1QZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:25:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA3C061756
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:24:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so3305317wru.9
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oyI67X50ojzhIpnbpuXT9S/gKWGtAIYucyjHS6Dr95E=;
        b=cPOU8+9TwFoe/MYx9OZCpklsw3Y8bUmo4ZMBnyv16qgOk4sPuqOh8393khpTm7utW+
         1yOSq9A3RPlF0LnAOvKOKzF4kWdtFBtGrL4c75BiBKvTskcezbhI+4Ht3JKtqgzxFlC1
         86VoxGBAEIxITY7R6rTzGNmuV5ci7ewi9p4znHRTelcelPJLjML4eFxbdrkmKQDX/r77
         ciDJsOLWt5jjymwsR+nhyl4wP3aW2L4Mxc9B7gnKu+Gwc1PtKcFygCNbjdy+3NBLiyAs
         NpWYdeIG0AeF4eMlmqXL3eaE7/2BQgJxvdPA2IhbUbO5Pg8omCIatadldLN5HVZOrL5Y
         6Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oyI67X50ojzhIpnbpuXT9S/gKWGtAIYucyjHS6Dr95E=;
        b=LRa0L3eub3B4jo0LofJb4/5FwLkwhHwULCjk8Cn2U6N9CizJXmkRqApygyDPVwybkq
         5k3IQ3x7R9zCZ1JGw6jUX/nNvGnwWiKZrfCwUCO14D+a/8Y1AIwrqC5Sjozall4uyDtq
         qZuqUBhNxpcrHXJKM8r4gH43Gvi/UaUWXDuKT0RDMy7Q8crrtEcjODSyjHBi7fnSToF3
         ELI6asT1t3JWaRBvpy9c1ESFcBfHHD4YFaGTogmuUlonG1CPhtz0OXTFaLIs+14iFhF0
         EF4j2one3lzptHqoz9NhfShE3tWPuUBSRoGZqGu+F2rcktiTQGxogcSHt952pUtPW3cQ
         MweQ==
X-Gm-Message-State: AOAM533bJns0MvEtzUqwuDLNN3XWJtVVoMGUyjxhXlmwLwQ028n68cDh
        5yOBTtYA18YEWNgxYZlHwhqZ2Lhh8m4=
X-Google-Smtp-Source: ABdhPJwy4tUEnrlIp6wcavpVfraMqZ++TWDT8gcvroxJA0/SMev01swxHiRfPMT9yHkGCQsa8X8Kww==
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr17361132wrz.38.1611851097829;
        Thu, 28 Jan 2021 08:24:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm6439948wme.38.2021.01.28.08.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:24:57 -0800 (PST)
Message-Id: <4c58877a7095f3509df0dda52b4110758aaf3201.1611851095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.git.1611851095.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 16:24:53 +0000
Subject: [PATCH 2/3] commit-reach: move compare_commits_by_gen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Move this earlier in the file so it can be used by more methods.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 677f6f7c3f3..783c604a405 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -17,6 +17,21 @@
 
 static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
 
+static int compare_commits_by_gen(const void *_a, const void *_b)
+{
+	const struct commit *a = *(const struct commit * const *)_a;
+	const struct commit *b = *(const struct commit * const *)_b;
+
+	timestamp_t generation_a = commit_graph_generation(a);
+	timestamp_t generation_b = commit_graph_generation(b);
+
+	if (generation_a < generation_b)
+		return -1;
+	if (generation_a > generation_b)
+		return 1;
+	return 0;
+}
+
 static int queue_has_nonstale(struct prio_queue *queue)
 {
 	int i;
@@ -583,21 +598,6 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return repo_is_descendant_of(the_repository, commit, list);
 }
 
-static int compare_commits_by_gen(const void *_a, const void *_b)
-{
-	const struct commit *a = *(const struct commit * const *)_a;
-	const struct commit *b = *(const struct commit * const *)_b;
-
-	timestamp_t generation_a = commit_graph_generation(a);
-	timestamp_t generation_b = commit_graph_generation(b);
-
-	if (generation_a < generation_b)
-		return -1;
-	if (generation_a > generation_b)
-		return 1;
-	return 0;
-}
-
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
-- 
gitgitgadget

