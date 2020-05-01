Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E5C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB986208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGTR/LQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgEAPar (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgEAPal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE520C061A0E
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so11945587wrt.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=b9lfT24oDqZsfGrUyhW3lJduHPE19Zx1Y9VOJZPoHj4=;
        b=jGTR/LQnrmn8PZseYw4JiVSL8CjxoaPcc0L+VALdq/0DSBkx6rcafAd8sxb1hD8gXP
         x+osZMNDy2ZrNgbVCOIOuL1Gq1v3dlLHaMybRA8p3SVt4411AB9n5kOgAdNzdWytyo0+
         XbN8S66w+pldKpQEGHjSGIkgFj5XAb0LH6Y4gcp5RK/vLlGY0kmsxZFCnmbEULVfjGDO
         Sov18QqqmlkJwisUFwC4OAGq2FC8eiKERe1VT1VPmm6Mnnk2sfgqw/rwCaFcGwcPMunl
         w3jkk8Gd2VCyQrmlJfyvdCudNqY49Pecdz7+Omlq6SegTl16/EqCpbT2ZWEKh7qY4whs
         Ajyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=b9lfT24oDqZsfGrUyhW3lJduHPE19Zx1Y9VOJZPoHj4=;
        b=SXtCvn69jMhqDQH8vILhrLjwjR6BjzeGNYiGVdNVQSv9sk55Ah67ZZFl19TQRsLak3
         mFj+koyL0eV+MjpbP8M3tLCaGLhytNgERNX63w3mSzUhHzJHbvdfwqFUdONP+hFSm9RP
         XoHUsVSpTF96IdiL6V2kGJ7xC0P+In/PNHPJQZbwcGo32kiRYEishvdpbojojaSvwjpO
         UGILS0tr1kqcMtIsr1we5bDZr7eLfvgrrs/7e1OElPZlarKxUcZtpsyaJ5MewlMoJk2i
         lzcjVasZgWBSG3AxS/k1dkvlCuNsgpUaVl8E9+RSFAC62FHftd/VmxVlbPAoLHaPAj3e
         /fxA==
X-Gm-Message-State: AGi0PuZ9dK/mk1jvesEO0zJq6s6A1iGZqrbcAnFf/vRkpqRdi2XmHouz
        ikF64O2LEiIFD+nBMt56xEWj7IeV
X-Google-Smtp-Source: APiQypK4/5KEQIHRGq+4cir1Q47CqNqIRbfoS8YX/eJV5WD/5PyT/9UnXaIAChfBD0VhtaB8dKRNeg==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr5101421wrh.254.1588347039414;
        Fri, 01 May 2020 08:30:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm21977wme.16.2020.05.01.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:39 -0700 (PDT)
Message-Id: <3abc713092456b7c34ac72c0064b0b5c51ac726f.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:28 +0000
Subject: [PATCH 11/12] line-log: try to use generation number-based
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
from the previous patch on the Linux kernel repository:

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

