Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60537C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiKHSTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiKHSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E578220D3
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so40765245ejb.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzC3dPCJpD86DM0C/Ni5xaRFcGfmv2GZxfHJhBt49TQ=;
        b=aozJGNwV7+hi0tw21ZDmww2u+WHuulZDEMyku+beKWaDbbXHzKUpqgEhCwTxSxgUhq
         M/qnAR0AInIFkyLFwsn0sCgJ/D8rzAYWFLoSdN0xqCKMG53Gkjv89X8MBGSlIW6oBzXM
         nYMY1G8cjQQ2WoUkaBYCml3RV0JpFx/FtVxM9eI0OezYroU2+ohwnKDRQB73LXRGkIQx
         pSJjchv9GeN5U4ZP/oToNymHC1Y6p4LzPsssaFjD0c5C1QlSW5SjeCjHOcTF4X2tCXLx
         +5I9H1xabBMBCw8fAMdaMEy+CBqOphVc20sZhnQdhHYL25MTJbUN7q1fUYBrcNp9Z95I
         evSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzC3dPCJpD86DM0C/Ni5xaRFcGfmv2GZxfHJhBt49TQ=;
        b=lRx3V7GgvKcw0wCH79fS6EEXQ71FZ/kFiyl8H0jMCKvhiA8b1UVEVWvSwzD4SVJggP
         xNiJuOjXTGGtXhXKL40VKnjseZa4uiqqiyk0nHxKLDCudAN7u+FikeZ3Ycee8mwtXNdj
         nn6S2/JU3gsSX+D4CYO6lkj3/2gsO2xY10ZlHhi3VyhrwWgI5t2Z82HTcBuXMbIXaqsR
         IMwLveMqxSWx0jbpolo6tzYVya+vhAx637Ck6sTJV/PPOpFS4pBpo7qHJTLaTrWgI3vC
         EPvW0DWX8MCZxpJ2tUrMKP7PGpBb/7O6fpeXynIWz6THnTwy2GN/vneKklj5Ou4vJ7NZ
         Yppg==
X-Gm-Message-State: ACrzQf1y4C2HGzzkmcj7a2khwBsA4YCtR+8p0R4rfKrVAuq8hf8qx8QF
        9hyijn8TVBbfE7AnMBT9GI8ROl1rXGNxDg==
X-Google-Smtp-Source: AMsMyM5ntMzNZ1IcxVzbcpHbkESuapkPTjGXVmzL63Y9hYNbHUDcquZtVAoaALIA/a89mQ3/J2BUbQ==
X-Received: by 2002:a17:907:75fc:b0:7aa:e0b3:270 with SMTP id jz28-20020a17090775fc00b007aae0b30270mr52386160ejc.680.1667931486557;
        Tue, 08 Nov 2022 10:18:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/15] built-ins: use free() not UNLEAK() if trivial, rm dead code
Date:   Tue,  8 Nov 2022 19:17:51 +0100
Message-Id: <patch-v2-15.15-f3e6a030394-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a lot of uses of UNLEAK() it would be quite tricky to release the
memory involved, or we're missing the relevant *_(release|clear)()
functions. But in these cases we have them already, and can just
invoke them on the variable(s) involved, instead of UNLEAK().

For "builtin/worktree.c" the UNLEAK() was also added in [1], but the
struct member it's unleaking was removed in [2]. The only non-"int"
member of that structure is "const char *keep_locked", which comes to
us via "argv" or a string literal[3].

We have good visibility via the compiler and
tooling (e.g. SANITIZE=address) on bad free()-ing, but none on
UNLEAK() we don't need anymore. So let's prefer releasing the memory
when it's easy.

For "bugreport", "worktree" and "config" we need to start using a "ret
= ..." return pattern. For "builtin/bugreport.c" these UNLEAK() were
added in [4], and for "builtin/config.c" in [1].

For "config" the code seen here was the only user of the "value"
variable. For "ACTION_{RENAME,REMOVE}_SECTION" we need to be sure to
return the right exit code in the cases where we were relying on
falling through to the top-level.

I think there's still a use-case for UNLEAK(), but hat it's changed
since then. Using it so that "we can see the real leaks" is
counter-productive in these cases.

It's more useful to have UNLEAK() be a marker of the remaining odd
cases where it's hard to free() the memory for whatever reason. With
this change less than 20 of them remain in-tree.

1. 0e5bba53af7 (add UNLEAK annotation for reducing leak false
   positives, 2017-09-08)
2. d861d34a6ed (worktree: remove extra members from struct add_opts,
   2018-04-24)
3. 0db4961c49b (worktree: teach `add` to accept --reason <string> with
  --lock, 2021-07-15)
4. 0e5bba53af7 and 00d8c311050 (commit: fix "author_ident" leak,
   2022-05-12).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c       |  2 +-
 builtin/bugreport.c |  9 ++++++---
 builtin/commit.c    |  6 +++---
 builtin/config.c    | 42 ++++++++++++++++++++----------------------
 builtin/diff.c      |  2 +-
 builtin/worktree.c  |  7 ++++---
 6 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f84372964c8..c68ebafed5e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -695,6 +695,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("Unable to write new index file"));
 
 	dir_clear(&dir);
-	UNLEAK(pathspec);
+	clear_pathspec(&pathspec);
 	return exit_status;
 }
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 96052541cbf..5bc254be80f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -106,6 +106,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
 	size_t output_path_len;
+	int ret;
 
 	const struct option bugreport_options[] = {
 		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
@@ -182,7 +183,9 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		user_relative_path);
 
 	free(prefixed_filename);
-	UNLEAK(buffer);
-	UNLEAK(report_path);
-	return !!launch_editor(report_path.buf, NULL, NULL);
+	strbuf_release(&buffer);
+
+	ret = !!launch_editor(report_path.buf, NULL, NULL);
+	strbuf_release(&report_path);
+	return ret;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index c291199b704..f88a29167f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1874,8 +1874,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	apply_autostash(git_path_merge_autostash(the_repository));
 
 cleanup:
-	UNLEAK(author_ident);
-	UNLEAK(err);
-	UNLEAK(sb);
+	strbuf_release(&author_ident);
+	strbuf_release(&err);
+	strbuf_release(&sb);
 	return ret;
 }
diff --git a/builtin/config.c b/builtin/config.c
index 753e5fac297..060cf9f3e05 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -639,8 +639,9 @@ static char *default_user_config(void)
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
-	char *value;
+	char *value = NULL;
 	int flags = 0;
+	int ret = 0;
 
 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
@@ -856,44 +857,38 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		free(config_file);
 	}
 	else if (actions == ACTION_SET) {
-		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		UNLEAK(value);
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
-		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		UNLEAK(value);
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value, argv[2],
-							      flags);
+		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], value, argv[2],
+							     flags);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		UNLEAK(value);
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value,
-							      CONFIG_REGEX_NONE,
-							      flags);
+		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], value,
+							     CONFIG_REGEX_NONE,
+							     flags);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		UNLEAK(value);
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value, argv[2],
-							      flags | CONFIG_FLAGS_MULTI_REPLACE);
+		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], value, argv[2],
+							     flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -934,26 +929,28 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
-		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
 			return ret;
-		if (ret == 0)
+		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
+		else
+			ret = 0;
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
-		int ret;
 		check_write();
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
 			return ret;
-		if (ret == 0)
+		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
+		else
+			ret = 0;
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
@@ -966,5 +963,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return get_colorbool(argv[0], argc == 2);
 	}
 
-	return 0;
+	free(value);
+	return ret;
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index 854d2c5a5c4..cb63f157dd1 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -609,7 +609,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	release_revisions(&rev);
-	UNLEAK(ent);
+	object_array_clear(&ent);
 	UNLEAK(blob);
 	return result;
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4a24d53be15..591d659faea 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -629,6 +629,7 @@ static int add(int ac, const char **av, const char *prefix)
 			 N_("try to match the new branch name with a remote-tracking branch")),
 		OPT_END()
 	};
+	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
@@ -705,9 +706,9 @@ static int add(int ac, const char **av, const char *prefix)
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
 
-	UNLEAK(path);
-	UNLEAK(opts);
-	return add_worktree(path, branch, &opts);
+	ret = add_worktree(path, branch, &opts);
+	free(path);
+	return ret;
 }
 
 static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
-- 
2.38.0.1467.g709fbdff1a9

