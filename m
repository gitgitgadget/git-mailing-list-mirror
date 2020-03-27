Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E03DC2D0E7
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB781206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgT2nQKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgC0AtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35285 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgC0AtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so9513343wrn.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OttmbKGh36mHnQ3eYZNtWdbQwMVIlgJ3cC1xR2/jBUI=;
        b=UgT2nQKbq2RbPKu/BCXAxFtSCdy4U9mAoc3JtSF0yRf53DX0sgFgHnXoMOG8e2sMky
         rz6rEk9UGsH46zHZK5hJrnK8gSrdhaktFeuOmVem42+bWrrNVWBDJV4nf0FlMd6Bw5zc
         3jid7cxXAbp0MB8Gu004w8tCEOdnEzumY7m8M9afuMAFGHiwPclSiNLggBD2OSZ94hxa
         RO9xXv1m8sKtLH1bcpc/aMfU1jFpfmWCXHeCLqD9bMy5jU++u4fKGWxdMiBqf0EtADC/
         PyqQgbOJdFJZAalzlyJf4qN7cXCH/NZct0HWdCfeQPsGQIauHihoK2nOoEXpJE13IZiy
         YNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OttmbKGh36mHnQ3eYZNtWdbQwMVIlgJ3cC1xR2/jBUI=;
        b=L4nLpWVXShF8HBtMcVkt2gNR9yn/9U9o9XchfppRnFFqGbxkSGYC2dGXgoac2tb2rj
         ASJvcfIfq5zM2BspPBIMAKkUZZ563yjwGKycsrodlu18rsG4Q/2v0VYok4q2D0xTE9FY
         2QT/CCQTFWgKIMq4wYrsEsj6kHZHgImOyC/LP8HVtmMY2QcaZPcuJsDCgJwlzJ9/ljXS
         LUroHSHNunnEjV7WkANZ7hNzv4TXsnVx7mW8Wqaa1hxDunrAUTx5GcnaVmC3HGPSOutU
         scmE8f7D9XGD2g1aVyApwXmYcgH7QxTFT6T6HDeXv8layhVd0S75gaUD2EgyUuM5mwBZ
         q9ZQ==
X-Gm-Message-State: ANhLgQ31KT13kMD970mO47gWDt/QRFxNUCYzoHZfBLgfz+iZqRUC5NM0
        0gUYGV6n5yN8mdBKnldPh3Jl5pQp
X-Google-Smtp-Source: ADFU+vuI58pq14WiAODk1sXCb6T/y8vn7HzDk8CH1JJ2I+m6RpKhfCkSqWlZLREwVxfe77y+45C3rw==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr11847743wrp.184.1585270156862;
        Thu, 26 Mar 2020 17:49:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm5671375wrq.95.2020.03.26.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:16 -0700 (PDT)
Message-Id: <93dbdd78acf5f703126695aff0e27024a6b725c0.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:49:01 +0000
Subject: [PATCH v3 18/18] sparse-checkout: provide a new reapply subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If commands like merge or rebase materialize files as part of their work,
or a previous sparse-checkout command failed to update individual files
due to dirty changes, users may want a command to simply 'reapply' the
sparsity rules.  Provide one.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 10 +++++++
 builtin/sparse-checkout.c             | 10 ++++++-
 t/t1091-sparse-checkout-builtin.sh    | 41 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c0342e53938..1a3ace60820 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,6 +70,16 @@ C-style quoted strings.
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
 	as directory names as in the 'set' subcommand.
 
+'reapply::
+	Reapply the sparsity pattern rules to paths in the working tree.
+	Commands like merge or rebase can materialize paths to do their
+	work (e.g. in order to show you a conflict), and other
+	sparse-checkout commands might fail to sparsify an individual file
+	(e.g. because it has unstaged changes or conflicts).  In such
+	cases, it can make sense to run `git sparse-checkout reapply` later
+	after cleaning up affected paths (e.g. resolving conflicts, undoing
+	or committing changes, etc.).
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files. Leaves the sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index aa81199f85d..95d08824172 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -18,7 +18,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
+	N_("git sparse-checkout (init|list|set|add|reapply|disable) <options>"),
 	NULL
 };
 
@@ -554,6 +554,12 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	return modify_pattern_list(argc, argv, m);
 }
 
+static int sparse_checkout_reapply(int argc, const char **argv)
+{
+	repo_read_index(the_repository);
+	return update_working_directory(NULL);
+}
+
 static int sparse_checkout_disable(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -603,6 +609,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_set(argc, argv, prefix, REPLACE);
 		if (!strcmp(argv[0], "add"))
 			return sparse_checkout_set(argc, argv, prefix, ADD);
+		if (!strcmp(argv[0], "reapply"))
+			return sparse_checkout_reapply(argc, argv);
 		if (!strcmp(argv[0], "disable"))
 			return sparse_checkout_disable(argc, argv);
 	}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 8e2976bc7b8..dee99eeec30 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -370,6 +370,47 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git -C unmerged sparse-checkout disable
 '
 
+test_expect_success 'sparse-checkout reapply' '
+	git clone repo tweak &&
+
+	echo dirty >tweak/deep/deeper2/a &&
+
+	cat >input <<-EOF &&
+	0 0000000000000000000000000000000000000000	folder1/a
+	100644 $(git -C tweak rev-parse HEAD:folder1/a) 1	folder1/a
+	EOF
+	git -C tweak update-index --index-info <input &&
+
+	git -C tweak sparse-checkout init --cone 2>err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C tweak sparse-checkout set folder2 deep/deeper1 2>err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+
+	git -C tweak sparse-checkout reapply 2>err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
+	test_path_is_file tweak/deep/deeper2/a &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_path_is_file tweak/folder1/a &&
+
+	git -C tweak checkout HEAD deep/deeper2/a &&
+	git -C tweak sparse-checkout reapply 2>err &&
+	test_i18ngrep ! "warning.*The following paths are not up to date" err &&
+	test_path_is_missing tweak/deep/deeper2/a &&
+	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_path_is_file tweak/folder1/a &&
+
+	git -C tweak add folder1/a &&
+	git -C tweak sparse-checkout reapply 2>err &&
+	test_must_be_empty err &&
+	test_path_is_missing tweak/deep/deeper2/a &&
+	test_path_is_missing tweak/folder1/a &&
+
+	git -C tweak sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
-- 
gitgitgadget
