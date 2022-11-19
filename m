Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D0C43217
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiKSNIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKSNH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C2990596
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so10557790edc.12
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vMPKAIJbk5wrO+LupTb1Mf59IgCyh6iqeI8EX4ox8U=;
        b=A3/qZp2KxWTBLw9C2g/4h0k78dKlHXJ16IZgqu1gt+dOsu4lfR9eUj6crlhFln/nUo
         PMEyhy0Ti/fuwKzGVSAVchw+4kxwnymHmyW6GC3fIeeGj0WhR3cQKXGI+Ztu1zt4MaHQ
         NIOd4oHnZASIzUr639ECkP1/ClZIe6Zuv3PJIGLjGZC7Ho0cAvurwmOIvXnxpnBG5ebf
         93KEgvqPwvh+dYpIAXa92Xb3w2Cg6UL/+W6zD59oMbanE9Rjndf7ouYBBVXlp5K6AYgk
         EpCyPXbToBSz9ga6vDdHf1Jr8jLN0gByGW9X70M5JA7q3Au+KEZ1e+ZtRckwXtbFS9so
         Qodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vMPKAIJbk5wrO+LupTb1Mf59IgCyh6iqeI8EX4ox8U=;
        b=rMF812y1Dfsg5kwNOnb7ysenFIw69ShPb40wa4X/aV+3OXF/ObOtR1j1jyQLyegd4n
         1YSFH5JaAO+92Wvd6G6vNkcmaveQH78gEyAZXDO9ayhryqxUvt4YR0uxLdVwuYHzUnr3
         I80CrXlkBpkbS1Nb5Ej9XFde7Zo0vL1jtREixgLrE8Iri/Kk1op/QIrRQtI0c5HcPsWV
         Gasf7N+ednK19iHBQCpxdtjMVkC5W79by14EBeB6WsKl0Ht1vTtdj/2IrAVq0rPTWzij
         /rdbTpLXAtCro9vUMD0siiNptyLRbkF/Av4LL/QUErzu949NdAUc/z9UapyNPAScs9Qr
         jT7Q==
X-Gm-Message-State: ANoB5pnBSQj/I2Pd5RRUYwNVElp7sKL2M3OCXjZCMpTikhtmmKeXvSAW
        83t5ba+JYaCnz/Go/09fgahsvfQvzHSCiQ==
X-Google-Smtp-Source: AA0mqf5XZI7uZUWfb4cSYo0ubsN7AHu1fhMXpFynB2f7i7wy0ttYZSQUFrXgxZ83Egd4HoWDkhKwnw==
X-Received: by 2002:aa7:d7d3:0:b0:469:906:2ece with SMTP id e19-20020aa7d7d3000000b0046909062ecemr6504256eds.342.1668863272519;
        Sat, 19 Nov 2022 05:07:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] cocci & cache.h: apply a selection of "pending" index-compatibility
Date:   Sat, 19 Nov 2022 14:07:33 +0100
Message-Id: <patch-v2-06.11-6849233bf2b-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply a selection of rules in "index-compatibility.pending.cocci"
tree-wide, and in doing so migrate them to
"index-compatibility.cocci".

As in preceding commits the only manual changes here are the macro
removals in "cache.h", and the update to the '*.cocci" rules. The rest
of the C code changes are the result of applying those updated rules.

Move rules for some rarely used cache compatibility macros from
"index-compatibility.pending.cocci" to "index-compatibility.cocci" and
apply them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c                            |  5 +++--
 builtin/commit.c                              |  2 +-
 builtin/merge.c                               |  2 +-
 builtin/mv.c                                  |  4 +++-
 builtin/read-tree.c                           |  2 +-
 builtin/reset.c                               |  5 +++--
 builtin/rm.c                                  |  4 ++--
 builtin/update-index.c                        | 22 +++++++++----------
 cache.h                                       |  5 -----
 contrib/coccinelle/index-compatibility.cocci  | 15 +++++++++++++
 .../index-compatibility.pending.cocci         | 15 -------------
 11 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index aa610b274e3..afbd71764a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -160,7 +160,8 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 		}
 	}
 
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(&the_index, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
 }
 
@@ -744,7 +745,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (read_cache_preload(NULL) < 0)
 		return error(_("index file corrupt"));
 
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->commit)
 			BUG("'switch --orphan' should never accept a commit as starting point");
diff --git a/builtin/commit.c b/builtin/commit.c
index 985503d43a6..10a827b1f4a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -305,7 +305,7 @@ static void add_remove_files(struct string_list *list)
 			if (add_to_index(&the_index, p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
-			remove_file_from_cache(p->string);
+			remove_file_from_index(&the_index, p->string);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 89fdac24e40..2046992d75a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1397,7 +1397,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists)."));
 	}
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 
 	if (option_edit < 0)
 		option_edit = default_edit_option();
diff --git a/builtin/mv.c b/builtin/mv.c
index df6157fd6b5..6f94c3b9238 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -471,7 +471,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
 		if (!(mode & SPARSE) && !lstat(src, &st))
-			sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);
+			sparse_and_dirty = ie_modified(&the_index,
+						       active_cache[pos], &st,
+						       0);
 		rename_index_entry_at(&the_index, pos, dst);
 
 		if (ignore_sparse &&
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index fd708273101..9ced755a6db 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -192,7 +192,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			die(_("You need to resolve your current index first"));
 		stage = opts.merge = 1;
 	}
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/reset.c b/builtin/reset.c
index e561180e8c4..59f777a1da4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -145,7 +145,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		struct cache_entry *ce;
 
 		if (!is_in_reset_tree && !intent_to_add) {
-			remove_file_from_cache(one->path);
+			remove_file_from_index(&the_index, one->path);
 			continue;
 		}
 
@@ -172,7 +172,8 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			ce->ce_flags |= CE_INTENT_TO_ADD;
 			set_object_name_for_intent_to_add_entry(ce);
 		}
-		add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+		add_index_entry(&the_index, ce,
+				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	}
 }
 
diff --git a/builtin/rm.c b/builtin/rm.c
index f0d025a4e23..c717cdc97f5 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -168,7 +168,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 * Is the index different from the file in the work tree?
 		 * If it's a submodule, is its work tree modified?
 		 */
-		if (ce_match_stat(ce, &st, 0) ||
+		if (ie_match_stat(&the_index, ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
 		     bad_to_remove_submodule(ce->name,
 				SUBMODULE_REMOVAL_DIE_ON_ERROR |
@@ -386,7 +386,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!quiet)
 			printf("rm '%s'\n", path);
 
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			die(_("git rm: unable to remove %s"), path);
 	}
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e1b2bb78e72..533ba66df05 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -256,7 +256,7 @@ static int remove_one_path(const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
-	if (remove_file_from_cache(path))
+	if (remove_file_from_index(&the_index, path))
 		return error("%s: cannot remove from the index", path);
 	return 0;
 }
@@ -281,7 +281,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	struct cache_entry *ce;
 
 	/* Was the old index entry already up-to-date? */
-	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
+	if (old && !ce_stage(old) && !ie_match_stat(&the_index, old, st, 0))
 		return 0;
 
 	ce = make_empty_cache_entry(&the_index, len);
@@ -298,7 +298,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option)) {
+	if (add_index_entry(&the_index, ce, option)) {
 		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
 	}
@@ -390,7 +390,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		 * On the other hand, removing it from index should work
 		 */
 		if (!ignore_skip_worktree_entries && allow_remove &&
-		    remove_file_from_cache(path))
+		    remove_file_from_index(&the_index, path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -429,7 +429,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	if (add_index_entry(&the_index, ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
 	report("add '%s'", path);
@@ -488,7 +488,7 @@ static void update_one(const char *path)
 	}
 
 	if (force_remove) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		return;
@@ -571,7 +571,7 @@ static void read_index_info(int nul_term_line)
 
 		if (!mode) {
 			/* mode == 0 means there is no such path -- remove */
-			if (remove_file_from_cache(path_name))
+			if (remove_file_from_index(&the_index, path_name))
 				die("git update-index: unable to remove %s",
 				    ptr);
 		}
@@ -686,13 +686,13 @@ static int unresolve_one(const char *path)
 		goto free_return;
 	}
 
-	remove_file_from_cache(path);
-	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
+	remove_file_from_index(&the_index, path);
+	if (add_index_entry(&the_index, ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
 		goto free_return;
 	}
-	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
+	if (!add_index_entry(&the_index, ce_3, ADD_CACHE_OK_TO_ADD))
 		return 0;
 	error("%s: cannot add their version to the index.", path);
 	ret = -1;
@@ -850,7 +850,7 @@ static int resolve_undo_clear_callback(const struct option *opt,
 {
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 489e9e1925b..79b8d479710 100644
--- a/cache.h
+++ b/cache.h
@@ -446,13 +446,8 @@ extern struct index_state the_index;
 #define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
 #define discard_cache() discard_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
-#define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
-#define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
-#define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
-#define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 04207c409e1..89c18986160 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -39,6 +39,21 @@
 |
 - add_file_to_cache
 + add_file_to_index
+|
+- add_cache_entry
++ add_index_entry
+|
+- remove_file_from_cache
++ remove_file_from_index
+|
+- ce_match_stat
++ ie_match_stat
+|
+- ce_modified
++ ie_modified
+|
+- resolve_undo_clear
++ resolve_undo_clear_index
 )
   (
 + &the_index,
diff --git a/contrib/coccinelle/index-compatibility.pending.cocci b/contrib/coccinelle/index-compatibility.pending.cocci
index 6e96de0f638..cf1ea57d700 100644
--- a/contrib/coccinelle/index-compatibility.pending.cocci
+++ b/contrib/coccinelle/index-compatibility.pending.cocci
@@ -38,21 +38,6 @@
 |
 - cache_name_pos
 + index_name_pos
-|
-- add_cache_entry
-+ add_index_entry
-|
-- remove_file_from_cache
-+ remove_file_from_index
-|
-- ce_match_stat
-+ ie_match_stat
-|
-- ce_modified
-+ ie_modified
-|
-- resolve_undo_clear
-+ resolve_undo_clear_index
 )
   (
 + &the_index,
-- 
2.38.0.1509.g9445af83948

