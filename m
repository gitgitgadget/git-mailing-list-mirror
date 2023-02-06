Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419DDC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjBFW7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBFW7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:59:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B431E27
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:59:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a2so11655685wrd.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm1ekYn0TASd9hSSWTM7PMXkimE3LkRg78N/a+doKNY=;
        b=k4tj7952TW8psgP3XsybPrXWb2hwK2uzPVZ7BGMdaSFLZFjcmCImX/8axx+hc+1IA5
         5UfP34MdsYjsiZRKiPsILoigzjs4SszjiHfeVA0twoEzUJqypF6TR+J33xhmpVkgLZqH
         8PHaccJLdyAQJx4043Gt9aFmPinRPEI440qaqU9sI3X8aDt3lqhEQQDlS/0ImtuG9uAF
         8hkhtzuZ7S/7jTJEA2yRdI85vpCWvZpdnGiojfNVX0uyVrib+5P7YELHjfZiUVYSj/Vm
         oImiuusxM5T+PoTfZgTp9YL3E6NoGfRm2FQxbYYX1YJwmTbp8K12Ya3mFY7RZF1hcFk1
         4Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm1ekYn0TASd9hSSWTM7PMXkimE3LkRg78N/a+doKNY=;
        b=etPkh/8sDCnhyGFFjQM8W82oRLCxrgR7rGuTDxaACYhr1yljIXAEdMfZRMJufJajnI
         oxhPVRP9DDBirJlxhD9eczIZCt3E1yevBxen3IGDn4YspOeETBNXEWU2LEBieDleAPAK
         SRU8CIqHhkrmegl53oVUNrGXvSxmshTw1l0woJrL6T34iydEnSsMPOHN3ki+SiQ4o+xC
         q38eMTWwCnEejHYeGwwCugVN1C1/I7OiDY/Zt7sMpBid2TbSoHxK47nquz9nn4xMg/rp
         B2Z56F7S7BNd97kWbDWUTF0GvJLUZq2uMVgxzh7UuLTHMhVLgMjmmPTzG5n8Kdq8zkJi
         ZZgg==
X-Gm-Message-State: AO0yUKXkD4sbeBRlUyCHIoJM4yG4tNX7NhZZXumpNfBY9bsrMHaAebzN
        XxDmoVTLqe/tEkxJH3/HYvyn2tJyY15sr/ap
X-Google-Smtp-Source: AK7set+6Wg4zuzZAKFwScCMpStGqSeVOeD648HFLfH/nPf048q/5D76yclww6dSGGDJgc0rMAHR2dw==
X-Received: by 2002:a5d:4b4c:0:b0:2bf:ef3b:d072 with SMTP id w12-20020a5d4b4c000000b002bfef3bd072mr618103wrs.0.1675724345910;
        Mon, 06 Feb 2023 14:59:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y17-20020adfd091000000b002c3ea68c58asm3170055wrh.1.2023.02.06.14.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:59:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] add API: remove run_add_interactive() wrapper function
Date:   Mon,  6 Feb 2023 23:58:57 +0100
Message-Id: <patch-v2-2.3-9299f22cc2c-20230206T225639Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

