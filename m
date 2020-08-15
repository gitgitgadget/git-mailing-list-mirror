Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD7DC433E4
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D97204FD
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2xlFNBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgHOVwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgHOVwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60045C0A3BEC
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so10920717wrx.9
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8HfzOFn9EHvhlcJ4nPceB7zs4j6XWa23+RSfvwPSb0Y=;
        b=h2xlFNBsPnsXOhdli9NBDo4eATEjiUJqeadAZOv5y5WjB6H0RpaUmzhgpjIm4hx9Sj
         d0wiLR/lPUjGc8t2fquVn/pjWym5jc+I9bNVMrlmzGLdK8aAP8BprXfZI5BXwFr0c4LC
         bC2A76+Xq1jWQVPwvznTYDNABnxLAa/vKE+r1dwiWIwXWKyLl9SeO6vz5jmG1YOx7ea/
         WZrXcxBMiiQDs4zyOlfbC5/nY2qxC7GVTi+JfwtwBOf3QQVIphoiEFXnr1TBNuag78D+
         o/1ldupTb6eQ5ufhXhMFOEXCxL1S5lAbaTfFZvEQmbqC2UbOVUTwNYhkpAafrOw369bK
         4w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8HfzOFn9EHvhlcJ4nPceB7zs4j6XWa23+RSfvwPSb0Y=;
        b=pFPgeIX0MbpYHRggymmKp3jNnRloff3aq2yBZ7ij3jQcoY6REFYvpQY6q8Brx8QnjN
         Yr3TvbXpA/BP73ePxcy5Jl1SDeNfEIdJNbOG/MqnuALqNl0jDpDoJ8/1DVobZIJjoxzG
         8j3O1HAG4TeoksPZtA2nLxQ0OAFNkAdYApd8Bw5OFaN16RcytzvOozIuZGfjmdauB9JW
         teXpEM7biCP/2Rq4tdBngj0NOQ4YAEUOojcgSCx2zWxkZyjUIdGLkRlb5nwI14DJKwtB
         ApPWIzBkOxCssyFVU3ZgqVSc3HNg2a4Sl7k5gzLsfdKD9OQ/RQy2ZAsIOqm7wZtfMPVu
         VtaA==
X-Gm-Message-State: AOAM531RR9PGHo3HE9ySu22oA+R+kK4baT3gUMxHKLEC6zI7JgGoM/Zm
        r5LQlV60566JvZhW3g7o2Ucs9GvIluU=
X-Google-Smtp-Source: ABdhPJxPoyNQ7ysTjuWUJiabZ2jePIRZHyKll9QXFnKlEw26WywMGh+h5bvrOzR4Yz6Z3WBmVb5TwA==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr7395784wrt.20.1597509585811;
        Sat, 15 Aug 2020 09:39:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm24124280wrb.12.2020.08.15.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:45 -0700 (PDT)
Message-Id: <c6b7ade7af92b6faf365a5609748f6d024ea0408.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:33 +0000
Subject: [PATCH v3 01/11] commit-graph: fix regression when computing bloom
 filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

commit_gen_cmp is used when writing a commit-graph to sort commits in
generation order before computing Bloom filters. Since c49c82aa (commit:
move members graph_pos, generation to a slab, 2020-06-17) made it so
that 'commit_graph_generation()' returns 'GENERATION_NUMBER_INFINITY'
during writing, we cannot call it within this function. Instead, access
the generation number directly through the slab (i.e., by calling
'commit_graph_data_at(c)->generation') in order to access it while
writing.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e51c91dd5b..ace7400a1a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_generation(a);
-	uint32_t generation_b = commit_graph_generation(b);
+	uint32_t generation_a = commit_graph_data_at(a)->generation;
+	uint32_t generation_b = commit_graph_data_at(b)->generation;
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
-- 
gitgitgadget

