Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7F4EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjHUVej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHUVej (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:34:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B410E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:36 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59234aaca15so10365857b3.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692653676; x=1693258476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5d8NzSBkSiNkrrtEFvPrJ7LnWsfZfx/6iDS0oVdLVk=;
        b=sDNz5ypVpTpHl84IB0lari4sZjxOnpcB8ZeU6PEFIDOgynFKpOX/1rHgaqpCZNMOuK
         O0NlEF0vYSyocVsIXLCh3v8Q2TAzC58CdNuzO2TGd8YWWT3+dX3emdxssSDFR58vkgCN
         EkH1waUYkm+/Bo6Ta61f1SAmtxnGNo230vzlIZ0bJjOA5jpipdvvFcuTENM/qIrEtyXk
         v/OtpfqzVu8vVfqtVEe3EXcAUrSDeItqk9mH13x3sJj0bf6akbbvexjozSDuXec2C7im
         Yn3OMLPqYqI52X/m4SA8+VyN+FIAnVD+lG6SfhjCRMtigfyXrpCj6Y8RAL1KxLsMB6w4
         vY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653676; x=1693258476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5d8NzSBkSiNkrrtEFvPrJ7LnWsfZfx/6iDS0oVdLVk=;
        b=OdsAbQURBtahP5YduIXlcdyEy9cmCYfmRClqXAemmeayO1WszWGYK2Bul4/8yR6ave
         RSTFbJRYV8o9tskIqBZIOdJu4ysk9eRvnvkV3Ipsa/kHKrrNg56w0KaBOkc9jA6pDxqF
         RObp6Y8qV5FM+RvgCtN+w449ygTG1peytdvY7AIsNkYyQjuvV+AQDU1G50MXWOYjBEPk
         S+2ACnqm9Q66Cl3TkbWK5g1ecx9gUbk1+qV76ovJmjYGQUJZMMFMTmYibaw4ZzRk82qT
         ouAAavCEjJG9tw82OUjnogV0K+iVOUUtoXPKjn5nIRGaJvGFqE+nGS6FStywk3O5xOj3
         UaPg==
X-Gm-Message-State: AOJu0YwEgR+NlbNjlErlHwcho3Vi5PoTCgR0sEqk4FOcdFxL8bQThY8D
        cXH0TrObZGHlJxm+GQrvKjtNynHZrJHQh1ELaFQ/ww==
X-Google-Smtp-Source: AGHT+IESg4rlTzgi0CZcT3ABKU4g+LCCmtNeJ2ZYiXfebdc26YvAR6+heasV1B4ZbcwmiakdwUFEvw==
X-Received: by 2002:a0d:d1c4:0:b0:583:b2a3:f780 with SMTP id t187-20020a0dd1c4000000b00583b2a3f780mr6970413ywd.49.1692653676040;
        Mon, 21 Aug 2023 14:34:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c10-20020a81df0a000000b00577044eb00esm2395948ywn.21.2023.08.21.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:34:35 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:34:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 1/4] commit-graph: introduce
 `commit_graph_generation_from_graph()`
Message-ID: <c88f945a547ac7da41c85f09e2cc01ce3472ed79.1692653671.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1692653671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692653671.git.me@ttaylorr.com>
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
2.42.0.4.g52b49bb434

