Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC968C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiKHOLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiKHOLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48085C748
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b2so38917341eja.6
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQBb3rLoIuqoFmPyQyCoIxLEZ4g1W/be0ZAAXXnp0JY=;
        b=PZQcBNXHJ3EE0Bpm5sC6RRxdJUuf/c0g1uCdOVuo2UKc+1diHZ3uSiOxyP2mqefzhl
         dl1U9hhr7GRQoftHqlxHEBn+5ZDRdRZGYZJoHBEqq55UZ6SlvKViUlc3fliJRetLhCG6
         cDNO9INK/nAHIPwJNfeOM6cqZX8chR1YMK65M58wlJz/qveBLeckjgH2hKWHbqSGJflg
         fdQShMPeBqt8eO5Rnr6OQ0Qw9DgtVMUsYk/VQeOkHBZu4j6vEQYfLOhLjP9R9jjTqWwY
         2EK4ogIDBchjUSauIi/tLs83b31QOIaihwA2RDQM3D71fgwJUUC8a7RCAU5qtzSi8wNr
         IEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQBb3rLoIuqoFmPyQyCoIxLEZ4g1W/be0ZAAXXnp0JY=;
        b=Sn81F2x2xahinckpQpBqmlk6evsYN1554WiF/J4CclGD9xr2IecCJ4JrJcCMDTTpGG
         o2xQMredQaXfa/3x1BRres/JvG13dka3tAG4GYmbCxLV1dodop+NJqTnGOeyZB8RmnuD
         MsydKjjm0VYcYFNa0HSrQW6rRn/QzEpf+eY1URpTaV7T1ocEcP3bBY/Ao0Eu7h10TEN1
         oHqpBD77AJjxumj603HS5MV65geewqSFCnywJQUNe4orSQ8v+xMZusDtADaWXCuTvOxi
         HbraYJKjeSgQOsSTXCGqZYs0RbWTx68XDJCA0IPh6v18GjD1lhZ+wLcYMQ2OjlclDfTC
         6bZA==
X-Gm-Message-State: ACrzQf0h92PCvq7SYol/2f+j4tV+T1tTvsUnKWaR59cxTjahWBzLDFdW
        R4zEFkx2478pFNOsVFkTg39GSYYNaF5Cpg==
X-Google-Smtp-Source: AA0mqf6FgkNw+rNiczraM550UyjosvtKXsFDXyuX9LpsW6Hs/OlVIhQ9D0w/Hnm8sYGYmittnxWJxA==
X-Received: by 2002:a17:906:5da5:b0:7ae:5b41:853d with SMTP id n5-20020a1709065da500b007ae5b41853dmr14214430ejv.600.1667916654488;
        Tue, 08 Nov 2022 06:10:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] submodule API & "absorbgitdirs": remove "----recursive" option
Date:   Tue,  8 Nov 2022 15:10:37 +0100
Message-Id: <patch-v2-6.9-322a02c30fc-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
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
index ee6f2d34cba..33f099dbc86 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1379,8 +1379,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 					  ".git file by using absorbgitdirs."),
 					displaypath);
 
-			absorb_git_dir_into_superproject(path,
-							 ABSORB_GITDIR_RECURSE_SUBMODULES);
+			absorb_git_dir_into_superproject(path);
 
 		}
 
@@ -2831,13 +2830,10 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
@@ -2853,7 +2849,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.38.0.1464.gea6794aacbc

