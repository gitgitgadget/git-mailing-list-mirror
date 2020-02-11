Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F2AC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D612720675
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtCEMh0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBKPCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:02:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36456 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgBKPC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 10:02:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so12790040wru.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 07:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CW1T+2U6y+c4aNwYKLRaVaxIYkhdm+eQ05TjbeRwYyU=;
        b=NtCEMh0Hr0uhz4N8kea9eJXQH78H/vSRVgRkxk16BgYYb+GjXYxzOdfdoYJ6y5Mwzj
         ok6V8O20KTExn8Jp1vy5P7BkMnn0uVY2QDJsmax+qVywS3gHdLRM5Rdsa9cS2z4eEd5p
         lD527yKBsffSE8fMB2BaGpjjrvMKjFTnxxY9pLwkUyTPvx0w1BUYnxdWmbdRvlhDuRO8
         gZkzoqHYC3++FZwmqvKcvy0OFoxFYunBvr7UeCWj/CTKUDHh5fpkiKaL26/g18+CXbgs
         c/VRSGl4xwiT4X0m/E+N+MD/lPw8D8rh74tWT0FUjdYgXnZbIrqOc29CzM+zygNiKsdg
         tHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CW1T+2U6y+c4aNwYKLRaVaxIYkhdm+eQ05TjbeRwYyU=;
        b=Uj0hWZZHvfV5HCYyWxGqsIWIyjSg0uN0v7oiuqAz3FOxn+4uEnepRxwESpA8OHAr9G
         aqB3mZd4RFcrt+wnRIVA1YC4yVNPqAypoXgC5Rc/ZUGXaRCo9ZkO3CSohSCIBwVVKC9+
         s+27q85uA9w1JEUq0bgma/jShmVBV16TCN/viCwzqzqTM/z3106w9vrsSsE7iPcbh2ia
         L97q7unBurkgoHLaQAkCqWRpvqAhn9NojNwOwk367yY9oqC027emJcjJ03zS0uYNwgC7
         L3CbA1MqQB2QkAS9ejKbFgA0I2Od+QE+x/hI9oUtujIKmRKEyFMgAb5FdettD61ug4yU
         GUhQ==
X-Gm-Message-State: APjAAAXUuoptNDutqVNvxc4M/YSop6ffk/ANF/TCv92kbJafhM+DC6Hj
        x2miOoT73RKe11fdOBnTl2UaoQea
X-Google-Smtp-Source: APXvYqwhitwFGiio3OBgo9alt3107b2BCPhweX5X+0aQXePc4ajtN/8qLyVrB/5/lnX/AgdQHXnDrw==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr9283513wrs.143.1581433347484;
        Tue, 11 Feb 2020 07:02:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm4252207wmm.0.2020.02.11.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 07:02:27 -0800 (PST)
Message-Id: <663c40a6909ffac6650a3ee6883b3299f6b2bd90.1581433344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.546.git.1581433344.gitgitgadget@gmail.com>
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 15:02:23 +0000
Subject: [PATCH 3/4] sparse-checkout: create 'add' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When using the sparse-checkout feature, a user may want to incrementally
grow their sparse-checkout pattern set. Allow adding patterns using a
new 'add' subcommand. This is not much different from the 'set'
subcommand, because we still want to allow the '--stdin' option and
interpret inputs as directories when in cone mode and patterns
otherwise.

When in cone mode, we are growing the cone. This may actually reduce the
set of patterns when adding directory A when A/B is already a directory
in the cone. Test the different cases: siblings, parents, ancestors.

When not in cone mode, we can only assume the patterns should be
appended to the sparse-checkout file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  7 +++
 builtin/sparse-checkout.c             | 72 ++++++++++++++++++++++++---
 t/t1091-sparse-checkout-builtin.sh    | 59 ++++++++++++++++++++++
 3 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 0914619881..746f920d71 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -59,6 +59,13 @@ directories. The input format matches the output of `git ls-tree --name-only`.
 This includes interpreting pathnames that begin with a double quote (") as
 C-style quoted strings.
 
+'add'::
+	Update the sparse-checkout file to include additional patterns.
+	By default, these patterns are read from the command-line arguments,
+	but they can be read from stdin using the `--stdin` option. When
+	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
+	as directory names as in the 'set' subcommand.
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files. Leaves the sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 03915dd729..af9e3e5123 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -18,7 +18,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set|disable) <options>"),
+	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
 	NULL
 };
 
@@ -404,7 +404,7 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	N_("git sparse-checkout (set|add) (--stdin | <patterns>)"),
 	NULL
 };
 
@@ -464,8 +464,54 @@ static void add_patterns_from_input(struct pattern_list *pl,
 
 enum modify_type {
 	REPLACE,
+	ADD,
 };
 
+static void add_patterns_cone_mode(int argc, const char **argv,
+				   struct pattern_list *pl)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct pattern_entry *pe;
+	struct hashmap_iter iter;
+	struct pattern_list existing;
+	char *sparse_filename = get_sparse_checkout_filename();
+
+	add_patterns_from_input(pl, argc, argv);
+
+	memset(&existing, 0, sizeof(existing));
+	existing.use_cone_patterns = core_sparse_checkout_cone;
+
+	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
+					   &existing, NULL))
+		die(_("unable to load existing sparse-checkout patterns"));
+	free(sparse_filename);
+
+	hashmap_for_each_entry(&existing.recursive_hashmap, &iter, pe, ent) {
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					pe->pattern, &buffer) ||
+		    !hashmap_contains_parent(&pl->parent_hashmap,
+					pe->pattern, &buffer)) {
+			strbuf_reset(&buffer);
+			strbuf_addstr(&buffer, pe->pattern);
+			insert_recursive_pattern(pl, &buffer);
+		}
+	}
+
+	clear_pattern_list(&existing);
+	strbuf_release(&buffer);
+}
+
+static void add_patterns_literal(int argc, const char **argv,
+				 struct pattern_list *pl)
+{
+	char *sparse_filename = get_sparse_checkout_filename();
+	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
+					   pl, NULL))
+		die(_("unable to load existing sparse-checkout patterns"));
+	free(sparse_filename);
+	add_patterns_from_input(pl, argc, argv);
+}
+
 static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 {
 	int result;
@@ -473,7 +519,18 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 	struct pattern_list pl;
 	memset(&pl, 0, sizeof(pl));
 
-	add_patterns_from_input(&pl, argc, argv);
+	switch (m) {
+	case ADD:
+		if (core_sparse_checkout_cone)
+			add_patterns_cone_mode(argc, argv, &pl);
+		else
+			add_patterns_literal(argc, argv, &pl);
+		break;
+
+	case REPLACE:
+		add_patterns_from_input(&pl, argc, argv);
+		break;
+	}
 
 	if (!core_apply_sparse_checkout) {
 		set_config(MODE_ALL_PATTERNS);
@@ -490,7 +547,8 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 	return result;
 }
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
+			       enum modify_type m)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
@@ -507,7 +565,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	return modify_pattern_list(argc, argv, REPLACE);
+	return modify_pattern_list(argc, argv, m);
 }
 
 static int sparse_checkout_disable(int argc, const char **argv)
@@ -558,7 +616,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
-			return sparse_checkout_set(argc, argv, prefix);
+			return sparse_checkout_set(argc, argv, prefix, REPLACE);
+		if (!strcmp(argv[0], "add"))
+			return sparse_checkout_set(argc, argv, prefix, ADD);
 		if (!strcmp(argv[0], "disable"))
 			return sparse_checkout_disable(argc, argv);
 	}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 7d982096fb..f9265de5e8 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -141,6 +141,21 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	check_files repo "a folder1 folder2"
 '
 
+test_expect_success 'add to sparse-checkout' '
+	cat repo/.git/info/sparse-checkout >expect &&
+	cat >add <<-\EOF &&
+	pattern1
+	/folder1/
+	pattern2
+	EOF
+	cat add >>expect &&
+	git -C repo sparse-checkout add --stdin <add &&
+	git -C repo sparse-checkout list >actual &&
+	test_cmp expect actual &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo "a folder1 folder2"
+'
+
 test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
@@ -219,8 +234,52 @@ test_expect_success 'cone mode: set with nested folders' '
 	test_cmp repo/.git/info/sparse-checkout expect
 '
 
+test_expect_success 'cone mode: add independent path' '
+	git -C repo sparse-checkout set deep/deeper1 &&
+	git -C repo sparse-checkout add folder1 &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	!/deep/*/
+	/deep/deeper1/
+	/folder1/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo a deep folder1
+'
+
+test_expect_success 'cone mode: add sibling path' '
+	git -C repo sparse-checkout set deep/deeper1 &&
+	git -C repo sparse-checkout add deep/deeper2 &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	!/deep/*/
+	/deep/deeper1/
+	/deep/deeper2/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo a deep
+'
+
+test_expect_success 'cone mode: add parent path' '
+	git -C repo sparse-checkout set deep/deeper1 folder1 &&
+	git -C repo sparse-checkout add deep &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	/folder1/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo a deep folder1
+'
+
 test_expect_success 'revert to old sparse-checkout on bad update' '
 	test_when_finished git -C repo reset --hard &&
+	git -C repo sparse-checkout set deep &&
 	echo update >repo/deep/deeper2/a &&
 	cp repo/.git/info/sparse-checkout expect &&
 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
-- 
gitgitgadget

