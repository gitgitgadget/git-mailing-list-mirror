Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA8C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiKSNH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiKSNHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF78FE41
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f18so19184983ejz.5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImsvhYVaspNdzTOXY0WsvIgWeVuWWo9dlLFG7aK8Fs0=;
        b=XtWA1wO4s0yJp6vtIJpG6wMHfnIm1btodwkKDMxttdyFyPOyVUFLfiUhAmY7sb5VoU
         RWf0d/cfrWTn4nAxezbMBIhkItFhofr+7O7lP2W4EXrKPfrHCnq5dKAlGDS30P0VgP7U
         WjB4cSCEMuyQmAzctrok0e7kzOriGm/1+buYj/YYS/2HkBgTaRFR18y7cP1ROgmZ8koO
         oibbCx0aBNh0UXDrHzpKxMMWlDOJ+lwqxcmhcBd42MO0L4dkCNvBT3j+KGDQGT5SgoLr
         afx2HpkIGo8G6+jEWxa317wLbADKwWYXfZhSVrG6Bovg+z2JLDtP7O/nKw8Id7kJQVqW
         4TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImsvhYVaspNdzTOXY0WsvIgWeVuWWo9dlLFG7aK8Fs0=;
        b=iN5BpMt83BrmS4OBqGocmgvBj/AgYBMnhhNLlmd8pqSkhlz0L5WHSeuTnqGuJmNVc5
         AuU5/2ZgFQuE6Ljz2eMAw1JBRpf9zoe17/B/8q601q5Jt72qZp+8hHztSzL96s2rl5io
         Frd8IibxBhzwatcYCpSnPycLeeH59jOpATV6azFr5ni7dN25ol+RqHSq6kC+psWkRlt4
         66DwibjAopo9yVNV/j0Wa/BcLMSiCsN3z3RAXEs5HaRjjrmLUYmddLhszXbY3dk+bbAQ
         yJNwlAMSdylACNNNb0RPBDU5WSSVQdEpbTo1BEOZ3qg4RwlmTFD0urW7PbMvUVy/0lt4
         PkFA==
X-Gm-Message-State: ANoB5pkMTVT1js0ZkmYFvw0M5pycfPWYGv79ACctflkkTZIpJ99IHMPK
        GasOZtWf2GHiIt7ChL6M9Kedm7h+rmedIA==
X-Google-Smtp-Source: AA0mqf4gsyIqdJFg2P3qrEuLdinfQ4FKQumy9dms27zk/g3GK6s7YvGUf5xrhYGtz719noC4839N8g==
X-Received: by 2002:a17:906:9518:b0:7ad:b152:6bd1 with SMTP id u24-20020a170906951800b007adb1526bd1mr827134ejx.30.1668863269634;
        Sat, 19 Nov 2022 05:07:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] cocci & cache.h: remove rarely used "the_index" compat macros
Date:   Sat, 19 Nov 2022 14:07:30 +0100
Message-Id: <patch-v2-03.11-5c2776a28f7-20221119T125550Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
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
index 45c6652444b..fd708273101 100644
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
index ab027774824..e561180e8c4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -84,7 +84,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 		BUG("invalid reset_type passed to reset_index");
 	}
 
-	read_cache_unmerged();
+	repo_read_index_unmerged(the_repository);
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
@@ -220,7 +220,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
 
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
2.38.0.1509.g9445af83948

