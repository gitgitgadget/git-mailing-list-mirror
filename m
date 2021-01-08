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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64898C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319E923ABA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbhAHUDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbhAHUDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D5EC0612FD
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n16so7341704wmc.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=46EBxVR106mVIDbq6Lo6I4pbDbN3mZe9YLzzhfxnxgk=;
        b=qvvuC/ZH7zFw+fPwNQG2/+MFpZ/Hx73u7ux4o0zirfEfg4M8pa7g6cZU9wyeqFtl87
         T1pD4aBPXYC6WJbuynvr0j5YM+eX9/LW7Pqq3rb2U8iuLBitdJQIzIfOBknujvZCO3pt
         iHdlpjBfVtFvfia2jfKuuam5sT7cLgLdADvRcG4aF+q/9XNwKysTHC9dzRMTM8KlPFJa
         wpes8iaZGitzAUgW2MIJA5OKxc+P/m14H+uf1JLAVmOTZTK7gPU4tW/7vAaT0CmOXF8a
         GXB9gNW9Z9akBUABMZL4GlXq6llUjkLXAsymZXco0M+wlTn0Bf6aQSfowEXl6ulp8raJ
         ta6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=46EBxVR106mVIDbq6Lo6I4pbDbN3mZe9YLzzhfxnxgk=;
        b=bfrRa1/5a6/uGKKY8ANqU4RY0M/4nPRqiDzBjANPrESq5Ph9FM5uq1kPS5WGM16oCi
         6Lmr2ewtthqpGHgezL4uf1RXUEyukaLZHW0AxEfr3iGvwnf8+hGzRX+GrDXiRwVeq9/P
         cZYjWyNV/6xW0efjAi7/neAxSzMt0TUJ6meBgAn//gCDMMT45F2khmFc44+ZTUTOnPGu
         dHmXOPpfHfh/Ewwf8mGDKWyFD2XvLDkyEpiRMvQDOrCBm1GVwan6A4FmywhISFJwy75/
         cuouOW0NfeX3YpdImOic8SP5ALkVsF9jKV6T+8Jdo/j7+U0KkPbOUsAwyZrzu8jPaUQ0
         2wmQ==
X-Gm-Message-State: AOAM530cYgug6v1l2IVox4I40/rLIM9oQlsuQRIArrlDA3IlZj/6/x9d
        w1c4EzzFCUxzQzLTeX43oblsd+WtTTo=
X-Google-Smtp-Source: ABdhPJxBloawJapOBgteUtKilsRyX36S4x3v1VMeJcjKxYfGsUnxQDqbi6WA5j+1un/b/NH8TWwSrg==
X-Received: by 2002:a1c:68d6:: with SMTP id d205mr4527463wmc.154.1610136179822;
        Fri, 08 Jan 2021 12:02:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm12950909wmj.31.2021.01.08.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:02:59 -0800 (PST)
Message-Id: <5ccc464cf268476932197c790693e1ecea9e778c.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:44 +0000
Subject: [PATCH v3 01/14] mv: remove index compatibility macros
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
index 2d844576ead..fdf061cac56 100644
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

