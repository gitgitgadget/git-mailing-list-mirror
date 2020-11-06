Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68300C56201
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133722083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO21Ts64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgKFAZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732898AbgKFAZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B9C0613D2
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:13 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so3275280wmd.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OA4wQ/JUZvjUd14KqKKplav5D5ohsMHFqJIjlPS/lz8=;
        b=YO21Ts64TBw74zUwIkLctDbzvCEJHrnzSrGjAUTqLb9AKSdTcShFv5aVODvaAlr7on
         ilPNI3fOnm7xfqBqNwVevWpCPfv2kfGAUPPx2fQKGhpR2/0pl3I0dSwrK5yE7CXgWRdP
         bYY6ngj4sFXdNJCksDlp8GAx1ANAqGZTZI9a/5qxoK0Tfp33nXyAigl4SGizKjX5UtZ3
         bXDEprUDKClrxci2O32xnYe/mHCvnnkVEAYMJqPX5kXIluvW4Vd5Qu8B/7ZVfuvSz2CV
         PkBxK3xVidtkHHU8Lz1KlZJV/974KMKkb79YEJfI6mB1+YfALDBVENQHkb0xOKlkVNVT
         KhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OA4wQ/JUZvjUd14KqKKplav5D5ohsMHFqJIjlPS/lz8=;
        b=aTSDvwodIZFziwJWzw6Tj4I91skuRLY+1EJ0n5iZrzwL3kWQlURZfNl/l4fMPIzLA+
         3KUL8lCl/BxG8coYC84NZn/1fHIGkrg5Jy8aMzcUSS9PtzfFQEaH+deDEwgCPvH4x3Gj
         26IO4qM1Cl8NQ9mH/WKj89qnwd6xnDUlMSPO37gOz5L2+rUtwGO8tXulECSNJzFHkJec
         VSDVl8XWg0trSsMHA+e/pZQ4uxVnf84FOrH8T164YDMWoxqJQ22zwd/GM/qzZa8iDtRM
         mUpKusMDlLbSJDoKReF1AFs48/i4sa45scPvOKQoOxrITqweVC2826tkXhE28JZUDc+M
         RPoQ==
X-Gm-Message-State: AOAM530iZzWH0I42SF8MjogFVQDiPmYeWdmRol1weekd6YQ3oSOHYK5r
        NEk6K1bx0TfZkOEQgdQkmILthj/AbuM=
X-Google-Smtp-Source: ABdhPJwA3ZF9n6VL3nUpsUrRHxtx01TJT24QSqOs4SlIy+cyPw6BYoz67SEQ6mIdXs/hFNcdrZ3fLA==
X-Received: by 2002:a1c:4888:: with SMTP id v130mr5135276wma.84.1604622311779;
        Thu, 05 Nov 2020 16:25:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k84sm5115337wmf.42.2020.11.05.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:11 -0800 (PST)
Message-Id: <d3713d88f2bca9eb97eee987e835fb7b6caeedcb.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:57 +0000
Subject: [PATCH v5 14/15] Use new HASHMAP_INIT macro to simplify hashmap
 initialization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Now that hashamp has lazy initialization and a HASHMAP_INIT macro,
hashmaps allocated on the stack can be initialized without a call to
hashmap_init() and in some cases makes the code a bit shorter.  Convert
some callsites over to take advantage of this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 attr.c                  | 26 ++++++++------------------
 bloom.c                 |  3 +--
 builtin/difftool.c      |  9 ++++-----
 range-diff.c            |  4 +---
 revision.c              |  9 +--------
 t/helper/test-hashmap.c |  3 +--
 6 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index a826b2ef1f..4ef85d668b 100644
--- a/attr.c
+++ b/attr.c
@@ -52,13 +52,6 @@ static inline void hashmap_unlock(struct attr_hashmap *map)
 	pthread_mutex_unlock(&map->mutex);
 }
 
-/*
- * The global dictionary of all interned attributes.  This
- * is a singleton object which is shared between threads.
- * Access to this dictionary must be surrounded with a mutex.
- */
-static struct attr_hashmap g_attr_hashmap;
-
 /* The container for objects stored in "struct attr_hashmap" */
 struct attr_hash_entry {
 	struct hashmap_entry ent;
@@ -80,11 +73,14 @@ static int attr_hash_entry_cmp(const void *unused_cmp_data,
 	return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
 }
 
-/* Initialize an 'attr_hashmap' object */
-static void attr_hashmap_init(struct attr_hashmap *map)
-{
-	hashmap_init(&map->map, attr_hash_entry_cmp, NULL, 0);
-}
+/*
+ * The global dictionary of all interned attributes.  This
+ * is a singleton object which is shared between threads.
+ * Access to this dictionary must be surrounded with a mutex.
+ */
+static struct attr_hashmap g_attr_hashmap = {
+	HASHMAP_INIT(attr_hash_entry_cmp, NULL)
+};
 
 /*
  * Retrieve the 'value' stored in a hashmap given the provided 'key'.
@@ -96,9 +92,6 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
 	struct attr_hash_entry k;
 	struct attr_hash_entry *e;
 
-	if (!map->map.tablesize)
-		attr_hashmap_init(map);
-
 	hashmap_entry_init(&k.ent, memhash(key, keylen));
 	k.key = key;
 	k.keylen = keylen;
@@ -114,9 +107,6 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 {
 	struct attr_hash_entry *e;
 
-	if (!map->map.tablesize)
-		attr_hashmap_init(map);
-
 	e = xmalloc(sizeof(struct attr_hash_entry));
 	hashmap_entry_init(&e->ent, memhash(key, keylen));
 	e->key = key;
diff --git a/bloom.c b/bloom.c
index 719c313a1c..b176f28f53 100644
--- a/bloom.c
+++ b/bloom.c
@@ -229,10 +229,9 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	diffcore_std(&diffopt);
 
 	if (diff_queued_diff.nr <= settings->max_changed_paths) {
-		struct hashmap pathmap;
+		struct hashmap pathmap = HASHMAP_INIT(pathmap_cmp, NULL);
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
-		hashmap_init(&pathmap, pathmap_cmp, NULL, 0);
 
 		for (i = 0; i < diff_queued_diff.nr; i++) {
 			const char *path = diff_queued_diff.queue[i]->two->path;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 7ac432b881..6e18e623fd 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -342,7 +342,10 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	const char *workdir, *tmp;
 	int ret = 0, i;
 	FILE *fp;
-	struct hashmap working_tree_dups, submodules, symlinks2;
+	struct hashmap working_tree_dups = HASHMAP_INIT(working_tree_entry_cmp,
+							NULL);
+	struct hashmap submodules = HASHMAP_INIT(pair_cmp, NULL);
+	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
 	struct index_state wtindex;
@@ -383,10 +386,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	rdir_len = rdir.len;
 	wtdir_len = wtdir.len;
 
-	hashmap_init(&working_tree_dups, working_tree_entry_cmp, NULL, 0);
-	hashmap_init(&submodules, pair_cmp, NULL, 0);
-	hashmap_init(&symlinks2, pair_cmp, NULL, 0);
-
 	child.no_stdin = 1;
 	child.git_cmd = 1;
 	child.use_shell = 0;
diff --git a/range-diff.c b/range-diff.c
index befeecae44..b9950f10c8 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -232,11 +232,9 @@ static int patch_util_cmp(const void *dummy, const struct patch_util *a,
 
 static void find_exact_matches(struct string_list *a, struct string_list *b)
 {
-	struct hashmap map;
+	struct hashmap map = HASHMAP_INIT((hashmap_cmp_fn)patch_util_cmp, NULL);
 	int i;
 
-	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
-
 	/* First, add the patches of a to a hash map */
 	for (i = 0; i < a->nr; i++) {
 		struct patch_util *util = a->items[i].util;
diff --git a/revision.c b/revision.c
index f27649d45d..c6e169e3eb 100644
--- a/revision.c
+++ b/revision.c
@@ -124,11 +124,6 @@ static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
 	return strcmp(e1->path, e2->path);
 }
 
-static void paths_and_oids_init(struct hashmap *map)
-{
-	hashmap_init(map, path_and_oids_cmp, NULL, 0);
-}
-
 static void paths_and_oids_clear(struct hashmap *map)
 {
 	struct hashmap_iter iter;
@@ -213,7 +208,7 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 				     struct oidset *trees)
 {
 	unsigned has_interesting = 0, has_uninteresting = 0;
-	struct hashmap map;
+	struct hashmap map = HASHMAP_INIT(path_and_oids_cmp, NULL);
 	struct hashmap_iter map_iter;
 	struct path_and_oids_entry *entry;
 	struct object_id *oid;
@@ -237,8 +232,6 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 	if (!has_uninteresting || !has_interesting)
 		return;
 
-	paths_and_oids_init(&map);
-
 	oidset_iter_init(trees, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
 		struct tree *tree = lookup_tree(r, oid);
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 2475663b49..36ff07bd4b 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -151,12 +151,11 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 int cmd__hashmap(int argc, const char **argv)
 {
 	struct strbuf line = STRBUF_INIT;
-	struct hashmap map;
 	int icase;
+	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &icase);
 
 	/* init hash map */
 	icase = argc > 1 && !strcmp("ignorecase", argv[1]);
-	hashmap_init(&map, test_entry_cmp, &icase, 0);
 
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
-- 
gitgitgadget

