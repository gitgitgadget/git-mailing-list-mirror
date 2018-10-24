Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7DB1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 06:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeJXPGD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 11:06:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38034 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJXPGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 11:06:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so286893pfi.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9uI/FsDA7I436nAPEMYKj3w+JokkM9MXCvlNFfn058Q=;
        b=BQbCE6fsivtW2e05ouDZt45n49B+B9FU7oHs/aAe2u+7kjLDCXKUOuU531XDzuY560
         ow9BQJP9JyQ4CUBArlZPUrHfsehR1AfKYcg89RCMttlLXCX4gRr0FK4HKFrkH4LyGlbR
         l7kmtJProJ+NKqqn+uCDeY30Q45bgO/bxwwx7BkYDx7BnUQMcM4ep4SfHluS2u9cf5VC
         atZ6b0AzBE8i/sZSlgZkDgEc22BxA7KF2mSg3M2qb6b0ZlknVgaVXSjHQaPXJYK3twEX
         4yw1ZzokQZoGiatgx27EIRess7eYvzAp0xYTDfl3puzjVTsPJf5mMRDRv15niKfXqiEG
         UM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9uI/FsDA7I436nAPEMYKj3w+JokkM9MXCvlNFfn058Q=;
        b=ofGpaEPf9CXEPRQeyCxLt/ItK7Ekl0zsvX7VGeGmKMnkKc30eSUH2uuupcwRAdKUDw
         6NNKcLUPqw7EKLr2Z1cWV1/A2ZL8e1DbCQLBfUL1Gn+74jL7Qy7JEolkrpumVD+Y41fK
         wTGziMPXEQ4H5x0+WwHmGwQgAIXA/ROe8ATf0ABbyX3EmmNCCOqaeORtJvlB0nevfDBz
         snWnGTg/anDWydxXmqeXIXyTpvk/O+AiIZQHLx4G+hVScGb0uGL+xqNaAyMEz31ZHYnk
         vy5r8dAmnIpaTaA6Mm3FQ9rNtXKNqbgbIXqxH/32Dtir9hBXC+hiwAbvz+0LdFzUOchb
         CiuQ==
X-Gm-Message-State: AGRZ1gI7NwhzA8HOrvYwULIhBc8dl30PU1wPpzsnzIiTn2TTogSPpCAk
        A4vlloO3gpBpTSRgCACN7tn4Smza
X-Google-Smtp-Source: AJdET5ff3R8rJt+2AAccPDtB6AHY+fpNyHq4Qv57yBPgdYVpkQuj6hv08a4CJrzY7boy+ELvU2VYoQ==
X-Received: by 2002:a63:c746:: with SMTP id v6-v6mr1415672pgg.108.1540363160136;
        Tue, 23 Oct 2018 23:39:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-200-74.socal.res.rr.com. [23.241.200.74])
        by smtp.gmail.com with ESMTPSA id g17-v6sm5957836pfe.37.2018.10.23.23.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 23:39:19 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, pclouds@gmail.com,
        rappazzo@gmail.com
Subject: [PATCH] worktree: populate lock_reason in get_worktrees and light refactor/cleanup in worktree files
Date:   Tue, 23 Oct 2018 23:39:04 -0700
Message-Id: <20181024063904.36096-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

lock_reason is now populated during the execution of get_worktrees

is_worktree_locked has been simplified, renamed, and changed to internal
linkage. It is simplified to only return the lock reason (or NULL in case
there is no lock reason) and to not have any side effects on the inputs.
As such it made sense to rename it since it only returns the reason.

Since this function was now being used to populate the worktree struct's
lock_reason field, it made sense to move the function to internal
linkage and have callers refer to the lock_reason field. The
lock_reason_valid field was removed since a NULL/non-NULL value of
lock_reason accomplishes the same effect.

Some unused variables within worktree source code were removed.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---

Notes:
    Travis CI results: https://travis-ci.org/nbelakovski/git/builds/445500127

 builtin/worktree.c | 27 +++++++++++----------------
 worktree.c         | 53 +++++++++++++++++++++++------------------------------
 worktree.h         |  9 +--------
 3 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e771439..fb203f61d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -615,7 +615,7 @@ static int list(int ac, const char **av, const char *prefix)
 
 static int lock_worktree(int ac, const char **av, const char *prefix)
 {
-	const char *reason = "", *old_reason;
+	const char *reason = "";
 	struct option options[] = {
 		OPT_STRING(0, "reason", &reason, N_("string"),
 			   N_("reason for locking")),
@@ -634,11 +634,10 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	if (is_main_worktree(wt))
 		die(_("The main working tree cannot be locked or unlocked"));
 
-	old_reason = is_worktree_locked(wt);
-	if (old_reason) {
-		if (*old_reason)
+	if (wt->lock_reason) {
+		if (*wt->lock_reason)
 			die(_("'%s' is already locked, reason: %s"),
-			    av[0], old_reason);
+			    av[0], wt->lock_reason);
 		die(_("'%s' is already locked"), av[0]);
 	}
 
@@ -666,7 +665,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("The main working tree cannot be locked or unlocked"));
-	if (!is_worktree_locked(wt))
+	if (!wt->lock_reason)
 		die(_("'%s' is not locked"), av[0]);
 	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
 	free_worktrees(worktrees);
@@ -703,7 +702,6 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	struct worktree **worktrees, *wt;
 	struct strbuf dst = STRBUF_INIT;
 	struct strbuf errmsg = STRBUF_INIT;
-	const char *reason;
 	char *path;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
@@ -734,11 +732,10 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 
 	validate_no_submodules(wt);
 
-	reason = is_worktree_locked(wt);
-	if (reason) {
-		if (*reason)
+	if (wt->lock_reason) {
+		if (*wt->lock_reason)
 			die(_("cannot move a locked working tree, lock reason: %s"),
-			    reason);
+			    wt->lock_reason);
 		die(_("cannot move a locked working tree"));
 	}
 	if (validate_worktree(wt, &errmsg, 0))
@@ -847,7 +844,6 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	};
 	struct worktree **worktrees, *wt;
 	struct strbuf errmsg = STRBUF_INIT;
-	const char *reason;
 	int ret = 0;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
@@ -860,11 +856,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
-	reason = is_worktree_locked(wt);
-	if (reason) {
-		if (*reason)
+	if (wt->lock_reason) {
+		if (*wt->lock_reason)
 			die(_("cannot remove a locked working tree, lock reason: %s"),
-			    reason);
+			    wt->lock_reason);
 		die(_("cannot remove a locked working tree"));
 	}
 	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
diff --git a/worktree.c b/worktree.c
index 97cda5f97..3bd25983c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -41,13 +41,34 @@ static void add_head_info(struct worktree *wt)
 		wt->is_detached = 1;
 }
 
+/**
+ * Return the reason the worktree is locked, or NULL if it is not locked
+ */
+static char *worktree_locked_reason(const struct worktree *wt)
+{
+	struct strbuf lock_reason = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+
+	assert(!is_main_worktree(wt));
+
+	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+	if (file_exists(path.buf)) {
+		if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
+			die_errno(_("failed to read '%s'"), path.buf);
+		strbuf_trim(&lock_reason);
+		strbuf_release(&path);
+		return strbuf_detach(&lock_reason, NULL);
+	}
+	strbuf_release(&path);
+	return NULL;
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
 
@@ -56,14 +77,11 @@ static struct worktree *get_main_worktree(void)
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
@@ -89,12 +107,10 @@ static struct worktree *get_linked_worktree(const char *id)
 		strbuf_strip_suffix(&worktree_path, "/.");
 	}
 
-	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
+	worktree->lock_reason = worktree_locked_reason(worktree);
 	add_head_info(worktree);
 
 done:
@@ -231,29 +247,6 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
 
-const char *is_worktree_locked(struct worktree *wt)
-{
-	assert(!is_main_worktree(wt));
-
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
-
-	return wt->lock_reason;
-}
-
 /* convenient wrapper to deal with NULL strbuf */
 static void strbuf_addf_gently(struct strbuf *buf, const char *fmt, ...)
 {
diff --git a/worktree.h b/worktree.h
index df3fc30f7..0214630fd 100644
--- a/worktree.h
+++ b/worktree.h
@@ -10,12 +10,11 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
-	char *lock_reason;	/* internal use */
+	char *lock_reason;
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
 	int is_current;
-	int lock_reason_valid;
 };
 
 /* Functions for acting on the information about worktrees. */
@@ -56,12 +55,6 @@ extern struct worktree *find_worktree(struct worktree **list,
  */
 extern int is_main_worktree(const struct worktree *wt);
 
-/*
- * Return the reason string if the given worktree is locked or NULL
- * otherwise.
- */
-extern const char *is_worktree_locked(struct worktree *wt);
-
 #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
 
 /*
-- 
2.14.2

