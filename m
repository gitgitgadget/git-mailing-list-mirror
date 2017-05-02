Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF46207EB
	for <e@80x24.org>; Tue,  2 May 2017 22:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbdEBWY1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:27 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36147 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdEBWXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:55 -0400
Received: by mail-pg0-f51.google.com with SMTP id t7so67989541pgt.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7/ue6O78k6PahcUp/7If4anD84RlsqptaE+qZ6iZ9s=;
        b=sHV/0vumbOLGV9Nvv/AaGKd8uC5+lsullOzeohFTKvRXvihviiC47HOndMk+L2lvnW
         ZFfk2Uc6hhuCs3LLTtQwcamwJfUDOyuueIWTutpxjUFR7nBMc5OUxbS067Mp09gDrqkc
         dyu7hU2ctMKCzevvzL/8AZ8Y90/i9b8jkZYJdbOPdaousFjvdFmYUOZHgCkaLzqlrIHs
         VnplepnAz8jqRptLMv6408WW0f2R2+hB29w7KYTNavAAkLLk9XSFmYCMEY2JvKReefnY
         FT/ovYb8UxEYuWYVA3+ACSO52RnfIfikrFZDkXpKCYGs7wG6vcBnTfk/w0nhEhia5kGp
         8xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7/ue6O78k6PahcUp/7If4anD84RlsqptaE+qZ6iZ9s=;
        b=d6fJQ307nhkqPTPH/UCsNdAFewyAmzAou5VTR2mRx04Tz7raLH5x0jLq6ruEJbCFMH
         ea6tkG7tLMHvzwJ849zcCpXrfc+8nCr+URgUuM6JM9cgFjdZ7kfjlU3hNqVrpESVfeo5
         wQ0vUXoXEIpQNnLdc4YBXMyt6pAgrvlOmOkGj4ZJ/7W3KU47twE/FYDr8ToWfypzt76n
         yWl2wMP05iJcRZHDDuwHQ9MoZ5vMCvnBH4obCmGu+EYdpUHAsLRZmiNZrpasdvyIzudF
         BTAusi+joEOmGZLVN7/6VmfgMCvzOD2h22/i5e965N/e3nCwezJMeEdxcjhKUWFnD8hP
         0vgg==
X-Gm-Message-State: AN3rC/6ZvG7LBpjlhGTzw0plKRcdSl3lv78K1tu95e+I2rbqsrSCSAGN
        kOEOPVHtX8JA075Xze31Yw==
X-Received: by 10.99.123.81 with SMTP id k17mr13534231pgn.125.1493763834501;
        Tue, 02 May 2017 15:23:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id n7sm768714pfn.0.2017.05.02.15.23.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 21/24] cache.h: drop refresh_cache
Date:   Tue,  2 May 2017 15:23:19 -0700
Message-Id: <20170502222322.21055-22-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression flags; @@
-refresh_cache(flags)
+refresh_index(&the_index, flags, NULL, NULL, NULL)

Additionally drop the define from cache.h manually.

This is a commit where I think the macro expansion is maybe silly, but
for reasons outlined in the first patch of the series, we still follow
through.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c           | 4 ++--
 builtin/checkout.c     | 2 +-
 builtin/commit.c       | 6 +++---
 builtin/diff.c         | 3 ++-
 builtin/merge.c        | 8 ++++----
 builtin/update-index.c | 3 ++-
 cache.h                | 1 -
 merge.c                | 2 +-
 wt-status.c            | 2 +-
 9 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 38fc4566f7..a7388ec4e0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1122,7 +1122,7 @@ static void refresh_and_write_cache(void)
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write index file"));
 }
@@ -1977,7 +1977,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 34ec9f7e32..49a8b3a7ff 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -509,7 +509,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 		setup_unpack_trees_porcelain(&topts, "checkout");
 
-		refresh_cache(REFRESH_QUIET);
+		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 		if (unmerged_index(&the_index)) {
 			error(_("you need to resolve your current index first"));
diff --git a/builtin/commit.c b/builtin/commit.c
index ac4fe97d36..4b95ff181b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -328,7 +328,7 @@ static void refresh_cache_or_die(int refresh_flags)
 	 * refresh_flags contains REFRESH_QUIET, so the only errors
 	 * are for unmerged entries.
 	 */
-	if (refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN))
+	if (refresh_index(&the_index, refresh_flags | REFRESH_IN_PORCELAIN, NULL, NULL, NULL))
 		die_resolve_conflict("commit");
 }
 
@@ -470,7 +470,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 		die(_("unable to write new_index file"));
@@ -482,7 +482,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	create_base_index(current_head);
 	add_remove_files(&partial);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
 		die(_("unable to write temporary index file"));
diff --git a/builtin/diff.c b/builtin/diff.c
index 1efd0d6b61..b11b94b214 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -211,7 +211,8 @@ static void refresh_index_quietly(void)
 		return;
 	discard_index(&the_index);
 	read_index(&the_index);
-	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED, NULL,
+		      NULL, NULL);
 	update_index_if_able(&the_index, lock_file);
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index b023107d26..4e219cb9e8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -324,7 +324,7 @@ static void restore_state(const struct object_id *head,
 	run_command_v_opt(args, RUN_GIT_CMD);
 
 	strbuf_release(&sb);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 }
 
 /* This is called when no merge was necessary. */
@@ -639,7 +639,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	const char *head_arg = "HEAD";
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
@@ -786,7 +786,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	static struct lock_file lock;
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
@@ -1393,7 +1393,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * We are not doing octopus, not fast-forward, and have
 		 * only one common.
 		 */
-		refresh_cache(REFRESH_QUIET);
+		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 		if (allow_trivial && fast_forward != FF_ONLY) {
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1c52a5531..9cbd346f95 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -767,7 +767,8 @@ static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
 	read_index_preload(&the_index, NULL);
-	*o->has_errors |= refresh_cache(o->flags | flag);
+	*o->has_errors |= refresh_index(&the_index, o->flags | flag, NULL,
+					NULL, NULL);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 07ad23d912..23c9c1697c 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #endif
diff --git a/merge.c b/merge.c
index e1f93e9714..2e468b507d 100644
--- a/merge.c
+++ b/merge.c
@@ -55,7 +55,7 @@ int checkout_fast_forward(const unsigned char *head,
 	struct dir_struct dir;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (hold_locked_index(lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
diff --git a/wt-status.c b/wt-status.c
index 59cdf09a07..1c5dcd172e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2270,7 +2270,7 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
 	int err = 0, fd;
 
 	fd = hold_locked_index(lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
-- 
2.13.0.rc1.39.ga6db8bfa24

