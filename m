Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACCDC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860362082E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da1APGCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgEKL4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729891AbgEKL4d (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764EC061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h17so1691019wrc.8
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FgvcaVTszUVZMTOf5bL5lAVJV+PTV072MNXPI+8C/wQ=;
        b=Da1APGCg9FT5QcoV35hoivwO11LgrqOjFr0+ZpPE1V8zghIUQtAlwJW8477LNRNNcM
         sn0o5O8Iyf9AkRhPxlY8z+8YtQLrV+VwRylzR1bCvYBhb6QrVQT/nCSeWXorc+fUY5vq
         BO3ynMRvrdG9KhiUYBG9a41CwvyqbhmXtbMmNNyuJkdwdbIk8wWFrhVMMJAaE89ULsle
         G7OFFPhLOPRMAm4u003n9YAWKXhPLoXbCRLf1pqI1bnG+lJPJ1VrylrzJ+0B6aHtR91y
         wwAE+tVgaY5cO7z/OP5dPvYWEwm6yJXkElh+wXDOOnWoIvHaoDOIoxyO6G0ZP53vxej5
         6uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FgvcaVTszUVZMTOf5bL5lAVJV+PTV072MNXPI+8C/wQ=;
        b=YWJOLx5/suDKQUi3caIy3bnTKhNHCPbFKj2RkNQXltwyR9+9KY0rTZtDqB2dIB9y/b
         43Ex2J9kchr8Yr1isS7tTKB/VmFYLFw1a6k/g0sCedvDQReHFio/xC3CWF+0neWYdbgv
         BEI7dWOYdd5zUVqKK/iG5Ha8xr/E+PHbnWznoF/rXfolt8EHGIX3sjyTpv44gsRes/UF
         ZpfJxqqMKGO3v/3hppX2vVlcYcnQmfwxhl/W+kyTqKdP6AV8qUjombjtAqyP2tpTIG1M
         DeHSny5CgI1Fr0ym9xuDP8y4hw9NBxIIJp73+37hCy6Jeft30KddBEa7N/A1wy7Ezb9H
         PeKw==
X-Gm-Message-State: AGi0PuZwBgxb06apU+zbLd2OQO7VFxPG7DL4Iqn1eGLsj4zDSrEHNFWp
        ze5cw0glrB+jWXTqSZiaXGk0Hf68
X-Google-Smtp-Source: APiQypJW7xzeV0RZh8hxNtW8DNnf9MKez/0/bkvE2BFSaV3LL0mPk4rhxFh01y18UNb1YcYRcnjiKg==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr14805176wrq.205.1589198190515;
        Mon, 11 May 2020 04:56:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm3613378wrr.42.2020.05.11.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:30 -0700 (PDT)
Message-Id: <da087d2acbb83a7056427d237627188744bbd3a2.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:18 +0000
Subject: [PATCH v2 11/12] line-log: try to use generation number-based
 topo-ordering
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

The previous patch made it possible to perform line-level filtering
during history traversal instead of in an expensive preprocessing
step, but it still requires some simpler preprocessing steps, notably
topo-ordering.  However, nowadays we have commit-graphs storing
generation numbers, which make it possible to incrementally traverse
the history in topological order, without the preparatory limit_list()
and sort_in_topological_order() steps; see b45424181e (revision.c:
generation-based topo-order algorithm, 2018-11-01).

This patch combines the two, so we can do both the topo-ordering and
the line-level filtering during history traversal, eliminating even
those simpler preprocessing steps, and thus further reducing the delay
before showing the first commit modifying the given line range.

The 'revs->limited' flag plays the central role in this, because, due
to limitations of the current implementation, the generation
number-based topo-ordering is only enabled when this flag remains
unset.  Line-level log, however, always sets this flag in
setup_revisions() ever since the feature was introduced in 12da1d1f6f
(Implement line-history search (git log -L), 2013-03-28).  The reason
for setting 'limited' is unclear, though, because the line-level log
itself doesn't directly depend on it, and it doesn't affect how the
limit_list() function limits the revision range.  However, there is an
indirect dependency: the line-level log requires topo-ordering, and
the "traditional" sort_in_topological_order() requires an already
limited commit list since e6c3505b44 (Make sure we generate the whole
commit list before trying to sort it topologically, 2005-07-06).  The
new, generation numbers-based topo-ordering doesn't require a limited
commit list anymore.

So don't set 'revs->limited' for line-level log, unless it is really
necessary, namely:

  - The user explicitly requested parent rewriting, because that is
    still done in the line_log_filter() preprocessing step (see
    previous patch), which requires sort_in_topological_order() and in
    turn limit_list() as well.

  - A commit-graph file is not available or it doesn't yet contain
    generation numbers.  In these cases we had to fall back on
    sort_in_topological_order() and in turn limit_list().  The
    existing condition with generation_numbers_enabled() has already
    ensured that the 'limited' flag is set in these cases; this patch
    just makes sure that the line-level log sets 'revs->topo_order'
    before that condition.

While the reduced delay before showing the first commit is measurable
in git.git, it takes a bigger repository to make it clearly noticable.
In both cases below the line ranges were chosen so that they were
modified rather close to the starting revisions, so the effect of this
change is most noticable.

  # git.git
  $ time git --no-pager log -L:read_alternate_refs:sha1-file.c -1 v2.23.0

  Before:

    real    0m0.107s
    user    0m0.091s
    sys     0m0.013s

  After:

    real    0m0.058s
    user    0m0.050s
    sys     0m0.005s

  # linux.git
  $ time git --no-pager log \
    -L:build_restore_work_registers:arch/mips/mm/tlbex.c -1 v5.2

  Before:

    real   0m1.129s
    user   0m1.061s
    sys    0m0.069s

  After:

    real   0m0.096s
    user   0m0.087s
    sys    0m0.009s

Additional testing by Derrick Stolee: Since this patch improves
the performance for the first result, I repeated the experiment
from the previous patch on the Linux kernel repository, reporting
real time here:

    Command: git log -L 100,200:MAINTAINERS -n 1 >/dev/null
     Before: 0.71 s
      After: 0.05 s

Now, we have dropped the full topo-order of all ~910,000 commits
before reporting the first result. The remaining performance
improvements then are:

 1. Update the parent-rewriting logic to be incremental similar to
    how "git log --graph" behaves.

 2. Use changed-path Bloom filters to reduce the time spend in the
    tree-diff to see if the path(s) changed.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 3228db9af6d..3356ede9a20 100644
--- a/revision.c
+++ b/revision.c
@@ -2790,6 +2790,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
+	if (revs->line_level_traverse) {
+		if (want_ancestry(revs))
+			revs->limited = 1;
+		revs->topo_order = 1;
+	}
+
 	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
@@ -2809,11 +2815,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-	if (revs->line_level_traverse) {
-		revs->limited = 1;
-		revs->topo_order = 1;
-	}
-
 	diff_setup_done(&revs->diffopt);
 
 	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
-- 
gitgitgadget

