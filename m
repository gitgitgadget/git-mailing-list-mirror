Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D6C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EE5611AE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhKFVNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhKFVNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207DC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u1so19514197wru.13
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEHyRhFT8HmnE16zg3Z0Mb5dOUWkUQn2mOrRL2WD5OI=;
        b=ItGEHBjWdhfjl0gLGWfApPHpUhyvJFpDVzVxtWk50ucuOfcrNIHICrBNjsL+voF/0r
         oZXAWdM3i4YuULUhFnkLjUPe86fzpxvVTrWBsasF+aNwlmlgMMZMIaowaKjn42eDSy4s
         2uFFWDQjZnsW1NcGYhhgD+xGLyonez8ZH68uyhvDmaLf9/l4xjHbI8p0VxdhQtfzXpdQ
         Gh+KHS+8XR5rTcxEVMn39BrivxExuSvXprmA4Dal0mbYh6yO3hu+q/hOjhMILXgobZXu
         ZUwB0vqmHA7qjMXX22DZVE5IYGXGp9v6/Tc0hOrb0P9aQ1F8kSC5th5pmBwPnd1me42+
         HvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEHyRhFT8HmnE16zg3Z0Mb5dOUWkUQn2mOrRL2WD5OI=;
        b=kG7ZfGnRymHCk/8B4cuTSM+vVBA5u8NBm4zo/BgsJlWbsbAo+VOPmMrhn4zzD3lxLN
         CmvG51haQ+Io2UiisQ1l32QbUV9vyawG7wr8AJXaq5zoG/1t0IZDE4uZj/WOuKK4rdN5
         XHkuZMy8WK+N8jCUmh4oxaHrjiFD0k6hpyTZrDzh4umThojiiE51a5COLKnzritv5wER
         BvDFfSs7GZUu4EBCxaJKhjX4PB7sDT+UXXLD9hAfl4VyFwfaosOvEUjKmGt4/MgvjUmB
         fuX8pRU3YxEh9pKk0lu1lOYjVJtvsWu+9exWA/j0w8265bmMs1hFY1YQ0r73BqF8Q2Rz
         1vjg==
X-Gm-Message-State: AOAM5316iF02UGQCLg1SqPB4azxsXJNysLTw0neZ0dZtvAxSp1efR2Et
        r8loetwp9lrDltRQ+l9gqhhnIT2mGrl2+Q==
X-Google-Smtp-Source: ABdhPJyN5t0ASoj400+6G7+Go2J6gZ3xrJoNnUrjlozmbZK6lMOJnUxAGjKBO4/f0nILpHlhgXP8xA==
X-Received: by 2002:a05:6000:2af:: with SMTP id l15mr88020020wry.296.1636233062615;
        Sat, 06 Nov 2021 14:11:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:11:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] grep.c: move "prefix" out of "struct grep_opt"
Date:   Sat,  6 Nov 2021 22:10:50 +0100
Message-Id: <patch-4.8-78298657d69-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct grep_opt" is a mixture of things that would be needed by
all callers of the grep.c API, and quite a few things that only the
builtin/grep.c needs.

Since we got rid of "prefix_length" in the previous commit, let's move
the "prefix" variable over to "builtin/grep.c" where it's used. To do
this let's create a "struct grep_cmd_opt", which we'll have a pointer
to in a new "caller_priv" member in "struct grep_opt" (the existing
"priv" is used by the top-level "grep.c" itself).

We might eventually need to have grep_opt_dup() learn about this new
member, but since the prefix can be a "const char *const" (i.e. we
never change it in any way) let's leave that aside for now, in any
case "builtin/grep.c" is the only user of grep_opt_dup(), even though
it lives in the top-level "grep.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 17 ++++++++++++-----
 grep.c         |  3 +--
 grep.h         |  4 ++--
 revision.c     |  2 +-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index bd4d2107351..960c7aac123 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -37,6 +37,10 @@ static int num_threads;
 
 static pthread_t *threads;
 
+struct grep_cmd_opt {
+	const char *const prefix;
+};
+
 /* We use one producer thread and THREADS consumer
  * threads. The producer adds struct work_items to 'todo' and the
  * consumers pick work items from the same array.
@@ -312,14 +316,15 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 static void grep_source_name(struct grep_opt *opt, const char *filename,
 			     int tree_name_len, struct strbuf *out)
 {
+	struct grep_cmd_opt *opt_cmd = opt->caller_priv;
 	strbuf_reset(out);
 
 	if (opt->null_following_name) {
-		if (opt->relative && opt->prefix) {
+		if (opt->relative && opt_cmd->prefix) {
 			struct strbuf rel_buf = STRBUF_INIT;
 			const char *rel_name =
 				relative_path(filename + tree_name_len,
-					      opt->prefix, &rel_buf);
+					      opt_cmd->prefix, &rel_buf);
 
 			if (tree_name_len)
 				strbuf_add(out, filename, tree_name_len);
@@ -332,8 +337,8 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 		return;
 	}
 
-	if (opt->relative && opt->prefix)
-		quote_path(filename + tree_name_len, opt->prefix, out, 0);
+	if (opt->relative && opt_cmd->prefix)
+		quote_path(filename + tree_name_len, opt_cmd->prefix, out, 0);
 	else
 		quote_c_style(filename + tree_name_len, out, NULL, 0);
 
@@ -837,6 +842,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int external_grep_allowed__ignored;
 	const char *show_in_pager = NULL, *default_pager = "dummy";
 	struct grep_opt opt;
+	struct grep_cmd_opt opt_cmd = { .prefix = prefix };
 	struct object_array list = OBJECT_ARRAY_INIT;
 	struct pathspec pathspec;
 	struct string_list path_list = STRING_LIST_INIT_DUP;
@@ -964,7 +970,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(grep_cmd_config, NULL);
-	grep_init(&opt, the_repository, prefix);
+	grep_init(&opt, the_repository);
+	opt.caller_priv = &opt_cmd;
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/grep.c b/grep.c
index 755afb5f96d..c9065254aeb 100644
--- a/grep.c
+++ b/grep.c
@@ -139,12 +139,11 @@ int grep_config(const char *var, const char *value, void *cb)
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
  */
-void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
+void grep_init(struct grep_opt *opt, struct repository *repo)
 {
 	*opt = grep_defaults;
 
 	opt->repo = repo;
-	opt->prefix = prefix;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 }
diff --git a/grep.h b/grep.h
index 467d775b5a9..6b923d8599c 100644
--- a/grep.h
+++ b/grep.h
@@ -134,7 +134,6 @@ struct grep_opt {
 	 */
 	struct repository *repo;
 
-	const char *prefix;
 	int linenum;
 	int columnnum;
 	int invert;
@@ -172,6 +171,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	void *caller_priv;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -179,7 +179,7 @@ struct grep_opt {
 };
 
 int grep_config(const char *var, const char *value, void *);
-void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void grep_init(struct grep_opt *, struct repository *repo);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index ab7c1358042..9f9b0d2429e 100644
--- a/revision.c
+++ b/revision.c
@@ -1833,7 +1833,7 @@ void repo_init_revisions(struct repository *r,
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	grep_init(&revs->grep_filter, revs->repo, prefix);
+	grep_init(&revs->grep_filter, revs->repo);
 	revs->grep_filter.status_only = 1;
 
 	repo_diff_setup(revs->repo, &revs->diffopt);
-- 
2.34.0.rc1.741.gab7bfd97031

