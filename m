Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7FC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D911208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdtX4rYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgEAPas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbgEAPal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9FC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so10013432wme.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tEt5c9Y8Tu8kUE5gWGCM2SjW/P21OSHrLMLD+MMpW5k=;
        b=IdtX4rYLpX6gvdEZjxqErkCh+nv6BUnYkbUxYxlvSd9Xv6ufhuiqv9hs2Y6jL5vvJW
         8znZLakqmlJSKdugibu88caQvexCsHzZOhtdTkagDqngIcNmmrTFsrj0NT1DlQMUecOz
         h4ZxOZx8eKi8KnF3Vdu5cOjqRJvzt7AfxjXQWr9qkHIFm4hFvt7FMHMYINsV7AQ/0V5/
         QgsFngmCwhb9HUSfol8hl3+B9aQZCw2NbYJSgTPHdWLPbdHbqviahKljimxn3VGyCTY3
         lVudy5AtcuO36ttYhsSO9AQ2XyBz3BRix7CRPCVWokCZDbZy5bH7zawff0tMQkoMkrGf
         s6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tEt5c9Y8Tu8kUE5gWGCM2SjW/P21OSHrLMLD+MMpW5k=;
        b=TvYdRMIFjJUHeXzg64k4t8JsTI+XdJUP/t95qu5ojAUTKYfmNAUxCnmVDxfn/Ai5mq
         2cS55uCxNTjCf8nKOlK4bxt19+TbGyvpMrDXemB7a+EIjYohqtD6F17qkwwbyLsf+sW/
         NizuzjxHX+3DSLGXLaV54KBJ5fwS0lnFUEx+uK2cVS3C4vAlgTDa+vAbfE2NWnStZXWj
         BjdxTdjFzlwENdInsRIp765jZeLqO/2hWBfLJXu4y1Um7hi+qEtRWfrfO8GZ4PmMMFLm
         HUqDHcl0y7K9IHwE5fkHD+4DQjfRQkQJHNciSUxH3Bsl2NTc3gKU18ZN6o2O5ZBOQPHt
         JPRg==
X-Gm-Message-State: AGi0Pubc487XK46S+QMwFdL4/DWEVXRZHkJlY1W3zs6dIgKel7YYZM8M
        qiWAvuQWMzScKLBWLeK0uam/cJ+s
X-Google-Smtp-Source: APiQypKueW8AYwjyMaOBaf7X3gp3clNAGpgH933OiscpOe+U4TxVaISgLWPrs7ly5b/clFxYygbgTg==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr147429wmb.10.1588347038682;
        Fri, 01 May 2020 08:30:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm1029751wrv.14.2020.05.01.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:38 -0700 (PDT)
Message-Id: <d9991d6158df6af0e62b8739591dd726d3479324.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:27 +0000
Subject: [PATCH 10/12] line-log: more responsive, incremental 'git log -L'
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

Additional testing by Derrick Stolee: In the Linux kernel repository,
the MAINTAINERS file was changed ~3,500 times across the ~915,000
commits. In addition to that edit frequency, the file itself is quite
large (~18,700 lines). This means that a significant portion of the
computation is taken up by computing the patch-diff of the file. This
patch improves the time it takes to output the first result quite a
bit:

Command: git log -L 100,200:MAINTAINERS -n 1 >/dev/null
 Before: 3.88 s
  After: 0.71 s

If we drop the "-n 1" in the command, then there is no change in
end-to-end process time. This is because the command still needs to
walk the entire commit history, which negates the point of this
patch. This is expected.

As a note for future reference, the ~4.3 seconds in the old code
spends ~2.6 seconds computing the patch-diffs, and the rest of the
time is spent walking commits and computing diffs for which paths
changed at each commit. The changed-path Bloom filters could improve
the end-to-end computation time (i.e. no "-n 1" in the command).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 line-log.c          |  4 ++--
 line-log.h          |  2 ++
 revision.c          | 27 ++++++++++++++++++++++++++-
 t/t4211-line-log.sh |  2 +-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index 9010e00950b..520ee715bcd 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1227,7 +1227,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	/* NEEDSWORK leaking like a sieve */
 }
 
-static int process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
+int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
 {
 	struct line_log_data *range = lookup_line_range(rev, commit);
 	int changed = 0;
@@ -1270,7 +1270,7 @@ int line_log_filter(struct rev_info *rev)
 	while (list) {
 		struct commit_list *to_free = NULL;
 		commit = list->item;
-		if (process_ranges_arbitrary_commit(rev, commit)) {
+		if (line_log_process_ranges_arbitrary_commit(rev, commit)) {
 			*pp = list;
 			pp = &list->next;
 		} else
diff --git a/line-log.h b/line-log.h
index 882c5055bb8..82ae8d98a40 100644
--- a/line-log.h
+++ b/line-log.h
@@ -54,6 +54,8 @@ struct line_log_data {
 void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args);
 
 int line_log_filter(struct rev_info *rev);
+int line_log_process_ranges_arbitrary_commit(struct rev_info *rev,
+						    struct commit *commit);
 
 int line_log_print(struct rev_info *rev, struct commit *commit);
 
diff --git a/revision.c b/revision.c
index f78c636e4d0..3228db9af6d 100644
--- a/revision.c
+++ b/revision.c
@@ -39,6 +39,8 @@ static const char *term_good;
 
 implement_shared_commit_slab(revision_sources, char *);
 
+static inline int want_ancestry(const struct rev_info *revs);
+
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	const char *p;
@@ -3511,7 +3513,14 @@ int prepare_revision_walk(struct rev_info *revs)
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
@@ -3722,6 +3731,22 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
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
index ea4a9398365..1428eae2629 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -263,7 +263,7 @@ test_expect_success 'setup for checking line-log and parent oids' '
 '
 
 # Parent oid should be from immediate parent.
-test_expect_failure 'parent oids without parent rewriting' '
+test_expect_success 'parent oids without parent rewriting' '
 	cat >expect <<-EOF &&
 	$head_oid $prev_oid Modify func2() in file.c
 	$root_oid  Add func1() and func2() in file.c
-- 
gitgitgadget

