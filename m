Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7421F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeJYOXD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:23:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39721 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYOXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:23:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so3637562pfe.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aVVsLAAOsZGLGXbvGU1nD3XDgml9dal/mLr+mJj6tUY=;
        b=WvfsT66Mkls7kl3LaUIlAyshEe4AfuPhUGXkDgVjzaYabqMFxuqakG3irktaXQwE+K
         uDChg3CV/uxyOVsWRXhpa8Mf9yVDmawwFZXKBRTiq+LGzboJACsNe7l1EOFuc6Xzyiab
         akSUCQPzdHZKspgxMvd5iv7UXRQXNVwf2EtiP/FzLcZMQfNSixh5ILyUi6qJDhczpDw3
         LW2SbL/D+NYSYziF5yaVJlC1jdwheKYcAPJRZ5lfOstNMoxbv7S9weuk/Q/pMlrZAk2L
         HpR2/n9UfJWqCvD1j/3uOiCmYyeR6+hd9dgeKvH0GyIx47pnc/SJfWEtErOAArk25Roh
         lbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aVVsLAAOsZGLGXbvGU1nD3XDgml9dal/mLr+mJj6tUY=;
        b=fL0sRpjQoEQQjpqHHTt23J9EXLUYuM1KdTVxabwDtivhet2fxjY5LHa/+AOaEhZopp
         g+l1W7X1SV0jcIP946eYr/WeRPdguOuQitb9MMGNhXzzDhAAvyhRWI3oBBmluR3js4s+
         eIKgbphHd72cSwOC+RghUWlTzk+49XNdh/LONdnKBw7YkxyiCCX4mzyg1I9hfGuocZpl
         S/ji3KWJQdIknW5b5Ajuf+VlLAnVjGlQihcdZbBkHroROgqqYIYrV0b71qjTh3OxLTPZ
         h7Uk/XhzpYOTzso2tg7tPdpLxmZ8XYvVZYX7nPXTZcq2Pfv9/FUYhPMj2PhfURt7yvIU
         LyKg==
X-Gm-Message-State: AGRZ1gLsLh7zUo0OSBTpOYo5bA66mfUuNQrHZRxDWVW+bPZFG7c6L21q
        29EoEq0EcGk6UbtVnLXrGWHaD0HP
X-Google-Smtp-Source: AJdET5daXFbCGlPmO3io6su3xRxWK9EXDt7rJ6/WRclRsPy7LVWNhE+b0+iACyS+de2wIqPW+bDvvg==
X-Received: by 2002:a63:aa48:: with SMTP id x8-v6mr184484pgo.87.1540446712777;
        Wed, 24 Oct 2018 22:51:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-200-74.socal.res.rr.com. [23.241.200.74])
        by smtp.gmail.com with ESMTPSA id n17-v6sm7813289pfj.84.2018.10.24.22.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 22:51:52 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH] worktree: refactor lock_reason_valid and lock_reason to be more sensible
Date:   Wed, 24 Oct 2018 22:51:42 -0700
Message-Id: <20181025055142.38077-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
In-Reply-To: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

lock_reason_valid is renamed to is_locked and lock_reason is removed as
a field of the worktree struct. Lock reason can be obtained instead by a
standalone function.

This is done in order to make the worktree struct more intuitive when it
is used elsewhere in the codebase.

Some unused variables are cleaned up as well.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 builtin/worktree.c | 16 ++++++++--------
 worktree.c         | 55 ++++++++++++++++++++++++++++--------------------------
 worktree.h         |  8 +++-----
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e771439..844789a21 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -634,8 +634,8 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	if (is_main_worktree(wt))
 		die(_("The main working tree cannot be locked or unlocked"));
 
-	old_reason = is_worktree_locked(wt);
-	if (old_reason) {
+	if (wt->is_locked) {
+		old_reason = worktree_locked_reason(wt);
 		if (*old_reason)
 			die(_("'%s' is already locked, reason: %s"),
 			    av[0], old_reason);
@@ -666,7 +666,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("The main working tree cannot be locked or unlocked"));
-	if (!is_worktree_locked(wt))
+	if (!wt->is_locked)
 		die(_("'%s' is not locked"), av[0]);
 	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
 	free_worktrees(worktrees);
@@ -734,8 +734,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 
 	validate_no_submodules(wt);
 
-	reason = is_worktree_locked(wt);
-	if (reason) {
+	if (wt->is_locked) {
+		reason = worktree_locked_reason(wt);
 		if (*reason)
 			die(_("cannot move a locked working tree, lock reason: %s"),
 			    reason);
@@ -860,11 +860,11 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
-	reason = is_worktree_locked(wt);
-	if (reason) {
+	if (wt->is_locked) {
+		reason = worktree_locked_reason(wt);
 		if (*reason)
 			die(_("cannot remove a locked working tree, lock reason: %s"),
-			    reason);
+				reason);
 		die(_("cannot remove a locked working tree"));
 	}
 	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
diff --git a/worktree.c b/worktree.c
index 97cda5f97..a3082d19d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -14,7 +14,6 @@ void free_worktrees(struct worktree **worktrees)
 		free(worktrees[i]->path);
 		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
-		free(worktrees[i]->lock_reason);
 		free(worktrees[i]);
 	}
 	free (worktrees);
@@ -41,13 +40,29 @@ static void add_head_info(struct worktree *wt)
 		wt->is_detached = 1;
 }
 
+
+/**
+ * Return 1 if the worktree is locked, 0 otherwise
+ */
+static int is_worktree_locked(const struct worktree *wt)
+{
+	struct strbuf path = STRBUF_INIT;
+	int locked_file_exists;
+
+	assert(!is_main_worktree(wt));
+
+	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+	locked_file_exists = file_exists(path.buf);
+	strbuf_release(&path);
+	return locked_file_exists;
+}
+
 /**
  * get the main worktree
  */
 static struct worktree *get_main_worktree(void)
 {
 	struct worktree *worktree = NULL;
-	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
 	int is_bare = 0;
 
@@ -56,14 +71,11 @@ static struct worktree *get_main_worktree(void)
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_bare = is_bare;
 	add_head_info(worktree);
 
-	strbuf_release(&path);
 	strbuf_release(&worktree_path);
 	return worktree;
 }
@@ -89,12 +101,10 @@ static struct worktree *get_linked_worktree(const char *id)
 		strbuf_strip_suffix(&worktree_path, "/.");
 	}
 
-	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
+	worktree->is_locked = is_worktree_locked(worktree);
 	add_head_info(worktree);
 
 done:
@@ -231,27 +241,20 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
 
-const char *is_worktree_locked(struct worktree *wt)
+const char *worktree_locked_reason(const struct worktree *wt)
 {
-	assert(!is_main_worktree(wt));
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf lock_reason = STRBUF_INIT;
 
-	if (!wt->lock_reason_valid) {
-		struct strbuf path = STRBUF_INIT;
-
-		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
-		if (file_exists(path.buf)) {
-			struct strbuf lock_reason = STRBUF_INIT;
-			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
-				die_errno(_("failed to read '%s'"), path.buf);
-			strbuf_trim(&lock_reason);
-			wt->lock_reason = strbuf_detach(&lock_reason, NULL);
-		} else
-			wt->lock_reason = NULL;
-		wt->lock_reason_valid = 1;
-		strbuf_release(&path);
-	}
+	assert(!is_main_worktree(wt));
+	assert(wt->is_locked);
 
-	return wt->lock_reason;
+	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+	if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
+		die_errno(_("failed to read '%s'"), path.buf);
+	strbuf_trim(&lock_reason);
+	strbuf_release(&path);
+	return strbuf_detach(&lock_reason, NULL);
 }
 
 /* convenient wrapper to deal with NULL strbuf */
diff --git a/worktree.h b/worktree.h
index df3fc30f7..6717287e8 100644
--- a/worktree.h
+++ b/worktree.h
@@ -10,12 +10,11 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
-	char *lock_reason;	/* internal use */
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
 	int is_current;
-	int lock_reason_valid;
+	int is_locked;
 };
 
 /* Functions for acting on the information about worktrees. */
@@ -57,10 +56,9 @@ extern struct worktree *find_worktree(struct worktree **list,
 extern int is_main_worktree(const struct worktree *wt);
 
 /*
- * Return the reason string if the given worktree is locked or NULL
- * otherwise.
+ * Return the reason string if the given worktree is locked or die
  */
-extern const char *is_worktree_locked(struct worktree *wt);
+extern const char *worktree_locked_reason(const struct worktree *wt);
 
 #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
 
-- 
2.14.2

