Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D8C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiLTMng (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiLTMnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96361ADB0
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r206-20020a1c44d7000000b003d6b8e8e07fso63633wma.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yqB/IQjPU0JdPCGgeUmhzJaK+oHnrbiIoWKnKW7KTI=;
        b=ETgGfQPXuVkI2CFJCyB3ypQuRoR4kEiDT6433BX3WANxhoE9Dz1O8iTwvMUiKoRKAr
         fl1LMQ5opZrD2KuXqovHZCPkj0KbUD4E/MiprRBpwgBjPHWVTn6AXkftQ6idEbmuO0up
         76eLEa6OfJ1NW0/z7MCnqTrJ6RVR3BrmeU/Gr0rvERNatbgR4VEhyp608fd6tcCrnHNE
         /ny0OjDy23Bzh4GrFK3vvDdK7x0pl+L0BHJ9jqOjl4f4LodfUJGH1Evr2MgkBcpVHYAZ
         xo4XvlUy7FUKhSrcr8xB0cc3AQ77VegUkjjlCL5WB7V16W65pvE906/frlFVSLhIjcmc
         tZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yqB/IQjPU0JdPCGgeUmhzJaK+oHnrbiIoWKnKW7KTI=;
        b=fU6QZNeF1gtm0J4UU06CcQkE5B9TWKpzr2vzYy0DxteMnAIpz+IPZP05VhnUcm8Tdy
         ddfpD37GFTl31C7pb87R8mbiu+BNYIYTE1jaA7vA2X+61zZ8MGwY92/NtmtJx7dgC1SF
         3av2ieDhmFvKVNdbt5Skni3LL6dtQrxsys1/omdI0Y+PbAu61aIboWushwD5Ww+nbybq
         DmYtIKWnMxG42cjWVdzFCOboipY4mkrAlB+oT12vwvoFN303briaJ+Oz7REnShK9iicr
         y3wq/hqRzcpZEbLdLeFDLwFgvKWYh/f3AQtasRySzXleEhPuVTN0G+4+TXR0SGp71wQb
         ghqA==
X-Gm-Message-State: ANoB5pn3chOLdQTBq1EGE7NZCtBC63nFTGz5l8A4dAwHsIcrXwTcA3iL
        c/fC11EFiA1z6hOUXwXcmG/zb3xKcoFanw==
X-Google-Smtp-Source: AA0mqf51uwbwEoZgDNlu6QzGx1FNXgXF/tBKYz+Ludt33M1p/NR0c9R98EpVnHA5pRvkrOCeS/AZFA==
X-Received: by 2002:a05:600c:2252:b0:3d2:196c:270c with SMTP id a18-20020a05600c225200b003d2196c270cmr29159726wmm.31.1671540004291;
        Tue, 20 Dec 2022 04:40:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/9] submodule.c & submodule--helper: pass along "super_prefix" param
Date:   Tue, 20 Dec 2022 13:39:50 +0100
Message-Id: <patch-v5-3.9-3fb2a1b16cd-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
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
  died if this was provided, so it's safe to pass "NULL".

- deinit_submodule(): The "deinit_submodule()" function has never been
  able to use the "git -super-prefix". It will call
  "absorb_git_dir_into_superproject()", but it will only do so from the
  top-level project.

  If "absorbgitdirs" recurses will use the "path" passed to
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
index d4989d4d863..4a4aec0d00e 100644
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
index 05f2c9bc985..da844cad5ce 100644
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
index 8ac2fca855d..bf19598b8c2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2145,7 +2145,8 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (old_head) {
 			if (!submodule_uses_gitfile(path))
-				absorb_git_dir_into_superproject(path);
+				absorb_git_dir_into_superproject(path,
+								 get_super_prefix());
 		} else {
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
@@ -2315,7 +2316,8 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	strbuf_release(&new_gitdir);
 }
 
-static void absorb_git_dir_into_superproject_recurse(const char *path)
+static void absorb_git_dir_into_superproject_recurse(const char *path,
+						     const char *super_prefix)
 {
 
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -2323,8 +2325,8 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
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
@@ -2337,7 +2339,8 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
  * having its git directory within the working tree to the git dir nested
  * in its superprojects git dir under modules/.
  */
-void absorb_git_dir_into_superproject(const char *path)
+void absorb_git_dir_into_superproject(const char *path,
+				      const char *super_prefix)
 {
 	int err_code;
 	const char *sub_git_dir;
@@ -2386,7 +2389,7 @@ void absorb_git_dir_into_superproject(const char *path)
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
2.39.0.1071.g97ce8966538

