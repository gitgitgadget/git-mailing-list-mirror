Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1404C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiDMUFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiDMUE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF367B55C
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so1763345wmr.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSkBur+QTC5OUIv+TFHm8crGorFFVGJrGuB5Jbg6kRY=;
        b=euKYGPXXs1WGNFdxD0jxF6aMahrwCadDiXoshIvcTH7dlg2OLJ0vW3WldSqAnVw7iU
         Y6dq5F8+u+78ATxFYnMDfQwXR5G+mwX7BdYLa6hv151ZUUCUGc4GEWEN4aIFjrEJQhml
         I47NLtxy2f4rmGJNsw5ciw9jaBpfGSN1CTR4g8muSH/sp6rH5EzjIx4iF7zkv7mTQYIH
         MazlA3dZsdx7eW+wAyi60qDjfKy23PaaM7Xfg2iEgkKlpm7XAlaNkAB03B9CzYRc5kvT
         foVJUE1dzSMf0GQ7OoU7ambZ+5HdDY/bASD35QzCL+bK1lkp5zcGCCP2STw0gEiiWbnE
         JK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSkBur+QTC5OUIv+TFHm8crGorFFVGJrGuB5Jbg6kRY=;
        b=0dEHpd/M8IVDRh1FFsCfeter5tfExORGyeHg/dFrQpBVafJOE1PcijPhHrnAHTo4ea
         UTbUIH9bSfQrtJpjx8mg6P0pCNJSYPHE5Redxs8x/IFpiOf7eZmXVjo+PCwRsjGVw1wd
         j22dEHytdJsCDz6Tu9CNdnAs2ta3lJHTp9/Lr1YQ1/AuqV4rudEUFv26WybraMIuzOvC
         EAxMaR85wX6DJJ550b7Tx2mVXbe4MqCxV4fBfZCzQ62q+qLj6oBVMxyIDDNQo86A6A0f
         3D+GJqAofTe4CULdNh0Uh/j0QzpbFsYLg2NEM/68jjdPkQByL7c6EmQ5cGZHprZ40GU9
         rCSw==
X-Gm-Message-State: AOAM531L4dMRVVXUmnhBL4+2IP2sZVezHqRHexP572yVRqV30gFDvL2s
        cqgfi/Mvr3XZ4vbW27qXijD0gu+c1dEx8Q==
X-Google-Smtp-Source: ABdhPJw1nOStHr8GDAqd8gbwoYrGXEQdpTAVZGdY8+araleODgIevdcsGtOUIeNW50j0elUB1+Pqiw==
X-Received: by 2002:a05:600c:4e12:b0:38b:b715:18a6 with SMTP id b18-20020a05600c4e1200b0038bb71518a6mr297559wmq.17.1649880140664;
        Wed, 13 Apr 2022 13:02:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:20 -0700 (PDT)
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
Subject: [PATCH v6 21/27] revisions API: have release_revisions() release "prune_data"
Date:   Wed, 13 Apr 2022 22:01:50 +0200
Message-Id: <patch-v6-21.27-54514a01096-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
index fce4393d123..16aad4b4d35 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1064,7 +1064,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	}
 
 done:
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return ret;
 }
@@ -1276,7 +1275,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
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
index 1db58c3e4db..6f444eaaeba 100644
--- a/revision.c
+++ b/revision.c
@@ -2949,6 +2949,7 @@ void release_revisions(struct rev_info *revs)
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
2.36.0.rc2.843.g193535c2aa7

