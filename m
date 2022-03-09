Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8968C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiCINS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiCINSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17B814FBF1
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t11so2988504wrm.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCG4MMCgIYtqXbvAkToeqJcwTWrMDkWxs2VS7nARu8M=;
        b=RmRcPFNpefLAbBprcEG53cvd2lROjKTqtHWTHagStZ23Mk57y1txVIm9asraPyBsui
         nNvkvVe2pTq0eMEYEToXYqLljfRIXBx2oasL8mOVjwDwN0AppmpU9Ev6fOgTAJekxRdY
         9Ux2bqXO38F36nHqv7R2z9gyi10wCbsmpzvDJF6jvrh+wEGB1pQssg4KGhi4kVnx807s
         pEChMNA5pHQChtB41HjbK0Whz+7GrPVJG9sJ4wuwgVVtt3qaAdyGXwLTWwl+PdUGGd2y
         neFtLbve4ltSP2Od6YYKAwfK5sbSoFEUuP9/mBmCTI1kN2tBw3Gcii91Tb1f/uE4VEZ7
         MWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCG4MMCgIYtqXbvAkToeqJcwTWrMDkWxs2VS7nARu8M=;
        b=s7yvyjK/ayMg2osVcRd/tdC9HWsOpmANIA1tvbScK8xw748BdtOI4cQCNIwXIJCjdx
         I/gQPdK7vxse2Aj4zkBxwq+JjNWVJM3Mxvjud3tOjJ4MbDLhkOZmJbPb+euFvUjEadgU
         skfyI3leg1/sRT/6Hpd5n9Sbd9+M0DbyS1wUFEF69qMG0ST1Z1dyX0EsYI5NO5u4LB6P
         YTRfwhxq8YwUQ2ipukRVf1H7KL22thsLm1Sfin35fbmQj4xgL3UmlN4JnZVG8DfLJnUa
         l2NgStyxwxvrAOL6c6PZD3Q4U9swlOi+x7KQX+gEO9xk9oXz3lZsfyDwGU1tzE8dD5Vm
         qFAg==
X-Gm-Message-State: AOAM530E4NAOPt3X4orEj53l3r5F3n06GvUcpXKIJZIw4dEGhilXXLBG
        dquYhnF2oFZosbOHw1cbggyX91s3APb9Tw==
X-Google-Smtp-Source: ABdhPJyGyIj0dLn+XiRg4abOhoc6jaZUSKJMKKMeVT1u/31FEBapvaZM7c1u3X11IgK/klhVEl+ziw==
X-Received: by 2002:a05:6000:23a:b0:1f0:2359:9cd5 with SMTP id l26-20020a056000023a00b001f023599cd5mr15816024wrz.335.1646831868080;
        Wed, 09 Mar 2022 05:17:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/24] revision.[ch]: provide and start using a release_revisions()
Date:   Wed,  9 Mar 2022 14:16:35 +0100
Message-Id: <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
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

1. https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 2 +-
 builtin/stash.c    | 3 +--
 diff-lib.c         | 6 ++++--
 range-diff.c       | 2 +-
 revision.c         | 7 +++++++
 revision.h         | 6 ++++++
 wt-status.c        | 7 ++++---
 7 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9244827ca02..ed993383531 100644
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
index 3e8af210fde..af9b61ef17a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1277,9 +1277,8 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
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
index ca085a03efc..ad1dd4834f7 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -651,6 +651,7 @@ int index_differs_from(struct repository *r,
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	unsigned int has_changes;
 
 	repo_init_revisions(r, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
@@ -662,8 +663,9 @@ int index_differs_from(struct repository *r,
 		diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
-	object_array_clear(&rev.pending);
-	return (rev.diffopt.flags.has_changes != 0);
+	has_changes = rev.diffopt.flags.has_changes;
+	release_revisions(&rev);
+	return (has_changes != 0);
 }
 
 static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
diff --git a/range-diff.c b/range-diff.c
index 30a4de5c2d8..2d0cd271a9e 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -600,6 +600,6 @@ int is_range_diff_range(const char *arg)
 	}
 
 	free(copy);
-	object_array_clear(&revs.pending);
+	release_revisions(&revs);
 	return negative > 0 && positive > 0;
 }
diff --git a/revision.c b/revision.c
index 5824fdeddfd..831f2cf977b 100644
--- a/revision.c
+++ b/revision.c
@@ -2926,6 +2926,13 @@ static void release_revisions_commit_list(struct rev_info *revs)
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
index b9c2421687f..c28e901021d 100644
--- a/revision.h
+++ b/revision.h
@@ -370,6 +370,12 @@ void repo_init_revisions(struct repository *r,
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
index 335e723a71e..398d0951aca 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -653,7 +653,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
-	object_array_clear(&rev.pending);
+	release_revisions(&rev);
 	clear_pathspec(&rev.prune_data);
 }
 
@@ -2568,8 +2568,9 @@ int has_uncommitted_changes(struct repository *r,
 
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
-	object_array_clear(&rev_info.pending);
-	return diff_result_code(&rev_info.diffopt, result);
+	result = diff_result_code(&rev_info.diffopt, result);
+	release_revisions(&rev_info);
+	return result;
 }
 
 /**
-- 
2.35.1.1295.g6b025d3e231

