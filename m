Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCFC1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562E661377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhGOCnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGOCnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:43:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E771C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso173978wmm.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x8SokSttIk6+HafxFnJ724fdoX4MYCuNU3p2AIgHh/A=;
        b=T2EMKlRK6sE3cRnGOJVXUQ2xFOAvdJ9yr5Qs45xqKjThplX+SMb20kJfObqRpeYJRU
         g6MwnIKRsYtX9BZABTk2sR+f1QPerl7K9pcLCIPLfGQPqsEa09+5rGD8l0SLKncX8c/0
         m4w8Vog43Hj0e+5dESjEYNqzQsprJ7p177Y7rsuH2K9vO/HefBU7mUe8HI3iAtLEsKRp
         D+ls+7WfZEp/4zwXLaeuEDgAgFm1XMppRIxPZ3P1QMftHOIVlvv7l7zIW3XGLlnEezbB
         VtQ8ItBIWzr5oxGqW2ohYahBzMgFSeeTmxe8e1T99+S3I0fKBakJmsohfKT0+6a94NMV
         texw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x8SokSttIk6+HafxFnJ724fdoX4MYCuNU3p2AIgHh/A=;
        b=clNTDGTJn8h5W2bklV9ZlYa5/fl6XjU0fddN8TCCefFIV76FI3ha8SThfpsPLh+Y7w
         YeW2sUFp0QTq7nZlwMWBxTcOaliMh+TJV1mIFobmVwvZ7CUSavBne9ACocd02if/u5ma
         n9bYQL80C0H7jsxD3nclwYGFak8qGldzWBZ6rNMFQCXTl2NvXrdKx/c1MshJAzEOInfL
         T2f5v/l4xWTnjzIS8c3/cznmaLY8wIOq021TJx76S1BJx8iLgL+KhmQ4vCzxJSeR5ozr
         Q2SNNIzNom8n+nnjOxERM4KH9YVF5ih4upAagl+mHwBx+YmhvEC6hueC5uWoitjeyUa1
         zARg==
X-Gm-Message-State: AOAM532A4xjDQZZ9BTTQAB8KgRh28nf1avD43jvTb1WPaCdd6YqRmgla
        02BYpzbP2nggKZ6BurC3AAUkq+hBM9c=
X-Google-Smtp-Source: ABdhPJxvWtamoPvCcTA6GUD24mPG4iLFz/x3KCyXttiIQkqlQ2ssAYgQa5g0l6RLkxWUSpLQ2KRGNA==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr7499660wmb.142.1626316852714;
        Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20sm5044390wrd.70.2021.07.14.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
Message-Id: <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:40:47 +0000
Subject: [PATCH 3/5] pull: handle conflicting rebase/merge options via last
 option wins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The --rebase[=...] flags and the various ff flags are incompatible,
except that --no-rebase (or --rebase=false) work with any of the ff
flags, and --ff works with any of the rebase flags.

Both sets of these flags could also be passed via configuration
options, namely pull.rebase and pull.ff.

As with elsewhere in git:
  * Make the last flag specified win
  * Treat command line flags as coming after any configuration options
  * Do not imply an order between different configuration options; if
    they conflict, just report an error.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/pull.txt |  3 +-
 Documentation/git-pull.txt    |  3 ++
 builtin/pull.c                | 12 +++++++
 t/t7601-merge-pull-config.sh  | 67 +++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 54048306095..e70ed99e408 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -7,12 +7,13 @@ pull.ff::
 	line). When set to `only`, only such fast-forward merges are
 	allowed (equivalent to giving the `--ff-only` option from the
 	command line). This setting overrides `merge.ff` when pulling.
+	Incompatible with pull.rebase.
 
 pull.rebase::
 	When true, rebase branches on top of the fetched branch, instead
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
-	per-branch basis.
+	per-branch basis.  Incompatible with pull.ff.
 +
 When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c014..03e8694e146 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -121,6 +121,9 @@ When false, merge the current branch into the upstream branch.
 +
 When `interactive`, enable the interactive mode of rebase.
 +
+Note that these flags are incompatible with --no-ff and --ff-only; if
+such incompatible flags are given, the last one will take precedence.
++
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
diff --git a/builtin/pull.c b/builtin/pull.c
index d99719403d0..b355fd38794 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -109,6 +109,11 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 		*value = parse_config_rebase("--rebase", arg, 0);
 	else
 		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+
+	/* --rebase overrides earlier --ff-only and --no-ff */
+	if (*value != REBASE_FALSE)
+		opt_ff = "--ff";
+
 	return *value == REBASE_INVALID ? -1 : 0;
 }
 
@@ -119,6 +124,10 @@ static int parse_opt_ff(const struct option *opt, const char *arg, int unset)
 	else
 		opt_ff = xstrfmt("--%s", opt->long_name);
 
+	/* --ff-only and --no-ff override earlier --rebase */
+	if (strcmp(opt_ff, "--ff"))
+		opt_rebase = REBASE_FALSE;
+
 	return 0;
 }
 
@@ -984,6 +993,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase(&rebase_unspecified);
 
+	if (opt_rebase != REBASE_FALSE && opt_ff && strcmp(opt_ff, "--ff"))
+		die(_("pull.rebase and pull.ff are incompatible; please unset one"));
+
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933a..73a0dbdf25a 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -143,6 +143,73 @@ test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_does_rebase() {
+	git reset --hard c2 &&
+	git "$@" . c1 &&
+	# Check that we actually did a rebase
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 3 0 >expect &&
+	test_cmp expect actual &&
+	rm actual expect
+}
+
+test_does_merge() {
+	git reset --hard c2 &&
+	git "$@" . c1 &&
+	# Check that we actually did a merge
+	git rev-list --count HEAD >actual &&
+	git rev-list --merges --count HEAD >>actual &&
+	test_write_lines 4 1 >expect &&
+	test_cmp expect actual &&
+	rm actual expect
+}
+
+test_attempts_fast_forward() {
+	git reset --hard c2 &&
+	test_must_fail git "$@" . c1 2>err &&
+	test_i18ngrep "Not possible to fast-forward, aborting" err
+}
+
+test_expect_success 'conflicting options: --ff-only --rebase' '
+	test_does_rebase pull --ff-only --rebase
+'
+
+test_expect_success 'conflicting options: --no-ff --rebase' '
+	test_does_rebase pull --no-ff --rebase
+'
+
+test_expect_success 'conflicting options: -c pull.ff=false --rebase' '
+	test_does_rebase -c pull.ff=false pull --rebase
+'
+
+test_expect_success 'conflicting options: -c pull.ff=only --rebase' '
+	test_does_rebase -c pull.ff=only pull --rebase
+'
+
+test_expect_success 'conflicting options: --rebase --ff-only' '
+	test_attempts_fast_forward pull --rebase --ff-only
+'
+
+test_expect_success 'conflicting options: --rebase --no-ff' '
+	test_does_merge pull --rebase --no-ff
+'
+
+test_expect_success 'conflicting options: -c pull.rebase=true --no-ff' '
+	test_does_merge -c pull.rebase=true pull --no-ff
+'
+
+test_expect_success 'conflicting options: -c pull.rebase=true --ff-only' '
+	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
+'
+
+test_expect_success 'report conflicting configuration' '
+	git reset --hard c2 &&
+	test_must_fail git -c pull.ff=false -c pull.rebase=true pull . c1 2>err &&
+	test_i18ngrep "pull.rebase and pull.ff are incompatible; please unset one" err
+
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
gitgitgadget

