Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ECEC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiCYRax (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbiCYR3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3FFE43B
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qa43so16687145ejc.12
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vj7a5rq1btc2WFP2cbTEqIODSMpa/eYfu+YgY2ipjOo=;
        b=XqTHbo/28XlI4ckvpRkK536fBAFSCgw+3TylgV9YlLwva8ftLGbaEwk/9Oiybdj+dm
         za5Usrjb7J/ebwB1FxHX3M0pdp+Vukbf5y5VQSxdvIar6sv6uYS3lD+J9QdZN+Ws8pJu
         LWQKW9i4pxrU8DASYclUpnBpey/lXXYMwuZYVs18e5+kAIl7oet6nfKoWuTYdUB4DG2F
         Lm7N0ulArKDKv9V1KxVglMFJX10/2/delYngzkRg1yU8yvmCexFdOE5IXgu/8Pf4i+6I
         tHyK3pfmuPn355M66Y+wnDgAi/sKQeuErpOFWPQFhoaBnUqopNQnAo17ZIvNo7egXFE9
         51ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vj7a5rq1btc2WFP2cbTEqIODSMpa/eYfu+YgY2ipjOo=;
        b=MUIMdCFEL9i44G+AtX1lPAZqg3vqCnoPQHlOqCZyzQRzwk4A3ziOA9gPuSG2nXL7b8
         XsQ7o1gnZESCKIgiOpKhcMr2wPbRP0UHyUNzhslPDlIJrei6LhQkQNUZ+NeEfGs/YK1T
         I/0J6Vacfmta0/ZNmy2+ukUAJKldqQmcfit0jUigWlYVI6rjqcz4H/FKVPzY7789GRFy
         bG4DbpTXuPjIRbQ41OqgVQoacWYlcURM7LpZLs/FyJTQac1WMqg68oDbAy18gjbDUHt6
         vDYHQkP/BrE1Y8YuAmtc/y6yxC3i83LvXSpLHQOfsoA6kp0gGqwgJ2zF4lvAwuBXDasa
         4AIA==
X-Gm-Message-State: AOAM5309YkZSP2jXl0oPhF05prPORSS1C5DjVrTzSsx6m+AgT+cO2cRP
        qCFWSeAObGfczNEYA1LmCrrPTbJeiz201A==
X-Google-Smtp-Source: ABdhPJzjxjH6G9cwRAa2RqTYuOo/kGq7hU274pxJcDo+bxeoJFQtytukN4rclI9REYQ8EsEqwRgNkQ==
X-Received: by 2002:a5d:550f:0:b0:203:efaa:fa8b with SMTP id b15-20020a5d550f000000b00203efaafa8bmr10241228wrv.284.1648228777448;
        Fri, 25 Mar 2022 10:19:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/27] revision.[ch]: provide and start using a release_revisions()
Date:   Fri, 25 Mar 2022 18:18:30 +0100
Message-Id: <patch-v3-06.27-1e93a60d81a-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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

The users of that API are largely one-shot, e.g. "git log", so
arguably freeing the memory is a waste of time, but in many cases
they've actually been trying to free the memory, and just doing that
in a buggy manner.

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
 builtin/stash.c    | 3 +--
 diff-lib.c         | 2 +-
 range-diff.c       | 2 +-
 revision.c         | 5 +++++
 revision.h         | 6 ++++++
 wt-status.c        | 5 +++--
 7 files changed, 18 insertions(+), 7 deletions(-)

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
index ccdfdab44be..ad74624c2f7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
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
index ef45762bf21..895bba9ae57 100644
--- a/revision.c
+++ b/revision.c
@@ -2931,6 +2931,11 @@ static void release_revisions_commit_list(struct rev_info *revs)
 	}
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
index 5bc59c7bfe1..ad325a30453 100644
--- a/revision.h
+++ b/revision.h
@@ -377,6 +377,12 @@ void repo_init_revisions(struct repository *r,
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 
+/**
+ * Free data allocated in a "struct rev_info" after it's been setup
+ * with repo_init_revisions() and setup_revisions().
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
2.35.1.1509.ge4eeb5bd39e

