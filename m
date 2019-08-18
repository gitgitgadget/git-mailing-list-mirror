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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A22F1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfHRS2T (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:28:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34344 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 14:28:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so1140699wme.1
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqBm2c0SHbd5AcJKFCJ0VSpr7Oo6uY+aBiNzs5Iftv0=;
        b=s4ApkALmd5rjYDEYp3BdOp0YS178k9eW0rSrtoCgPTIvAziuwklw9y7FQSiT74qd7T
         KWKLqxTPLK79GTGpwWzPqyKwYhouN9JTjPbEt4xmFWnJKTjCbUMk6z62Y7oj4APxH5eI
         MV3NDbvt/ob88YI/JC8a9riHY44qWUmw6Xfm1Re9ah23AkzkU9lzbF/EPikofeGGkWzO
         9phPzl4dNjYil3yrQcIKID98VOWmcKRtneZpd1JMsc7QfmeWgPTySsYR2GVyVvnEdogD
         T6KrzoE1/A2jv+WB3Wu69WhHAPulu7LGLJ7G68j5C67qj+RxC96t1AA4iz6N4fxNWxq9
         T6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqBm2c0SHbd5AcJKFCJ0VSpr7Oo6uY+aBiNzs5Iftv0=;
        b=A93wfD2g8iSvfIX8hsv5AOuCsY63PWHDtdKRdl6DOQBqhbYq1kEYuznu2oWz6iO2NE
         Y2Pvhpo5y8Zzn13o2okwOzB5EI15DQYP87jd2cp4K+ACVThTCa6sx4gtPBP4pT20RLU1
         JHGY2raLdx8OLGG/j1tWvwGkbZHuPeeGcu43sBOVZavIWkAW8fUYLM8QZfy1e1KaF18+
         U1YsRQraoN1IWC2txlbOIbQqZpCa2JbP6AFOe0Z52gH9EDrv47ARZf5jGQ1F5ggdLr/y
         JT2vaUDQUsyPwHOBVcTY4a2BJb7maistm4q5zAh1WQR5kznZ3cRjREmtWyp2LSnJbCg5
         5RJw==
X-Gm-Message-State: APjAAAWkGJ50+OJ/rqZBc7qqEKp+6olqfUeHy0RnjJPUPmXUPy6sP4Rd
        n3vGFrZLVh6jyMurPWBqD4kXuKZV
X-Google-Smtp-Source: APXvYqww3Mv4a/gYlqppXOsRXaIxZWliMmvQlxTSsAOBs1NeM1sRK8EfgeJhriE7HoyORx+SxXDzlQ==
X-Received: by 2002:a1c:c188:: with SMTP id r130mr16080982wmf.73.1566152895880;
        Sun, 18 Aug 2019 11:28:15 -0700 (PDT)
Received: from localhost.localdomain (x4db53457.dyn.telefonica.de. [77.181.52.87])
        by smtp.gmail.com with ESMTPSA id c201sm24112584wmd.33.2019.08.18.11.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:28:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 4/5] line-log: more responsive, incremental 'git log -L'
Date:   Sun, 18 Aug 2019 20:28:00 +0200
Message-Id: <20190818182801.7580-5-szeder.dev@gmail.com>
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

The current line-level log implementation performs a preprocessing
step in prepare_revision_walk(), during which the line_log_filter()
function filters and rewrites history to keep only commits modifying
the given line range.  This preprocessing affects both responsiveness
and correctness:

  - Git doesn't produce any output during this preprocessing step.
    Checking whether a commit modified the given line range is
    somewhat expensive, so depending on the size of the given revision
    range this preprocessing can result in a significant delay before
    the first commit is shown.

  - Limiting the number of displayed commits (e.g. 'git log -3 -L...')
    doesn't limit the amount of work during preprocessing, because
    that limit is applied during history traversal.  Alas, by that
    point this expensive preprocessing step has already churned
    through the whole revision range to find all commits modifying the
    revision range, even though only a few of them need to be shown.

  - It rewrites parents, with no way to turn it off.  Without the user
    explicitly requesting parent rewriting any parent object ID shown
    should be that of the immediate parent, just like in case of a
    pathspec-limited history traversal without parent rewriting.

    However, after that preprocessing step rewrote history, the
    subsequent "regular" history traversal (i.e. get_revision() in a
    loop) only sees commits modifying the given line range.
    Consequently, it can only show the object ID of the last ancestor
    that modified the given line range (which might happen to be the
    immediate parent, but many-many times it isn't).

This patch addresses both the correctness and, at least for the common
case, the responsiveness issues by integrating line-level log
filtering into the regular revision walking machinery:

  - Make process_ranges_arbitrary_commit(), the static function in
    'line-log.c' deciding whether a commit modifies the given line
    range, public by removing the static keyword and adding the
    'line_log_' prefix, so it can be called from other parts of the
    revision walking machinery.

  - If the user didn't explicitly ask for parent rewriting (which, I
    believe, is the most common case):

    - Call this now-public function during regular history traversal,
      namely from get_commit_action() to ignore any commits not
      modifying the given line range.

      Note that while this check is relatively expensive, it must be
      performed before other, much cheaper conditions, because the
      tracked line range must be adjusted even when the commit will
      end up being ignored by other conditions.

    - Skip the line_log_filter() call, i.e. the expensive
      preprocessing step, in prepare_revision_walk(), because, thanks
      to the above points, the revision walking machinery is now able
      to filter out commits not modifying the given line range while
      traversing history.

      This way the regular history traversal sees the unmodified
      history, and is therefore able to print the object ids of the
      immediate parents of the listed commits.  The eliminated
      preprocessing step can greatly reduce the delay before the first
      commit is shown, see the numbers below.

  - However, if the user did explicitly ask for parent rewriting via
    '--parents' or a similar option, then stick with the current
    implementation for now, i.e. perform that expensive filtering and
    history rewriting in the preprocessing step just like we did
    before, leaving the initial delay as long as it was.

I tried to integrate line-level log filtering with parent rewriting
into the regular history traversal, but, unfortunately, several
subtleties resisted... :)  Maybe someday we'll figure out how to do
that, but until then at least the simple and common (i.e. without
parent rewriting) 'git log -L:func:file' commands can benefit from the
reduced delay.

This change makes the failing 'parent oids without parent rewriting'
test in 't4211-line-log.sh' succeed.

The reduced delay is most noticable when there's a commit modifying
the line range near the tip of a large-ish revision range:

  # no parent rewriting requested, no commit-graph present
  $ time git --no-pager log -L:read_alternate_refs:sha1-file.c -1 v2.23.0

  Before:

    real    0m9.570s
    user    0m9.494s
    sys     0m0.076s

  After:

    real    0m0.718s
    user    0m0.674s
    sys     0m0.044s

A significant part of the remaining delay is spent reading and parsing
commit objects in limit_list().  With the help of the commit-graph we
can eliminate most of that reading and parsing overhead, so here are
the timing results of the same command as above, but this time using
the commit-graph:

  Before:

    real    0m8.874s
    user    0m8.816s
    sys     0m0.057s

  After:

    real    0m0.107s
    user    0m0.091s
    sys     0m0.013s

The next patch will further reduce the remaining delay.

To be clear: this patch doesn't actually optimize the line-level log,
but merely moves most of the work from the preprocessing step to the
history travelsal, so the commits modifying the line range can be
shown as soon as they are processed, and the traversal can be
terminated as soon as the given number of commits are shown.
Consequently, listing the full history of a line range, potentially
all the way to the root commit, will take the same time as before (but
at least the user might start reading the output earlier).
Furthermore, if the most recent commit modifying the line range is far
away from the starting revision, then that initial delay will still be
significant.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    Regarding that "most common case": I know, I know, one should not
    extrapolate only from his own usage patterns...  But FWIW, I've been
    using various versions of this patch for over two years now, and never
    missed the rewritten parents.  And just pulled a couple of years worth
    of ~/.bash_history files from backups, and there was not a single
    occasion where I used line-level log with parent rewriting (apart from
    testing these changes).

 line-log.c          |  4 ++--
 line-log.h          |  2 ++
 revision.c          | 27 ++++++++++++++++++++++++++-
 t/t4211-line-log.sh |  2 +-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index 3aff1849e7..772ab57d52 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1194,7 +1194,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	/* NEEDSWORK leaking like a sieve */
 }
 
-static int process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
+int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
 {
 	struct line_log_data *range = lookup_line_range(rev, commit);
 	int changed = 0;
@@ -1237,7 +1237,7 @@ int line_log_filter(struct rev_info *rev)
 	while (list) {
 		struct commit_list *to_free = NULL;
 		commit = list->item;
-		if (process_ranges_arbitrary_commit(rev, commit)) {
+		if (line_log_process_ranges_arbitrary_commit(rev, commit)) {
 			*pp = list;
 			pp = &list->next;
 		} else
diff --git a/line-log.h b/line-log.h
index 882c5055bb..82ae8d98a4 100644
--- a/line-log.h
+++ b/line-log.h
@@ -54,6 +54,8 @@ struct line_log_data {
 void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args);
 
 int line_log_filter(struct rev_info *rev);
+int line_log_process_ranges_arbitrary_commit(struct rev_info *rev,
+						    struct commit *commit);
 
 int line_log_print(struct rev_info *rev, struct commit *commit);
 
diff --git a/revision.c b/revision.c
index 07412297f0..6bdfcb38cd 100644
--- a/revision.c
+++ b/revision.c
@@ -36,6 +36,8 @@ static const char *term_good;
 
 implement_shared_commit_slab(revision_sources, char *);
 
+static inline int want_ancestry(const struct rev_info *revs);
+
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	const char *p;
@@ -3359,7 +3361,14 @@ int prepare_revision_walk(struct rev_info *revs)
 			sort_in_topological_order(&revs->commits, revs->sort_order);
 	} else if (revs->topo_order)
 		init_topo_walk(revs);
-	if (revs->line_level_traverse)
+	if (revs->line_level_traverse && want_ancestry(revs))
+		/*
+		 * At the moment we can only do line-level log with parent
+		 * rewriting by performing this expensive pre-filtering step.
+		 * If parent rewriting is not requested, then we rather
+		 * perform the line-level log filtering during the regular
+		 * history traversal.
+		 */
 		line_log_filter(revs);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
@@ -3569,6 +3578,22 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_ignore;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
+	if (revs->line_level_traverse && !want_ancestry(revs)) {
+		/*
+		 * In case of line-level log with parent rewriting
+		 * prepare_revision_walk() already took care of all line-level
+		 * log filtering, and there is nothing left to do here.
+		 *
+		 * If parent rewriting was not requested, then this is the
+		 * place to perform the line-level log filtering.  Notably,
+		 * this check, though expensive, must come before the other,
+		 * cheaper filtering conditions, because the tracked line
+		 * ranges must be adjusted even when the commit will end up
+		 * being ignored based on other conditions.
+		 */
+		if (!line_log_process_ranges_arbitrary_commit(revs, commit))
+			return commit_ignore;
+	}
 	if (revs->min_age != -1 &&
 	    comparison_date(revs, commit) > revs->min_age)
 			return commit_ignore;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index c378a453de..8096208abb 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -180,7 +180,7 @@ test_expect_success 'setup for checking line-log and parent oids' '
 '
 
 # Parent oid should be from immediate parent.
-test_expect_failure 'parent oids without parent rewriting' '
+test_expect_success 'parent oids without parent rewriting' '
 	cat >expect <<-EOF &&
 	$head_oid $prev_oid Modify func2() in file.c
 	$root_oid  Add func1() and func2() in file.c
-- 
2.23.0.349.g73f10e387d

