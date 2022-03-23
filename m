Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3950C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiCWUeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbiCWUeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37188CCC4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h23so3765505wrb.8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yoGZmoMhgOPL66zlrXCUY8UZk3gr+8qOmQmsxPdBXfo=;
        b=IAh9v96Aw+uI5/nG779CW6SFQh8ps7bBR+l/2a8XzkMhtxcW6JAlDCGgcV8hU5cLOp
         71qJHoCRakuGqoVpRN+z5EKLkxql2HtLGnb8JJgqrG+uBaG+FYvsZmmCRrxiicsJb8NU
         1Okzttbh+N2Y7l+VVXpcj5Sqmp2/7HoYv2QWUY4/lpDzbfoAAKiFChLIQvntLcpj8ivQ
         uDyz8Qa/0s3a2J0fmeEHkuE7S3BdG0ZyH3JKQGe08hg8Sni6AEM30cvmYyZLhT4yrwCr
         kvGkyZMchYQg+A+sr5TnP6ygXfi9zH1irDG6EiUvHBMa0XhvwxHCW4O4HOJiARwLVK2Y
         IuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yoGZmoMhgOPL66zlrXCUY8UZk3gr+8qOmQmsxPdBXfo=;
        b=KOx5n9Yfv1imMVgphddRElzm8oLvLwhSQXa8G6LT7XB4Qlabt6DT3pEbKSYCu3oJEf
         mUyHhHOYglc3zYZDAyZOcUZpEvkRZDfOWk/w+Tm0BgFgKNEyTV2GerQjxirQLHXP0OoN
         8NTlVLucdW4WHPAXQwrjC12t2Q42UTuJxto7JrCMyUsj5B6iUvdj93i/AzUR/rlUPNOk
         o//No03X6He5ylHQwrqU/8H1X2dVEnyqBzRBYkRoYYHo9NqgNwunM37uFYK8wbU6+TsP
         xHU5VL+JFnm4wL2aGgq0slaU9AgEg0HBAIJCU4dANvVKxroHMu5GtTlWBcdiuGChnZSl
         zLnw==
X-Gm-Message-State: AOAM531VWGvZumbJy3Ap03bBUdMxz4zwHwmzETQbg1INFzR6gw4Kjb2b
        msYQMlPhrNqCd4cEO06OPvRGGHzvAFVOwA==
X-Google-Smtp-Source: ABdhPJzLetyGtdb79sNYsGolBJpbpKmwCeFLUULxlDz8j5xI3y5fAR/efoWO1Aq9uKcmrlrJovQuoQ==
X-Received: by 2002:a05:6000:144d:b0:205:8905:4cc1 with SMTP id v13-20020a056000144d00b0020589054cc1mr1620773wrx.508.1648067551929;
        Wed, 23 Mar 2022 13:32:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:31 -0700 (PDT)
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
Subject: [PATCH v2 06/27] revision.[ch]: provide and start using a release_revisions()
Date:   Wed, 23 Mar 2022 21:31:56 +0100
Message-Id: <patch-v2-06.27-7194aac88e1-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
 revision.c         | 7 +++++++
 revision.h         | 6 ++++++
 wt-status.c        | 5 +++--
 7 files changed, 20 insertions(+), 7 deletions(-)

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
index 242e73cbb09..8a8093c5eea 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1267,9 +1267,8 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
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
index 303d1188207..90bac9ada03 100644
--- a/revision.c
+++ b/revision.c
@@ -2933,6 +2933,13 @@ static void release_revisions_commit_list(struct rev_info *revs)
 	revs->commits = NULL;
 }
 
+void release_revisions(struct rev_info *revs)
+{
+	if (!revs)
+		return;
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
2.35.1.1452.ga7cfc89151f

