Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE9C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 00:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B9A22573
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbhATAVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbhATAUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 19:20:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5917C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 16:20:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c128so1313227wme.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hI+CxRMbiaasgwtl92KpvA+LyUvjbpoE0T1VUejHWIg=;
        b=a6HQagQ4jS3UZD5fLHj9LfVCWoWQUvtUQvFlXT8sYbumjyNYGm1lGaTD9onoTG9V56
         r721T/w+yC/ay/r6NgFo0mRRY/jvXxuIB3bU2voP65b7j04ueoLfRSnksI76fzKgezgC
         FyaKcfaYvH2yPSk/3OczRh+Xa4M8jF6Oc3GhxgWILM2en1YT7s14j1jfV5hWXSxyqrSH
         qmLUyyRLfzZzi4WpA4xaw9zn/CM1gxeSsKSULiFyvllTogPEQQ8Ma3RafM3QR8EY7+Mc
         sI/xmXKCj+SXrtim7Hn5klMf7SxKOEdHtvaWW8VKl45IVIErAgIjs32/BQXij3MSGVOW
         InHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hI+CxRMbiaasgwtl92KpvA+LyUvjbpoE0T1VUejHWIg=;
        b=BEtm1tfBzLs9whAW7IOcWVnaaiXQP0NiCqrzJ0EUzL3o/9fv3/Q/+IwvWo4eE/IFGb
         8RIRjR0ICo+738GDkuTfRZI2k2JrXL6obc3oD11jVPuJCq+80enQhPOrCGOfDX5MjJ1i
         jViTD+7hczoDFVwtnK+196Ppv7kqVdsTFAJv/Zfz2wQibFPNwQh61UJ46ifEhDlvnkin
         G4MJMqvU+tZ2oL+qvQOUvtHjycKYIFQeo8hvhLvFj52GwmXrxpxvkkX7DoKxGh73SqSA
         cZtLXR6L/Easvu6gzXMQVIrIBuOKI+5WR9JiP7bqv7K6c8pC5tl/Io4aMbUGUCrdaH8L
         MFUQ==
X-Gm-Message-State: AOAM530I7B6Ahm5cKSbgeFFQk1RWZ0jwmLw2Xe5x5w4YVbXs3GTLdSI+
        8djHKAGKiHNpQDqzsE/hLjzxtojaAGg=
X-Google-Smtp-Source: ABdhPJxZ0qJ2twFTIHONAAGb9XcasuO67UMkmzjZiuxD3xvq3DsMS11h2x4TXPrHxO+1KoweH7DkPQ==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr1721498wmb.43.1611102011094;
        Tue, 19 Jan 2021 16:20:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm653464wmd.15.2021.01.19.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:20:10 -0800 (PST)
Message-Id: <pull.948.git.git.1611102010142.gitgitgadget@gmail.com>
From:   "Alex Reed via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 00:20:09 +0000
Subject: [PATCH] branch, config:  teach branch.autosetuprebase about 'merges'
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Reed <acreed4@gmail.com>, Alex Reed <acreed4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Reed <acreed4@gmail.com>

branch.autoSetupRebase now honors the 'merges' flag, allowing tracking branches
to be auto-populated with 'branch.<name>.rebase = merges'.  This allows complex
workflows to more easily retain non-trivial merges while rebasing branches on
pull operations.  Seeding new branches with 'branch.<name>.rebase = true' is not
always sufficient (read: not project default) and requiring developers to
manually reconfigure every new branch is cumbersome and error-prone.

Signed-off-by: Alex Reed <acreed4@gmail.com>
---
    branch, config: teach branch.autosetuprebase about 'merges' mode
    
    branch.autoSetupRebase now honors the 'merges' flag, allowing tracking
    branches to be auto-populated with 'branch..rebase = merges'. This
    allows complex workflows to more easily retain non-trivial merges while
    rebasing branches on pull operations. Seeding new branches with
    'branch..rebase = true' is not always sufficient (read: not project
    default) and requiring developers to manually reconfigure every new
    branch is cumbersome and error-prone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-948%2Facr4%2Fautosetuprebase-merges-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-948/acr4/autosetuprebase-merges-v1
Pull-Request: https://github.com/git/git/pull/948

 Documentation/config/branch.txt |  2 +
 branch.c                        | 70 ++++++++++++++++++++-------------
 cache.h                         |  3 +-
 config.c                        |  2 +
 t/t3200-branch.sh               | 45 +++++++++++++++++++++
 t/t5601-clone.sh                | 14 ++++++-
 6 files changed, 107 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc5..98410bf003f 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -21,6 +21,8 @@ branch.autoSetupRebase::
 	remote-tracking branches.
 	When `always`, rebase will be set to true for all tracking
 	branches.
+	When `merges`, rebase will be set to `merges` for all tracking
+	branches.
 	See "branch.autoSetupMerge" for details on how to set up a
 	branch to track another branch.
 	This option defaults to never.
diff --git a/branch.c b/branch.c
index 9c9dae1eae3..b197fe0bbb3 100644
--- a/branch.c
+++ b/branch.c
@@ -34,17 +34,25 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
-static int should_setup_rebase(const char *origin)
+typedef enum {
+	REBASE_FALSE,
+	REBASE_TRUE,
+	REBASE_MERGES
+} rebase_type;
+
+static rebase_type should_setup_rebase(const char *origin)
 {
 	switch (autorebase) {
 	case AUTOREBASE_NEVER:
-		return 0;
+		return REBASE_FALSE;
 	case AUTOREBASE_LOCAL:
-		return origin == NULL;
+		return origin == NULL ? REBASE_TRUE : REBASE_FALSE;
 	case AUTOREBASE_REMOTE:
-		return origin != NULL;
+		return origin != NULL ? REBASE_TRUE : REBASE_FALSE;
 	case AUTOREBASE_ALWAYS:
-		return 1;
+		return REBASE_TRUE;
+	case AUTOREBASE_MERGES:
+		return REBASE_MERGES;
 	}
 	return 0;
 }
@@ -59,7 +67,8 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 {
 	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
-	int rebasing = should_setup_rebase(origin);
+	rebase_type rebasing = should_setup_rebase(origin);
+	struct strbuf method = STRBUF_INIT;
 
 	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
@@ -78,44 +87,51 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	if (git_config_set_gently(key.buf, remote) < 0)
 		goto out_err;
 
-	if (rebasing) {
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.rebase", local);
-		if (git_config_set_gently(key.buf, "true") < 0)
-			goto out_err;
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.rebase", local);
+	switch(rebasing) {
+		case REBASE_TRUE:
+			strbuf_addstr(&method, " by rebasing");
+			if(git_config_set_gently(key.buf, "true") < 0)
+				goto out_err;
+			break;
+		case REBASE_MERGES:
+			strbuf_addstr(&method, " by rebasing while preserving merges");
+			if (git_config_set_gently(key.buf, "merges") < 0)
+				goto out_err;
+			break;
+    default:;
 	}
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (shortname) {
 			if (origin)
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
-					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
-					  local, shortname, origin);
+				printf_ln(
+					_("Branch '%s' set up to track remote branch '%s' from '%s'%s."),
+					local, shortname, origin, method.buf);
 			else
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
-					  _("Branch '%s' set up to track local branch '%s'."),
-					  local, shortname);
+				printf_ln(
+					_("Branch '%s' set up to track local branch '%s'%s."),
+					local, shortname, method.buf);
 		} else {
 			if (origin)
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
-					  _("Branch '%s' set up to track remote ref '%s'."),
-					  local, remote);
+				printf_ln(
+					_("Branch '%s' set up to track remote ref '%s'%s."),
+					local, remote, method.buf);
 			else
-				printf_ln(rebasing ?
-					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
-					  _("Branch '%s' set up to track local ref '%s'."),
-					  local, remote);
+				printf_ln(
+					_("Branch '%s' set up to track local ref '%s'%s."),
+					local, remote, method.buf);
 		}
 	}
 
+	strbuf_release(&method);
 	return 0;
 
 out_err:
 	strbuf_release(&key);
+	strbuf_release(&method);
 	error(_("Unable to write upstream branch configuration"));
 
 	advise(_(tracking_advice),
diff --git a/cache.h b/cache.h
index eefa93b08f8..5a378bcd534 100644
--- a/cache.h
+++ b/cache.h
@@ -995,7 +995,8 @@ enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
 	AUTOREBASE_REMOTE,
-	AUTOREBASE_ALWAYS
+	AUTOREBASE_ALWAYS,
+	AUTOREBASE_MERGES
 };
 
 enum push_default_type {
diff --git a/config.c b/config.c
index 4c0cf3a1c15..28d813f2595 100644
--- a/config.c
+++ b/config.c
@@ -1443,6 +1443,8 @@ static int git_default_branch_config(const char *var, const char *value)
 			autorebase = AUTOREBASE_REMOTE;
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
+		else if (!strcmp(value, "merges"))
+			autorebase = AUTOREBASE_MERGES;
 		else
 			return error(_("malformed value for %s"), var);
 		return 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 0af3b85d172..056192f72c5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1222,6 +1222,51 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	test "z$(git config branch.myr20.rebase)" = z
 '
 
+test_expect_success 'autosetuprebase merges on a tracked local branch' '
+	git config branch.autosetuprebase merges &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/o || git fetch local) &&
+	git branch mybase21 &&
+	git branch --track myr21 mybase3 &&
+	test "$(git config branch.myr21.remote)" = . &&
+	test "$(git config branch.myr21.merge)" = refs/heads/mybase3 &&
+	test "$(git config branch.myr21.rebase)" = merges
+'
+
+test_expect_success 'autosetuprebase merges on a tracked remote branch' '
+	git config branch.autosetuprebase merges &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr22 local/main &&
+	test "$(git config branch.myr22.remote)" = local &&
+	test "$(git config branch.myr22.merge)" = refs/heads/main &&
+	test "$(git config branch.myr22.rebase)" = merges
+'
+
+test_expect_success 'autosetuprebase merges on an untracked local branch' '
+	git config branch.autosetuprebase merges &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr23 mybase2 &&
+	test "z$(git config branch.myr23.remote)" = z &&
+	test "z$(git config branch.myr23.merge)" = z &&
+	test "z$(git config branch.myr23.rebase)" = z
+'
+
+test_expect_success 'autosetuprebase merges on an untracked remote branch' '
+	git config branch.autosetuprebase merges &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr24 local/main &&
+	test "z$(git config branch.myr24.remote)" = z &&
+	test "z$(git config branch.myr24.merge)" = z &&
+	test "z$(git config branch.myr24.rebase)" = z
+'
+
 test_expect_success 'autosetuprebase always on detached HEAD' '
 	git config branch.autosetupmerge always &&
 	test_when_finished git checkout main &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7df3c5373ae..10983191439 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -210,7 +210,7 @@ test_expect_success 'clone a void' '
 	test_cmp target-6/.git/config target-7/.git/config
 '
 
-test_expect_success 'clone respects global branch.autosetuprebase' '
+test_expect_success 'clone respects global branch.autosetuprebase remote' '
 	(
 		test_config="$HOME/.gitconfig" &&
 		git config -f "$test_config" branch.autosetuprebase remote &&
@@ -222,6 +222,18 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 	)
 '
 
+test_expect_success 'clone respects global branch.autosetuprebase merges' '
+	(
+		test_config="$HOME/.gitconfig" &&
+		git config -f "$test_config" branch.autosetuprebase merges &&
+		rm -fr dst &&
+		git clone src dst &&
+		cd dst &&
+		actual="z$(git config branch.master.rebase)" &&
+		test zmerges = $actual
+	)
+'
+
 test_expect_success 'respect url-encoding of file://' '
 	git init x+y &&
 	git clone "file://$PWD/x+y" xy-url-1 &&

base-commit: 66e871b6647ffea61a77a0f82c7ef3415f1ee79c
-- 
gitgitgadget
