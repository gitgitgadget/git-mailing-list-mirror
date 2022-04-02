Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37CC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354498AbiDBKvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354477AbiDBKvo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACAD1403E9
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s8so153273edi.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCDDJcavfq2JcCGDtdxL3HECY+nJ6s5KWxpA/uFFn8o=;
        b=ORvf8+4gONLaGHLsJpuvXq2xQtZXtgadQL89Fz184+nq4RA9FzvpA/bakzbWnua1BK
         BqoPqRpzqbGREx+C+ixxhu1rX+5JaYER0xq/+cRZnwkSD07p2oLFr1sWHLFAjPQxv2X4
         LjXW/qlRq66fhNosUQ+hL1XtXTHqPciY6fU2MK9UMRqXUOsPpR1F6sZzDcfqS9yY+84N
         MnHAVNlxZ0yQpqYTwvQpxd5n4HxJ/j7BNJkcljbjVDl9a959MGQEwSZUnUfgcqR0pSMY
         NV1opwrNhpKWTmccTeu5nTgRo+6TWxiP1gH/0vh0D7HpS8Ah0ywd7jk5TzDQGFUD3u+g
         9Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCDDJcavfq2JcCGDtdxL3HECY+nJ6s5KWxpA/uFFn8o=;
        b=cjv4MWT3ZINqXfi1otEs7O1mdZzMXmxaGjiqVgCyBs+G9HaZcIlxiHrK67IHoOObeb
         GnESbtgTbd8zqcdzsbwnsl5BQarFIdlgfJGlwS4R6HDjf9umENfa2zjwhEJWRFwjzJ+U
         V2bt8O7LC8+HyhNg36mTHOgoU8n2jwml+UY0fAEUKMDfiqfRjGvQrpjTy0mHkzDrN1y/
         vPvrhEkbx2gq+qY6SsCGjaO1oy9HWiJ356onQc0v31owdBSsXsHBvJVw+Rx8GcyWWCT7
         LRbnQSRtl+nkbf55cHVh1Stwd8j9C0fi57GNW0xZhLMAaPGARHRhw5bJGUVzlxMahRbC
         CCjA==
X-Gm-Message-State: AOAM533lFoTReNH1gRd5dvr2wMJ8yf8iBUmoqc+ttzJa0iWB73I12GIN
        CJCwrBOvR/e5KJZd24A3ahC3n+ele4rnkw==
X-Google-Smtp-Source: ABdhPJyCkmdNmkkcIb7zI8VVamHkRHVjY6MMr8ZwRBUr6txIHE50aAHsxMzSpM4g0b49xBXKIJ3MdQ==
X-Received: by 2002:a05:6402:64d:b0:41c:b920:aa57 with SMTP id u13-20020a056402064d00b0041cb920aa57mr441293edx.389.1648896590697;
        Sat, 02 Apr 2022 03:49:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/27] revision.[ch]: provide and start using a release_revisions()
Date:   Sat,  2 Apr 2022 12:49:20 +0200
Message-Id: <patch-v5-06.27-b99f96599bb-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The users of the revision.[ch] API's "struct rev_info" are a major
source of memory leaks in the test suite under SANITIZE=leak, which in
turn adds a lot of noise when trying to mark up tests with
"TEST_PASSES_SANITIZE_LEAK=true".

The users of that API are largely one-shot, e.g. "git rev-list" or
"git log", or the "git checkout" and "git stash" being modified here

For these callers freeing the memory is arguably a waste of time, but
in many cases they've actually been trying to free the memory, and
just doing that in a buggy manner.

Let's provide a release_revisions() function for these users, and
start migrating them over per the plan outlined in [1]. Right now this
only handles the "pending" member of the struct, but more will be
added in subsequent commits.

Even though we only clear the "pending" member now, let's not leave a
trap in code like the pre-image of index_differs_from(), where we'd
start doing the wrong thing as soon as the release_revisions() learned
to clear its "diffopt". I.e. we need to call release_revisions() after
we've inspected any state in "struct rev_info".

This leaves in place e.g. clear_pathspec(&rev.prune_data) in
stash_working_tree() in builtin/stash.c, subsequent commits will teach
release_revisions() to free "prune_data" and other members that in
some cases are individually cleared by users of "struct rev_info" by
reaching into its members. Those subsequent commits will remove the
relevant calls to e.g. clear_pathspec().

We avoid amending code in index_differs_from() in diff-lib.c as well
as wt_status_collect_changes_index(), has_unstaged_changes() and
has_uncommitted_changes() in wt-status.c in a way that assumes that we
are already clearing the "diffopt" member. That will be handled in a
subsequent commit.

1. https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 2 +-
 builtin/stash.c    | 5 ++---
 diff-lib.c         | 2 +-
 range-diff.c       | 2 +-
 revision.c         | 5 +++++
 revision.h         | 6 ++++++
 wt-status.c        | 5 +++--
 7 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 797681481d1..4d9e0bd3ac1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -629,7 +629,7 @@ static void show_local_changes(struct object *head,
 	diff_setup_done(&rev.diffopt);
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
-	object_array_clear(&rev.pending);
+	release_revisions(&rev);
 }
 
 static void describe_detached_head(const char *msg, struct commit *commit)
diff --git a/builtin/stash.c b/builtin/stash.c
index 0c7b6a95882..74fa810cf8c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1047,7 +1047,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 		goto done;
 	}
 
-	object_array_clear(&rev.pending);
 	result = run_diff_files(&rev, 0);
 	if (diff_result_code(&rev.diffopt, result)) {
 		ret = 1;
@@ -1056,6 +1055,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 
 done:
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	return ret;
 }
 
@@ -1266,9 +1266,8 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 done:
 	discard_index(&istate);
-	UNLEAK(rev);
-	object_array_clear(&rev.pending);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
 	return ret;
diff --git a/diff-lib.c b/diff-lib.c
index ca085a03efc..d6800274bd5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -662,7 +662,7 @@ int index_differs_from(struct repository *r,
 		diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
-	object_array_clear(&rev.pending);
+	release_revisions(&rev);
 	return (rev.diffopt.flags.has_changes != 0);
 }
 
diff --git a/range-diff.c b/range-diff.c
index b72eb9fdbee..39cc010c628 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -596,6 +596,6 @@ int is_range_diff_range(const char *arg)
 	}
 
 	free(copy);
-	object_array_clear(&revs.pending);
+	release_revisions(&revs);
 	return negative > 0 && positive > 0;
 }
diff --git a/revision.c b/revision.c
index 4963ba7def8..5dd4b2e910c 100644
--- a/revision.c
+++ b/revision.c
@@ -2922,6 +2922,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	return left;
 }
 
+void release_revisions(struct rev_info *revs)
+{
+	object_array_clear(&revs->pending);
+}
+
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
 {
 	struct commit_list *l = xcalloc(1, sizeof(*l));
diff --git a/revision.h b/revision.h
index 5bc59c7bfe1..61c780fc4cd 100644
--- a/revision.h
+++ b/revision.h
@@ -377,6 +377,12 @@ void repo_init_revisions(struct repository *r,
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 
+/**
+ * Free data allocated in a "struct rev_info" after it's been
+ * initialized with repo_init_revisions().
+ */
+void release_revisions(struct rev_info *revs);
+
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[]);
diff --git a/wt-status.c b/wt-status.c
index d33f9272b72..922cf787f95 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -662,7 +662,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
-	object_array_clear(&rev.pending);
+	release_revisions(&rev);
 	clear_pathspec(&rev.prune_data);
 }
 
@@ -2545,6 +2545,7 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
+	release_revisions(&rev_info);
 	return diff_result_code(&rev_info.diffopt, result);
 }
 
@@ -2577,7 +2578,7 @@ int has_uncommitted_changes(struct repository *r,
 
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
-	object_array_clear(&rev_info.pending);
+	release_revisions(&rev_info);
 	return diff_result_code(&rev_info.diffopt, result);
 }
 
-- 
2.35.1.1585.gd85f8dcb745

