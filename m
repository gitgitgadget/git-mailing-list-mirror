Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E221FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbcLHVEL (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:11 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34564 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so85290871pfb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eGdxzw+Rx08xPue+wNXucAhmrRgKxf1AgpaS5W26qZo=;
        b=ItsMOXO9RIUb9XvUzj85o6lc3U72JVOtmKgrT2thvCs5FIQAGnWMUKdIUOx5hfxAPa
         nHDlQdb5lhtAAz0TmHQc1zeWKuFyXVfhJRRwF1W9l8ebtH1Rs3CYFddPsCZYbiv+fENQ
         hzQVyTiONSxQNeP1zeLBfnsCyj0FPwVYWQaV+7/mZ6FANwJv/vIQ/ZTLL9llBIc6lEX6
         1KtcFDAVnOZj2CY16ox/sWN7qglGU+EhO49BSzV+moQia43WCaelzZOyGiM2XkdiUjmS
         I+0pwdaJKxBQMBzrHAOkh6M5GUyF/3s5fqgrYr/Wl5NATbhU6///nx3zarRZpUQgASuA
         x9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eGdxzw+Rx08xPue+wNXucAhmrRgKxf1AgpaS5W26qZo=;
        b=cVsuCgw6PC3Rh+HmDWcJjQx6tujuAkI8VHUnNuzHTzy31qsW0kOhsw94zCl3kLunfa
         uxsltb7SGHZgN74D2cWZ2wzZPkUpVRnnfL4mIMsU67FtpGwreJr4C4U+ZBC/0PyRWNlr
         sqfb7s1LVh3/FO4j36q5b9bR7Ny99tpZXwnxRHC9S7HxmJCef7XK4uBBL4S7wbUrDi0M
         jRdorhZskK+PRzmnCOgbqirye/+kR5D5iHWm3uGG8Bn+ZtPbU3QL3LyMhM73GKGFWpcf
         hOJLAgtuz7F6Q7dNlfv4Yagpkfoz7ughN4v9OPJHtKNynL8Wya7nt4QADVTQ5y5wHxJo
         Yzrw==
X-Gm-Message-State: AKaTC00pq+TgmQWo9LYFzBi0PaeoxYkbU/MR3/QJ2L/79dSA5trS7EAdhuLs6JCfLpHXT1vO
X-Received: by 10.99.114.89 with SMTP id c25mr133615309pgn.4.1481231018741;
        Thu, 08 Dec 2016 13:03:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id i76sm52133484pfk.89.2016.12.08.13.03.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 5/6] move connect_work_tree_and_git_dir to dir.h
Date:   Thu,  8 Dec 2016 13:03:28 -0800
Message-Id: <20161208210329.12919-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
In-Reply-To: <20161208210329.12919-1-sbeller@google.com>
References: <20161208210329.12919-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That function was primarily used by submodule code, but the function
itself is not inherently about submodules. In the next patch we'll
introduce relocate_git_dir, which can be used by worktrees as well,
so find a neutral middle ground in dir.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 dir.c       | 25 +++++++++++++++++++++++++
 dir.h       |  1 +
 submodule.c | 25 -------------------------
 submodule.h |  1 -
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a9a5..e0efd3c2c3 100644
--- a/dir.c
+++ b/dir.c
@@ -2748,3 +2748,28 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/* Update gitfile and core.worktree setting to connect work tree and git dir */
+void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
+{
+	struct strbuf file_name = STRBUF_INIT;
+	struct strbuf rel_path = STRBUF_INIT;
+	char *git_dir = xstrdup(real_path(git_dir_));
+	char *work_tree = xstrdup(real_path(work_tree_));
+
+	/* Update gitfile */
+	strbuf_addf(&file_name, "%s/.git", work_tree);
+	write_file(file_name.buf, "gitdir: %s",
+		   relative_path(git_dir, work_tree, &rel_path));
+
+	/* Update core.worktree setting */
+	strbuf_reset(&file_name);
+	strbuf_addf(&file_name, "%s/config", git_dir);
+	git_config_set_in_file(file_name.buf, "core.worktree",
+			       relative_path(work_tree, git_dir, &rel_path));
+
+	strbuf_release(&file_name);
+	strbuf_release(&rel_path);
+	free(work_tree);
+	free(git_dir);
+}
diff --git a/dir.h b/dir.h
index 97c83bb383..051674a431 100644
--- a/dir.h
+++ b/dir.h
@@ -335,4 +335,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 #endif
diff --git a/submodule.c b/submodule.c
index d4f7afe2f1..0bb50b4b62 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1222,31 +1222,6 @@ int merge_submodule(unsigned char result[20], const char *path,
 	return 0;
 }
 
-/* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
-{
-	struct strbuf file_name = STRBUF_INIT;
-	struct strbuf rel_path = STRBUF_INIT;
-	char *git_dir = xstrdup(real_path(git_dir_));
-	char *work_tree = xstrdup(real_path(work_tree_));
-
-	/* Update gitfile */
-	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, work_tree, &rel_path));
-
-	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(work_tree, git_dir, &rel_path));
-
-	strbuf_release(&file_name);
-	strbuf_release(&rel_path);
-	free(work_tree);
-	free(git_dir);
-}
-
 int parallel_submodules(void)
 {
 	return parallel_jobs;
diff --git a/submodule.h b/submodule.h
index d9e197a948..4e3bf469b4 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,7 +65,6 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
 /*
-- 
2.11.0.rc2.29.g7c00390.dirty

