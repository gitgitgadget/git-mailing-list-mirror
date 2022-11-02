Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA715C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKBHy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKBHyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2F32610E
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 21so25178962edv.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgwdAoK4er9kojqN0MPtw6y+VWSBCJ5BhDqQA9/L0u8=;
        b=OlMZvEmr/Den2522baWKWsBi4kE3x7V0UpES2ltzr0DjrSR9QOT3zH8xRX9UGs+1rq
         InNnsUjso/f3M56If409GxsPXygmRR+pxrbItL16NDcQ7/GMaFg2seqxcOIke77jnQPn
         WD8hob1zj8X72lmPPVR8BGwoL4uKec0rS6BrF2ejFFmlEMOCQw8tx3Hntv/zmWLEd7UG
         016KxiMJ8BZ6ec1MbcvMKZTnd+2k3TAllU5Kxu+JuJKW5I5w4v6N6kEewKrrp3rT1hI0
         ekcKIaQu4fiC75cEFKK4cvmz9ExFPL0xhcm0EorpQb2V9DkdVdRGLgeFBDkuhzAYTgCD
         rfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgwdAoK4er9kojqN0MPtw6y+VWSBCJ5BhDqQA9/L0u8=;
        b=x+901JekMkAoZA7QatXRTWlAAnsuf75hvk9yM0Lx/h9KL2vSfo8TBdRRVeGLBJ7ss3
         rh2ynIu1vbg89LhL3DlZKZyT9ly4ZIipVIfpjfSj53vFjI06XDzrv5MFuyhZbEIwUcpT
         RJkK8usVf4+5F9Z+CZYzpSc8M6G8sAPg6kr2Useuk4SNFNl5IeO2BFxShjNbbN/L+m//
         d7/TKQMF6AkIgu6Ac0HLYks5I6jrKOkAcA5JFHsHO+rvJ+CKfYlpURf3YAczTQK3KIAi
         v3xVgSbzOG3MXrIuNLM+9r8kcXgrSk3nRMXI/3pxXQROy1z3Acf5DvMscayIQuHQFb5v
         /+yQ==
X-Gm-Message-State: ACrzQf0Ja9D7xfr8R/v+oLyeH/ztNLqKBwQccY3WYA+eMbyq7kaYZrc7
        40wan6iTHgjP9yQaVc4z+74DIG2QvsdK8Q==
X-Google-Smtp-Source: AMsMyM60rq3nwCR9r2oNGuUo001aRILK3ccYeqCrRhD63o3SXim3pNnD1syLDk7wjVKCZoairdDQbg==
X-Received: by 2002:a05:6402:f24:b0:461:7c77:98c4 with SMTP id i36-20020a0564020f2400b004617c7798c4mr22538996eda.80.1667375652823;
        Wed, 02 Nov 2022 00:54:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] submodule API & "absorbgitdirs": remove "----recursive" option
Date:   Wed,  2 Nov 2022 08:54:02 +0100
Message-Id: <patch-5.8-2b8afd73b9b-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "----recursive" option to "git submodule--helper
absorbgitdirs" (yes, with 4 dashes, not 2).

This option and all the "else" when "flags &
ABSORB_GITDIR_RECURSE_SUBMODULES" is false has never been used since
it was added in f6f85861400 (submodule: add absorb-git-dir function,
2016-12-12), which we'd have had to do as "----recursive", a
"--recursive" would have errored out.

It would be nice to follow-up with an optbug() assertion to
parse-options.c for such funnily named options, I manually validated
that this was the only long option whose name started with "-", but
let's skip adding such an assertion for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rm.c                |  3 +--
 builtin/submodule--helper.c |  8 ++------
 submodule.c                 | 13 +++----------
 submodule.h                 |  4 +---
 4 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index f0d025a4e23..05bfe20a469 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -86,8 +86,7 @@ static void submodules_absorb_gitdir_if_needed(void)
 			continue;
 
 		if (!submodule_uses_gitfile(name))
-			absorb_git_dir_into_superproject(name,
-				ABSORB_GITDIR_RECURSE_SUBMODULES);
+			absorb_git_dir_into_superproject(name);
 	}
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6250b95a6f7..8b4af8430dc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1378,8 +1378,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 					  ".git file by using absorbgitdirs."),
 					displaypath);
 
-			absorb_git_dir_into_superproject(path,
-							 ABSORB_GITDIR_RECURSE_SUBMODULES);
+			absorb_git_dir_into_superproject(path);
 
 		}
 
@@ -2830,13 +2829,10 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
-	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
 	struct option embed_gitdir_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_BIT(0, "--recursive", &flags, N_("recurse into submodules"),
-			ABSORB_GITDIR_RECURSE_SUBMODULES),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
@@ -2852,7 +2848,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 
 	for (i = 0; i < list.nr; i++)
-		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
+		absorb_git_dir_into_superproject(list.entries[i]->name);
 
 	ret = 0;
 cleanup:
diff --git a/submodule.c b/submodule.c
index fe1e3f03905..8fa2ad457b2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2139,8 +2139,7 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (old_head) {
 			if (!submodule_uses_gitfile(path))
-				absorb_git_dir_into_superproject(path,
-					ABSORB_GITDIR_RECURSE_SUBMODULES);
+				absorb_git_dir_into_superproject(path);
 		} else {
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
@@ -2332,8 +2331,7 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
  * having its git directory within the working tree to the git dir nested
  * in its superprojects git dir under modules/.
  */
-void absorb_git_dir_into_superproject(const char *path,
-				      unsigned flags)
+void absorb_git_dir_into_superproject(const char *path)
 {
 	int err_code;
 	const char *sub_git_dir;
@@ -2382,12 +2380,7 @@ void absorb_git_dir_into_superproject(const char *path,
 	}
 	strbuf_release(&gitdir);
 
-	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
-		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
-			BUG("we don't know how to pass the flags down?");
-
-		absorb_git_dir_into_superproject_recurse(path);
-	}
+	absorb_git_dir_into_superproject_recurse(path);
 }
 
 int get_superproject_working_tree(struct strbuf *buf)
diff --git a/submodule.h b/submodule.h
index 6a9fec6de11..b52a4ff1e73 100644
--- a/submodule.h
+++ b/submodule.h
@@ -164,9 +164,7 @@ void submodule_unset_core_worktree(const struct submodule *sub);
  */
 void prepare_submodule_repo_env(struct strvec *env);
 
-#define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
-void absorb_git_dir_into_superproject(const char *path,
-				      unsigned flags);
+void absorb_git_dir_into_superproject(const char *path);
 
 /*
  * Return the absolute path of the working tree of the superproject, which this
-- 
2.38.0.1280.g8136eb6fab2

