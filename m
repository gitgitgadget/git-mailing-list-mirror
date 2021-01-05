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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB8C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6498E22515
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhAEEnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbhAEEnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:43:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA519C061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c133so1857690wme.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=46EBxVR106mVIDbq6Lo6I4pbDbN3mZe9YLzzhfxnxgk=;
        b=qQSXSg32GGwbuOJFBtkK7Md25mqaphhXfb06LrVzzx9rYAAI8C/U2zpXaZNaYbC0Pq
         yrnL+8RLbni9LH0Aw6B7sj0QnD+nBvHxpSh2iqkrHl8RHgpUc6l5qhnNzfaO2iiOg/0V
         6xbIOg5JIZh0gpcbq3lL63Yc0Jq8dqRIQbLIuNBJsbns+xeZ2oQKOvfteAQXodQDBF7d
         2fxMFW/efByDA3fgxMJrfYLXLdr/TrQ6qniDg/qfHrvPICER6BThA1UwLvzOegzh+F4p
         JwO8rcqNjkQGg3Q5B1LHU1SIqDBy5R9fWN0j8pmyNPBU5hHjvUEeY7Ks7S8FzGHG2/mX
         1szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=46EBxVR106mVIDbq6Lo6I4pbDbN3mZe9YLzzhfxnxgk=;
        b=I0JgFcUCxqh9hOiN3DChrpMKlCrr0NJOKLLO7dtf5kD/TESOdeWgLFvi+alGmkQMc4
         +1twBCsBC25sVP3EDIIO0Ecglb6iHkjtgl8QPHeQUdyXbV9d2jUYyVm3HjjP7B7bm9dx
         j7QamxWeFSMXZVS9fJ5Hg1Yt0EEiD8QrmjR4X6dbwE+AeX3jtYfXDFuY5R15SbL2IYrN
         FuUfr3fAV2/TlVF7qTgu5/PKGWiZiMnhW82YbKMf/UB5sfXu1IknjOMClCdQMYnGu9P2
         uDEr7An/svU/LUkanQn6GHd7p1gR0hjsUm3idR3FWj9JYvWyqnoIffJC5Y6VoEpIcmc6
         8jow==
X-Gm-Message-State: AOAM531nncONzihVaO2jxoLVnDsiWzTSdojHF23TL9+1Lhk2m7Yh31tG
        KaV2q3u/1Smi7fJ7dqrLjWLmvQBCgmI=
X-Google-Smtp-Source: ABdhPJxySCxhSDubYycbaMEZA0i+VeLMqZBOdM/H45OLP2/pi/Gnq7iYIVmoYBqUokKhb2Z0VNTa7A==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr1664528wml.33.1609821785740;
        Mon, 04 Jan 2021 20:43:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b200sm2324396wmb.10.2021.01.04.20.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:04 -0800 (PST)
Message-Id: <5ccc464cf268476932197c790693e1ecea9e778c.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:50 +0000
Subject: [PATCH v2 01/14] mv: remove index compatibility macros
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

