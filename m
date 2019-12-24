Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F74C2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DDB20643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5kT32Yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLXLGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34786 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfLXLGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:06:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so16177001qkk.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dd4cRdrwUOdnxiynbesblqHwrYI4u9VIiC1VHZZfibA=;
        b=R5kT32YtU3mp/PHZ0cfomub7PXgHu0SaJUGSBWpHqIBuGNuhO5qTkksZLiZ/WDV0On
         iGiWdI7xa8f6o5Y54P1xjuVykhn/GR6kkgsSwUqFOI0w2DwtMlH4o4cjf8ODHYcQRYBF
         GQ6SGL1m4X1wV8mI4v98wjFl5lpt/rkcbgioY8MvNmDG42aO+KEEhgecVvaymNMqa0er
         MmBGOw+3WHF16hhi19afFbjK9OM+ORElaWpdYkNz7/o0OA0263hYCFwIPPYJPRY4D0GS
         2YqPRplmFV8Ea4+uChrNkUR+riENidQTVeYxaXVYZTK7dKZ65zwEXl1VMIrR3C9SM16l
         e23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dd4cRdrwUOdnxiynbesblqHwrYI4u9VIiC1VHZZfibA=;
        b=QwAN1jJftucOkWpLpt8rsn6ZR7wdxxjgEhT5Ih0lQYCTh71XQDoXDp+5QJiCM1L0xS
         8cOr7syQfTK8Rg+eJd0O3FOI84beqfOFkWqz9HWA91x09JBszNghageMDpfTsQCd9lNn
         BPeu3eFh5TcUwmqky1AhoF93P9kfazv+qDG1kHNWTrECosdzg1EvDIn0oAGgxIsdhegb
         wIDUbuxLRyM+V+MW9rxY7ZxOk0NIgDvnOIFBh24loW/ROPlxZt07Zyg+Dh2o/rlfV901
         UBFSfjyYLVPtusONc6Z+E0cuR29u+p8Vgs8ea6IDgpTFJ1BRyTaATGfmazvyok4dV+UR
         jKiQ==
X-Gm-Message-State: APjAAAUtg0VmtqegLM8HbbnYj2H387VcPD4su037QnOfEEsVKEpZaf7Z
        PtkGNYWEp2deVqX6HI4ukuoKIiu0
X-Google-Smtp-Source: APXvYqxudq11m/LDDJxX7tqkJv8RWYnimVaJ/UZFLq8C457iK7/L/50/snXPl2MUC/cB9e3S+OhyZg==
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr29976975qke.14.1577185562709;
        Tue, 24 Dec 2019 03:06:02 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:06:02 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 17/17] pull: pass --autostash to merge
Date:   Tue, 24 Dec 2019 06:05:14 -0500
Message-Id: <6ebae1d7588acbba5dd11d6a0d6dcdb78e266b17.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
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
index 34493eb58b..ae56cca826 100644
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
 	rebase might result in non-trivial conflicts.
 
-endif::git-pull[]
-
 --allow-unrelated-histories::
 	By default, `git merge` command refuses to merge histories
 	that do not share a common ancestor.  This option can be
diff --git a/builtin/pull.c b/builtin/pull.c
index d25ff13a60..ee186781ae 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -183,7 +183,7 @@ static struct option pull_options[] = {
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
 	OPT_BOOL(0, "autostash", &opt_autostash,
-		N_("automatically stash/stash pop before and after rebase")),
+		N_("automatically stash/stash pop before and after")),
 	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 		N_("merge strategy to use"),
 		0),
@@ -671,6 +671,10 @@ static int run_merge(void)
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
 		argv_array_push(&args, "--allow-unrelated-histories");
 
@@ -918,9 +922,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (!opt_rebase && opt_autostash != -1)
-		die(_("--[no-]autostash option is only valid with --rebase."));
-
 	autostash = config_autostash;
 	if (opt_rebase) {
 		if (opt_autostash != -1)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 218f469d0a..2919ad4f81 100755
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
@@ -391,13 +391,40 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
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
2.24.1.810.g65a2f617f4

