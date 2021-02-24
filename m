Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9766EC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4449F64E60
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBXEHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhBXEGp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:06:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2AAC061793
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:35 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v64so558469qtd.5
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nW9oN1R/EIiGKiZwIO8MN0lHdqz+uR5vXY9vLukJ1TA=;
        b=LqVQgjIEb7nOVW/YB6RMZoX7ykx3LDKTFKfiabL4vP8lfhEQg94FXPhXhSdAO0z6Az
         rbxTHiPk2uvZJC8LIuvbZZbsQU7NdbdyJa2ETCIpOoZXBih9R0oJaKhcCd9dxFNgonHI
         DnYuoR0+KNIo+MJ93UbqyyJwoxYEkKPsLesHGeosyvwiQYPAsEDcrjr4IlvL8lkGFv6s
         TvWNyCvZLNcFinObTg57z3fgkHRzBqCnzrvSGOHuLM+z476vWoWLMKAn6nVQNG1dKB/L
         0EOy45IZsJrHnErLkmy0CR9BdSiRSEWbcmxfGHnQH3PsTOHzpH5e6GMpEnyxraIFkn/v
         LmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nW9oN1R/EIiGKiZwIO8MN0lHdqz+uR5vXY9vLukJ1TA=;
        b=IxzvdFWwRN1FXAsm9BYtl3zP/iDKNczt0LmEH7K6Qy6YPeEcz+ydHuXh5pTkm8atsz
         3g35J9XinzO/3n8gFCp5vAbueSUsZi+QjfzsL8njiM54HSc0KSSnxbLVPAFY9ZsS4UJk
         5mGO4bLuwQg5iyDl8I9g5+1av5rXo5yBIB3eCpoSzG6+M1e2JjJkY5Sz10POduCkSybd
         1IqDxcoWr6xzuts0cTrAPSD9mfzh1YrZQM4toQY+mEgCZBWu3h+Jwt25B63du1fEjs0f
         4KEdg5QWsZ1IWhVYgoC3p5R3WuKZXZwAKvakxb5k9r2RUPFXmbd9Fh9SrS2i+mbNp6nV
         tUuQ==
X-Gm-Message-State: AOAM531yNWsBRN7+59rA4xXI9GmZwPGf3c/DwuBKYahFJGqvnCfGaDth
        RuDmo/oqna1JPdRwE6n7R4dfgPwo/u8uVQ==
X-Google-Smtp-Source: ABdhPJwA1jsIr/YhWEu8CyFbwkXWyhDtQfyffIzM42FdoJOwZlYay3P5LcSJMXXLE4r4U3S0JqwsWQ==
X-Received: by 2002:ac8:3aa5:: with SMTP id x34mr16832758qte.299.1614139534176;
        Tue, 23 Feb 2021 20:05:34 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z65sm547878qtd.15.2021.02.23.20.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:05:33 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
Date:   Wed, 24 Feb 2021 01:05:11 -0300
Message-Id: <24e889ca9b1cb0823d1663a60ce1e0ba9e55f875.1614138107.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git add` already refrains from updating SKIP_WORKTREE entries, but it
silently exits with zero code when a pathspec only matches these
entries. Instead, let's warn the user and display a hint on how to
update these entries.

Note that the warning is only shown if the pathspec matches no untracked
paths in the working tree and only matches index entries with the
SKIP_WORKTREE bit set. A warning message was chosen over erroring out
right away to reproduce the same behavior `add` already exhibits with
ignored files. This also allow users to continue their workflow without
having to invoke `add` again with only the matching pathspecs, as the
matched files will have already been added.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/advice.txt |  3 ++
 advice.c                        | 19 +++++++++
 advice.h                        |  4 ++
 builtin/add.c                   | 70 ++++++++++++++++++++++++-------
 pathspec.c                      | 15 +++++++
 pathspec.h                      |  8 ++++
 t/t3705-add-sparse-checkout.sh  | 73 +++++++++++++++++++++++++++++----
 7 files changed, 171 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index acbd0c09aa..d53eafa00b 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -119,4 +119,7 @@ advice.*::
 	addEmptyPathspec::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
+	updateSparsePath::
+		Advice shown if the pathspec given to linkgit:git-add[1] only
+		matches index entries outside the current sparse-checkout.
 --
diff --git a/advice.c b/advice.c
index 164742305f..cf22c1a6e5 100644
--- a/advice.c
+++ b/advice.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "color.h"
 #include "help.h"
+#include "string-list.h"
 
 int advice_fetch_show_forced_updates = 1;
 int advice_push_update_rejected = 1;
@@ -136,6 +137,7 @@ static struct {
 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
+	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
 };
 
@@ -284,6 +286,23 @@ void NORETURN die_conclude_merge(void)
 	die(_("Exiting because of unfinished merge."));
 }
 
+void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
+{
+	struct string_list_item *item;
+
+	if (!pathspec_list->nr)
+		return;
+
+	fprintf(stderr, _("The following pathspecs only matched index entries outside the current\n"
+			  "sparse checkout:\n"));
+	for_each_string_list_item(item, pathspec_list)
+		fprintf(stderr, "%s\n", item->string);
+
+	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
+			  _("Disable or modify the sparsity rules if you intend to update such entries."));
+
+}
+
 void detach_advice(const char *new_name)
 {
 	const char *fmt =
diff --git a/advice.h b/advice.h
index bc2432980a..bd26c385d0 100644
--- a/advice.h
+++ b/advice.h
@@ -3,6 +3,8 @@
 
 #include "git-compat-util.h"
 
+struct string_list;
+
 extern int advice_fetch_show_forced_updates;
 extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
@@ -71,6 +73,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	ADVICE_UPDATE_SPARSE_PATH,
 	ADVICE_WAITING_FOR_EDITOR,
 };
 
@@ -92,6 +95,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...);
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
+void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 
 #endif /* ADVICE_H */
diff --git a/builtin/add.c b/builtin/add.c
index e15b25a623..fde6462850 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -177,24 +177,43 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen, 1);
 	return seen;
 }
 
-static void refresh(int verbose, const struct pathspec *pathspec)
+static int refresh(int verbose, const struct pathspec *pathspec)
 {
 	char *seen;
-	int i;
+	int i, ret = 0;
+	char *skip_worktree_seen = NULL;
+	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
+	int flags = REFRESH_DONT_MARK_SPARSE_MATCHES |
+		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
 
 	seen = xcalloc(pathspec->nr, 1);
-	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
-		      pathspec, seen, _("Unstaged changes after refreshing the index:"));
+	refresh_index(&the_index, flags, pathspec, seen,
+		      _("Unstaged changes after refreshing the index:"));
 	for (i = 0; i < pathspec->nr; i++) {
-		if (!seen[i])
-			die(_("pathspec '%s' did not match any files"),
-			    pathspec->items[i].original);
+		if (!seen[i]) {
+			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
+				string_list_append(&only_match_skip_worktree,
+						   pathspec->items[i].original);
+			} else {
+				die(_("pathspec '%s' did not match any files"),
+				    pathspec->items[i].original);
+			}
+		}
+	}
+
+	if (only_match_skip_worktree.nr) {
+		advise_on_updating_sparse_paths(&only_match_skip_worktree);
+		ret = 1;
 	}
+
 	free(seen);
+	free(skip_worktree_seen);
+	string_list_clear(&only_match_skip_worktree, 0);
+	return ret;
 }
 
 int run_add_interactive(const char *revision, const char *patch_mode,
@@ -570,15 +589,17 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	if (refresh_only) {
-		refresh(verbose, &pathspec);
+		exit_status |= refresh(verbose, &pathspec);
 		goto finish;
 	}
 
 	if (pathspec.nr) {
 		int i;
+		char *skip_worktree_seen = NULL;
+		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 1);
 
 		/*
 		 * file_exists() assumes exact match
@@ -592,12 +613,24 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < pathspec.nr; i++) {
 			const char *path = pathspec.items[i].match;
+
 			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
 				continue;
-			if (!seen[i] && path[0] &&
-			    ((pathspec.items[i].magic &
-			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
-			     !file_exists(path))) {
+			if (seen[i])
+				continue;
+
+			if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
+				string_list_append(&only_match_skip_worktree,
+						   pathspec.items[i].original);
+				continue;
+			}
+
+			/* Don't complain at 'git add .' inside empty repo. */
+			if (!path[0])
+				continue;
+
+			if ((pathspec.items[i].magic & (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
+			    !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
 					if (is_excluded(&dir, &the_index, path, &dtype))
@@ -608,7 +641,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 					    pathspec.items[i].original);
 			}
 		}
+
+
+		if (only_match_skip_worktree.nr) {
+			advise_on_updating_sparse_paths(&only_match_skip_worktree);
+			exit_status = 1;
+		}
+
 		free(seen);
+		free(skip_worktree_seen);
+		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
 	plug_bulk_checkin();
diff --git a/pathspec.c b/pathspec.c
index e5e6b7458d..61f294fed5 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -62,6 +62,21 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 	return seen;
 }
 
+char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
+{
+	struct index_state *istate = the_repository->index;
+	char *seen = xcalloc(pathspec->nr, 1);
+	int i;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (ce_skip_worktree(ce))
+		    ce_path_match(istate, ce, pathspec, seen);
+	}
+
+	return seen;
+}
+
 /*
  * Magic pathspec
  *
diff --git a/pathspec.h b/pathspec.h
index 8202882ecd..f591ba625c 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -155,6 +155,14 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 					    const struct index_state *istate,
 					    int ignore_skip_worktree);
+char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec);
+static inline int matches_skip_worktree(const struct pathspec *pathspec,
+					int item, char **seen_ptr)
+{
+	if (!*seen_ptr)
+		*seen_ptr = find_pathspecs_matching_skip_worktree(pathspec);
+	return (*seen_ptr)[item];
+}
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 6781620297..fdfd8b085e 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -36,10 +36,26 @@ setup_gitignore () {
 	EOF
 }
 
+test_expect_success 'setup' '
+	cat >sparse_error_header <<-EOF &&
+	The following pathspecs only matched index entries outside the current
+	sparse checkout:
+	EOF
+
+	cat >sparse_hint <<-EOF &&
+	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable this message with "git config advice.updateSparsePath false"
+	EOF
+
+	echo sparse_entry | cat sparse_error_header - >sparse_entry_error &&
+	cat sparse_entry_error sparse_hint >error_and_hint
+'
+
 test_expect_success 'git add does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
-	git add sparse_entry &&
+	test_must_fail git add sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
 
@@ -47,7 +63,8 @@ test_expect_success 'git add -A does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	setup_gitignore &&
-	git add -A &&
+	git add -A 2>stderr &&
+	test_must_be_empty stderr &&
 	test_sparse_entry_unchanged
 '
 
@@ -55,7 +72,13 @@ test_expect_success 'git add . does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	setup_gitignore &&
-	git add . &&
+	test_must_fail git add . 2>stderr &&
+
+	cat sparse_error_header >expect &&
+	echo . >>expect &&
+	cat sparse_hint >>expect &&
+
+	test_i18ncmp expect stderr &&
 	test_sparse_entry_unchanged
 '
 
@@ -64,7 +87,8 @@ do
 	test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
 		setup_sparse_entry &&
 		echo modified >sparse_entry &&
-		git add $opt sparse_entry &&
+		test_must_fail git add $opt sparse_entry 2>stderr &&
+		test_i18ncmp error_and_hint stderr &&
 		test_sparse_entry_unchanged
 	'
 done
@@ -73,14 +97,16 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	setup_sparse_entry &&
 	git ls-files --debug sparse_entry | grep mtime >before &&
 	test-tool chmtime -60 sparse_entry &&
-	git add --refresh sparse_entry &&
+	test_must_fail git add --refresh sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	git ls-files --debug sparse_entry | grep mtime >after &&
 	test_cmp before after
 '
 
 test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
-	git add --chmod=+x sparse_entry &&
+	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	test_sparse_entry_unchanged &&
 	! test -x sparse_entry
 '
@@ -89,8 +115,41 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
 	test_config core.autocrlf false &&
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
-	git add --renormalize sparse_entry &&
+	test_must_fail git add --renormalize sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
 
+test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
+	setup_sparse_entry &&
+	rm sparse_entry &&
+	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
+	test_sparse_entry_unchanged
+'
+
+test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
+	setup_sparse_entry &&
+	test_must_fail git add nonexistent 2>stderr &&
+	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
+	test_i18ngrep ! "The following pathspecs only matched index entries" stderr
+'
+
+test_expect_success 'do not warn when pathspec matches dense entries' '
+	setup_sparse_entry &&
+	echo modified >sparse_entry &&
+	>dense_entry &&
+	git add "*_entry" 2>stderr &&
+	test_must_be_empty stderr &&
+	test_sparse_entry_unchanged &&
+	git ls-files --error-unmatch dense_entry
+'
+
+test_expect_success 'add obeys advice.updateSparsePath' '
+	setup_sparse_entry &&
+	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
+	test_i18ncmp sparse_entry_error stderr
+
+'
+
 test_done
-- 
2.30.1

