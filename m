Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA16C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHJUhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJUhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:37:37 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88D2733
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-589addee1c1so12531077b3.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691699856; x=1692304656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofzl09eKj+yUQsN17iTmwMKP9Q5MFiGKPCOHCIHHtsk=;
        b=mH8qq3ZULUpvm0oQ2aoHQknum2ZwtKUNG+HQ1c+J4WI/WkCfmgxnCFvd/itf+UWfMv
         nZ67GcarLX2sWXMbsNfYPsnjZWTNoavkhd7U8um7P/QiaBp3TPnEghaUiU6R8XOmPsx7
         heqKaopeWheeyzUTZToercVngqeWfwm9C4grP6eIEbiNoOI9EyD4bVUPGvQ0KJSxJ7kj
         byFWT+XaYvcKJCbwwzn94WHtGtvnjho9+Rj9cICgG8t3T21a4o1SXUSmJFlYyenKSrGr
         1VIaJCNRR7blSarvoxoi1s4tDEs1mWevMoSnN394e00invBL3Ng+DHiorlHh0+uo78aT
         XbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699856; x=1692304656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofzl09eKj+yUQsN17iTmwMKP9Q5MFiGKPCOHCIHHtsk=;
        b=RsI3HRBEA+QNKw8HLOlZwim709He27Xjsjjj6aoTrowkkh5AxxKLDOWH6+Cdk76TPM
         6XgWRmPQcXp54X+kN+B3kPYzkkOV1I927/rpPcP8Ub7YWwAiLYu1MX83cDyAe5v1LlNs
         7VbUvzhIxg0Fb/V1i6HNAs1G+Wxs8DHcH2Xi1hGfeEX+XhpZCzYcBNwv8OXQYQxChz/1
         Od3IEns96MVxasan6GylpNhSd47ImKmCzddqb62pssWVoQAVOhO407IoZsZA6J2mUS9p
         OGlEzFPWQ1Zt7oSwWQx7/ETpylWqtx9Mm9AZcJvBMWZqcFI7mQHtfNOCA3/8dBeYBTKr
         UENw==
X-Gm-Message-State: AOJu0Yzi9Q1zBh2Nfbr8QMcnUBbvYFahiXAUKA9OtXqNPGYxWwgMiBRv
        XkBf5iqebu+dlANSb6hDPe38K1Z8u4aeImP0fYTOQQ==
X-Google-Smtp-Source: AGHT+IGrGzpNphow6g5BxNsZZ8ZCD4ljvclbo6lyOvESozX9Pc6LRQ+ITOIlJXmMkTr70ehEaD6lmw==
X-Received: by 2002:a81:49d4:0:b0:570:2568:15e with SMTP id w203-20020a8149d4000000b005702568015emr3833971ywa.43.1691699855942;
        Thu, 10 Aug 2023 13:37:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b0058038e6609csm560681ywc.74.2023.08.10.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:37:35 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:37:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/4] commit-graph: introduce
 `commit_graph_generation_from_graph()`
Message-ID: <701c198e197a8e6008672b7be7e11e02007f808a.1691699851.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691699851.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2ee11f7261 (commit-graph: return generation from memory, 2023-03-20),
the `commit_graph_generation()` function stopped returning zeros when
asked to locate the generation number of a given commit.

This was done at the time to prepare for a later change which set
generation values in memory, meaning that we could no longer rely on
`graph_pos` alone to tell us whether or not to trust the generation
number returned by this function.

In 2ee11f7261, it was noted that this change only impacted very old
commit-graphs, which were written with all commits having generation
number 0. Indeed, zero is not a valid generation number, so we should
never expect to see that value outside of the aforementioned case.

The test fallout in 2ee11f7261 indicated that we were no longer able to
fsck a specific old case of commit-graph corruption, where we see a
non-zero generation number after having seen a generation number of 0
earlier.

Introduce a variant of `commit_graph_generation()` which behaves like
that function did prior to 2ee11f7261, known as
`commit_graph_generation_from_graph()`. Then use this function in the
context of `verify_one_commit_graph()`, where we only want to trust the
values from the graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 14 ++++++++++++--
 t/t5318-commit-graph.sh |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..c68f5c6b3a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -128,6 +128,16 @@ timestamp_t commit_graph_generation(const struct commit *c)
 	return GENERATION_NUMBER_INFINITY;
 }
 
+static timestamp_t commit_graph_generation_from_graph(const struct commit *c)
+{
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	if (!data || data->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return GENERATION_NUMBER_INFINITY;
+	return data->generation;
+}
+
 static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 {
 	unsigned int i, nth_slab;
@@ -2659,7 +2669,7 @@ static int verify_one_commit_graph(struct repository *r,
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			generation = commit_graph_generation(graph_parents->item);
+			generation = commit_graph_generation_from_graph(graph_parents->item);
 			if (generation > max_generation)
 				max_generation = generation;
 
@@ -2671,7 +2681,7 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!commit_graph_generation(graph_commit)) {
+		if (!commit_graph_generation_from_graph(graph_commit)) {
 			if (generation_zero == GENERATION_NUMBER_EXISTS)
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4df76173a8..4e70820c74 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -598,7 +598,7 @@ test_expect_success 'detect incorrect generation number' '
 
 test_expect_success 'detect incorrect generation number' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-		"commit-graph generation for commit"
+		"but zero elsewhere"
 '
 
 test_expect_success 'detect incorrect commit date' '
-- 
2.42.0.rc0.29.g00abebef8e

