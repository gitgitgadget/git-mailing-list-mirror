Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6315C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiKSMln (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKSMlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:37 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE208776F7
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id i10so19047835ejg.6
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXZT36h6eub7H/Vcec8yPX/20sUW+f+ZwuuUbq0jw0o=;
        b=FxJI6W9vEMKpFiLhhOGqcQCHFWgcLRMdPeGcravGG4rpdbqDpmmwcPQA4BSeU7hQOw
         EwbTQOsXuoTg0wCXdmZPxGNGalMiJFz490X92cSMxQXly2G2W+yOq/wQ0sc20ozZEwVD
         N1kzJJ19lOZoMxmn6dH8rl5VC8xUmAgLuxxl1jTetofxJCPcyYdeaputqVwqlFr1DopE
         X6VTxFRCHjbwhDYcxEIunwYF/P2hPKi9RMKJRvSXi18sRpxI4Jj5VzUU5d32OBfA4mJo
         0nODfd2kvoAKkgLYrbbs7OfLrOHxhphYF/9g3FtKYn1Kcz17C29vD8qh8Ua61Vwj3hon
         BLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXZT36h6eub7H/Vcec8yPX/20sUW+f+ZwuuUbq0jw0o=;
        b=oU9PJibtzcu9qkz0hHlg5ZBOZ22mKA1QDFnU7i9EKRjOoaLOCVY/YbddL71FU/CHPO
         MbmLQ2+9OSzbSAk0jwdqG5Ibj9PZIH7H4g+Y3naMrsY18nt3wqLo+9GQ1uS22BPsuavw
         LVKF1zup1vFj9A5TQHcqA4EKoi2i3lqYuJZdMZ7Ns4WTwxmcwnsv4NBP2WI+jnuwbBOs
         TkmSjhj56PbxoXC6LSEnmMqUPR67u72BWeBT1GKmc/PlHwKTIijjW9xQ2Bd+63Mq3KbQ
         G4h5BMsJNW8H5NPjgIN09lMQJmj4XMwZnXYmPpAgbVXlgsuNXfsw/M0eb4jbvW+iCUDA
         v79w==
X-Gm-Message-State: ANoB5pkGLMiYZlPuMHzP27xTnNn7h1Q9bKXeF6FpKBalkNeuZJGxzjP4
        EBZQ6AUKSxP/rNmUtrsOgdE0DXnpcPJ++g==
X-Google-Smtp-Source: AA0mqf5V+LpDjMCgQuGvMKagUlSPIVrj7TjtZiD2pV59xPs8EoQN5AEkD0VCU3d/EDgK2EPXnvZtAg==
X-Received: by 2002:a17:906:b46:b0:7ad:a030:4816 with SMTP id v6-20020a1709060b4600b007ada0304816mr985755ejg.765.1668861693926;
        Sat, 19 Nov 2022 04:41:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] submodule.c & submodule--helper: pass along "super_prefix" param
Date:   Sat, 19 Nov 2022 13:41:21 +0100
Message-Id: <patch-v3-2.9-2e4a2236898-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start passing the "super_prefix" along as a parameter to
get_submodule_displaypath() and absorb_git_dir_into_superproject(),
rather than get the value directly as a global.

This is in preparation for subsequent commits, where we'll gradually
phase out get_super_prefix() for an alternative way of getting the
"super_prefix".

Most of the users of this get a get_super_prefix() value, either
directly or by indirection. The exceptions are:

- builtin/rm.c: Doesn't declare SUPPORT_SUPER_PREFIX, so we'd have
  died if this was provided, so it's safe to passs "NULL".

- deinit_submodule(): The "deinit_submodule()" function has never been
  able to use the "git -super-prefix". It will call
  "absorb_git_dir_into_superproject()", but it will only do so from the
  top-level project.

  If "absorbgitdirs" recurses it will use the "path" passed to
  "absorb_git_dir_into_superproject()" in "deinit_submodule()" as its
  starting "--super-prefix". So we can safely remove the
  get_super_prefix() call here, and pass NULL instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c | 35 ++++++++++++++++++++++-------------
 submodule.c                 | 15 +++++++++------
 submodule.h                 |  3 ++-
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 05bfe20a469..24e13f6e899 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -86,7 +86,7 @@ static void submodules_absorb_gitdir_if_needed(void)
 			continue;
 
 		if (!submodule_uses_gitfile(name))
-			absorb_git_dir_into_superproject(name);
+			absorb_git_dir_into_superproject(name, NULL);
 	}
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c75e9e86b06..dc220d3348b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -113,10 +113,9 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 }
 
 /* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *get_submodule_displaypath(const char *path, const char *prefix,
+				       const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -294,7 +293,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *displaypath;
 
-	displaypath = get_submodule_displaypath(path, info->prefix);
+	displaypath = get_submodule_displaypath(path, info->prefix,
+						get_super_prefix());
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -447,7 +447,8 @@ static void init_submodule(const char *path, const char *prefix,
 	const char *upd;
 	char *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(path, prefix,
+						get_super_prefix());
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -624,7 +625,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(path, prefix,
+						get_super_prefix());
 
 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
 		print_status(flags, 'U', path, null_oid(), displaypath);
@@ -948,7 +950,8 @@ static void generate_submodule_summary(struct summary_cb *info,
 		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
 	}
 
-	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
+	displaypath = get_submodule_displaypath(p->sm_path, info->prefix,
+						get_super_prefix());
 
 	if (!missing_src && !missing_dst) {
 		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
@@ -1239,7 +1242,8 @@ static void sync_submodule(const char *path, const char *prefix,
 		super_config_url = xstrdup("");
 	}
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(path, prefix,
+						get_super_prefix());
 
 	if (!(flags & OPT_QUIET))
 		printf(_("Synchronizing submodule url for '%s'\n"),
@@ -1365,7 +1369,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	if (!sub || !sub->name)
 		goto cleanup;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(path, prefix, NULL);
 
 	/* remove the submodule work tree (unless the user already did it) */
 	if (is_directory(path)) {
@@ -1379,7 +1383,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 					  ".git file by using absorbgitdirs."),
 					displaypath);
 
-			absorb_git_dir_into_superproject(path);
+			absorb_git_dir_into_superproject(path, NULL);
 
 		}
 
@@ -1958,7 +1962,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	enum submodule_update_type update_type;
 	char *key;
 	const struct update_data *ud = suc->update_data;
-	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
+	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix,
+						      get_super_prefix());
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
 	int need_free_url = 0;
@@ -2608,7 +2613,8 @@ static int update_submodules(struct update_data *update_data)
 			goto fail;
 
 		update_data->displaypath = get_submodule_displaypath(
-			update_data->sm_path, update_data->prefix);
+			update_data->sm_path, update_data->prefix,
+			get_super_prefix());
 		code = update_submodule(update_data);
 		FREE_AND_NULL(update_data->displaypath);
 fail:
@@ -2828,6 +2834,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	const char *super_prefix;
 	struct option embed_gitdir_options[] = {
 		OPT_END()
 	};
@@ -2843,8 +2850,10 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
+	super_prefix = get_super_prefix();
 	for (i = 0; i < list.nr; i++)
-		absorb_git_dir_into_superproject(list.entries[i]->name);
+		absorb_git_dir_into_superproject(list.entries[i]->name,
+						 super_prefix);
 
 	ret = 0;
 cleanup:
diff --git a/submodule.c b/submodule.c
index c47358097fd..d339ce3b62c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2139,7 +2139,8 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (old_head) {
 			if (!submodule_uses_gitfile(path))
-				absorb_git_dir_into_superproject(path);
+				absorb_git_dir_into_superproject(path,
+								 get_super_prefix());
 		} else {
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
@@ -2313,7 +2314,8 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	strbuf_release(&new_gitdir);
 }
 
-static void absorb_git_dir_into_superproject_recurse(const char *path)
+static void absorb_git_dir_into_superproject_recurse(const char *path,
+						     const char *super_prefix)
 {
 
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -2321,8 +2323,8 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
 	cp.dir = path;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
+		     super_prefix : "", path);
 	strvec_pushl(&cp.args, "submodule--helper",
 		     "absorbgitdirs", NULL);
 	prepare_submodule_repo_env(&cp.env);
@@ -2335,7 +2337,8 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
  * having its git directory within the working tree to the git dir nested
  * in its superprojects git dir under modules/.
  */
-void absorb_git_dir_into_superproject(const char *path)
+void absorb_git_dir_into_superproject(const char *path,
+				      const char *super_prefix)
 {
 	int err_code;
 	const char *sub_git_dir;
@@ -2384,7 +2387,7 @@ void absorb_git_dir_into_superproject(const char *path)
 	}
 	strbuf_release(&gitdir);
 
-	absorb_git_dir_into_superproject_recurse(path);
+	absorb_git_dir_into_superproject_recurse(path, super_prefix);
 }
 
 int get_superproject_working_tree(struct strbuf *buf)
diff --git a/submodule.h b/submodule.h
index b52a4ff1e73..f90ee547d08 100644
--- a/submodule.h
+++ b/submodule.h
@@ -164,7 +164,8 @@ void submodule_unset_core_worktree(const struct submodule *sub);
  */
 void prepare_submodule_repo_env(struct strvec *env);
 
-void absorb_git_dir_into_superproject(const char *path);
+void absorb_git_dir_into_superproject(const char *path,
+				      const char *super_prefix);
 
 /*
  * Return the absolute path of the working tree of the superproject, which this
-- 
2.38.0.1509.g9445af83948

