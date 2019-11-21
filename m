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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC177C43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925D5206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQoAV9DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUWFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKUWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:04:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so2883187wrl.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vY8VFK4zKWWsn+NxNJ2Dm65h7RsVpIrzHj9Hpel3GTk=;
        b=hQoAV9DXmiH26gbjfpsFzyDOUF8cKtvL1Z1Y6zqtL3x3sCXIKC408MgaT3oU7dLMwO
         hHe6XJ2swweUgCuD7wbiqGfXcNkIoM+eXU2ViTZ5m+BPGrCfGy8zH9xS2fb/5CzJMMHv
         FWoDEF1/slBfgLA6ENlt06URnSKkbYMSfCepMJWBWqbee7RzF2kpcyaFlngFLKEsJSDK
         mdGTkYbpP4TFxcJ/HdwbXE7CNhuk451wXVz3vD2fSdq2W9cWFlqTQ89hxtoNQLsF/HRP
         R5uU8AryA8BTD1W5FPjZDaIcCZ1GQtGDHm6ocqjHkYtYawlXIXwUi9YVCCjki+TzFMoa
         Is2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vY8VFK4zKWWsn+NxNJ2Dm65h7RsVpIrzHj9Hpel3GTk=;
        b=p1+ZilXSPkb+1c6UJx5uGDMatLa5MoWas/de8vRPgXcOFKUuHY/uXD7lUsS8pRHSkn
         wxjK3U4AEA7oGC/8oG118GQ/Mf/SgNGn1WtX90ycjrDidQMBGPLxIWU5AtKG1yYwlZI4
         nD1v0hGQK6gT2Uuxz6KjRGKglxW4ve1VwrLqEaCsN0GIJ28xEK4+fSJsiCf/rIQg0pnM
         lxWX/RwQnNua6089VfQIRLyFWM6Aoz3UqQ/bzv1YsBCf+JuVbDD4sXtKJPSY07X2uiPa
         a+gmS1XV2Cg7b0QMp9nfXEl8kDtSLFV2OLNju0CSRmgYcKYjbWlkB7XJB5bGsgk050pT
         jkfg==
X-Gm-Message-State: APjAAAWqOkAAhZyshGWNh+QmuH67KXLhbeGvgkhVjWX45rU2CY8GnCea
        7AWdPmsb+jerFhVHboeH78GQBG3z
X-Google-Smtp-Source: APXvYqx9/aw62hv9v7AvGumpbso5KWVjv9S3U4c08+JU0qJ72mEz5RjsdomIkzR8JMULHpgpn3iBgA==
X-Received: by 2002:a05:6000:18e:: with SMTP id p14mr13819169wrx.98.1574373896072;
        Thu, 21 Nov 2019 14:04:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm1194862wmd.29.2019.11.21.14.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:55 -0800 (PST)
Message-Id: <fcfe477813cfe91c1e84a224e6736c9c238ca29e.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:34 +0000
Subject: [PATCH v6 02/19] sparse-checkout: create 'init' subcommand
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

Getting started with a sparse-checkout file can be daunting. Help
users start their sparse enlistment using 'git sparse-checkout init'.
This will set 'core.sparseCheckout=true' in their config, write
an initial set of patterns to the sparse-checkout file, and update
their working directory.

Make sure to use the `extensions.worktreeConfig` setting and write
the sparse checkout config to the worktree-specific config file.
This avoids confusing interactions with other worktrees.

The use of running another process for 'git read-tree' is sub-
optimal. This will be removed in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 11 ++++
 builtin/sparse-checkout.c             | 75 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 40 ++++++++++++++
 3 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 87ffcbbcb0..491be1345f 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -30,6 +30,17 @@ COMMANDS
 'list'::
 	Provide a list of the contents in the sparse-checkout file.
 
+'init'::
+	Enable the `core.sparseCheckout` setting. If the
+	sparse-checkout file does not exist, then populate it with
+	patterns that match every file in the root directory and
+	no other directories, then will remove all directories tracked
+	by Git. Add patterns to the sparse-checkout file to
+	repopulate the working directory.
++
+To avoid interfering with other worktrees, it first enables the
+`extensions.worktreeConfig` setting and makes sure to set the
+`core.sparseCheckout` setting in the worktree-specific config file.
 
 SPARSE CHECKOUT
 ---------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5717c9b2cb..fcf97e9df8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout list"),
+	N_("git sparse-checkout (init|list)"),
 	NULL
 };
 
@@ -59,6 +59,77 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
+static int update_working_directory(void)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int result = 0;
+	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to update index with new sparse-checkout paths"));
+		result = 1;
+	}
+
+	argv_array_clear(&argv);
+	return result;
+}
+
+enum sparse_checkout_mode {
+	MODE_NO_PATTERNS = 0,
+	MODE_ALL_PATTERNS = 1,
+};
+
+static int set_config(enum sparse_checkout_mode mode)
+{
+	const char *config_path;
+
+	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
+		error(_("failed to set extensions.worktreeConfig setting"));
+		return 1;
+	}
+
+	config_path = git_path("config.worktree");
+	git_config_set_in_file_gently(config_path,
+				      "core.sparseCheckout",
+				      mode ? "true" : NULL);
+
+	return 0;
+}
+
+static int sparse_checkout_init(int argc, const char **argv)
+{
+	struct pattern_list pl;
+	char *sparse_filename;
+	FILE *fp;
+	int res;
+
+	if (set_config(MODE_ALL_PATTERNS))
+		return 1;
+
+	memset(&pl, 0, sizeof(pl));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+
+	/* If we already have a sparse-checkout file, use it. */
+	if (res >= 0) {
+		free(sparse_filename);
+		goto reset_dir;
+	}
+
+	/* initial mode: all blobs at root */
+	fp = xfopen(sparse_filename, "w");
+	if (!fp)
+		die(_("failed to open '%s'"), sparse_filename);
+
+	free(sparse_filename);
+	fprintf(fp, "/*\n!/*/\n");
+	fclose(fp);
+
+reset_dir:
+	return update_working_directory();
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -79,6 +150,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "list"))
 			return sparse_checkout_list(argc, argv);
+		if (!strcmp(argv[0], "init"))
+			return sparse_checkout_init(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9b73d44907..21143c529c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -42,4 +42,44 @@ test_expect_success 'git sparse-checkout list (populated)' '
 	test_cmp expect list
 '
 
+test_expect_success 'git sparse-checkout init' '
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	test_cmp_config -C repo true core.sparsecheckout &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir
+'
+
+test_expect_success 'git sparse-checkout list after init' '
+	git -C repo sparse-checkout list >actual &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'init with existing sparse-checkout' '
+	echo "*folder*" >> repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		*folder*
+	EOF
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

