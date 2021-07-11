Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4CFC07E95
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ED761220
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhGKAaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhGKAaL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:30:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDBDC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i94so18421722wri.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dyR4GnCNZegSsxkLmJz76UXzoi9X/D3A53gE6yBBUxA=;
        b=dF5JYrIuczjojHZQC8XpkI46I+3oJRSwHaKQyQvB/Hnp1T5loZ0wMyqHKyizUjBF7d
         5cq+Qt1BlM81FWnCdxXz6CINd9i68PVmfXu5w6/TaGtmtLk98ci5SvaaEKWxSGfuHVQ4
         X+oyWMRkdUWLNJ2bDW3zBkGUMRIc0bzhkiXGrCssdQ15C01TIOAEi/O4PYUr6FH++1YQ
         obR1LLzV4tR5d2i2YQK0oeP2vEm/IZgjaj6SKwu0+PlYDOjbRCkxvt/OkFg0F84vaBRE
         ojk/nFBusUfuFbUyxB2yRcz9iSOU5G29VPyzcmryCITGA7gn/kHu/ceJuHtHLv8XvqBn
         ooAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dyR4GnCNZegSsxkLmJz76UXzoi9X/D3A53gE6yBBUxA=;
        b=nmb6w6+zC9TYwKymoVjo/rsQ5XYnykl82kByme9x8DGTfJ+gXeK4/kvztj/IzI4u4s
         qP9MkI0C6o0uKOk61z9i6FHPuAX7NzpS+ooE8oDPA5qJyIQrxlif1UhnTBz0KWD82l5u
         RP6/3Cp4KUtgU4mG8um9uIhfwv/UtcifYDnQs55SJG04MMRvOw3Iw/8eSYPCxtV0gf2X
         zT6FyDJfb2V8GMVlKt4rSlB807oNqjJgy2LDLBviXDBAOoiGOV5jLMVF4yg11WmawFxk
         GsJR3LKpuWWPEkKcy095VbFHVY6tvTcDay8+RDNsp5J8iXkb9asSXFhs83uNtJ2EPNYn
         yhIA==
X-Gm-Message-State: AOAM532wihG3mnHhE7FOpdmoUCamvxkbOwtAA7cZ99wfUJIZyz0HFHfq
        wmgmiABqVeZw1gWpvXL3U0nkUrEqrZQ=
X-Google-Smtp-Source: ABdhPJwSam/nkEdUFmwsswBKABPcvUnwVywT1doHuuh7bJvA6Dl5mOvgZpR+5M2raElu0s8DGQjTTQ==
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr5501593wrs.275.1625963243398;
        Sat, 10 Jul 2021 17:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm4681702wrm.82.2021.07.10.17.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:27:23 -0700 (PDT)
Message-Id: <9a414a3078bb481ba19449065d47e6e27322cef2.1625963240.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
References: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
        <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:27:20 +0000
Subject: [PATCH v3 3/3] worktree: teach `add` to accept --reason <string> with
 --lock
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

The default reason stored in the lock file, "added with --lock",
is unlikely to be what the user would have given in a separate
`git worktree lock` command. Allowing `--reason` to be specified
along with `--lock` when adding a working tree gives the user control
over the reason for locking without needing a second command.

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
 Documentation/git-worktree.txt |  4 ++--
 builtin/worktree.c             | 21 ++++++++++++++++-----
 t/t2400-worktree-add.sh        | 13 +++++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 66e67e6cbfa..8a7cbdd19c1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -242,7 +242,7 @@ With `list`, annotate missing working trees as prunable if they are
 older than `<time>`.
 
 --reason <string>::
-	With `lock`, an explanation why the working tree is locked.
+	With `lock` or with `add --lock`, an explanation why the working tree is locked.
 
 <worktree>::
 	Working trees can be identified by path, either relative or
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4829b9507ff..0d0a80da61f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -30,7 +30,7 @@ struct add_opts {
 	int detach;
 	int quiet;
 	int checkout;
-	int keep_locked;
+	const char *keep_locked;
 };
 
 static int show_only;
@@ -302,10 +302,10 @@ static int add_worktree(const char *path, const char *refname,
 	 * after the preparation is over.
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	if (!opts->keep_locked)
-		write_file(sb.buf, _("initializing"));
+	if (opts->keep_locked)
+		write_file(sb.buf, "%s", opts->keep_locked);
 	else
-		write_file(sb.buf, _("added with --lock"));
+		write_file(sb.buf, _("initializing"));
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
@@ -475,6 +475,8 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
+	const char *lock_reason = NULL;
+	int keep_locked = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force,
 			   N_("checkout <branch> even if already checked out in other worktree"),
@@ -485,7 +487,9 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create or reset a branch")),
 		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
-		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
+		OPT_STRING(0, "reason", &lock_reason, N_("string"),
+			   N_("reason for locking")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
@@ -500,6 +504,13 @@ static int add(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
+	if (lock_reason && !keep_locked)
+		die(_("--reason requires --lock"));
+	if (lock_reason)
+		opts.keep_locked = lock_reason;
+	else if (keep_locked)
+		opts.keep_locked = _("added with --lock");
+
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 93d3795cab9..7590064076a 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -72,6 +72,19 @@ test_expect_success '"add" worktree with lock' '
 	test -f .git/worktrees/here-with-lock/locked
 '
 
+test_expect_success '"add" worktree with lock and reason' '
+	git worktree add --detach --lock --reason "why not" here-with-lock-reason main &&
+	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
+	test -f .git/worktrees/here-with-lock-reason/locked &&
+	echo why not >expect &&
+	test_cmp expect .git/worktrees/here-with-lock-reason/locked
+'
+
+test_expect_success '"add" worktree with reason but no lock' '
+	test_must_fail git worktree add --detach --reason "why not" here-with-reason-only main &&
+	test_path_is_missing .git/worktrees/here-with-reason-only/locked
+'
+
 test_expect_success '"add" worktree from a subdir' '
 	(
 		mkdir sub &&
-- 
gitgitgadget
