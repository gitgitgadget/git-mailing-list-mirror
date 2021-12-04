Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599CBC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 05:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhLDFjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 00:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhLDFjU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 00:39:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963FC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 21:35:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so10126291wru.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 21:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2pxRHH3Rxl5y/9NZs0n++D0rTUjZ8J6XLfy7eWqmF4w=;
        b=eDidkHGp9u7/Mzu7V81FjES7aWPsBL9lKpNqrA+H26A90o3+lJr5M1uq9vtxBAYbiY
         QYQSZ32FB288tSVF7GMJ3bU8HhBoNu/4pBWIqbIFjeDx+fwnl+tIM0iNKgQAO5kdJa+G
         9hxxzDz03TfJXiz1v2hZ8DdKVBOcNgONHJcGIPGWn8/GLMha4Z9JOzVhguQZVQ9cAbXH
         eUjpQ6mweq4Rk/Z8zGyIkkKJzfq2qAwtSjhtrBSksQcf5SBI23uBptm+jy83+u8q9dgV
         g8EvV0BP+0A6bn9v1MC7eIqKG5/Z6GFQbaszwZztsa7KmxMhM/c7/5sbUXibcy0wcJJ8
         xgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2pxRHH3Rxl5y/9NZs0n++D0rTUjZ8J6XLfy7eWqmF4w=;
        b=Rmg67vNjcrZL06tzEy95E9gncwo9Eb4DQcD2kPQxD9ux1nPVcPn+NlDh7LgNX3h8M+
         w0g3FJ0IHDRGMlGErIwuNRcoiUb1ApsTqodMEo6EM/jq0qWTxq3NahXSu0/2sJHH65Vl
         MCcgUGZGPKBL0e4lQMOg9gPk15j9ilpMXLmufxOm4/dz+BLr7mDgGz5CCWLUxNSVn5OY
         o2t4oweLF4VQWYIlsR22j3fv1idx9rZsiWk4m7YG4HX1PZJ8Bck9jihPtKh2Gwq1n5VX
         qd9eD70tD+Vs9g4F8qc9f3MuZ47clB9wwKzgmthu2GHkDlY/ZLIT9DdprAgVGoakW/38
         MqBg==
X-Gm-Message-State: AOAM532jBC/znjgXeZ4fEMLZhUkcHyuvU3td6EJw7tHo8sfvCvwbSync
        fKErdTjpx85MgnyBAS0uAGtwwIMVpok=
X-Google-Smtp-Source: ABdhPJxMhuw1MntdAAWcrWEVeKN3S8TC/LeLhKk7TQ8A+jjpdyfrmvvVKEx8qarvMZNVCF3Ws/h+TA==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr26581469wrv.73.1638596153775;
        Fri, 03 Dec 2021 21:35:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm8071065wms.1.2021.12.03.21.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 21:35:53 -0800 (PST)
Message-Id: <pull.1119.v2.git.git.1638596152340.gitgitgadget@gmail.com>
In-Reply-To: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
References: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 05:35:52 +0000
Subject: [PATCH v2] name-rev: prefer shorter names over following merges
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

name-rev has a MERGE_TRAVERSAL_WEIGHT to say that traversing a second or
later parent of a merge should be 65535 times more expensive than a
first-parent traversal, as per ac076c29ae8d (name-rev: Fix non-shortest
description, 2007-08-27).  The point of this weight is to prefer names
like

    v2.32.0~1471^2

over names like

    v2.32.0~43^2~15^2~11^2~20^2~31^2

which are two equally valid names in git.git for the same commit.  Note
that the first follows 1472 parent traversals compared to a mere 125 for
the second.  Weighting all traversals equally would clearly prefer the
second name since it has fewer parent traversals, but humans aren't
going to be traversing commits and they tend to have an easier time
digesting names with fewer segments.  The fact that the former only has
two segments (~1471, ^2) makes it much simpler than the latter which has
six segments (~43, ^2, ~15, etc.).  Since name-rev is meant to "find
symbolic names suitable for human digestion", we prefer fewer segments.

However, the particular rule implemented in name-rev would actually
prefer

    v2.33.0-rc0~11^2~1

over

    v2.33.0-rc0~20^2

because both have precisely one second parent traversal, and it gives
the tie breaker to shortest number of total parent traversals.  Fewer
segments is more important for human consumption than number of hops, so
we'd rather see the latter which has one fewer segment.

Include the generation in is_better_name() and use a new
effective_distance() calculation so that we prefer fewer segments in
the printed name over fewer total parent traversals performed to get the
answer.

== Side-note on tie-breakers ==

When there are the same number of segments for two different names, we
actually use the name of an ancestor commit as a tie-breaker as well.
For example, for the commit cbdca289fb in the git.git repository, we
prefer the name v2.33.0-rc0~112^2~1 over v2.33.0-rc0~57^2~5.  This is
because:

  * cbdca289fb is the parent of 25e65b6dd5, which implies the name for
    cbdca289fb should be the first parent of the preferred name for
    25e65b6dd5
  * 25e65b6dd5 could be named either v2.33.0-rc0~112^2 or
    v2.33.0-rc0~57^2~4, but the former is preferred over the latter due
    to fewer segments
  * combine the two previous facts, and the name we get for cbdca289fb
    is "v2.33.0-rc0~112^2~1" rather than "v2.33.0-rc0~57^2~5".

Technically, we get this for free out of the implementation since we
only keep track of one name for each commit as we walk history (and
re-add parents to the queue if we find a better name for those parents),
but the first bullet point above ensures users get results that feel
more consistent.

== Alternative Ideas and Meanings Discussed ==

One suggestion that came up during review was that shortest
string-length might be easiest for users to consume.  However, such a
scheme would be rather computationally expensive (we'd have to track all
names for each commit as we traversed the graph) and would additionally
come with the possibly perplexing result that on a linear segment of
history we could rapidly swap back and forth on names:
   MYTAG~3^2     would     be preferred over   MYTAG~9998
   MYTAG~3^2~1   would NOT be preferred over   MYTAG~9999
   MYTAG~3^2~2   might     be preferred over   MYTAG~10000

Another item that came up was possible auxiliary semantic meanings for
name-rev results either before or after this patch.  The basic answer
was that the previous implementation had no known useful auxiliary
semantics, but that for many repositories (most in my experience), the
new scheme does.  In particular, the new name-rev output can often be
used to answer the question, "How or when did this commit get merged?"
Since that usefulness depends on how merges happen within the repository
and thus isn't universally applicable, details are omitted here but you
can see them at [1].

[1] https://lore.kernel.org/git/CABPp-BEeUM+3NLKDVdak90_UUeNghYCx=Dgir6=8ixvYmvyq3Q@mail.gmail.com/

Finally, it was noted that the algorithm could be improved by just
explicitly tracking the number of segments and using both it and
distance in the comparison, instead of giving a magic number that tries
to blend the two (and which therefore might give suboptimal results in
repositories with really huge numbers of commits that periodically merge
older code).  However, "[this patch] seems to give us a much better
results than the current code, so let's take it and leave further
futzing outside the scope."

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
    name-rev: prefer shorter names over following merges
    
    Changes since v1:
    
     * Include acks from Ævar and Dscho
     * To aid future readers, added a few comments to the commit message
       from the mailing list discussion about tie-breakers and other
       possible improvements
     * The 2.35 cycle has started and it's been weeks since I sent v1, so
       it's time to resend. :-)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1119%2Fnewren%2Fprefer-shorter-names-in-name-rev-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1119/newren/prefer-shorter-names-in-name-rev-v2
Pull-Request: https://github.com/git/git/pull/1119

Range-diff vs v1:

 1:  50812ed6fdf ! 1:  5d068486f9f name-rev: prefer shorter names over following merges
     @@ Commit message
          the printed name over fewer total parent traversals performed to get the
          answer.
      
     +    == Side-note on tie-breakers ==
     +
     +    When there are the same number of segments for two different names, we
     +    actually use the name of an ancestor commit as a tie-breaker as well.
     +    For example, for the commit cbdca289fb in the git.git repository, we
     +    prefer the name v2.33.0-rc0~112^2~1 over v2.33.0-rc0~57^2~5.  This is
     +    because:
     +
     +      * cbdca289fb is the parent of 25e65b6dd5, which implies the name for
     +        cbdca289fb should be the first parent of the preferred name for
     +        25e65b6dd5
     +      * 25e65b6dd5 could be named either v2.33.0-rc0~112^2 or
     +        v2.33.0-rc0~57^2~4, but the former is preferred over the latter due
     +        to fewer segments
     +      * combine the two previous facts, and the name we get for cbdca289fb
     +        is "v2.33.0-rc0~112^2~1" rather than "v2.33.0-rc0~57^2~5".
     +
     +    Technically, we get this for free out of the implementation since we
     +    only keep track of one name for each commit as we walk history (and
     +    re-add parents to the queue if we find a better name for those parents),
     +    but the first bullet point above ensures users get results that feel
     +    more consistent.
     +
     +    == Alternative Ideas and Meanings Discussed ==
     +
     +    One suggestion that came up during review was that shortest
     +    string-length might be easiest for users to consume.  However, such a
     +    scheme would be rather computationally expensive (we'd have to track all
     +    names for each commit as we traversed the graph) and would additionally
     +    come with the possibly perplexing result that on a linear segment of
     +    history we could rapidly swap back and forth on names:
     +       MYTAG~3^2     would     be preferred over   MYTAG~9998
     +       MYTAG~3^2~1   would NOT be preferred over   MYTAG~9999
     +       MYTAG~3^2~2   might     be preferred over   MYTAG~10000
     +
     +    Another item that came up was possible auxiliary semantic meanings for
     +    name-rev results either before or after this patch.  The basic answer
     +    was that the previous implementation had no known useful auxiliary
     +    semantics, but that for many repositories (most in my experience), the
     +    new scheme does.  In particular, the new name-rev output can often be
     +    used to answer the question, "How or when did this commit get merged?"
     +    Since that usefulness depends on how merges happen within the repository
     +    and thus isn't universally applicable, details are omitted here but you
     +    can see them at [1].
     +
     +    [1] https://lore.kernel.org/git/CABPp-BEeUM+3NLKDVdak90_UUeNghYCx=Dgir6=8ixvYmvyq3Q@mail.gmail.com/
     +
     +    Finally, it was noted that the algorithm could be improved by just
     +    explicitly tracking the number of segments and using both it and
     +    distance in the comparison, instead of giving a magic number that tries
     +    to blend the two (and which therefore might give suboptimal results in
     +    repositories with really huge numbers of commits that periodically merge
     +    older code).  However, "[this patch] seems to give us a much better
     +    results than the current code, so let's take it and leave further
     +    futzing outside the scope."
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## builtin/name-rev.c ##
      @@ builtin/name-rev.c: static struct rev_name *get_commit_rev_name(const struct commit *commit)


 builtin/name-rev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b221d300147..27f60153a6c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -44,11 +44,20 @@ static struct rev_name *get_commit_rev_name(const struct commit *commit)
 	return is_valid_rev_name(name) ? name : NULL;
 }
 
+static int effective_distance(int distance, int generation)
+{
+	return distance + (generation > 0 ? MERGE_TRAVERSAL_WEIGHT : 0);
+}
+
 static int is_better_name(struct rev_name *name,
 			  timestamp_t taggerdate,
+			  int generation,
 			  int distance,
 			  int from_tag)
 {
+	int name_distance = effective_distance(name->distance, name->generation);
+	int new_distance = effective_distance(distance, generation);
+
 	/*
 	 * When comparing names based on tags, prefer names
 	 * based on the older tag, even if it is farther away.
@@ -56,7 +65,7 @@ static int is_better_name(struct rev_name *name,
 	if (from_tag && name->from_tag)
 		return (name->taggerdate > taggerdate ||
 			(name->taggerdate == taggerdate &&
-			 name->distance > distance));
+			 name_distance > new_distance));
 
 	/*
 	 * We know that at least one of them is a non-tag at this point.
@@ -69,8 +78,8 @@ static int is_better_name(struct rev_name *name,
 	 * We are now looking at two non-tags.  Tiebreak to favor
 	 * shorter hops.
 	 */
-	if (name->distance != distance)
-		return name->distance > distance;
+	if (name_distance != new_distance)
+		return name_distance > new_distance;
 
 	/* ... or tiebreak to favor older date */
 	if (name->taggerdate != taggerdate)
@@ -88,7 +97,7 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 	struct rev_name *name = commit_rev_name_at(&rev_names, commit);
 
 	if (is_valid_rev_name(name)) {
-		if (!is_better_name(name, taggerdate, distance, from_tag))
+		if (!is_better_name(name, taggerdate, generation, distance, from_tag))
 			return NULL;
 
 		/*

base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
-- 
gitgitgadget
