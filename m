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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6DC43141
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C3E2068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1zwsNM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKUWFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45744 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUWFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so6259539wrs.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CeQpqzkkcpx3RAGRByIDR8QVywUcDDYDsIGH+weGgSw=;
        b=E1zwsNM4Qa5ZKk7mMIXrFsAVf1gv/kIOIo133YSiJuRqLMtCzUwzwUCmjTCgYzfYk1
         qiubJkg2S8ewyMMVYZDo6ToBZt1ATSWjx+r0s9+h/HvbNaRSRg4yfU9Z14vmxVp+R3/5
         qQTklthIPM3AoyTnCggCj9uyVSx7gqqMgCGPPBzyXbBwCKctUciKX3BOT/vVCAoi1ZNA
         E2NO3iP8mHED/NIeS8qMTOtEziSBH6wKu1KlhAe+FTS7m6Agby/WKQK3mFHt+PvDMp6i
         weVOPiU04e+LYLvOhL4tlWNSTh7VMMH8I+yhLtGGdSQAf/LTxaWU8SGrkCaj9J/CUeF1
         qZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CeQpqzkkcpx3RAGRByIDR8QVywUcDDYDsIGH+weGgSw=;
        b=Pu8JKIbxxrMPj95AMbOcCP3TK7CNtzqSSjVxq30bhZ0AfmjFHMveBYBMcNKvkF650t
         e5zAW3DTENbDSybzBJnMarqeAb6TVhfLC+NHd8Cr3Th+hIDV6nc88VrrkF60QxH+VhOb
         WNMWDHCKhUC6YCvMzyxYFhi7UPhl1QorPYlRmdDQpPs9A28P6y9AO0lm3uhPyNFYpN/t
         5xMnNUyrE6cSn7f+X8V10dRdbicBl87TOfmV609wWOW4n/B7RnvYh/+eQkAa9lUf3ZGy
         VX7ai2jU1Inf5QeZz93BnVC5yM7N7UrETYYtBmvPBIq4OYGRffp7EwB7IxUI6SDdHRht
         K0Kg==
X-Gm-Message-State: APjAAAVsQpPx1ZtJhTOCv4mwvUXsDgyYDVntlGwvu0ro6N3GJio1qfyR
        ZsqGXVG0hlSQC3KuXl6QV5cSZmoG
X-Google-Smtp-Source: APXvYqz1be/liLqyKRx5bnSbB5+NmsfLJXqkSXjEuJeaLXv33Ze3NPxWtkV18slbeE6JRuPHzgMjEA==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr14392977wrw.126.1574373905167;
        Thu, 21 Nov 2019 14:05:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k125sm1208232wmf.2.2019.11.21.14.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:04 -0800 (PST)
Message-Id: <951e622aacdb2069177038bff6eb1a0330d46f34.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:42 +0000
Subject: [PATCH v6 10/19] sparse-checkout: init and set in cone mode
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

To make the cone pattern set easy to use, update the behavior of
'git sparse-checkout (init|set)'.

Add '--cone' flag to 'git sparse-checkout init' to set the config
option 'core.sparseCheckoutCone=true'.

When running 'git sparse-checkout set' in cone mode, a user only
needs to supply a list of recursive folder matches. Git will
automatically add the necessary parent matches for the leading
directories.

When testing 'git sparse-checkout set' in cone mode, check the
error stream to ensure we do not see any errors. Specifically,
we want to avoid the warning that the patterns do not match
the cone-mode patterns.

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 163 ++++++++++++++++++++++++++---
 dir.c                              |   8 +-
 dir.h                              |   4 +
 t/t1091-sparse-checkout-builtin.sh |  51 +++++++++
 4 files changed, 206 insertions(+), 20 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e3a8d3460a..85cc801f03 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout (init|list|set|disable) <options>"),
@@ -74,9 +75,65 @@ static int update_working_directory(void)
 	return result;
 }
 
+static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+	struct pattern_entry *pe;
+	struct hashmap_iter iter;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
+		string_list_insert(&sl, pe->pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	fprintf(fp, "/*\n!/*/\n");
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+
+		if (strlen(pattern))
+			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+	}
+
+	string_list_clear(&sl, 0);
+
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
+		string_list_insert(&sl, pe->pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+		fprintf(fp, "%s/\n", pattern);
+	}
+}
+
+static int write_patterns_and_update(struct pattern_list *pl)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	sparse_filename = get_sparse_checkout_filename();
+	fp = fopen(sparse_filename, "w");
+
+	if (core_sparse_checkout_cone)
+		write_cone_to_file(fp, pl);
+	else
+		write_patterns_to_file(fp, pl);
+
+	fclose(fp);
+	free(sparse_filename);
+
+	return update_working_directory();
+}
+
 enum sparse_checkout_mode {
 	MODE_NO_PATTERNS = 0,
 	MODE_ALL_PATTERNS = 1,
+	MODE_CONE_PATTERNS = 2,
 };
 
 static int set_config(enum sparse_checkout_mode mode)
@@ -93,9 +150,22 @@ static int set_config(enum sparse_checkout_mode mode)
 				      "core.sparseCheckout",
 				      mode ? "true" : NULL);
 
+	git_config_set_in_file_gently(config_path,
+				      "core.sparseCheckoutCone",
+				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
+
 	return 0;
 }
 
+static char const * const builtin_sparse_checkout_init_usage[] = {
+	N_("git sparse-checkout init [--cone]"),
+	NULL
+};
+
+static struct sparse_checkout_init_opts {
+	int cone_mode;
+} init_opts;
+
 static int sparse_checkout_init(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -103,8 +173,21 @@ static int sparse_checkout_init(int argc, const char **argv)
 	FILE *fp;
 	int res;
 	struct object_id oid;
+	int mode;
 
-	if (set_config(MODE_ALL_PATTERNS))
+	static struct option builtin_sparse_checkout_init_options[] = {
+		OPT_BOOL(0, "cone", &init_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_init_options,
+			     builtin_sparse_checkout_init_usage, 0);
+
+	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
+
+	if (set_config(mode))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -136,18 +219,47 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return update_working_directory();
 }
 
-static int write_patterns_and_update(struct pattern_list *pl)
+static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
 {
-	char *sparse_filename;
-	FILE *fp;
+	struct pattern_entry *e = xmalloc(sizeof(*e));
+	e->patternlen = path->len;
+	e->pattern = strbuf_detach(path, NULL);
+	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
 
-	sparse_filename = get_sparse_checkout_filename();
-	fp = fopen(sparse_filename, "w");
-	write_patterns_to_file(fp, pl);
-	fclose(fp);
-	free(sparse_filename);
+	hashmap_add(&pl->recursive_hashmap, &e->ent);
 
-	return update_working_directory();
+	while (e->patternlen) {
+		char *slash = strrchr(e->pattern, '/');
+		char *oldpattern = e->pattern;
+		size_t newlen;
+
+		if (slash == e->pattern)
+			break;
+
+		newlen = slash - e->pattern;
+		e = xmalloc(sizeof(struct pattern_entry));
+		e->patternlen = newlen;
+		e->pattern = xstrndup(oldpattern, newlen);
+		hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
+
+		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
+			hashmap_add(&pl->parent_hashmap, &e->ent);
+	}
+}
+
+static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
+{
+	strbuf_trim(line);
+
+	strbuf_trim_trailing_dir_sep(line);
+
+	if (!line->len)
+		return;
+
+	if (line->buf[0] != '/')
+		strbuf_insert(line, 0, "/", 1);
+
+	insert_recursive_pattern(pl, line);
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
@@ -180,16 +292,35 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (set_opts.use_stdin) {
+	if (core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
 
-		while (!strbuf_getline(&line, stdin)) {
-			char *buf = strbuf_detach(&line, NULL);
-			add_pattern(buf, empty_base, 0, &pl, 0);
+		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+
+		if (set_opts.use_stdin) {
+			while (!strbuf_getline(&line, stdin))
+				strbuf_to_cone_pattern(&line, &pl);
+		} else {
+			for (i = 0; i < argc; i++) {
+				strbuf_setlen(&line, 0);
+				strbuf_addstr(&line, argv[i]);
+				strbuf_to_cone_pattern(&line, &pl);
+			}
 		}
 	} else {
-		for (i = 0; i < argc; i++)
-			add_pattern(argv[i], empty_base, 0, &pl, 0);
+		if (set_opts.use_stdin) {
+			struct strbuf line = STRBUF_INIT;
+
+			while (!strbuf_getline(&line, stdin)) {
+				size_t len;
+				char *buf = strbuf_detach(&line, &len);
+				add_pattern(buf, empty_base, 0, &pl, 0);
+			}
+		} else {
+			for (i = 0; i < argc; i++)
+				add_pattern(argv[i], empty_base, 0, &pl, 0);
+		}
 	}
 
 	if (!core_apply_sparse_checkout) {
diff --git a/dir.c b/dir.c
index dfabf9982f..35c1ca9e24 100644
--- a/dir.c
+++ b/dir.c
@@ -611,10 +611,10 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
-static int pl_hashmap_cmp(const void *unused_cmp_data,
-			  const struct hashmap_entry *a,
-			  const struct hashmap_entry *b,
-			  const void *key)
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const struct hashmap_entry *a,
+		   const struct hashmap_entry *b,
+		   const void *key)
 {
 	const struct pattern_entry *ee1 =
 			container_of(a, struct pattern_entry, ent);
diff --git a/dir.h b/dir.h
index f8edbca72b..8e232085cd 100644
--- a/dir.h
+++ b/dir.h
@@ -299,6 +299,10 @@ int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const struct hashmap_entry *a,
+		   const struct hashmap_entry *b,
+		   const void *key);
 int hashmap_contains_parent(struct hashmap *map,
 			    const char *path,
 			    struct strbuf *buffer);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 1ed003ac1d..fbd46c3f61 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -186,4 +186,55 @@ test_expect_success 'sparse-checkout disable' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: init and set' '
+	git -C repo sparse-checkout init --cone &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckoutcone=true" config &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir &&
+	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
+	test_must_be_empty err &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deep
+	EOF
+	test_cmp expect dir &&
+	ls repo/deep >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deeper1
+	EOF
+	test_cmp expect dir &&
+	ls repo/deep/deeper1 >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deepest
+	EOF
+	test_cmp expect dir &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/deep/
+		!/deep/*/
+		/deep/deeper1/
+		!/deep/deeper1/*/
+		/deep/deeper1/deepest/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout set --stdin 2>err <<-EOF &&
+		folder1
+		folder2
+	EOF
+	test_must_be_empty err &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	ls repo >dir &&
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

