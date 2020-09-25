Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E1C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B2721741
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7nvTv+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgIYO2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgIYO2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2CDC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c18so3808039wrm.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hL9TlMZZosnACEN9wYMLe2vrd/LfeO8AgKrq7EqvNZI=;
        b=S7nvTv+T346upH+pQc4q1Hp/OF0oJ/O7ULt1y/MvcYeo8admm1YKB29my/shK+y292
         UbVf4S5bsxtNI35jVXnCkdBKJ0BeW776Tt2vV1D1rNHtOwFyuPpFK6dgShWduRfCz3Wg
         DFUxNR0+GwjmIsLQgQ6GvcW3NsUx8gFCNTaKkc5ukjMFJLK/GGLD1e3zIyZhxBUT3Tri
         v0LY6E6p/zIzxJPCOnfcg7ak7uLKXmpROim8reX6GL/Tz/bJ5j72013nJLLZgsFH1d8V
         cJCyF7uIjQJt5fAsJDx16/VJkpv/vbidxSzc7VBo2CgFPsTwTHzfa++qnf6MFz5VfaRX
         fsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hL9TlMZZosnACEN9wYMLe2vrd/LfeO8AgKrq7EqvNZI=;
        b=ff3f7GD6JxeVV53VBsOmLqwNIdvuTUUTTy+GVDVMf2msEUnsCgXnD633+AKK+pWifm
         JXqMLxx5BfxomwypQguAhtKlCUTa6MIpXf3riBKjL4uy6B9TzYatmhaSqglor+3yuCGx
         /FC3C32ORnPK46l8DDe2brREfz222a3VB5NLv5dQz2r4lwYlMaD98RUiz+JEonfjPBCx
         W8MhzthRVjpvuo2mpx5Eo+a1K062YS6FVUtpIsNwuFA1BUGOaRQXXjP5dBvQPP4Mm77J
         ch/2QMNWZiO0iaeuDQk2W3okXFRuhZbPqwmqY9fxNUQhL3KbIXPhFTdkkZ/dUjI4ktki
         ul9A==
X-Gm-Message-State: AOAM532JC1Obh+rj+LhZFulUHKsSRSuMDRTSE+H8w13qwXx1uYYXLVRP
        2m3Z+Oy3OmTxDS5kE4B7HNrAOO+i6ck=
X-Google-Smtp-Source: ABdhPJySAUtAPX1lfjiOudXY9DBFZDYWF8bR9fBbptxgt8Hwh/mUdkqTb5o3Jgn8kvmD9RSzc1Hr5Q==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr4644915wrp.332.1601044128189;
        Fri, 25 Sep 2020 07:28:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm2960787wmc.48.2020.09.25.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:47 -0700 (PDT)
Message-Id: <dc46d39611df4ebd90d9308364d887e638c1bc30.1601044119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:38 +0000
Subject: [PATCH 10/10] hashmap_for_each_entry(): work around MSVC's run-time
 check failure #3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When compiling Git in Visual C, we do not have the luxury of
support for `typeof()`, and therefore `OFFSETOF_VAR()` unfortunately
has to fall back to pointer arithmetic.

When compiling code using the `hashmap_for_each_entry()` macro in Debug
mode, this leads to the "run-time check failure #3" because the variable
passed as `var` are not initialized, yet we calculate the pointer
difference `&(var->member)-var`.

This "run-time check failure" causes a scary dialog to pop up.

Work around this by initializing the respective variables.

Note: according to the C standard, performing pointer arithmetic
with `NULL` is not exactly well-defined, but it seems to work
here, and it is at least better than performing pointer arithmetic
with an uninitialized pointer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 attr.c                              |  2 +-
 blame.c                             |  4 ++--
 bloom.c                             |  2 +-
 builtin/describe.c                  |  2 +-
 builtin/difftool.c                  |  2 +-
 builtin/fast-import.c               |  2 +-
 builtin/sparse-checkout.c           |  6 +++---
 config.c                            |  2 +-
 merge-recursive.c                   | 10 +++++-----
 name-hash.c                         |  2 +-
 revision.c                          |  4 ++--
 submodule-config.c                  |  2 +-
 t/helper/test-hashmap.c             |  2 +-
 t/helper/test-lazy-init-name-hash.c |  4 ++--
 14 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/attr.c b/attr.c
index a826b2ef1f..b4fde37877 100644
--- a/attr.c
+++ b/attr.c
@@ -160,7 +160,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	 * field and fill each entry with its corresponding git_attr.
 	 */
 	if (size != check->all_attrs_nr) {
-		struct attr_hash_entry *e;
+		struct attr_hash_entry *e = NULL;
 		struct hashmap_iter iter;
 
 		REALLOC_ARRAY(check->all_attrs, size);
diff --git a/blame.c b/blame.c
index b475bfa1c0..e9879a772e 100644
--- a/blame.c
+++ b/blame.c
@@ -450,7 +450,7 @@ static int fingerprint_similarity(struct fingerprint *a, struct fingerprint *b)
 {
 	int intersection = 0;
 	struct hashmap_iter iter;
-	const struct fingerprint_entry *entry_a, *entry_b;
+	const struct fingerprint_entry *entry_a, *entry_b = NULL;
 
 	hashmap_for_each_entry(&b->map, &iter, entry_b,
 				entry /* member name */) {
@@ -469,7 +469,7 @@ static void fingerprint_subtract(struct fingerprint *a, struct fingerprint *b)
 {
 	struct hashmap_iter iter;
 	struct fingerprint_entry *entry_a;
-	const struct fingerprint_entry *entry_b;
+	const struct fingerprint_entry *entry_b = NULL;
 
 	hashmap_iter_init(&b->map, &iter);
 
diff --git a/bloom.c b/bloom.c
index 1a573226e7..ee45e9ccce 100644
--- a/bloom.c
+++ b/bloom.c
@@ -221,7 +221,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	if (diffopt.num_changes <= max_changes) {
 		struct hashmap pathmap;
-		struct pathmap_hash_entry *e;
+		struct pathmap_hash_entry *e = NULL;
 		struct hashmap_iter iter;
 		hashmap_init(&pathmap, pathmap_cmp, NULL, 0);
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 7668591d57..8b281cf426 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -332,7 +332,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n;
+		struct commit_name *n = NULL;
 
 		init_commit_names(&commit_names);
 		hashmap_for_each_entry(&names, &iter, n,
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 7ac432b881..a1527ea01c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -344,7 +344,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	FILE *fp;
 	struct hashmap working_tree_dups, submodules, symlinks2;
 	struct hashmap_iter iter;
-	struct pair_entry *entry;
+	struct pair_entry *entry = NULL;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
 	int rc, flags = RUN_GIT_CMD, err = 0;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1bf50a73dc..72154383c3 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -498,7 +498,7 @@ static void invalidate_pack_id(unsigned int id)
 	unsigned long lu;
 	struct tag *t;
 	struct hashmap_iter iter;
-	struct object_entry *e;
+	struct object_entry *e = NULL;
 
 	hashmap_for_each_entry(&object_table, &iter, e, ent) {
 		if (e->pack_id == id)
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 4003f4d13a..fcd87da036 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -67,7 +67,7 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 	if (pl.use_cone_patterns) {
 		int i;
-		struct pattern_entry *pe;
+		struct pattern_entry *pe = NULL;
 		struct hashmap_iter iter;
 		struct string_list sl = STRING_LIST_INIT_DUP;
 
@@ -153,7 +153,7 @@ static char *escaped_pattern(char *pattern)
 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
 	int i;
-	struct pattern_entry *pe;
+	struct pattern_entry *pe = NULL;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
 	struct strbuf parent_pattern = STRBUF_INIT;
@@ -465,7 +465,7 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 				   struct pattern_list *pl)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	struct pattern_entry *pe;
+	struct pattern_entry *pe = NULL;
 	struct hashmap_iter iter;
 	struct pattern_list existing;
 	char *sparse_filename = get_sparse_checkout_filename();
diff --git a/config.c b/config.c
index 2bdff4457b..83c72dd6e6 100644
--- a/config.c
+++ b/config.c
@@ -1953,7 +1953,7 @@ void git_configset_init(struct config_set *cs)
 
 void git_configset_clear(struct config_set *cs)
 {
-	struct config_set_element *entry;
+	struct config_set_element *entry = NULL;
 	struct hashmap_iter iter;
 	if (!cs->hash_initialized)
 		return;
diff --git a/merge-recursive.c b/merge-recursive.c
index d0214335a7..11ea550b0d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2151,8 +2151,8 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 					     struct tree *merge)
 {
 	struct hashmap_iter iter;
-	struct dir_rename_entry *head_ent;
-	struct dir_rename_entry *merge_ent;
+	struct dir_rename_entry *head_ent = NULL;
+	struct dir_rename_entry *merge_ent = NULL;
 
 	struct string_list remove_from_head = STRING_LIST_INIT_NODUP;
 	struct string_list remove_from_merge = STRING_LIST_INIT_NODUP;
@@ -2221,7 +2221,7 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)
 {
 	struct hashmap *dir_renames;
 	struct hashmap_iter iter;
-	struct dir_rename_entry *entry;
+	struct dir_rename_entry *entry = NULL;
 	int i;
 
 	/*
@@ -2590,7 +2590,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 	int i;
 	struct hashmap collisions;
 	struct hashmap_iter iter;
-	struct collision_entry *e;
+	struct collision_entry *e = NULL;
 	struct string_list *renames;
 
 	compute_collisions(&collisions, dir_renames, pairs);
@@ -2862,7 +2862,7 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 				   struct hashmap *dir_renames)
 {
 	struct hashmap_iter iter;
-	struct dir_rename_entry *e;
+	struct dir_rename_entry *e = NULL;
 
 	hashmap_for_each_entry(dir_renames, &iter, e,
 				ent /* member name */) {
diff --git a/name-hash.c b/name-hash.c
index fb526a3775..a3f710b2f8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -706,7 +706,7 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
-	struct cache_entry *ce;
+	struct cache_entry *ce = NULL;
 	unsigned int hash = memihash(name, namelen);
 
 	lazy_init_name_hash(istate);
diff --git a/revision.c b/revision.c
index 067030e64c..232de3f6f5 100644
--- a/revision.c
+++ b/revision.c
@@ -132,7 +132,7 @@ static void paths_and_oids_init(struct hashmap *map)
 static void paths_and_oids_clear(struct hashmap *map)
 {
 	struct hashmap_iter iter;
-	struct path_and_oids_entry *entry;
+	struct path_and_oids_entry *entry = NULL;
 
 	hashmap_for_each_entry(map, &iter, entry, ent /* member name */) {
 		oidset_clear(&entry->trees);
@@ -215,7 +215,7 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 	unsigned has_interesting = 0, has_uninteresting = 0;
 	struct hashmap map;
 	struct hashmap_iter map_iter;
-	struct path_and_oids_entry *entry;
+	struct path_and_oids_entry *entry = NULL;
 	struct object_id *oid;
 	struct oidset_iter iter;
 
diff --git a/submodule-config.c b/submodule-config.c
index c569e22aa3..662b9d9c09 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -89,7 +89,7 @@ static void free_one_config(struct submodule_entry *entry)
 static void submodule_cache_clear(struct submodule_cache *cache)
 {
 	struct hashmap_iter iter;
-	struct submodule_entry *entry;
+	struct submodule_entry *entry = NULL;
 
 	if (!cache->initialized)
 		return;
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index f38706216f..2bde90309b 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -162,7 +162,7 @@ int cmd__hashmap(int argc, const char **argv)
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
 		unsigned int hash = 0;
-		struct test_entry *entry;
+		struct test_entry *entry = NULL;
 
 		/* break line into command and up to two parameters */
 		cmd = strtok(line.buf, DELIM);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index cd1b4c9736..2cb1fa3d8c 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -29,8 +29,8 @@ static void dump_run(void)
 		char name[FLEX_ARRAY];
 	};
 
-	struct dir_entry *dir;
-	struct cache_entry *ce;
+	struct dir_entry *dir = NULL;
+	struct cache_entry *ce = NULL;
 
 	read_cache();
 	if (single) {
-- 
gitgitgadget
