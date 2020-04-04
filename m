Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA864C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89C220731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbnNV0n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgDDBM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:27 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40234 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgDDBMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:24 -0400
Received: by mail-qv1-f67.google.com with SMTP id bp12so4595805qvb.7
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfqKQCJxrbAI7q9qgz7feSm3n/yolzfRqw44OcRExYc=;
        b=gbnNV0n7q01HKhDIXfN+TiqAjCaMgvg0w1XkBEdJYpLhV6i1fa6JR3aE3Vt1RpNgk9
         CF8NPT3HFraBfbjgVR0oGYmj3FGz0a1bxevpxtPXaVFGcHjY9PfLOCuoof0lOCOiWbsc
         agiK/BvytVV4P6gC7+1rYaCO63KCDUdK+V80a5ZkZQyRe8hk0yBI/OxQfuImfczwBLWn
         5d9KgOCziraIqCCvIrvGVPW8rY+lA7TX7j52fmsimKEcC5A1HSWKyK5mgLoTsl3uHs1H
         QoLOd9doXoKjrW5C2p5RO4ZIJ838QKcKOAV7i9lCwnZwW4goeGuAzguvE2IaREwPtU6m
         nhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfqKQCJxrbAI7q9qgz7feSm3n/yolzfRqw44OcRExYc=;
        b=X3ADd2QnBR6fiKvR+eHuAtI6z43QDOuoAj3pircyXEifvgFcpHZc70IUh43m2GxRJ3
         gQ8lXxYEEuEST063XNsPEAYeGYkg0YT8c+cfeLk5uc/HZKBGXOQ7B/Istm9XOAGL3MPx
         +xasi0W6kqFselbUjujy8kTB25W1nl66myWc0irmP1mAP6HetuMgZwpOX5mqmTFvRS8U
         d6cFxDJYSRtjspcds3chCHkHePDZKh3+VNThQZ5T1Yc5YKYn4m0AqmyldJT7jp19VaGT
         Q5mhFFBSvpZFkm4J6qWyTG1Bp6Bc+KkhSPOtR8AnWMiSezcFjwNx5CIBELL9MrJL4TPD
         1l4Q==
X-Gm-Message-State: AGi0PuYXWkcC9hnBX24ZdugXjtCjQp4w7nCxMWeF6K0C+lBfUEDVp2MO
        MF+IHmSshkAfmv87uUiH7UgvrzeB
X-Google-Smtp-Source: APiQypJkPv8vNIwPHycAv3mkF2KHPu1f85oVyOBRWEEE1F4vWZmaR/LpxktrybRA0R/5y9KhEGBK+g==
X-Received: by 2002:ad4:5610:: with SMTP id ca16mr11321999qvb.104.1585962743478;
        Fri, 03 Apr 2020 18:12:23 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:22 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 23/23] pull: pass --autostash to merge
Date:   Fri,  3 Apr 2020 21:11:36 -0400
Message-Id: <177c7e537b1d853f34719882702e1f39d06e5a16.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, `--autostash` only worked with `git pull --rebase`. However, in
the last patch, merge learned `--autostash` as well so there's no reason
why we should have this restriction anymore. Teach pull to pass
`--autostash` to merge, just like it did for rebase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-pull.txt      |  9 -------
 Documentation/merge-options.txt |  4 +--
 builtin/pull.c                  |  9 ++++---
 t/t5520-pull.sh                 | 43 +++++++++++++++++++++++++++------
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dfb901f8b8..ba3772de9f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -133,15 +133,6 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
---autostash::
---no-autostash::
-	Before starting rebase, stash local modifications away (see
-	linkgit:git-stash[1]) if needed, and apply the stash entry when
-	done. `--no-autostash` is useful to override the `rebase.autoStash`
-	configuration variable (see linkgit:git-config[1]).
-+
-This option is only valid when "--rebase" is used.
-
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 3985e6d4a9..48bfcda084 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -155,6 +155,8 @@ ifndef::git-pull[]
 	Note that not all merge strategies may support progress
 	reporting.
 
+endif::git-pull[]
+
 --autostash::
 --no-autostash::
 	Automatically create a temporary stash entry before the operation
@@ -163,8 +165,6 @@ ifndef::git-pull[]
 	with care: the final stash application after a successful
 	merge might result in non-trivial conflicts.
 
-endif::git-pull[]
-
 --allow-unrelated-histories::
 	By default, `git merge` command refuses to merge histories
 	that do not share a common ancestor.  This option can be
diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..9beb4841d1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -163,7 +163,7 @@ static struct option pull_options[] = {
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
 	OPT_BOOL(0, "autostash", &opt_autostash,
-		N_("automatically stash/stash pop before and after rebase")),
+		N_("automatically stash/stash pop before and after")),
 	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 		N_("merge strategy to use"),
 		0),
@@ -661,6 +661,10 @@ static int run_merge(void)
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
 		argv_array_push(&args, "--allow-unrelated-histories");
 
@@ -908,9 +912,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (!opt_rebase && opt_autostash != -1)
-		die(_("--[no-]autostash option is only valid with --rebase."));
-
 	autostash = config_autostash;
 	if (opt_rebase) {
 		if (opt_autostash != -1)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f610dc14de..37535d63a9 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -28,7 +28,7 @@ test_pull_autostash_fail () {
 	echo dirty >new_file &&
 	git add new_file &&
 	test_must_fail git pull "$@" . copy 2>err &&
-	test_i18ngrep "uncommitted changes." err
+	test_i18ngrep "\(uncommitted changes.\)\|\(overwritten by merge:\)" err
 }
 
 test_expect_success setup '
@@ -404,13 +404,40 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_pull_autostash_fail --rebase --no-autostash
 '
 
-for i in --autostash --no-autostash
-do
-	test_expect_success "pull $i (without --rebase) is illegal" '
-		test_must_fail git pull $i . copy 2>err &&
-		test_i18ngrep "only valid with --rebase" err
-	'
-done
+test_expect_success 'pull succeeds with dirty working directory and merge.autostash set' '
+	test_config merge.autostash true &&
+	test_pull_autostash 2
+'
+
+test_expect_success 'pull --autostash & merge.autostash=true' '
+	test_config merge.autostash true &&
+	test_pull_autostash 2 --autostash
+'
+
+test_expect_success 'pull --autostash & merge.autostash=false' '
+	test_config merge.autostash false &&
+	test_pull_autostash 2 --autostash
+'
+
+test_expect_success 'pull --autostash & merge.autostash unset' '
+	test_unconfig merge.autostash &&
+	test_pull_autostash 2 --autostash
+'
+
+test_expect_success 'pull --no-autostash & merge.autostash=true' '
+	test_config merge.autostash true &&
+	test_pull_autostash_fail --no-autostash
+'
+
+test_expect_success 'pull --no-autostash & merge.autostash=false' '
+	test_config merge.autostash false &&
+	test_pull_autostash_fail --no-autostash
+'
+
+test_expect_success 'pull --no-autostash & merge.autostash unset' '
+	test_unconfig merge.autostash &&
+	test_pull_autostash_fail --no-autostash
+'
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.26.0.159.g23e2136ad0

