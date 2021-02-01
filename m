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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE7CC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF62964E2B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhBAG7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAG7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 01:59:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5501C061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d16so15285408wro.11
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TEn2MjmptZkcNZR3QfnWESfHn4uIr+R6RuBklnAznUY=;
        b=AdvfLXfiRf/+0+Mx6yykltxh9AM3iy19XCAL6ukd25KNhyKGeMeS7p+PFCgx/L/LlB
         +OeDrpTSV1sYYMhld1zipgqnVO2EOF29lRVMVRIRUEJ1nZT2goWuXYX0xkmLpEu3hdUl
         wyh7PL85rOwfQqCciA2pmP74fBgMRi3h5u7ACVJA33yb2n7KXYQKT4bQdqXYRaT+C+/w
         qmdwPgVq664VFcB3LNP4ljzXoP7r3W/RW+0FOS45SlSZsfumgT6pe680j/1lYWiyWiff
         zdUydruzUDcDypuCvS5mQxjKb1NG0985C555BqAGEDCAUvVhE3NPWalc2cTjMSjDUV7j
         0DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TEn2MjmptZkcNZR3QfnWESfHn4uIr+R6RuBklnAznUY=;
        b=Hf5OUBeGdWOR+L+tv5btUWVMzfn45yrSmEyXb0pQKMAEN0jEBuiDeBNoarvebz9jGi
         IS2yO7y5fWgOcSzhrhpkJlz0iOk58VykloC85f7TYxFrOfkEeFMsmpBdy50QsJfN0/KK
         fr0evxPRXk6sA8JohJoQ40hMUabFz0mnOPCppjsDWIiHzyni2wMetfVGOJMCBgNJVQq7
         8+/dfXaW0nnJIiFVfZsZF8WJUbvn63HDLlcCyQCm4UnLZehmaLUP/hyidu0Oy4zC6Aeb
         dvFXb2kEh/DG5m5/Cml6Y+/c4fwTxqwP/IUwAybTmFe4qd27vFnFBDDkkjbTWvUkLGCV
         tZJA==
X-Gm-Message-State: AOAM533VnXEXNn9d8S749S+Kaymk8Xb37j17cFrU0+Dzm9UXNjVjZWwh
        +31/iSjYjbWU9rVtqtq85NagudP9kIk=
X-Google-Smtp-Source: ABdhPJzvxTekn/GYwIfJtSysU6/KCE6OyRo6X4VyRhGXQLWbMvBE0DOyTj0e3edHozXqKezWoITmZQ==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr16173055wrx.91.1612162729353;
        Sun, 31 Jan 2021 22:58:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm19148668wmj.40.2021.01.31.22.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:48 -0800 (PST)
Message-Id: <9ac331b63ee609f5380649d3b395f420e57e56f8.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:35 +0000
Subject: [PATCH v7 01/11] commit-graph: fix regression when computing Bloom
 filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Before computing Bloom filters, the commit-graph machinery uses
commit_gen_cmp to sort commits by generation order for improved diff
performance. 3d11275505 (commit-graph: examine commits by generation
number, 2020-03-30) claims that this sort can reduce the time spent to
compute Bloom filters by nearly half.

But since c49c82aa4c (commit: move members graph_pos, generation to a
slab, 2020-06-17), this optimization is broken, since asking for a
'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
while writing.

Not all hope is lost, though: 'commit_gen_cmp()' falls back to
comparing commits by their date when they have equal generation number,
and so since c49c82aa4c is purely a date comparison function. This
heuristic is good enough that we don't seem to loose appreciable
performance while computing Bloom filters.

Applying this patch (compared with v2.30.0) speeds up computing Bloom
filters by factors ranging from 0.40% to 5.19% on various repositories [1].

So, avoid the useless 'commit_graph_generation()' while writing by
instead accessing the slab directly. This returns the newly-computed
generation numbers, and allows us to avoid the heuristic by directly
comparing generation numbers.

[1]: https://lore.kernel.org/git/20210105094535.GN8396@szeder.dev/

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f3486ec18f1..78de312ccec 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -139,13 +139,17 @@ static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 	return data;
 }
 
+/* 
+ * Should be used only while writing commit-graph as it compares
+ * generation value of commits by directly accessing commit-slab.
+ */
 static int commit_gen_cmp(const void *va, const void *vb)
 {
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

