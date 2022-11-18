Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4001BC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiKRLbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiKRLbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D27657D5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:12 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vv4so3011686ejc.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp9bU1LYQhh+OMVgMRUd6uAREv7P7Y29YL0nNnCSkQk=;
        b=Dr/NirBrCue7XLPHi5AtZMqe09XKQmKtLsNgSdEtdszTQFAKmLpPlsi66+fJEUnjus
         IOIU1/fMdPrDOn2bc+AWzrsrlsfe39h0cBsoXuUPnUdurIJTw2ANSVdpGhNMlWbb02PL
         wLjO3qzD/b2UQ7dvg1DNUltF3dHMg4cfZ6ESPaHz/knUF66kdbfXlfWm7bacg+IJt5mE
         g7+qAviBmTjtA8f2eF/jzdA/IzI4AF6WpbYxbzXzA+w0fOOQBGWIIOCwIXIZXf9tKwyy
         2fvhvAJlT+fonXjaG3KBpnFDNLd2ZcN5Y5SmVO3gEKDvf/zHPkawbvOBoSmYoCHOMXYw
         ORZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp9bU1LYQhh+OMVgMRUd6uAREv7P7Y29YL0nNnCSkQk=;
        b=4dU5XxfzLGF08btYoXq4X3+5i2fov9JP2bTV2tOVVxrBfAflDUbqXqbYO0wDFXAKqF
         vP2+Bzr9Y22ElbBJjymH69IFVjIBnsbXL4Q7E2DvjyWIuSmLDb1pSKrd/kV4qpeMfmB4
         1HxVQrauQb2zs4qlQUebTlQ6+EwiOS/9FDgzeNL2zTe0TyAYFOS/7xLwNmFsoOQ4jm8W
         Zr4uroT2fVm2D59ex8NcVSYO97LMfEF4cJG7ObdzLt53gQmRkgrHGcRLpS6rvMfeoYP0
         aNj1/6aKZdoYW8McUoKaCNdfgFirfwWd8siRKb8YMjqa5HacqKpphjM4NLTyLYtLrfOM
         8NBg==
X-Gm-Message-State: ANoB5pk7xHfKhz8jofKeyXS333S+WflY5nGEtLqNrgfYuga3v0+8/FdO
        +huNdIITt8U7QjO35lctx52C+KUqkE5mCQ==
X-Google-Smtp-Source: AA0mqf7OlMySOE0WEF0SH4vFBpanqcVx3dvhWq0HkYtzhFxbgtS2+2LS6eo1WIt9ZeFMbDrC8TsvDg==
X-Received: by 2002:a17:907:900a:b0:7ae:f6e8:2502 with SMTP id ay10-20020a170907900a00b007aef6e82502mr5679423ejc.157.1668771070908;
        Fri, 18 Nov 2022 03:31:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/12] cocci & cache.h: remove rarely used "the_index" compat macros
Date:   Fri, 18 Nov 2022 12:30:57 +0100
Message-Id: <patch-03.12-faa7757cb32-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4aab5b46f44 (Make read-cache.c "the_index" free., 2007-04-01)
we've been undergoing a slow migration away from these macros, but
haven't made much progress since f8adbec9fea (cache.h: flip
NO_THE_INDEX_COMPATIBILITY_MACROS switch, 2019-01-24).

Let's move forward a bit by changing the users of those macros that
are rare enough that we can convert them in one go, and then remove
the compatibility shim.

The only manual change to the C code here is to "cache.h", the rest is
all the result of applying the new "index-compatibility.cocci".

Even though it's a one-off, let's keep the coccinelle rules for
now. We'll extend them in subsequent commits, and this will help
anything that's in-flight or out-of-tree to migrate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c                                |  5 ++-
 builtin/am.c                                 |  4 +-
 builtin/checkout.c                           |  4 +-
 builtin/clean.c                              |  2 +-
 builtin/commit.c                             |  2 +-
 builtin/merge.c                              |  2 +-
 builtin/mv.c                                 |  4 +-
 builtin/pull.c                               |  4 +-
 builtin/read-tree.c                          |  4 +-
 builtin/reset.c                              |  4 +-
 builtin/update-index.c                       |  4 +-
 cache.h                                      | 10 -----
 contrib/coccinelle/index-compatibility.cocci | 45 ++++++++++++++++++++
 13 files changed, 65 insertions(+), 29 deletions(-)
 create mode 100644 contrib/coccinelle/index-compatibility.cocci

diff --git a/builtin/add.c b/builtin/add.c
index 626c71ec6aa..75be1d021ab 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -55,7 +55,7 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 			continue;
 
 		if (!show_only)
-			err = chmod_cache_entry(ce, flip);
+			err = chmod_index_entry(&the_index, ce, flip);
 		else
 			err = S_ISREG(ce->ce_mode) ? 0 : -1;
 
@@ -172,7 +172,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 			continue; /* do not touch non blobs */
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
-		retval |= add_file_to_cache(ce->name, flags | ADD_CACHE_RENORMALIZE);
+		retval |= add_file_to_index(&the_index, ce->name,
+					    flags | ADD_CACHE_RENORMALIZE);
 	}
 
 	return retval;
diff --git a/builtin/am.c b/builtin/am.c
index 20aea0d2487..f362a1c29fd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1930,7 +1930,7 @@ static void am_resolve(struct am_state *state, int allow_empty)
 		}
 	}
 
-	if (unmerged_cache()) {
+	if (unmerged_index(&the_index)) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
 			"You should 'git add' each file with resolved conflicts to mark them as such.\n"
 			"You might run `git rm` on a file to accept \"deleted by them\" for it."));
@@ -2045,7 +2045,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (!remote_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(remote));
 
-	read_cache_unmerged();
+	repo_read_index_unmerged(the_repository);
 
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a132392fbe..aa610b274e3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -722,7 +722,7 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
 
 	setup_unpack_trees_porcelain(topts, "checkout");
 
-	topts->initial_checkout = is_cache_unborn();
+	topts->initial_checkout = is_index_unborn(&the_index);
 	topts->update = 1;
 	topts->merge = 1;
 	topts->quiet = merge && old_commit;
@@ -763,7 +763,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 		refresh_cache(REFRESH_QUIET);
 
-		if (unmerged_cache()) {
+		if (unmerged_index(&the_index)) {
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
diff --git a/builtin/clean.c b/builtin/clean.c
index 40ff2c578de..7084e685f6f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1031,7 +1031,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		struct stat st;
 		const char *rel;
 
-		if (!cache_name_is_other(ent->name, ent->len))
+		if (!index_name_is_other(&the_index, ent->name, ent->len))
 			continue;
 
 		if (lstat(ent->name, &st))
diff --git a/builtin/commit.c b/builtin/commit.c
index e22bdf23f5f..985503d43a6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -302,7 +302,7 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_cache(p->string, &st, 0))
+			if (add_to_index(&the_index, p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
 			remove_file_from_cache(p->string);
diff --git a/builtin/merge.c b/builtin/merge.c
index b3f75f55c8a..da11dfae19e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1375,7 +1375,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
-	if (read_cache_unmerged())
+	if (repo_read_index_unmerged(the_repository))
 		die_resolve_conflict("merge");
 
 	if (file_exists(git_path_merge_head(the_repository))) {
diff --git a/builtin/mv.c b/builtin/mv.c
index 3413ad1c9b1..df6157fd6b5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -343,7 +343,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			argc += last - first;
 			goto act_on_entry;
 		}
-		if (!(ce = cache_file_exists(src, length, 0))) {
+		if (!(ce = index_file_exists(&the_index, src, length, 0))) {
 			bad = _("not under version control");
 			goto act_on_entry;
 		}
@@ -472,7 +472,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		assert(pos >= 0);
 		if (!(mode & SPARSE) && !lstat(src, &st))
 			sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);
-		rename_cache_entry_at(pos, dst);
+		rename_index_entry_at(&the_index, pos, dst);
 
 		if (ignore_sparse &&
 		    core_apply_sparse_checkout &&
diff --git a/builtin/pull.c b/builtin/pull.c
index b21edd767aa..4a2a6db2dce 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1030,7 +1030,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase(&rebase_unspecified);
 
-	if (read_cache_unmerged())
+	if (repo_read_index_unmerged(the_repository))
 		die_resolve_conflict("pull");
 
 	if (file_exists(git_path_merge_head(the_repository)))
@@ -1043,7 +1043,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (opt_autostash == -1)
 			opt_autostash = config_autostash;
 
-		if (is_null_oid(&orig_head) && !is_cache_unborn())
+		if (is_null_oid(&orig_head) && !is_index_unborn(&the_index))
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!opt_autostash)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f4cbe460b97..8a697a782fc 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -188,7 +188,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	 */
 
 	if (opts.reset || opts.merge || opts.prefix) {
-		if (read_cache_unmerged() && (opts.prefix || opts.merge))
+		if (repo_read_index_unmerged(the_repository) && (opts.prefix || opts.merge))
 			die(_("You need to resolve your current index first"));
 		stage = opts.merge = 1;
 	}
@@ -232,7 +232,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			break;
 		case 2:
 			opts.fn = twoway_merge;
-			opts.initial_checkout = is_cache_unborn();
+			opts.initial_checkout = is_index_unborn(&the_index);
 			break;
 		case 3:
 		default:
diff --git a/builtin/reset.c b/builtin/reset.c
index fdce6f8c856..ee874ee6d5b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -82,7 +82,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 		BUG("invalid reset_type passed to reset_index");
 	}
 
-	read_cache_unmerged();
+	repo_read_index_unmerged(the_repository);
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
@@ -218,7 +218,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
 
 static void die_if_unmerged_cache(int reset_type)
 {
-	if (is_merge() || unmerged_cache())
+	if (is_merge() || unmerged_index(&the_index))
 		die(_("Cannot do a %s reset in the middle of a merge."),
 		    _(reset_type_names[reset_type]));
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7b0c924d7d4..e1b2bb78e72 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -445,7 +445,7 @@ static void chmod_path(char flip, const char *path)
 	if (pos < 0)
 		goto fail;
 	ce = active_cache[pos];
-	if (chmod_cache_entry(ce, flip) < 0)
+	if (chmod_index_entry(&the_index, ce, flip) < 0)
 		goto fail;
 
 	report("chmod %cx '%s'", flip, path);
@@ -641,7 +641,7 @@ static int unresolve_one(const char *path)
 	pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
 		/* already merged */
-		pos = unmerge_cache_entry_at(pos);
+		pos = unmerge_index_entry_at(&the_index, pos);
 		if (pos < active_nr) {
 			const struct cache_entry *ce = active_cache[pos];
 			if (ce_stage(ce) &&
diff --git a/cache.h b/cache.h
index 29bb0ad2b41..53dc4341717 100644
--- a/cache.h
+++ b/cache.h
@@ -444,25 +444,15 @@ extern struct index_state the_index;
 #define read_cache() repo_read_index(the_repository)
 #define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
 #define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
-#define is_cache_unborn() is_index_unborn(&the_index)
-#define read_cache_unmerged() repo_read_index_unmerged(the_repository)
 #define discard_cache() discard_index(&the_index)
-#define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
-#define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
-#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
-#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
-#define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
-#define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
-#define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
new file mode 100644
index 00000000000..04207c409e1
--- /dev/null
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -0,0 +1,45 @@
+// "the_repository" simple cases
+@@
+@@
+(
+- read_cache_unmerged
++ repo_read_index_unmerged
+)
+  (
++ the_repository,
+  ...)
+
+// "the_index" simple cases
+@@
+@@
+(
+- is_cache_unborn
++ is_index_unborn
+|
+- unmerged_cache
++ unmerged_index
+|
+- rename_cache_entry_at
++ rename_index_entry_at
+|
+- chmod_cache_entry
++ chmod_index_entry
+|
+- cache_file_exists
++ index_file_exists
+|
+- cache_name_is_other
++ index_name_is_other
+|
+- unmerge_cache_entry_at
++ unmerge_index_entry_at
+|
+- add_to_cache
++ add_to_index
+|
+- add_file_to_cache
++ add_file_to_index
+)
+  (
++ &the_index,
+  ...)
-- 
2.38.0.1511.gcdcff1f1dc2

