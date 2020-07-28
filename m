Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D54C433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0E020786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+AAtWyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgG1JN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgG1JN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:13:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69364C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f14so4036541ejb.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cJz965k/KbCTInwJwNvwRaLO7w8do9VOiZT/XRxiIzs=;
        b=D+AAtWyGMtLwXuA/kfgihycu/3PtIeqo+JH9ajkum8ual53o/lqR5+CP3cy891loih
         Qludv2r69X9/sEeYsb5v1oWRtJKgorLmwmB6l9DbajnryNcB0RC4XTRug8Wsj184kWF6
         hXM0CicP6JkwHHcG4bjzk6RqI+1GtXgPe1GDP1Ny2Bae3EwAPn5mPoG/ThSus6SZ+SQf
         7lPIutHV7+EaGVPUy7tHC6cWxfQqHPVyV6scXzFh0Z0/n8iSYLJVgXwJ7ow3oCPxS33j
         g0V+L2uVUBQ/yOJkcsk+Nda9Hpjy/hewVoAxRLB0ujELgivnb0BwmRpjTwjKLb5c8eSa
         +bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cJz965k/KbCTInwJwNvwRaLO7w8do9VOiZT/XRxiIzs=;
        b=N8uzPUzsygiZCUKFFRrI67ltr1vliTGBTbxOps+1m9hCqckgMSN3A42xS9++Kxx2gI
         rIFj+qSW6cbIKkM6TNpejJWMrHApTnXj/5F9AWpZRws0zhAaXpKa5cWblkUA07M4TKAL
         /G2TjjXy+b6KIjPFxVimoSh0RSohjkF+BWPIyLAwyNYAcGqKD3Yl++GPXPHPkzhodYb9
         teauRZxQHUwGo94li8DEKrBM23BdEv7rmESVLo00rF8yeiBTW09p01SNenIJ8OryGMzy
         UrTCkyl7LEkr9ZmkDg4GUod5qYbFVrDKKIeJHHnySxvBuV7Vgax2QJR0qXZlEhBWjb2R
         xRSg==
X-Gm-Message-State: AOAM530bfVQ/+HR1OSSQs6f9v/3+6iSRutv5un9i2qCNep2yDIy3J1+p
        h5ijcPEaxpvx2VIjFMa9TWu1uLTL
X-Google-Smtp-Source: ABdhPJzq6gjv2Jdm/eBzDoqaGknYevudAOpUI69U6heOfBIT0EdL5oPXDCiqt/lSkhjAvxvSnWkiIg==
X-Received: by 2002:a17:907:72c8:: with SMTP id du8mr14032535ejc.237.1595927634964;
        Tue, 28 Jul 2020 02:13:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm7921177eja.13.2020.07.28.02.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:13:54 -0700 (PDT)
Message-Id: <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 09:13:46 +0000
Subject: [PATCH 1/6] commit-graph: fix regression when computing bloom filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With 3d112755 (commit-graph: examine commits by generation number), Git
knew to sort by generation number before examining the diff when not
using pack order. c49c82aa (commit: move members graph_pos, generation
to a slab, 2020-06-17) moved generation number into a slab and
introduced a helper which returns GENERATION_NUMBER_INFINITY when
writing the graph. Sorting is no longer useful and essentially reverts
the earlier commit.

Let's fix this by accessing generation number directly through the slab.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1af68c297d..5d3c9bd23c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_generation(a);
-	uint32_t generation_b = commit_graph_generation(b);
+	uint32_t generation_a = commit_graph_data_at(a)->generation;
+	uint32_t generation_b = commit_graph_data_at(b)->generation;
+
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
-- 
gitgitgadget

