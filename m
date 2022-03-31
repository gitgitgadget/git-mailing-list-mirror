Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B9C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349013AbiCaBOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352268AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7966CA2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w21so26981372wra.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYiJ2THb7QbMaBVG1Ns4amqAxQ+IK4QinXbAkmcAWyo=;
        b=cEblz6nYYVDSqL3hsNLStzqGCaB3x8lZ3MjsxhJsaXsw5IDYsTNTUT9JbBmv+D7sEK
         wtabH78aYf1b28IIG2AwZPspCzoUvEQjNOLa09q4EsDCG/NOE47sw2brfsipkdHAlSp6
         Lf2ikI0L1GSeXr4YGIJRDM7qnjGUbREwM3wcmklR271i3Wjibzcy+rJq07UqVMzAOXh9
         yTBQMrGUdqsycAKUaE50lPsUsBT/NoXUfYU/BnEs1bdDdoT5ADKXoZV8N5qKbXNfrsKe
         pLmHnVEy3M5e9+lhRwPARqsbuQhhRbktw4+oz74zUVKz8W0mKrIaF+bWIjM0vqqczC4R
         /Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYiJ2THb7QbMaBVG1Ns4amqAxQ+IK4QinXbAkmcAWyo=;
        b=J6bSbFRkzIV50ywHPeLyIHd95hFWB/dkyn5J3z/lHTAdtPhrOQmV/J8gKQaRlAh7La
         wvPQ0jSe7NoMUc15EWA6osJk8aaTM7QVIEmUl383HYCs1mGq+v3RI2OxlMU918KR3ELS
         4rMpDHU2ZuMFiRECgIUigc9A6VmuSK/mYGODAmgOsUUbf3RKLHw9E8KOfaPxDJ9piBed
         oj5Z2sHj4GgKbyGQ7amimki0VGnOmTU+l4HPQORp9K/M4ubZRhNiCFeMc2JkwJK3g8/2
         GWxXqOZ345wBh6VPmse2NBloZ92Z4AO9j5XSXjjgwNjmTjvN50QETDNz3Aur/uDOc/qf
         iteA==
X-Gm-Message-State: AOAM531sWPYtQPqLkZy3FiDjDHu0wg2GBhGxjwveTZqCkA1Vc6/VuX2U
        hmgTKm6OaKWpcSLEzLqInX+TD09lJ1bKMQ==
X-Google-Smtp-Source: ABdhPJwoKC4A4vYERSwAVsayJVJKchUO6PwQPXmWVt6iuXSDvNDRxJvFuVlQZapO0r92EmiVYr0mRQ==
X-Received: by 2002:a5d:5189:0:b0:205:9c7b:d374 with SMTP id k9-20020a5d5189000000b002059c7bd374mr2019158wrv.551.1648689143739;
        Wed, 30 Mar 2022 18:12:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:23 -0700 (PDT)
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
Subject: [PATCH v4 21/27] revisions API: have release_revisions() release "prune_data"
Date:   Thu, 31 Mar 2022 03:11:26 +0200
Message-Id: <patch-v4-21.27-fabbe452a14-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"prune_data" in the "struct rev_info". This means that any code that
calls "release_revisions()" already can get rid of adjacent calls to
clear_pathspec().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c | 2 --
 builtin/add.c     | 1 -
 builtin/stash.c   | 2 --
 diff-lib.c        | 1 -
 revision.c        | 1 +
 wt-status.c       | 2 --
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 54cdfc82017..6047e8f6489 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -568,8 +568,6 @@ static int get_modified_files(struct repository *r,
 			run_diff_files(&rev, 0);
 		}
 
-		if (ps)
-			clear_pathspec(&rev.prune_data);
 		release_revisions(&rev);
 	}
 	hashmap_clear_and_free(&s.file_map, struct pathname_entry, ent);
diff --git a/builtin/add.c b/builtin/add.c
index 115a26ea633..fc729e14c17 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -142,7 +142,6 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return !!data.add_errors;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index a6ee030d4bd..5237d0d061a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1059,7 +1059,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	}
 
 done:
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return ret;
 }
@@ -1271,7 +1270,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 done:
 	discard_index(&istate);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
diff --git a/diff-lib.c b/diff-lib.c
index 0f16281253f..298265e5b54 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -641,7 +641,6 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
-	clear_pathspec(&revs.prune_data);
 	release_revisions(&revs);
 	return 0;
 }
diff --git a/revision.c b/revision.c
index 349c3f77536..c7a0e08765a 100644
--- a/revision.c
+++ b/revision.c
@@ -2960,6 +2960,7 @@ void release_revisions(struct rev_info *revs)
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
+	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 }
diff --git a/wt-status.c b/wt-status.c
index a14fad1e03a..61e0c1022f5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,7 +616,6 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 }
 
@@ -664,7 +663,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	release_revisions(&rev);
-	clear_pathspec(&rev.prune_data);
 }
 
 static int add_file_to_list(const struct object_id *oid,
-- 
2.35.1.1557.g4e3e9cdb5e0

