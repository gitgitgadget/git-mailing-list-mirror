Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D98C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C7D2068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aya0eymv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUWFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37753 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so4113312wmf.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mqWQvZmcTJamruP6gGMqpeVPBu5fmRJkGWAyy4kBscc=;
        b=Aya0eymvgvbiytn915bdn8Xim/Tz//AGsqA2++gYkqZppbdU5k3kizoT5IJUI3pMXE
         ajoUquHDkxLXhy2WrDlL4qoU/+gK466ShXaBLuw7vdYuCrtqWH+aB+DUIT1ZQvOaqbKs
         h1x7IqbJFkAhB/aKJnZqOeONIyFsQEpJCgQnmnX4A8G5b9Hd2aUUD98xM7svZOmwuvPq
         erhcIbqGM0oW7rP3WvOrBUPABLDQRzd9ueWjuiYlIg/2cHVbj2++bamhesPyWNLUf33l
         BqHpYgzF+4yw94x71sQh8LAMHue7lluw8wXlFu0GhqQlT+GpnDnkwDOE84WGtwRVZFS7
         qokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mqWQvZmcTJamruP6gGMqpeVPBu5fmRJkGWAyy4kBscc=;
        b=lP3fwA2GPA+SkT2Y58ond/LAY1uaZ3SwKKyh7s+ZrCU+T8eb3W7HJ7yZP4dEXuub+6
         URnl037PWFWulZG+AsmGXQZisDaK607XKmjf5m8OPuj46Pd1fgnQ5R+Pz6wo1iywREjr
         NdO+h+CgJ4JPCII7cMK3RN3myuMluDdJs9xdNq6vDzESETEsd5q5PyegRgsAyGczY2sC
         1ziCRSJa+xtuhXsAZ4HIrxPFtwNm8uxTFWVlzeF87r4AYD8JEQmywvhpNsbe9YH80bBf
         U+TfLJLXGfQb5pKJ7c69q5kYYH655IgbgVeWHSKJERs+US0zKLp1NJ2JSIeXd5jJZMO0
         wvSQ==
X-Gm-Message-State: APjAAAW3kkYiYb9KCE+mXQZYJB0eoIvupiKB7JMP8hMC8Ix+x45S7R6X
        32svE+79pgZeKcJk2dq1gTUya5ZH
X-Google-Smtp-Source: APXvYqzjCTTv2ujDkeMmxJS19beMAsPWO2r8avUuGxQZVHe/nNYuSErI5eFI8N3LsN66Y6YyOi1m1g==
X-Received: by 2002:a05:600c:2389:: with SMTP id m9mr13194700wma.65.1574373897958;
        Thu, 21 Nov 2019 14:04:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm1029474wmj.44.2019.11.21.14.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:57 -0800 (PST)
Message-Id: <248fc172acc1cb3d0fdb5c3cf4ac91a51d0c85d9.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:36 +0000
Subject: [PATCH v6 04/19] sparse-checkout: 'set' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git sparse-checkout set' subcommand takes a list of patterns
as arguments and writes them to the sparse-checkout file. Then, it
updates the working directory using 'git read-tree -mu HEAD'.

The 'set' subcommand will replace the entire contents of the
sparse-checkout file. The write_patterns_and_update() method is
extracted from cmd_sparse_checkout() to make it easier to implement
'add' and/or 'remove' subcommands in the future.

If the core.sparseCheckout config setting is disabled, then enable
the config setting in the worktree config. If we set the config
this way and the sparse-checkout fails, then re-disable the config
setting.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  6 ++++
 builtin/sparse-checkout.c             | 47 +++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh    | 33 +++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 491be1345f..ca62669b8c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -42,6 +42,12 @@ To avoid interfering with other worktrees, it first enables the
 `extensions.worktreeConfig` setting and makes sure to set the
 `core.sparseCheckout` setting in the worktree-specific config file.
 
+'set'::
+	Write a set of patterns to the sparse-checkout file, as given as
+	a list of arguments following the 'set' subcommand. Update the
+	working directory to match the new patterns. Enable the
+	core.sparseCheckout config setting if it is not already enabled.
+
 SPARSE CHECKOUT
 ---------------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e3418fbe2a..95cbd0a42c 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list)"),
+	N_("git sparse-checkout (init|list|set) <options>"),
 	NULL
 };
 
@@ -66,7 +66,7 @@ static int update_working_directory(void)
 	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
 
 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-		error(_("failed to update index with new sparse-checkout paths"));
+		error(_("failed to update index with new sparse-checkout patterns"));
 		result = 1;
 	}
 
@@ -136,6 +136,47 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return update_working_directory();
 }
 
+static int write_patterns_and_update(struct pattern_list *pl)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	sparse_filename = get_sparse_checkout_filename();
+	fp = fopen(sparse_filename, "w");
+	write_patterns_to_file(fp, pl);
+	fclose(fp);
+	free(sparse_filename);
+
+	return update_working_directory();
+}
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+{
+	static const char *empty_base = "";
+	int i;
+	struct pattern_list pl;
+	int result;
+	int changed_config = 0;
+	memset(&pl, 0, sizeof(pl));
+
+	for (i = 1; i < argc; i++)
+		add_pattern(argv[i], empty_base, 0, &pl, 0);
+
+	if (!core_apply_sparse_checkout) {
+		set_config(MODE_ALL_PATTERNS);
+		core_apply_sparse_checkout = 1;
+		changed_config = 1;
+	}
+
+	result = write_patterns_and_update(&pl);
+
+	if (result && changed_config)
+		set_config(MODE_NO_PATTERNS);
+
+	clear_pattern_list(&pl);
+	return result;
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -158,6 +199,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_list(argc, argv);
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
+		if (!strcmp(argv[0], "set"))
+			return sparse_checkout_set(argc, argv, prefix);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 78c20cb7e3..72d8bc5c25 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -95,4 +95,37 @@ test_expect_success 'clone --sparse' '
 	test_cmp expect dir
 '
 
+test_expect_success 'set enables config' '
+	git init empty-config &&
+	(
+		cd empty-config &&
+		test_commit test file &&
+		test_path_is_missing .git/config.worktree &&
+		test_must_fail git sparse-checkout set nothing &&
+		test_path_is_file .git/config.worktree &&
+		test_must_fail git config core.sparseCheckout &&
+		git sparse-checkout set "/*" &&
+		test_cmp_config true core.sparseCheckout
+	)
+'
+
+test_expect_success 'set sparse-checkout using builtin' '
+	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		*folder*
+	EOF
+	git -C repo sparse-checkout list >actual &&
+	test_cmp expect actual &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

