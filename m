Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB3C11F66
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018C461621
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhGHPxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhGHPxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19DCC06175F
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 08:50:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a8so8121447wrp.5
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Y/TmwlBcAk8htzDjstcv+QUDvQTDluc2kzQtTQW4Hg=;
        b=b0ROeWQUHF0UUqcSdyHA9/qge+ohhy6RhvhbdPqgwmOPnzPPxLzAgDdDERfTyktOnW
         DWrFUPNsHoGE7huglD7516gTC08cAcDJa3hsiXfvfbFPXICHAT4BkMA397jWkTikn0gP
         qfWZFr5mMZpy5v7Geze/6uBHBStAF+uJD79BGTPoLPWbNUG9LESTxCbKAIIB1NSYz/iB
         HI6erA01ryVTzCdDV9CnxtbFOAvFgNlCNjZu27NsrqItAoMVttDnTURJBjZRC4ypgXtb
         2p+j6ZWBEBDZiAaS5A8Jw67K5cudY5a74C2tQgHJEtBZH1gQ9gdFgTPxv6vvmmLMfqrw
         hOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Y/TmwlBcAk8htzDjstcv+QUDvQTDluc2kzQtTQW4Hg=;
        b=TG1QnmxIkCdGQnlpz5Shx51PdE1rUA6ifEdUD0AL0WhEv+4lubWGptObsed03ICrl7
         ylNmQqVeOKHDU49XFfWrtKa54whYMYHatB45Kketw1YFfqUwV7SN/XhzyNvRVxWQWvOL
         jDNajDfCpXs8sC+hWXbVjOs/sSg/XFYWgBFdOu7WDTrUzrAO9XfqKgz/hJA39cSiKZaG
         OikbNBCjFthLSLV9EBWMpVmqSSw5xyyfvbFybVF9EvUrgQgR5+XH6XiglhfreN5vnt8+
         68nA5a6i93k67rUEjqbp60W88BDRRFg8Bb4aFUZnmKRn/cTQMVmau2jxDeiFZWjP3DBB
         xS8g==
X-Gm-Message-State: AOAM531u/1yX22HEFYh9L1j7n/nATp0RRJEXfP16Mp2eZDIboMbd4qCT
        wM0BHSB/K67zRJoksOg7iwDdcsl5MzU=
X-Google-Smtp-Source: ABdhPJx7P3uuIsRp1oyQkBXwszbxo8PfryZGHL/rq8FYpbffmh+nRMXRx2RpeZ/8gBOWosnQ1IbnOg==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr34032158wrx.177.1625759446402;
        Thu, 08 Jul 2021 08:50:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm2607058wrm.12.2021.07.08.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:50:46 -0700 (PDT)
Message-Id: <4d17b31921ac775ad512d4de094b4718f5dd2eb3.1625759443.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Jul 2021 15:50:43 +0000
Subject: [PATCH v2 3/3] worktree: teach `add` to accept --reason <string> with
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
 builtin/worktree.c             |  7 +++++++
 t/t2400-worktree-add.sh        | 13 +++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f1bb1fa5f5a..720663746ba 100644
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
index 448ec69e745..074169508d0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -31,6 +31,7 @@ struct add_opts {
 	int quiet;
 	int checkout;
 	int keep_locked;
+	const char *lock_reason;
 };
 
 static int show_only;
@@ -304,6 +305,8 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	if (!opts->keep_locked)
 		write_file(sb.buf, "initializing");
+	else if (opts->lock_reason)
+		write_file(sb.buf, "%s", opts->lock_reason);
 	else
 		write_file(sb.buf, _("added with --lock"));
 
@@ -486,6 +489,8 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_STRING(0, "reason", &opts.lock_reason, N_("string"),
+			   N_("reason for locking")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
@@ -500,6 +505,8 @@ static int add(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
+	if (opts.lock_reason && !opts.keep_locked)
+		die(_("--reason requires --lock"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 874a61dbfa7..de904448e59 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -71,6 +71,19 @@ test_expect_success '"add" worktree with lock' '
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
