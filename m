Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527531F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfHRS2U (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:28:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35013 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 14:28:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id k2so6389977wrq.2
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PO9BYIrfXh56jG2MQnZKLDJN52D2cV0+O/dPenP9Jd8=;
        b=VtOR5JCzUgUBWOjrxM+4/WYrZBmqB/43xaJOYwppyuGHlxcSyiWt9fjxqEU2rBhVtR
         ln4g4ELAmt1vECN+QhGA/jU2FT/ZdzvCNJeSZ7q2iSB9RNuAKG/CU9d/23ebaVvJNKY/
         NwhATOCZVi4xJGHQYGI5NihAC+msFliAuMsizzYthB9TpSuDdo3IzWHEEzr1GsYHLNmD
         zCCtat8Kz18vRT7cotGlsUtFZVMEv3PuiMK5fUHLw49B5bJLH6IxPz4YNSKRV+R9GINT
         0uXM21hiVO9e45n3KUQTdFaaYQj0vCekgzjdefWmBBdNxyk9/cZPS5zv5YKZ547Bh96a
         AThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PO9BYIrfXh56jG2MQnZKLDJN52D2cV0+O/dPenP9Jd8=;
        b=Bfv0Rtd7C+rCecHlQHnGW9urbL1Y9SSdDyES+2DqZtKzfTHlfocGS6WSkDizpI0Smb
         JyC4zG5bDLcQc/ZSWX/yyjUcGSKfJo1FsMpQiwC4rEGQXdp6PzVTn4mI3goOqe/StNZF
         r/J3vr63YIcmv0RGq+0S2L4pjMo4VdqfFLuNy16S7UCo48H6ptF5eYTj3p9eoCnewXc9
         ZHWXLMoX9pMXzAQAIyrDFpTdHk5AgN43PHhL7D00D0Efp8k8aAxfkIDZC6Gnje1mfqPc
         3lHBKS39MfDlStphu6C8Jql2kQXfGmV1fgilEFItMJkx/1j/ZcEDj/0Xbs8iyBoY353i
         AK1Q==
X-Gm-Message-State: APjAAAUc4UgsIoWL5GHt90qLuMA5nsFrGW62VtlvMBTLfWfaQZqyUvrm
        mpBIeJw7KrrECLOVL6whuaIf7YjB
X-Google-Smtp-Source: APXvYqwggF6fTGffEYdom27G2h8zdV7J6CtTiN5KyewbCM+HJR0zr/h9+zNkyGTlnzn8+V1NmnNPJg==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr22543132wrq.52.1566152897352;
        Sun, 18 Aug 2019 11:28:17 -0700 (PDT)
Received: from localhost.localdomain (x4db53457.dyn.telefonica.de. [77.181.52.87])
        by smtp.gmail.com with ESMTPSA id c201sm24112584wmd.33.2019.08.18.11.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:28:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 5/5] line-log: try to use generation number-based topo-ordering
Date:   Sun, 18 Aug 2019 20:28:01 +0200
Message-Id: <20190818182801.7580-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.349.g73f10e387d
In-Reply-To: <20190818182801.7580-1-szeder.dev@gmail.com>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    FWIW, that line-level log sets 'limited' in addition to 'topo_order'
    thing was already part of the first submitted iteration of the
    line-level log patch series:
    
    https://public-inbox.org/git/1277558857-23103-4-git-send-email-struggleyb.nku@gmail.com/#Z30revision.c
    
    But it was never discussed during review.

 revision.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 6bdfcb38cd..7a9dc54771 100644
--- a/revision.c
+++ b/revision.c
@@ -2658,6 +2658,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
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
 
@@ -2677,11 +2683,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-	if (revs->line_level_traverse) {
-		revs->limited = 1;
-		revs->topo_order = 1;
-	}
-
 	diff_setup_done(&revs->diffopt);
 
 	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
-- 
2.23.0.349.g73f10e387d

