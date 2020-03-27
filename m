Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8AC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFFD20719
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItWyjDUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgC0AtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53031 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgC0AtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id z18so9819219wmk.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ds+B2/zRCxUQ8qA+wVd6G4oQ9CD/PVmlzJAwt9YJ1hc=;
        b=ItWyjDUxGcJRyTnTwu8Gx8IRw2Z/mZuZF8zYLtroLon0vOwnu7EkGyHXYH2m7zhTss
         2x7TnYrQTvTJ6QV4yGLFocp62pHxPd/B9X8HAbGf8h3h/Jmjd6gyPfq/8F7ih2L998gj
         y+x2ujQzk0DIo8Al9PpEUDCGSXVUX89/e+i9oB90PZWAAaqS6KNDwx9Tr2aeMzA/zqqo
         zl7Jo/M16TGfgO7/d/CbrZPFa165xS8uVCUltpc5QT3f9/CeZb3MBKD5kaLbgcyZnEZV
         fSkfZIFeB6L8BQecXW8Nk2c2f9eILInLBVJEdkP+rS2+pA57unnqvcjsMJenPJ+1V0CV
         eX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ds+B2/zRCxUQ8qA+wVd6G4oQ9CD/PVmlzJAwt9YJ1hc=;
        b=ggWJbVZoUrTSJmvSfKDlsFFHw5h/tuLwIygQzgFwWg/+0FEmKPKOL3wTE3rMhAVVZU
         saH+z3O/ca/WUr4NXSzFKDYmDSY4oqTuLMM0EN2n38teycQOV7JxWlJIvsK/nOg1Enuu
         DLtu4Mlj/Vd3Jr/0xiqv445ysIis7lNhrL7f2v0hdON8zaGKXS6nhtT9KQ1Q943EQ/4Q
         8aXuftnxNcACqqo35TUw3Lk6u0mKuZrT10fI3NIGzmj5OgCMFQjjFJrLtj2NaLjX5tEZ
         XwRTa++RFk5zbfLoMHkiWuIqwgXEQbL9UmxWym9mL0N9oI8eNLfk+1QXJcyh3auC7yrX
         vdLQ==
X-Gm-Message-State: ANhLgQ25Cz6YzOC/eMDvUJU73ha2d9MCbtahYMxMLH8EVii8oUjuBpyo
        wZmJi8LszoJg1Plw+I3VzosGhIZ1
X-Google-Smtp-Source: ADFU+vtCgsozCFb3xYbeKE+rvRtil/pWvNReGtNp9kicCG+/nyPRXc4ZHQKWSK2zayBPToVXGm/xaQ==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr2592471wmc.101.1585270150358;
        Thu, 26 Mar 2020 17:49:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm5516292wrr.62.2020.03.26.17.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:10 -0700 (PDT)
Message-Id: <3a1f084641eb47515b5a41ed4409a36128913309.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:52 +0000
Subject: [PATCH v3 09/18] unpack-trees: add a new update_sparsity() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, the only way to update the SKIP_WORKTREE bits for various
paths was invoking `git read-tree -mu HEAD` or calling the same code
that this codepath invoked.  This however had a number of problems if
the index or working directory were not clean.  First, let's consider
the case:

  Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files)

If the working tree was clean this was fine, but if there were files or
directories or symlinks or whatever already present at the given path
then the operation would abort with an error.  Let's label this case
for later discussion:

    A) There is an untracked path in the way

Now let's consider the opposite case:

  Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files)

If the index and working tree was clean this was fine, but if there were
any unclean paths we would run into problems.  There are three different
cases to consider:

    B) The path is unmerged
    C) The path has unstaged changes
    D) The path has staged changes (differs from HEAD)

If any path fell into case B or C, then the whole operation would be
aborted with an error.  With sparse-checkout, the whole operation would
be aborted for case D as well, but for its predecessor of using `git
read-tree -mu HEAD` directly, any paths that fell into case D would be
removed from the working copy and the index entry for that path would be
reset to match HEAD -- which looks and feels like data loss to users
(only a few are even aware to ask whether it can be recovered, and even
then it requires walking through loose objects trying to match up the
right ones).

Refusing to remove files that have unsaved user changes is good, but
refusing to work on any other paths is very problematic for users.  If
the user is in the middle of a rebase or has made modifications to files
that bring in more dependencies, then for their build to work they need
to update the sparse paths.  This logic has been preventing them from
doing so.  Sometimes in response, the user will stage the files and
re-try, to no avail with sparse-checkout or to the horror of losing
their changes if they are using its predecessor of `git read-tree -mu
HEAD`.

Add a new update_sparsity() function which will not error out in any of
these cases but behaves as follows for the special cases:
    A) Leave the file in the working copy alone, clear the SKIP_WORKTREE
       bit, and print a warning (thus leaving the path in a state where
       status will report the file as modified, which seems logical).
    B) Do NOT mark this path as SKIP_WORKTREE, and leave it as unmerged.
    C) Do NOT mark this path as SKIP_WORKTREE and print a warning about
       the dirty path.
    D) Mark the path as SKIP_WORKTREE, but do not revert the version
       stored in the index to match HEAD; leave the contents alone.

I tried a different behavior for A (leave the SKIP_WORKTREE bit set),
but found it very surprising and counter-intuitive (e.g. the user sees
it is present along with all the other files in that directory, tries to
stage it, but git add ignores it since the SKIP_WORKTREE bit is set).  A
& C seem like optimal behavior to me.  B may be as well, though I wonder
if printing a warning would be an improvement.  Some might be slightly
surprised by D at first, but given that it does the right thing with
`git commit` and even `git commit -a` (`git add` ignores entries that
are marked SKIP_WORKTREE and thus doesn't delete them, and `commit -a`
is similar), it seems logical to me.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.h |  9 ++++++
 2 files changed, 86 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4733e7eaf89..a5bc0a3a16d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1714,6 +1714,83 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	goto done;
 }
 
+/*
+ * Update SKIP_WORKTREE bits according to sparsity patterns, and update
+ * working directory to match.
+ *
+ * CE_NEW_SKIP_WORKTREE is used internally.
+ */
+enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
+{
+	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
+	struct pattern_list pl;
+	int i, empty_worktree;
+	unsigned old_show_all_errors;
+	int free_pattern_list = 0;
+
+	old_show_all_errors = o->show_all_errors;
+	o->show_all_errors = 1;
+
+	/* Sanity checks */
+	if (!o->update || o->index_only || o->skip_sparse_checkout)
+		BUG("update_sparsity() is for reflecting sparsity patterns in working directory");
+	if (o->src_index != o->dst_index || o->fn)
+		BUG("update_sparsity() called wrong");
+
+	trace_performance_enter();
+
+	/* If we weren't given patterns, use the recorded ones */
+	if (!o->pl) {
+		memset(&pl, 0, sizeof(pl));
+		free_pattern_list = 1;
+		populate_from_existing_patterns(o, &pl);
+		if (o->skip_sparse_checkout)
+			goto skip_sparse_checkout;
+	}
+
+	/* Set NEW_SKIP_WORKTREE on existing entries. */
+	mark_all_ce_unused(o->src_index);
+	mark_new_skip_worktree(o->pl, o->src_index, 0,
+			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
+
+	/* Then loop over entries and update/remove as needed */
+	ret = UPDATE_SPARSITY_SUCCESS;
+	empty_worktree = 1;
+	for (i = 0; i < o->src_index->cache_nr; i++) {
+		struct cache_entry *ce = o->src_index->cache[i];
+
+		if (apply_sparse_checkout(o->src_index, ce, o))
+			ret = UPDATE_SPARSITY_WARNINGS;
+
+		if (!ce_skip_worktree(ce))
+			empty_worktree = 0;
+	}
+
+	/*
+	 * Sparse checkout is meant to narrow down checkout area
+	 * but it does not make sense to narrow down to empty working
+	 * tree. This is usually a mistake in sparse checkout rules.
+	 * Do not allow users to do that.
+	 */
+	if (o->src_index->cache_nr && empty_worktree) {
+		unpack_failed(o, "Sparse checkout leaves no entry on working directory");
+		ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
+		goto done;
+	}
+
+skip_sparse_checkout:
+	if (check_updates(o, o->src_index))
+		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
+
+done:
+	display_error_msgs(o);
+	o->show_all_errors = old_show_all_errors;
+	if (free_pattern_list)
+		clear_pattern_list(&pl);
+	trace_performance_leave("update_sparsity");
+	return ret;
+}
+
 /* Here come the merge functions */
 
 static int reject_merge(const struct cache_entry *ce,
diff --git a/unpack-trees.h b/unpack-trees.h
index d3516267f36..5cf41ef5b53 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -88,6 +88,15 @@ struct unpack_trees_options {
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
 
+enum update_sparsity_result {
+	UPDATE_SPARSITY_SUCCESS = 0,
+	UPDATE_SPARSITY_WARNINGS = 1,
+	UPDATE_SPARSITY_INDEX_UPDATE_FAILURES = -1,
+	UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
+};
+
+enum update_sparsity_result update_sparsity(struct unpack_trees_options *options);
+
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
 
-- 
gitgitgadget

