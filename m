Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90935C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiDMUEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiDMUEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC27521D
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so4141121wrh.11
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9yHSgglAYI3aqoobTMwGtilusId8b46hzecHwrbpLU=;
        b=DeQQVkxQV9E9gTMqNg6x2cabzFuR4S/tErK2SPlgyU0M47B5V0n1RKCtzuFAUt7D3p
         8ArFnKIRNPTtIv/u4uh/j0MfiUU04VL1+k13ZkyoAOCgiSuKYWsKAE76yoE+xtcTjCm4
         6fLejeb4+FVcvF1pl7ehDxcajcJLUtSuLBMfPPtcLknM0zqOgPi76EjFYPGcA5KUugiH
         u13BViMB8bwfjZAgzCZBDdpBrjBIh1F9JwZURL9oCi2pM0AFB+6ldOKk7zNgfa0ok096
         vq1LZENb6RR0NrHFuEw6wxdY6IYkoFHmwlcypBh8NnAkKuLx9p8SIysoBfSITYNVa2xE
         pExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9yHSgglAYI3aqoobTMwGtilusId8b46hzecHwrbpLU=;
        b=70BSE6vhygsHHAaBSOWGmRybonnelhEizbDahr9nTUx6InlOAwKRkBISxvn6QCi2+O
         lRZMJL/2vO6r8BHXi+AmU/xlIsZ0wjRsdt22fdl9WGS/gCi8XJ6tXT+14mKhvL8Vx0Wn
         mX7tXGSUmg90czmaIYIeW/tk+2KzKUuoc6ji0BoxkESYCbHFvdLyFoso4HUmZnsq+u+n
         w+hKPcqEVKZ6I35AQPeT/s8KpNFUBSghetL63Q3UQRQewGrE26Lc2Ja+KRJeywl8W1Z2
         AW866dv6oj4g06PdutWv2gpaec7VLBvkj0A3Gzq6cZgFJrOPR0287zJ1ndPX63BfMxoH
         Zahg==
X-Gm-Message-State: AOAM531Eoov+eY+QJk6Eh0boQlV9c8eRXkl+z5pQTENbLGMytsKX68u3
        u6VA9uZLpAKBDCVR78sl66ffjk7oty0IXw==
X-Google-Smtp-Source: ABdhPJxsisiGIftjV3viuBcgYZ5/9crnWJywsNlVN5jIruydbIAoUpOH4r/BKnr9T6ePPxfKqwjsRQ==
X-Received: by 2002:a5d:588b:0:b0:207:b922:5f3c with SMTP id n11-20020a5d588b000000b00207b9225f3cmr354510wrf.166.1649880126499;
        Wed, 13 Apr 2022 13:02:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:05 -0700 (PDT)
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
Subject: [PATCH v6 06/27] revision.[ch]: provide and start using a release_revisions()
Date:   Wed, 13 Apr 2022 22:01:35 +0200
Message-Id: <patch-v6-06.27-22de5dc3cc1-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

