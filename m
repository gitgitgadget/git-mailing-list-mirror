Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F973C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiCYRaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbiCYR24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D86ED9E9
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so14545238lfl.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjDLZUzJGSegEO/hUXN9/0pKkhAVINjWfVu9jrggagM=;
        b=Folm1uJTMRL2/a3jEmz8aGgjXyx8aDxL6IclCLyBZSvrzCeh3KmPYqQz7htURXziTH
         fWYEvXW7AVqSLix61YQYIhQx1OGj2/KCLKHUxP+mhjoF3jJZiBtsXk6qTTI5SqDIF15l
         6usK+u4Tnc5KZVlF9KFkq4Xv/NqNuEFWfnQhZOvbZk7+0luTgHrsWYU+/zn4YECgdEUR
         4N6ObJk7omO8fSznFL2RnMz/MInBfOAYCKNo394QShTka1XcHlrXk5jW6kX4XwhBHWi9
         xw4/BRXPPDfiS/0OgFN7x/vByLG/SlLwJn0yy6SJ558H3F2TAsmyRGjDolADjHQCT5Ct
         f4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjDLZUzJGSegEO/hUXN9/0pKkhAVINjWfVu9jrggagM=;
        b=w6hQtOyOmsjSUY57U2r4adVPEd59CXc+JmjtE4l9aU7iGTTxXDF3K24KKu3LHzFOAw
         9Uy4Js5mnviO2Hz4JXOjJiXjunPzyfeZn0ThzY/yDMRVjbsDtdPArln++lMU1mdDpXkv
         Olkbr+Ad0sB2VdZSEKBIo83znR96wbFZ5LRtyhuE5MLQPTiyYeudt1HbjCY6Y4wm54aQ
         n9BxCLyn5O+7AX5zg9RZ+UmdFa5PunB6d7wonqTsu3LsLFMgGwnfsq69nFAE0Ftq/Zpb
         VR7TiIY9wFrmVkiPABcAYhudXOC9wec1bEP7pUfG1hoFB4VP9y+9dHmZ4dFUuG51VHFB
         2HMA==
X-Gm-Message-State: AOAM531OMHEMR00YkvjO2D5vE8g03VxK+NXR/o5yOjotON8cEeyjfGBB
        fwTRm/YJd/JOfzrWGSjO4V/+y6qnSapocg==
X-Google-Smtp-Source: ABdhPJxLariosuE+241MwmdWYzShJMmuNFj1V4S+Q4ThKXB50fs+0W0zoiBrEgl4hZRCMfcjPmhLTg==
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id l16-20020a5d6750000000b00203efaf9fc1mr9867108wrw.252.1648228791480;
        Fri, 25 Mar 2022 10:19:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:50 -0700 (PDT)
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
Subject: [PATCH v3 21/27] revisions API: have release_revisions() release "prune_data"
Date:   Fri, 25 Mar 2022 18:18:45 +0100
Message-Id: <patch-v3-21.27-842faebddc4-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index da7e6356e68..6fd582819fe 100644
--- a/revision.c
+++ b/revision.c
@@ -2956,6 +2956,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1509.ge4eeb5bd39e

