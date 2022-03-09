Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A1FC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiCINTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiCINTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E21795C7
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so2962166wrg.11
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxx/+ZMnHehDYFTPEl5t82Fr+dvv6O4Oev9AdqK0R9k=;
        b=bk4NwHTwAbap3TN4dRrSCpCuAVmnCpt0JGH2RLGHh1vFw9zL0Ejh2MkrjtgHgko8bi
         BzddEdZhe0hjdRIG9SRRNSeoQ2jk7zov6J36wpULu7D7A0u+aJZcFLmPSypK5JucRhs2
         z0nNFYLEbP6wTwvLetczeEqgMLyCDhuAXLL6X1GAngC1gtbOOxBd8VISEDXXbBnEtScI
         buscvXTvxUyQzqPnZyNGa79lze1S0iu32RETdoAAw5J77BNz59Jg6DPAfi6cWa910x86
         qtlYzIW0JYGptRkgMtlU7ypTHRvN0WVioDUd5TmJbbTugr6LGMzJoVYSUfaeMRVp1MA5
         Z8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxx/+ZMnHehDYFTPEl5t82Fr+dvv6O4Oev9AdqK0R9k=;
        b=x4xysHakKVplHliwwiH9SXyMIfvoIHrGzkbTRGoi6pcDnKopyKAyYYoit4vTZHskie
         dV91OKSKoNNoMa+Yd+/yZkFlh9zNTcms7r3hoA/+F/zMURjIBTIjsF6qjyJvZxWz+Iej
         Z5cUEJ+3TvuUD/ihR6vtAJk9D9z0TRXYuu8vqAxaP/+WrdKnwZ2bzAunZaBa75M1/9AP
         9t4DaTIh20/j9ilAG5MPRZNn8Z5/9p4sisJRJMQuaajy4u9fC8s8jNU+3/yYtdAIM2SW
         wfu2HMZe7v1gUt5/TS/eeu9GQaKnZEfXb4qZzkOjMtmrn3GOmzvgv2ItrC89e1gBDwHd
         ZVsg==
X-Gm-Message-State: AOAM533HWR6QtlnBTaZGlR9jSZZBivQsHLPTumKlJhOqongnmvbKAuxB
        JGUlzYF/D2UJz1X6NQiykphKRej/vaN0Xw==
X-Google-Smtp-Source: ABdhPJyyOcSv6+d7EOzTwauj/e6tvNOHRKGfg3FxksE7RqnoAj+H0nGUIlLGU8ZeEiQkyiUsAQbA5w==
X-Received: by 2002:adf:f48d:0:b0:1ed:e2d7:d5e0 with SMTP id l13-20020adff48d000000b001ede2d7d5e0mr15776319wro.252.1646831880615;
        Wed, 09 Mar 2022 05:18:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/24] revisions API: have release_revisions() release "prune_data"
Date:   Wed,  9 Mar 2022 14:16:49 +0100
Message-Id: <patch-19.24-b5948be0d4e-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"prune_data" in the "struct ref_info". This means that any code that
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
index 13d5ec6f49f..bd612270001 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -566,8 +566,6 @@ static int get_modified_files(struct repository *r,
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
index b9fe6f7c712..53bfa82eeb1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1072,7 +1072,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	}
 
 done:
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return ret;
 }
@@ -1284,7 +1283,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 done:
 	discard_index(&istate);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
diff --git a/diff-lib.c b/diff-lib.c
index 68858a39964..255abb4959f 100644
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
index f51a60b2a96..290700ea66f 100644
--- a/revision.c
+++ b/revision.c
@@ -2952,6 +2952,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
+	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 }
diff --git a/wt-status.c b/wt-status.c
index aaef10451f3..4e6b2ca9b82 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,7 +616,6 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 }
 
@@ -655,7 +654,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	release_revisions(&rev);
-	clear_pathspec(&rev.prune_data);
 }
 
 static int add_file_to_list(const struct object_id *oid,
-- 
2.35.1.1295.g6b025d3e231

