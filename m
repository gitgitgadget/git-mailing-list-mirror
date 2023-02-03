Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FFCC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 16:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjBCQak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjBCQah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 11:30:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC2A7EDD
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 08:30:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a2so4867990wrd.6
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoYfXRz5VdyzclXktwA3697mJ1Yj+twYplvi3tNR7W4=;
        b=SNkV8D0nSdSxC4QGQcnuwWajnPBSpk2EmS60qcjxl/B66N/8MOh7B1jwC+kJrbu2zk
         2ZKRsbDONLN1Wck7LMn4R/9fZS3voF5Kr/jJKnkZ0tKCaksvWF1awDZ8LEr/13TfMwzz
         NaX3wFkQneu8j6AdAa8xFfkey8cWPOCw4ns0A3kYCCcLJjiKTW5HNJNazFNJgYr47NJz
         7H6xdqiV9qAZ7KtjpzVlCpfZKPvBlIuIJZdJnVg2UReZ4sEeG7e4J4K9Pg6KqShQOTZ2
         PjAstAdx4NPdNWoV9/jUxKPm4gD+rPfzIT/25uoI8aof5WwOhvF6H8qqB1j1cSvZuai7
         ENHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoYfXRz5VdyzclXktwA3697mJ1Yj+twYplvi3tNR7W4=;
        b=X5dCAmZK/gZvNQv9rolqo9oILpOyhVmSF78Fi7Hwpq40XAzLSkOnrJiU+hB15r31Gi
         ZxH8zIdYVOXGhCMAziZDgckjCqooyTYZt34PXQQjj7AOZdi02mWhmdbiVY+33VnZK3OX
         vL3Z2ptncfRkPxCf0qcafNsU560coR7HdKyRXZt9QAfJpvbyE2ZFkfQ0kPamEpm0FcXT
         KsWMf7umkiQMhOlow+v8e7gVhIPeuMaemeFyhQXdAse1eY9yJJpb2nHkmjnLgdszbrzp
         f7Vj9dQeRd4xdStDcwm9UwwQjzOS1XStylBcaq7C2H382LXSE7UTSH1R1c4NgBQNVZi5
         wxgQ==
X-Gm-Message-State: AO0yUKVWFNdvRC8lWFmodsd+idzbqlqG9M8SLioDmPIAwOE5YRdIcqbT
        UGXzAwWrUriFQR/up3/TBBYkfdDuTFlM+Upj
X-Google-Smtp-Source: AK7set9RJ3uo5vN/Zi3v0IDcYR4W877biFne6QVpciVF9orr7U9Vc32FN+xyi6/f0EZxS6ncJIEBKQ==
X-Received: by 2002:adf:f7c9:0:b0:2bf:bfc1:f622 with SMTP id a9-20020adff7c9000000b002bfbfc1f622mr9057731wrq.64.1675441833682;
        Fri, 03 Feb 2023 08:30:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b00287da7ee033sm2315637wru.46.2023.02.03.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:30:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] add API: remove run_add_interactive() wrapper function
Date:   Fri,  3 Feb 2023 17:30:03 +0100
Message-Id: <patch-2.3-fb0dafaf4a4-20230203T125859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the Perl "git-add--interactive" has gone away in the
preceding commit we don't need to pass along our desire for a mode as
a string, and can instead directly use the "enum add_p_mode", see
d2a233cb8b9 (built-in add -p: prepare for patch modes other than
"stage", 2019-12-21) for its introduction.

As a result of that the run_add_interactive() function would become a
trivial wrapper which would only run run_add_i() if a 0 (or now,
"NULL") "patch_mode" was provided. Let's instead remove it, and have
the one callsite that wanted the "NULL" case (interactive_add())
handle it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c      | 31 ++++---------------------------
 builtin/checkout.c | 12 +++++++-----
 builtin/reset.c    |  4 +++-
 builtin/stash.c    |  3 ++-
 commit.h           |  2 --
 5 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9f5b6e26a02..61dd386d109 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -238,30 +238,6 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	return ret;
 }
 
-int run_add_interactive(const char *revision, const char *patch_mode,
-			const struct pathspec *pathspec)
-{
-	enum add_p_mode mode;
-
-	if (!patch_mode)
-		return !!run_add_i(the_repository, pathspec);
-
-	if (!strcmp(patch_mode, "--patch"))
-		mode = ADD_P_ADD;
-	else if (!strcmp(patch_mode, "--patch=stash"))
-		mode = ADD_P_STASH;
-	else if (!strcmp(patch_mode, "--patch=reset"))
-		mode = ADD_P_RESET;
-	else if (!strcmp(patch_mode, "--patch=checkout"))
-		mode = ADD_P_CHECKOUT;
-	else if (!strcmp(patch_mode, "--patch=worktree"))
-		mode = ADD_P_WORKTREE;
-	else
-		die("'%s' not supported", patch_mode);
-
-	return !!run_add_p(the_repository, mode, revision, pathspec);
-}
-
 int interactive_add(const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
@@ -277,9 +253,10 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 		       PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
 
-	return run_add_interactive(NULL,
-				   patch ? "--patch" : NULL,
-				   &pathspec);
+	if (patch)
+		return !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
+	else
+		return !!run_add_i(the_repository, &pathspec);
 }
 
 static int edit_patch(int argc, const char **argv, const char *prefix)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5963e1b74b8..a5155cf55c1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -29,6 +29,7 @@
 #include "xdiff-interface.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "add-interactive.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -499,7 +500,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		    "--merge", "--conflict", "--staged");
 
 	if (opts->patch_mode) {
-		const char *patch_mode;
+		enum add_p_mode patch_mode;
 		const char *rev = new_branch_info->name;
 		char rev_oid[GIT_MAX_HEXSZ + 1];
 
@@ -517,15 +518,16 @@ static int checkout_paths(const struct checkout_opts *opts,
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
-			patch_mode = "--patch=checkout";
+			patch_mode = ADD_P_CHECKOUT;
 		else if (opts->checkout_index && !opts->checkout_worktree)
-			patch_mode = "--patch=reset";
+			patch_mode = ADD_P_RESET;
 		else if (!opts->checkout_index && opts->checkout_worktree)
-			patch_mode = "--patch=worktree";
+			patch_mode = ADD_P_WORKTREE;
 		else
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
-		return run_add_interactive(rev, patch_mode, &opts->pathspec);
+		return !!run_add_p(the_repository, patch_mode, rev,
+				   &opts->pathspec);
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
diff --git a/builtin/reset.c b/builtin/reset.c
index fea20a9ba0b..4b59aa9aeae 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -26,6 +26,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "dir.h"
+#include "add-interactive.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -390,7 +391,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type != NONE)
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
-		return run_add_interactive(rev, "--patch=reset", &pathspec);
+		return !!run_add_p(the_repository, ADD_P_RESET, rev,
+				   &pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
diff --git a/builtin/stash.c b/builtin/stash.c
index 839569a9803..9fcd2e5d993 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -18,6 +18,7 @@
 #include "diffcore.h"
 #include "exec-cmd.h"
 #include "reflog.h"
+#include "add-interactive.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -1229,7 +1230,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-	ret = run_add_interactive(NULL, "--patch=stash", ps);
+	ret = !!run_add_p(the_repository, ADD_P_STASH, NULL, ps);
 
 	the_repository->index_file = old_repo_index_file;
 	if (old_index_env && *old_index_env)
diff --git a/commit.h b/commit.h
index fa39202fa6b..cc2c5da7bdb 100644
--- a/commit.h
+++ b/commit.h
@@ -274,8 +274,6 @@ struct ref;
 int for_each_commit_graft(each_commit_graft_fn, void *);
 
 int interactive_add(const char **argv, const char *prefix, int patch);
-int run_add_interactive(const char *revision, const char *patch_mode,
-			const struct pathspec *pathspec);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;
-- 
2.39.1.1397.gbe42486b8a4

