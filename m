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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306FC433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE26F22210
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbhAANHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbhAANHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:07:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78253C061757
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i9so21971052wrc.4
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kdqg4CyYOfAKKRHMgCjKZSdIP/XxZ73cWhV3hxpXNuY=;
        b=SCj8+9VwX+PgQT6P7YudEnOWAH+1UbslupGzRdCw1Ya0zAvto5VPuwJWZtOjm98P4H
         4lzK4cdX3LtYXEBhDN+WDTxSsBhTjSeEVzcVcSrkaNlOpL2ymjaNHxakGJ7ySGxh+BNK
         ovOsr6Pw2yhqOmPc2RhOpoQXsfQpVo+o2QCvE/LPwa1GZH77UFLS5NAmhV4PsmhPGg6w
         EhusrF0egivC9c3YtfR/JH/O5njEjTvuEZQE83NlSn9XxMHd/DGFXZoL/EAsgZ/iIXq+
         TRzpsIrgerxhh6Q+L5a1eoIjbP899J5TxLpAAM5A+gpnvyDgzdRpbwa0iVTsWaQm3k5H
         BMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kdqg4CyYOfAKKRHMgCjKZSdIP/XxZ73cWhV3hxpXNuY=;
        b=keCzZvHqz85lW0z39614DxmgAyOyuqKaeRAX1V+NWE/Fe4F46zBIu46UNmP7T9j7wt
         9LM92kkz1HWtDhAsWyt0MfCreUVZEzQ+1sC5ro7cS672dQTJrfL6eON0Bk9mlcj+4qYF
         kaGLNhxls9VtSeH1qZSsMbmnSWea7xCCjwNOqI88jyjd0FRxF8IcW9tD3M5LGjqpMvxz
         RM5003gMAFQxQbSnvX5k3yck7Ipa4PYnTbMqHzro0urk+0M0nkJsqRKY7yqQrr/brMkI
         zdKGsVeJYRayDjtIzCE2ivnv59fvDfCsDuQB8fm/3jHAol5J2lU5KZp6nSZ4RsoLS6ZB
         gHCA==
X-Gm-Message-State: AOAM5333hIKI4y2p+0pZkESoblB+0wDQrKzGy5lW4+8Vhzp/q8H5AKz7
        I0Ns9jx8Q+1iUN0r8zvD/OptwS5pwAE=
X-Google-Smtp-Source: ABdhPJyFE4BNGzJ2VT5bj6b0pGchC0KodXEmB9MGoZHqOKBesBYDfYsUyXflKhdmgt0gEQdO2D7QwQ==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr68872582wrx.76.1609506431854;
        Fri, 01 Jan 2021 05:07:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm60124395wrc.93.2021.01.01.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:11 -0800 (PST)
Message-Id: <84330533d4f4e203cd5d8a61495adaafd3881a4a.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:06:58 +0000
Subject: [PATCH 02/12] mv: remove index compatibility macros
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

The mv builtin uses the compatibility macros to interact with the index.
Update these to use modern methods referring to a 'struct index_state'
pointer. Several helper methods need to be updated to consider such a
pointer, but the modifications are rudimentary.

Two macros can be deleted from cache.h because these are the last uses.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/mv.c | 42 +++++++++++++++++++++++-------------------
 cache.h      |  2 --
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7dac714af90..0055d49a8a7 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "pathspec.h"
@@ -75,13 +74,14 @@ static const char *add_slash(const char *path)
 
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
 
-static void prepare_move_submodule(const char *src, int first,
+static void prepare_move_submodule(struct index_state *istate,
+				   const char *src, int first,
 				   const char **submodule_gitfile)
 {
 	struct strbuf submodule_dotgit = STRBUF_INIT;
-	if (!S_ISGITLINK(active_cache[first]->ce_mode))
+	if (!S_ISGITLINK(istate->cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
-	if (!is_staging_gitmodules_ok(&the_index))
+	if (!is_staging_gitmodules_ok(istate))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile = read_gitfile(submodule_dotgit.buf);
@@ -92,19 +92,20 @@ static void prepare_move_submodule(const char *src, int first,
 	strbuf_release(&submodule_dotgit);
 }
 
-static int index_range_of_same_dir(const char *src, int length,
+static int index_range_of_same_dir(struct index_state *istate,
+				   const char *src, int length,
 				   int *first_p, int *last_p)
 {
 	const char *src_w_slash = add_slash(src);
 	int first, last, len_w_slash = length + 1;
 
-	first = cache_name_pos(src_w_slash, len_w_slash);
+	first = index_name_pos(istate, src_w_slash, len_w_slash);
 	if (first >= 0)
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
 
 	first = -1 - first;
-	for (last = first; last < active_nr; last++) {
-		const char *path = active_cache[last]->name;
+	for (last = first; last < istate->cache_nr; last++) {
+		const char *path = istate->cache[last]->name;
 		if (strncmp(path, src_w_slash, len_w_slash))
 			break;
 	}
@@ -133,6 +134,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
+	struct index_state *istate;
 
 	git_config(git_default_config, NULL);
 
@@ -141,9 +143,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
+	istate = the_repository->index;
 
 	source = internal_prefix_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
@@ -190,12 +193,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				&& lstat(dst, &st) == 0)
 			bad = _("cannot move directory over file");
 		else if (src_is_dir) {
-			int first = cache_name_pos(src, length), last;
+			int first = index_name_pos(istate, src, length);
+			int last;
 
 			if (first >= 0)
-				prepare_move_submodule(src, first,
+				prepare_move_submodule(istate, src, first,
 						       submodule_gitfile + i);
-			else if (index_range_of_same_dir(src, length,
+			else if (index_range_of_same_dir(istate, src, length,
 							 &first, &last) < 1)
 				bad = _("source directory is empty");
 			else { /* last - first >= 1 */
@@ -212,7 +216,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
-					const char *path = active_cache[first + j]->name;
+					const char *path = istate->cache[first + j]->name;
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len, path + length + 1);
@@ -221,7 +225,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (!(ce = cache_file_exists(src, length, ignore_case))) {
+		} else if (!(ce = index_file_exists(istate, src, length, ignore_case))) {
 			bad = _("not under version control");
 		} else if (ce_stage(ce)) {
 			bad = _("conflicted");
@@ -291,15 +295,15 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		pos = cache_name_pos(src, strlen(src));
+		pos = index_name_pos(istate, src, strlen(src));
 		assert(pos >= 0);
-		rename_cache_entry_at(pos, dst);
+		rename_index_entry_at(istate, pos, dst);
 	}
 
 	if (gitmodules_modified)
-		stage_updated_gitmodules(&the_index);
+		stage_updated_gitmodules(istate);
 
-	if (write_locked_index(&the_index, &lock_file,
+	if (write_locked_index(istate, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
diff --git a/cache.h b/cache.h
index 71097657489..7bfb8195d97 100644
--- a/cache.h
+++ b/cache.h
@@ -409,7 +409,6 @@ extern struct index_state the_index;
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
-#define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
@@ -420,7 +419,6 @@ extern struct index_state the_index;
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
-#define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
-- 
gitgitgadget

