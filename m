Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49CC433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D850E20799
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbhAANH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbhAANHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:07:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4974CC0613C1
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so21949652wrj.7
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0TeogiNJ7ipGmFDWNnuJH30APRPsqSsAei8/MLisySQ=;
        b=DiIZdUhYsfJikPnf3CQNG+G/Fbvz6HRkg5gbKe/ExctAItVvWFGkTy06YzieSTgHsm
         iO+IeLvXzY5sq5aeCFw10pMS1J9dcazoYEPBLJNXpPwbBj7IFnbKgvBUElV9MYXaudCa
         9sLedB8okhdbD0TjN7n2oK95tMAzzPd1pqJ4WdsUn0c5U84s/HsaPoTwlB4kU1SCiD4/
         Xpj5fomVsj/3H2EmS3jpzVXqeSY0DWwJJV5dWSn4CNrdx/Oa6mKsJB2z3g0wzENYvENo
         J5LInKRc+HIMIQCwMCU7zv1iclbjkAOgYzx4kq7LlbBpLjKF5KyLlOv85V8AZkYOmLWy
         i2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0TeogiNJ7ipGmFDWNnuJH30APRPsqSsAei8/MLisySQ=;
        b=P2B7Fzs2bVlHggRI//BQRgFc5fIF7TTXixHFHBUu8vVtsn3+CeTW2T8WBACVa4v/aO
         /qH8R7q9S9SygdfE6Wg9UYAsqD+KrRQqLDjMDWdPyewyzMXJFAFSVoqeC/dwpFnlKjYf
         BskG0209CvCdUN+lTTwBOg8/hXLNveGMmZq1np3xyxpu1xFb4Oj4PL62ZoLfiaOSe/zf
         wd/4ORZ+ftvblGMSO3+jLUH0O5bfAZz5vyDH6bHYidrdp2+1iSpV51ydFC2cbH+vrOJ4
         fGZGAWrnTq1GmgPIYJDgG0YtIDJ/b1o2GvHJKMiQ0cZeHgeLFlfpHJo9/ki8uJEzlPed
         uN1A==
X-Gm-Message-State: AOAM532HYVwZEJ9nuWwd/BBtez3bZOC3BXpEtGLtMWhEZRU26vB1vdGu
        kk1S4HSrC1fA5sdnyZZAQt/B+lHQLaM=
X-Google-Smtp-Source: ABdhPJzWSVKSA0BdiY7y6EHOAQXcZEoFKrJPQof4nwqTLVaVjFbOZAWb8/5GRQuhkcygCxGSQqSxMg==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr66473738wrw.129.1609506432669;
        Fri, 01 Jan 2021 05:07:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm16537472wme.4.2021.01.01.05.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:12 -0800 (PST)
Message-Id: <54e167d587260f79d3ce532e26de27ca5a440fd1.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:06:59 +0000
Subject: [PATCH 03/12] rm: remove compatilibity macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The rm builtin still uses the antiquated compatibility macros for
interacting with the index. Update these to the more modern uses by
passing around a 'struct index_state' pointer.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rm.c | 56 ++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f0..767df8d6b25 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
@@ -28,12 +27,14 @@ static struct {
 	} *entry;
 } list;
 
-static int get_ours_cache_pos(const char *path, int pos)
+static int get_ours_cache_pos(struct index_state *istate,
+			      const char *path, int pos)
 {
 	int i = -pos - 1;
 
-	while ((i < active_nr) && !strcmp(active_cache[i]->name, path)) {
-		if (ce_stage(active_cache[i]) == 2)
+	while ((i < istate->cache_nr) &&
+	       !strcmp(istate->cache[i]->name, path)) {
+		if (ce_stage(istate->cache[i]) == 2)
 			return i;
 		i++;
 	}
@@ -61,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
 	}
 }
 
-static void submodules_absorb_gitdir_if_needed(void)
+static void submodules_absorb_gitdir_if_needed(struct index_state *istate)
 {
 	int i;
 	for (i = 0; i < list.nr; i++) {
@@ -69,13 +70,13 @@ static void submodules_absorb_gitdir_if_needed(void)
 		int pos;
 		const struct cache_entry *ce;
 
-		pos = cache_name_pos(name, strlen(name));
+		pos = index_name_pos(istate, name, strlen(name));
 		if (pos < 0) {
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(istate, name, pos);
 			if (pos < 0)
 				continue;
 		}
-		ce = active_cache[pos];
+		ce = istate->cache[pos];
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !file_exists(ce->name) ||
@@ -88,7 +89,8 @@ static void submodules_absorb_gitdir_if_needed(void)
 	}
 }
 
-static int check_local_mod(struct object_id *head, int index_only)
+static int check_local_mod(struct index_state *istate,
+			   struct object_id *head, int index_only)
 {
 	/*
 	 * Items in list are already sorted in the cache order,
@@ -114,21 +116,21 @@ static int check_local_mod(struct object_id *head, int index_only)
 		int local_changes = 0;
 		int staged_changes = 0;
 
-		pos = cache_name_pos(name, strlen(name));
+		pos = index_name_pos(istate, name, strlen(name));
 		if (pos < 0) {
 			/*
 			 * Skip unmerged entries except for populated submodules
 			 * that could lose history when removed.
 			 */
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(istate, name, pos);
 			if (pos < 0)
 				continue;
 
-			if (!S_ISGITLINK(active_cache[pos]->ce_mode) ||
+			if (!S_ISGITLINK(istate->cache[pos]->ce_mode) ||
 			    is_empty_dir(name))
 				continue;
 		}
-		ce = active_cache[pos];
+		ce = istate->cache[pos];
 
 		if (lstat(ce->name, &st) < 0) {
 			if (!is_missing_file_error(errno))
@@ -165,7 +167,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 * Is the index different from the file in the work tree?
 		 * If it's a submodule, is its work tree modified?
 		 */
-		if (ce_match_stat(ce, &st, 0) ||
+		if (ie_match_stat(istate, ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
 		     bad_to_remove_submodule(ce->name,
 				SUBMODULE_REMOVAL_DIE_ON_ERROR |
@@ -257,6 +259,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec;
 	char *seen;
+	struct index_state *istate;
 
 	git_config(git_default_config, NULL);
 
@@ -284,24 +287,25 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only)
 		setup_work_tree();
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
+	istate = the_repository->index;
+	refresh_index(istate, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
-		if (!ce_path_match(&the_index, ce, &pathspec, seen))
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (!ce_path_match(istate, ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name = xstrdup(ce->name);
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
-		    !is_staging_gitmodules_ok(&the_index))
+		    !is_staging_gitmodules_ok(istate))
 			die(_("please stage your changes to .gitmodules or stash them to proceed"));
 	}
 
@@ -329,7 +333,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!index_only)
-		submodules_absorb_gitdir_if_needed();
+		submodules_absorb_gitdir_if_needed(istate);
 
 	/*
 	 * If not forced, the file, the index and the HEAD (if exists)
@@ -345,7 +349,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct object_id oid;
 		if (get_oid("HEAD", &oid))
 			oidclr(&oid);
-		if (check_local_mod(&oid, index_only))
+		if (check_local_mod(istate, &oid, index_only))
 			exit(1);
 	}
 
@@ -358,7 +362,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!quiet)
 			printf("rm '%s'\n", path);
 
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(istate, path))
 			die(_("git rm: unable to remove %s"), path);
 	}
 
@@ -398,10 +402,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&buf);
 		if (gitmodules_modified)
-			stage_updated_gitmodules(&the_index);
+			stage_updated_gitmodules(istate);
 	}
 
-	if (write_locked_index(&the_index, &lock_file,
+	if (write_locked_index(istate, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
-- 
gitgitgadget

