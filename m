Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2999EC2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1016207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cigJmtnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgDGO2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38105 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgDGO2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id 13so895302qtt.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfqKQCJxrbAI7q9qgz7feSm3n/yolzfRqw44OcRExYc=;
        b=cigJmtnSkAJBQBmgDFDxlt3YrTyVMi8vMZixpVRhve+3siMYtY6UEGO+Gwg2xIUsvZ
         og9TQspl7biUy9uXfqW87YZZL7+taUSSQMNgXwHccm3YK+hSFXB+ljnGx1c9szyvgN85
         rt81XJC0g95tGlww/pSznBrjB1lLT5wKcVI4pa4qAO+e2j06SVE2RqvQ0g8Blbx6ligP
         MWAKSnrr9cbKpH60gRG4Imfhg76PDXB76zYrF3zvCLzrCyS99RjU45xRiienIIcKZqKd
         vjBFfAkIKfpv53cvjWUeOg5j6Cd2tYRT45c2hr7EpK1UNkLzOVhXJQVvCA3FB4oswfF6
         gfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfqKQCJxrbAI7q9qgz7feSm3n/yolzfRqw44OcRExYc=;
        b=S3z6sPzArtE+vdQDLY/+PwgY+kCiBsNDZ/Vcbjpqx4zpodDsERCXzNiP/0QsKNedJa
         GFYp4L19MIxgVaEvviZ48ANPAARMm4YWPsJMIC/SlFq7HQKt9ORAa5Wz4vV8+ZP99Z+x
         V2wP58dZu2lPbe/dCgel+S21TkfiPMR3phiUewZBjraIAnNLDnxaVZQT5juBtuNwCoxn
         Gv+CHABni96JM0WUXO4Ib6PD82tUSWhbjdxtXWoxUAwD4XYHMXTYkcXSd3nlxZDnTMt1
         Sw7Xg+Y7SGzgNSdeq9JDmVz5kzvu2vLDzrHfZUAWHQFuEF8SAijdHnfLEdE3OIkHonPJ
         dwFA==
X-Gm-Message-State: AGi0PuaxihA2Ob4dgtZctrhnwrVroxn0xa+Z1YBLs00an61Fy2bpN9Yr
        fDQI5PEGR9v4FhijVQ2QdjjTTkpe
X-Google-Smtp-Source: APiQypJDTGtkDTAx0RpMQVC73uA74PXch5DHnsE8nNLf6n0yW7uV1nGzI/7Jlk87RAOethS1tA5gvQ==
X-Received: by 2002:ac8:5195:: with SMTP id c21mr2408254qtn.75.1586269726561;
        Tue, 07 Apr 2020 07:28:46 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:45 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 22/22] pull: pass --autostash to merge
Date:   Tue,  7 Apr 2020 10:28:09 -0400
Message-Id: <f4fec1e780555900be78531890c2a70e0e03eabf.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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

