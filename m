Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C40C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AC92089D
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEPpHYr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFQRYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFQRYg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 13:24:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC82C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:24:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so3171436wru.12
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xZ7etHJFI6V7aTuvdBoofGc/M+gcK1FR+i84kcWaLI0=;
        b=oEPpHYr6gbdYialWlAdL8ZdrjcWhNwIvpwt+lsL361h3sQ8+xJA/dd5XUWPQZsoP99
         3fWlp4rSVvtaurTIlavpaN7DUdYCnNJ8AUsLfJClfTJAj5KyaUIn9aYLsFKR0LPtSjfc
         BnC4AS3O/+qtr9sKf9oMX3hwFpvKLLjq84g97irKhw+wVUy3qzEfMU9QttOp4q/Zdrgg
         NDzUvjTMdUiu4bhFo9Ou9tmMiP1ETJjEVafM04nXEIBAgPc11sinovM6a3aBqTWFKEiH
         DM+wrPlx9OjS7RSb4GqZqcCPRl/LXJGt69k3JzH/GPd98yMbIq/2gioB0zsXE4jEa58T
         dm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xZ7etHJFI6V7aTuvdBoofGc/M+gcK1FR+i84kcWaLI0=;
        b=ogHS/D0FshZIxHoQlsigv/Kvia6ua8H3qSWhud30ydMRGwFvPQRLHONBhqkCx85Cid
         cNqVwnadHv4rQLF6wqzkh4wgZPGDrM9DvpcDEJSL99Efp5RcDf0nij7L/IWosJ7j3hzt
         0WMAueIOQniP6SuaaUEtzuBMCj/ZaSvlGLR2KExNkDGT/7+pJQkZ1RezfynBGXX1YkXF
         VH2/vgr7l7K9YaBBG18Ttds2nuVDfDyQKUhQy54/sc+SZgtW2oSyC+603xkUSj5CD2XK
         90zh/JMVUR9Z13lo7aCFGLbblhQUVGXND83VqRB63+sKazdUM1psheJm36Em1WwHq8/+
         Ve5Q==
X-Gm-Message-State: AOAM531OsMSq4BfJF0rEWAqLC+Y59dHWSNzYWb2DsQMGnEUaZooFH+61
        7rBVPUyHZD3+fSPMmmKZGswoUDaj
X-Google-Smtp-Source: ABdhPJyke767lhz2Jp7sGxaUWvPlWbiEZrCc/ZgdnC+l03Rr+dbHhxkjYsOuVxSox30d2wKpA10pmg==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr312609wra.238.1592414673599;
        Wed, 17 Jun 2020 10:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c70sm415815wme.32.2020.06.17.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:24:33 -0700 (PDT)
Message-Id: <ead5a0d9bd3b5c4a8c3fde970941c0e4a10025ab.1592414670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.664.git.1592414670.gitgitgadget@gmail.com>
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Jun 2020 17:24:29 +0000
Subject: [PATCH 2/2] commit-reach: use fast logic in repo_in_merge_base
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The repo_is_descendant_of() method is aware of the existence of the
commit-graph file. It checks for generation_numbers_enabled() before
deciding on using can_all_from_reach() or repo_in_merge_bases()
depending on the situation. The reason here is that can_all_from_reach()
uses a depth-first search that is limited by the minimum generation
number of the target commits, and that algorithm can be very slow when
generation numbers are not present. The alternative uses
paint_down_to_common() which will walk the entire merge-base boundary,
which is typically slower.

This method is used by commands like "git tag --contains" and "git
branch --contains" for very fast results when a commit-graph file
exists. Unfortunately, it is _not_ used in commands like "git merge-base
--is-ancestor" which is doing an even simpler request.

This issue was raised recently [1] with respect to a change to how
generation numbers are stored, but was also reported much earlier [2]
before commit-reach.c existed to simplify these reachability queries.

[1] https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/
[2] https://lore.kernel.org/git/87608bawoa.fsf@evledraar.gmail.com/

The root cause is that builtin/merge-base.c has a method
handle_is_ancestor() that calls in_merge_bases(), an older version of
repo_in_merge_bases(). It would be better if we have every caller to
in_merge_bases() use the logic in can_all_from_reach() when possible.

This is where things get a little tricky: repo_is_descendant_of() calls
repo_in_merge_bases() in the non-generation numbers enabled case! If we
simply update repo_in_merge_bases() to call repo_is_descendant_of()
instead of repo_in_merge_bases_many(), then we will get a recursive call
loop. Thankfully, this is caught by the test suite in the default mode
(i.e. GIT_TEST_COMMIT_GRAPH=0).

The trick, then, is to make the non-generation number case for
repo_is_descendant_of() call repo_in_merge_bases_many() directly,
skipping the non-_many version. This allows us to take advantage of this
faster code path, when possible.

The easiest way to measure the performance impact is to test the
following command on the Linux kernel repository:

	git merge-base --is-ancestor <A> <B>

  | A    | B    | Time Before | Time After |
  |------|------|-------------|------------|
  | v3.0 | v5.7 | 0.459s      | 0.028s     |
  | v4.0 | v5.7 | 0.267s      | 0.021s     |
  | v5.0 | v5.7 | 0.074s      | 0.013s     |

Note that each of these samples return success. The old code performed
the same operation when <A> and <B> are swapped. However,
can_all_from_reach() will return immediately if the generation numbers
show that <A> has larger generation number than <B>. Thus, the time for
the swapped case is universally 0.004s in each case.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 13722430aa5..43e303d5f25 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -303,7 +303,7 @@ static int repo_is_descendant_of(struct repository *r,
 
 			other = with_commit->item;
 			with_commit = with_commit->next;
-			if (repo_in_merge_bases(r, other, commit))
+			if (repo_in_merge_bases_many(r, other, 1, &commit))
 				return 1;
 		}
 		return 0;
@@ -355,7 +355,15 @@ int repo_in_merge_bases(struct repository *r,
 			struct commit *commit,
 			struct commit *reference)
 {
-	return repo_in_merge_bases_many(r, commit, 1, &reference);
+	int res;
+	struct commit_list *list = NULL;
+	struct commit_list **next = &list;
+
+	next = commit_list_append(commit, next);
+	res = repo_is_descendant_of(r, reference, list);
+	free_commit_list(list);
+
+	return res;
 }
 
 struct commit_list *reduce_heads(struct commit_list *heads)
-- 
gitgitgadget
