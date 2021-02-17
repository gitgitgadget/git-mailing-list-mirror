Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F6C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62A964E6C
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhBQVEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhBQVEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:04:01 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF651C06178B
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:50 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o21so10647376qtr.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTFJ70JTy4mtEe2oYpH5DrjWnZPMuMmeBWJI1tKb/h4=;
        b=RXTzKd8iVy8YUNfKL1YbZdUGVl1XlAoLYrtcLZcuur18Muf6/tIKd+20mvBXS1etAH
         mKZC/e6BaEbxB5Vs/KXKLaHux0fPYf+Wl77UbWPuZMS2oxAuFHOwFs3uVfXHBU33hJU1
         OGDo2FwlawVTI7cLMWQ701mjegfN2JDXc7abT+Al0uRewVk8BNOymBPv0WDh1JQCMBp2
         JC8tRkaAF6JHQl26d3d72LGK7mJEYWyFd4PdkPycMVvgnDpFuj36JDyO1OrjdN7pR9IL
         b6iTThFTtfu3OSB45FsMRwq9Zmt1MqHMZs9N6yOpLqCUGv+5QWToPf7G7d7THWpzpEXG
         DBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTFJ70JTy4mtEe2oYpH5DrjWnZPMuMmeBWJI1tKb/h4=;
        b=r9S28F4NNxVRWsNdNX4YUARTREl6FmirW7yEukCBvERQ1an+effGbGA5uQDSBn0xE1
         q+3qEaU5AGDVwQZSZuMfWTuF8wn6eOZXzz1iYrON2ANKL1M1RhftaB+CwnV+kky3ad+O
         ZxxhW1l+MvOPqRos6VbQGHkRzLiMO+FOPE/NsfDcRHgb2U0YsgRssMmIOd+Yhw/Js9mN
         AUUJDCqPlKH5mEScvssTbW0ES+QYTEdYJrEGVQWsqfeW+arxYrOE+O/tUTr4X4jKlBIN
         amrJbIz/+pXXlPDp0PYH2D67L4Ud4OFiaVxhoE59YXZtB5qoI3PZSyrcc0E0vZ82ad1g
         8X2g==
X-Gm-Message-State: AOAM530nfDACvdgxrelq5Tt2gHzmOjwgGzpnU3tXUeF25mDeJWwBpu7p
        QHHTURNSxdHlSsJGe2tcGgFVO+d0lDyC7Q==
X-Google-Smtp-Source: ABdhPJzeKZzuS/UtyexWlc4EbAcsOfdA4WLANlV/69Fnqy9McdPbBXusTd8PvUkO5BW97RcW2NSBjA==
X-Received: by 2002:ac8:5ad4:: with SMTP id d20mr1210803qtd.224.1613595769123;
        Wed, 17 Feb 2021 13:02:49 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:48 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
Date:   Wed, 17 Feb 2021 18:02:29 -0300
Message-Id: <8f1bc014ae8a34c0bc43d1a2b8c0ebdbe7e47e02.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git add` already refrains from updating SKIP_WORKTREE entries, but it
silently succeeds when a pathspec only matches these entries. Instead,
let's warn the user and display a hint on how to update these entries.

Note that the warning is only shown if the pathspec matches no untracked
paths in the working tree and only matches index entries with the
SKIP_WORKTREE bit set. Performance-wise, this patch doesn't change the
number of ce_path_match() calls in the worst case scenario (because we
still need to check the sparse entries for the warning). But in the
general case, it avoids unnecessarily calling this function for each
SKIP_WORKTREE entry.

A warning message was chosen over erroring out right away to reproduce
the same behavior `add` already exhibits with ignored files. This also
allow users to continue their workflow without having to invoke `add`
again with only the matching pathspecs, as the matched files will have
already been added.

Note: refresh_index() was changed to only mark matches with
no-SKIP-WORKTREE entries in the `seen` output parameter. This is exactly
the behavior we want for `add`, and only `add` calls this function with
a non-NULL `seen` pointer. So the change brings no side effect on
other callers.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/advice.txt |  3 ++
 advice.c                        | 19 +++++++++++
 advice.h                        |  4 +++
 builtin/add.c                   | 60 ++++++++++++++++++++++++++-------
 pathspec.c                      | 15 +++++++++
 pathspec.h                      |  8 +++++
 read-cache.c                    |  3 +-
 t/t3705-add-sparse-checkout.sh  | 40 +++++++++++++++++++---
 8 files changed, 134 insertions(+), 18 deletions(-)

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
index 9f0f6ebaff..b556c566c3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -170,24 +170,41 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
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
 
 	seen = xcalloc(pathspec->nr, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
 		      pathspec, seen, _("Unstaged changes after refreshing the index:"));
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
@@ -563,15 +580,17 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
@@ -585,12 +604,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < pathspec.nr; i++) {
 			const char *path = pathspec.items[i].match;
+
 			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
 				continue;
-			if (!seen[i] && path[0] &&
-			    ((pathspec.items[i].magic &
-			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
-			     !file_exists(path))) {
+			if (seen[i] || !path[0])
+				continue;
+
+			if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
+				string_list_append(&only_match_skip_worktree,
+						   pathspec.items[i].original);
+				continue;
+			}
+
+			if ((pathspec.items[i].magic & (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
+			    !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
 					if (is_excluded(&dir, &the_index, path, &dtype))
@@ -601,7 +628,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
diff --git a/read-cache.c b/read-cache.c
index 29144cf879..cbede4ada3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1546,7 +1546,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
+		if (pathspec && !ce_path_match(istate, ce, pathspec,
+					       ce_skip_worktree(ce) ? NULL : seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index f7b0ea782e..f66d369bf4 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -32,10 +32,22 @@ test_sparse_entry_unchanged() {
 	test_cmp expected actual
 }
 
+cat >sparse_entry_error <<-EOF
+The following pathspecs only matched index entries outside the current
+sparse checkout:
+sparse_entry
+EOF
+
+cat >error_and_hint sparse_entry_error - <<-EOF
+hint: Disable or modify the sparsity rules if you intend to update such entries.
+hint: Disable this message with "git config advice.updateSparsePath false"
+EOF
+
 test_expect_success "git add does not remove SKIP_WORKTREE entries" '
 	setup_sparse_entry &&
 	rm sparse_entry &&
-	git add sparse_entry &&
+	test_must_fail git add sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
 
@@ -56,7 +68,8 @@ do
 	test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
 		setup_sparse_entry &&
 		echo modified >sparse_entry &&
-		git add $opt sparse_entry &&
+		test_must_fail git add $opt sparse_entry 2>stderr &&
+		test_i18ncmp error_and_hint stderr &&
 		test_sparse_entry_unchanged
 	'
 done
@@ -64,7 +77,8 @@ done
 test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
 	setup_sparse_entry &&
 	test-tool chmtime -60 sparse_entry &&
-	git add --refresh sparse_entry &&
+	test_must_fail git add --refresh sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 
 	# We must unset the SKIP_WORKTREE bit, otherwise
 	# git diff-files would skip examining the file
@@ -77,7 +91,8 @@ test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
 
 test_expect_success 'git add --chmod does not update SKIP_WORKTREE entries' '
 	setup_sparse_entry &&
-	git add --chmod=+x sparse_entry &&
+	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
 
@@ -85,8 +100,23 @@ test_expect_success 'git add --renormalize does not update SKIP_WORKTREE entries
 	test_config core.autocrlf false &&
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
-	git add --renormalize sparse_entry &&
+	test_must_fail git add --renormalize sparse_entry 2>stderr &&
+	test_i18ncmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
 
+test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
+	setup_sparse_entry &&
+	test_must_fail git add nonexistent sp 2>stderr &&
+	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
+	test_i18ngrep ! "The following pathspecs only matched index entries" stderr
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
2.29.2

