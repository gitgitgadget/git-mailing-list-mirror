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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3879C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C69206F4
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM/AdlbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUWFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55202 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUWFD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id x26so5129324wmk.4
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BLwAFH7+821xmGEVunmv2X4aeXkGjSS/WiZj+vxjF2o=;
        b=BM/AdlbE9MDVloBjbsnuaV+fcOMYOAMVNExvuxsU6DwWpEvQ7KL+THgELPdlDTOGj8
         /JrNb8zxDiCqTsrkIdmC1q4HYC2dXFhMgBGSa9LE6e1rrO5gFfrdoaWG5XuC2rATeoDe
         UibYC3Qkw40HKnmG342PNjF5x3rko7+onqq4lsBaPDrzKOlP354xT9KgXdhsfhDDOiW3
         zJKhYCf8xEMGse9/D2Ukw6tUFnlGHQUs//yFnWkqgla7r76JEdjVsL72RJnmjHpx+Ooi
         m6/uQ7fl6j2ZD6x3dGM+3yktD77buDY+YMX/H5aJevofLqvxYyn4VDhUAAce9fXjYwuL
         MAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BLwAFH7+821xmGEVunmv2X4aeXkGjSS/WiZj+vxjF2o=;
        b=SPqunbDl6nejH70KIMy4X5fiM9pAKBKa/DZI6VQoaMoEOCVPZKV53mmFzV5dvKGbm3
         HC3AvmzDMp8H7yrsTOsy1z739q/LVyWwMP2oKMWpcVIWfODmF5B0SWnrkAZ3yGhYgTdQ
         wH+iuAxYGfunjm1G1x1x6pwRtST3V1J/LwiUng/p52ia3gzwdCxZ0rZxjlz9fX7GpH6C
         vNDrDr9v3YNW2bOaiKZMAmO4D3zAZoiQC7UmE/f/oWHsISwB8JT7xCKRY6HYdIS8C1LK
         9iIaeXOYwQFu+EWJajISEZQ+AnxUO61MuQHg187P+9ubSbmLjOX/KxJpXr9Gq3jfk7o6
         hpCg==
X-Gm-Message-State: APjAAAXibNSFij9yckR5DfrxnNMP752phyz2FuaxAkjaAohXxfKB3QUY
        I+Wn+13TGQFBi7Qff6hf3jcxLD59
X-Google-Smtp-Source: APXvYqw1N+XTKZT3r2QZ99aosDLWQtrE/umZAExRI0k02x4jm/W6zZ5D/3UT7pu01E2hBFt+lkxPdw==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr12791134wml.49.1574373899511;
        Thu, 21 Nov 2019 14:04:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm4601654wrs.95.2019.11.21.14.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:59 -0800 (PST)
Message-Id: <6431141e0385c2d700fd213d9ad8238f75f1cab3.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:38 +0000
Subject: [PATCH v6 06/19] sparse-checkout: create 'disable' subcommand
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

The instructions for disabling a sparse-checkout to a full
working directory are complicated and non-intuitive. Add a
subcommand, 'git sparse-checkout disable', to perform those
steps for the user.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 27 ++++++++++++---------------
 builtin/sparse-checkout.c             | 26 +++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++++++
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index a724eae09c..c2cb19f80d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -51,6 +51,10 @@ To avoid interfering with other worktrees, it first enables the
 When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
 
+'disable'::
+	Remove the sparse-checkout file, set `core.sparseCheckout` to
+	`false`, and restore the working directory to include all files.
+
 SPARSE CHECKOUT
 ---------------
 
@@ -68,6 +72,14 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
+To enable the sparse-checkout feature, run `git sparse-checkout init` to
+initialize a simple sparse-checkout file and enable the `core.sparseCheckout`
+config setting. Then, run `git sparse-checkout set` to modify the patterns in
+the sparse-checkout file.
+
+To repopulate the working directory with all files, use the
+`git sparse-checkout disable` command.
+
 ## FULL PATTERN SET
 
 By default, the sparse-checkout file uses the same syntax as `.gitignore`
@@ -82,21 +94,6 @@ using negative patterns. For example, to remove the file `unwanted`:
 !unwanted
 ----------------
 
-Another tricky thing is fully repopulating the working directory when you
-no longer want sparse checkout. You cannot just disable "sparse
-checkout" because skip-worktree bits are still in the index and your working
-directory is still sparsely populated. You should re-populate the working
-directory with the `$GIT_DIR/info/sparse-checkout` file content as
-follows:
-
-----------------
-/*
-----------------
-
-Then you can disable sparse checkout. Sparse checkout support in 'git
-checkout' and similar commands is disabled by default. You need to
-set `core.sparseCheckout` to `true` in order to have sparse checkout
-support.
 
 SEE ALSO
 --------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 82bff0020d..e3a8d3460a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set) <options>"),
+	N_("git sparse-checkout (init|list|set|disable) <options>"),
 	NULL
 };
 
@@ -207,6 +207,28 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static int sparse_checkout_disable(int argc, const char **argv)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	if (set_config(MODE_ALL_PATTERNS))
+		die(_("failed to change config"));
+
+	sparse_filename = get_sparse_checkout_filename();
+	fp = xfopen(sparse_filename, "w");
+	fprintf(fp, "/*\n");
+	fclose(fp);
+
+	if (update_working_directory())
+		die(_("error while refreshing working directory"));
+
+	unlink(sparse_filename);
+	free(sparse_filename);
+
+	return set_config(MODE_NO_PATTERNS);
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -231,6 +253,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
 			return sparse_checkout_set(argc, argv, prefix);
+		if (!strcmp(argv[0], "disable"))
+			return sparse_checkout_disable(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 07e73b4674..c385c62c92 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -148,4 +148,19 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	test_cmp expect dir
 '
 
+test_expect_success 'sparse-checkout disable' '
+	git -C repo sparse-checkout disable &&
+	test_path_is_missing repo/.git/info/sparse-checkout &&
+	git -C repo config --list >config &&
+	test_must_fail git config core.sparseCheckout &&
+	ls repo >dir &&
+	cat >expect <<-EOF &&
+		a
+		deep
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

