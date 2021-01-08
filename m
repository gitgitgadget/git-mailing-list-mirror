Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D7C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798C123ABA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbhAHUDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbhAHUDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F367C0612FE
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so8726828wmi.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0TeogiNJ7ipGmFDWNnuJH30APRPsqSsAei8/MLisySQ=;
        b=J+XxQG+XP94VCSQQnLLN1myWSFh8tEVaBEvCpQVguuK0NsRpaLJvp7BuipqjTbySM4
         0/3yQdg3trvvWeM7E7P6L+oLt6mCQg0D0iihW6ncdrCJUdoOtHWwl3+PqK/5+mOKqjLJ
         MFLJSjqyXU7OVuRd3Fri3hyv1VftcSVSF8zSIUw1TljxdXhwzoBjv7jlGuXYthqPNQhR
         H7A57wR1IVjHkN01bPsslmcd65xFziAhKhqGCOVJYTpMHhmrJnXI/d+0rztb7lwHqaTg
         LvxBB2qCVxlu14cV8QhhJJ30h8ZOJNNNi/zTyBDC2ZhLKvsc21wZgTluCEaKBsXZvblU
         GeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0TeogiNJ7ipGmFDWNnuJH30APRPsqSsAei8/MLisySQ=;
        b=R97e7J9QXOPMvsp9njkS90IP0mT89yUW7gOJ7U9dn3wJmmLyprAgDg141dOCm8JYLO
         jxiWp/YeChZ3XOaQZrRhyKQYlXv4eCTLz8oHHx+JWroL7BYwNVly2m9t019K0G9TJTA/
         hkxeDtZv5+ek0ZqB1d/7nNE8oVYi0P5NfbM1UBoj24RW+IqNgpzPAwlVyuxK2XLrC2Xw
         182ZDdh5hVCXtpG86sHxa2ODqBbRsH3o8PwIxk1ZILZeiKz4G2gcF5oXAdVusp4fXuKx
         ffvdHnGTj+SlD5SVzB7WaYPdpvm1sloOSuK7pP/K4zhfr8VTomJAQwGRfnFFA/DrmPRS
         gShw==
X-Gm-Message-State: AOAM53161PVuJP3P/EoX9ctG9sYTefOzVIoLWe/yOyjo7SxuYD9I+Izc
        qpWVwn4JirUAm4m0FIUDzScjL7AS3y4=
X-Google-Smtp-Source: ABdhPJwwEBMDci69IAy7gQTHkeX2jDyeyfx6aF5bn4JV3AsmVEE7G+9sqkxafDCX+3EGC+eDASg0Gw==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr4519787wme.150.1610136180736;
        Fri, 08 Jan 2021 12:03:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm13493311wmd.6.2021.01.08.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:00 -0800 (PST)
Message-Id: <e715c703cb88d9a153e2925ae24c31b5bf5957ec.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:45 +0000
Subject: [PATCH v3 02/14] rm: remove compatilibity macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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

