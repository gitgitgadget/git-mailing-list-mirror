Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364911F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeGLTvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41628 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeGLTvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:04 -0400
Received: by mail-qt0-f195.google.com with SMTP id e19-v6so10953569qtp.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3RNeR1iWBiwa1lrzH5Rdn/2GDImvrh2t61bGVgBYgMM=;
        b=ik5FurcMBajpUlSEQwef9bseojj09kryfoQs6J1sSxS/IV9v0PWz4vlddcsPSXOZ1B
         lI+OJqOQ6OHBa3r15NB52Fcgqe/8/Gy7K3nc5G/OoDSxm+ZkqBpOWyBF+Ryn2TiUXcCD
         4ORQTiyg03NvIBlSjpxl8/YNqtuYBQln/Wiq3jrS/4CfDy5zshY66wBMIuKX8D/U2Uxg
         pUKlIVHt6DCXPoDl+b1YrT3rD6V9MVgEBHy6UPRDqI8PcTHNEFvS78CR+OqNHaAx6F5W
         DCBQT0s/x1L9+Wljav6+D1ilzMDIP/3BYTgwVWWV/F6ZI03MpdU3Aut9hHAG44XJEIYy
         Jo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3RNeR1iWBiwa1lrzH5Rdn/2GDImvrh2t61bGVgBYgMM=;
        b=sBUOh6Qs0KgtuawnGQzZuUkceP2kuVSDsBLUBkHHS01vi4/k+7+lVI8t6BKhHzTrj7
         ozYqEVqSzFje2F+NiOjxCo6BjmjhDbcA0yCxkDLd99nV/ay9figGWkZB5KIrMARfN6zO
         /8wl2c9q8adGVFUzscsivEGrx9R3MLHdpw+2Jsf3mEl/JKBPZpw1lZokPdY+k5ZnCVtT
         ZuUmCCAh7NGwtHritDSVI5xsnZe3iM638FngrkSN1PxDX1z2OMVCu7iZGeryBKfz1Jb+
         Pti4K31w8oIr5Hei+WIlcQpNt8kbivY3t9VQkziA2PBrkYpBCzjfMcbKjNHxLZPOcra7
         zqQQ==
X-Gm-Message-State: AOUpUlF/yQwhrFmbdQgy7vdwYS1qNB6NJecUU4avRjbV2c9cz5Yg+KMm
        bUlw+MZ23niFaaGJKUZin3aVgRG/wf4=
X-Google-Smtp-Source: AAOMgpfzfgFMhLXcDsqLt0VR7XNujKkelXCH6QGbk6YZctXeGItGsWEqVg7d3m5QtF6akBpBJ6p3Nw==
X-Received: by 2002:a0c:88ad:: with SMTP id 42-v6mr3949527qvn.61.1531424403332;
        Thu, 12 Jul 2018 12:40:03 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:02 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 00/23] Multi-pack-index (MIDX)
Date:   Thu, 12 Jul 2018 15:39:17 -0400
Message-Id: <20180712193940.21065-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 had a lot of interesting feedback, most of which was non-functional,
but made a big impact on the shape of the patch, especially the test
script.

These are the important changes:

* 'git multi-pack-index' will report usage if the 'write' verb is not
  provided, or if extra parameters are provided. A later series will
  create the 'verify' verb.

* t5319-multi-pack-index.sh has a reoganized way to generate object
  data, so it has fewer code clones.

* 'test-tool read-midx' uses '-' instead of '_'.

* The global 'core_multi_pack_index' is replaced with a one-time call to
  git_config_bool() per repository that loads a multi-pack-index.

* 'struct multi_pack_index' is now defined in midx.h and kept anonymous
  to object-store.h.

* Added a test that 'git repack' removes the multi-pack-index.

* Fixed a doc bug when linking to the technical docs.

I included the diff between the latest ds/multi-pack-index and this
series as part of this message.

You can see the CI builds for Linux, Mac, and Windows linked from the
GitHub pull request [1].

Thanks,
-Stolee

[1] https://github.com/gitgitgadget/git/pull/5

Derrick Stolee (23):
  multi-pack-index: add design document
  multi-pack-index: add format details
  multi-pack-index: add builtin
  multi-pack-index: add 'write' verb
  midx: write header information to lockfile
  multi-pack-index: load into memory
  t5319: expand test data
  packfile: generalize pack directory list
  multi-pack-index: read packfile list
  multi-pack-index: write pack names in chunk
  midx: read pack names into array
  midx: sort and deduplicate objects from packfiles
  midx: write object ids in a chunk
  midx: write object id fanout chunk
  midx: write object offsets
  config: create core.multiPackIndex setting
  midx: read objects from multi-pack-index
  midx: use midx in abbreviation calculations
  midx: use existing midx when writing new one
  midx: use midx in approximate_object_count
  midx: prevent duplicate packfile loads
  packfile: skip loading index if in multi-pack-index
  midx: clear midx on repack

 .gitignore                                   |   3 +-
 Documentation/config.txt                     |   5 +
 Documentation/git-multi-pack-index.txt       |  56 ++
 Documentation/technical/multi-pack-index.txt | 109 +++
 Documentation/technical/pack-format.txt      |  77 ++
 Makefile                                     |   3 +
 builtin.h                                    |   1 +
 builtin/multi-pack-index.c                   |  47 +
 builtin/repack.c                             |   9 +
 command-list.txt                             |   1 +
 git.c                                        |   1 +
 midx.c                                       | 918 +++++++++++++++++++
 midx.h                                       |  44 +
 object-store.h                               |   9 +
 packfile.c                                   | 169 +++-
 packfile.h                                   |   9 +
 sha1-name.c                                  |  70 ++
 t/helper/test-read-midx.c                    |  51 ++
 t/helper/test-tool.c                         |   1 +
 t/helper/test-tool.h                         |   1 +
 t/t5319-multi-pack-index.sh                  | 179 ++++
 21 files changed, 1720 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/git-multi-pack-index.txt
 create mode 100644 Documentation/technical/multi-pack-index.txt
 create mode 100644 builtin/multi-pack-index.c
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100644 t/helper/test-read-midx.c
 create mode 100755 t/t5319-multi-pack-index.sh


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
-- 
2.18.0.118.gd4f65b8d14

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9dcde07a34..25f817ca42 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -910,7 +910,8 @@ core.commitGraph::
 
 core.multiPackIndex::
 	Use the multi-pack-index file to track multiple packfiles using a
-	single index. See link:technical/multi-pack-index[1].
+	single index. See link:technical/multi-pack-index.html[the
+	multi-pack-index design document].
 
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index be97c9372e..a62af1caca 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir <dir>] <verb>
+'git multi-pack-index' [--object-dir=<dir>] <verb>
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ Write or verify a multi-pack-index (MIDX) file.
 OPTIONS
 -------
 
---object-dir <dir>::
+--object-dir=<dir>::
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
@@ -37,7 +37,7 @@ EXAMPLES
 $ git multi-pack-index write
 -----------------------------------------------
 
-* Write a MIDX file for the packfiles in an alternate.
+* Write a MIDX file for the packfiles in an alternate object store.
 +
 -----------------------------------------------
 $ git multi-pack-index --object-dir <alt> write
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 14b32e1373..6a7aa00cf2 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir <dir>] [write]"),
+	N_("git multi-pack-index [--object-dir=<dir>] write"),
 	NULL
 };
 
@@ -18,14 +18,10 @@ int cmd_multi_pack_index(int argc, const char **argv,
 {
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
-		  N_("The object directory containing set of packfile and pack-index pairs")),
+		  N_("object directory containing set of packfile and pack-index pairs")),
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
-
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
@@ -36,11 +32,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		opts.object_dir = get_object_directory();
 
 	if (argc == 0)
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
+		goto usage;
+
+	if (!strcmp(argv[0], "write")) {
+		if (argc > 1)
+			goto usage;
 
-	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
+	}
 
-	return 0;
+usage:
+	usage_with_options(builtin_multi_pack_index_usage,
+			   builtin_multi_pack_index_options);
 }
diff --git a/builtin/repack.c b/builtin/repack.c
index 66a7d8e8ea..7f7cdc8b17 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -335,12 +335,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
-			fname = mkpathdup("%s/pack-%s%s", packdir,
-						item->string, exts[ext].name);
-			if (!file_exists(fname)) {
-				free(fname);
-				continue;
-			}
 
 			if (!midx_cleared) {
 				/* if we move a packfile, it will invalidated the midx */
@@ -348,6 +342,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				midx_cleared = 1;
 			}
 
+			fname = mkpathdup("%s/pack-%s%s", packdir,
+						item->string, exts[ext].name);
+			if (!file_exists(fname)) {
+				free(fname);
+				continue;
+			}
+
 			fname_old = mkpathdup("%s/old-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (file_exists(fname_old))
diff --git a/cache.h b/cache.h
index d12aa49710..89a107a7f7 100644
--- a/cache.h
+++ b/cache.h
@@ -814,7 +814,6 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_commit_graph;
-extern int core_multi_pack_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index 95d8da4243..fbbf0f8e9f 100644
--- a/config.c
+++ b/config.c
@@ -1313,11 +1313,6 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.multipackindex")) {
-		core_multi_pack_index = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index b9bc919cdb..2a6de2330b 100644
--- a/environment.c
+++ b/environment.c
@@ -67,7 +67,6 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_commit_graph;
-int core_multi_pack_index;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/midx.c b/midx.c
index 8afd08f3fe..19b7df338e 100644
--- a/midx.c
+++ b/midx.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "csum-file.h"
 #include "dir.h"
 #include "lockfile.h"
@@ -60,7 +61,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	midx_size = xsize_t(st.st_size);
 
 	if (midx_size < MIDX_MIN_SIZE) {
-		close(fd);
 		error(_("multi-pack-index file %s is too small"), midx_name);
 		goto cleanup_fail;
 	}
@@ -69,8 +69,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 
-	m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
-	strcpy(m->object_dir, object_dir);
+	FLEX_ALLOC_MEM(m, object_dir, object_dir, strlen(object_dir));
 	m->fd = fd;
 	m->data = midx_map;
 	m->data_len = midx_size;
@@ -171,7 +170,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	return m;
 
 cleanup_fail:
-	/* no need to check for NULL when freeing */
 	free(m);
 	free(midx_name);
 	if (midx_map)
@@ -324,8 +322,10 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir)
 {
 	struct multi_pack_index *m = r->objects->multi_pack_index;
 	struct multi_pack_index *m_search;
+	int config_value;
 
-	if (!core_multi_pack_index)
+	if (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
+	    !config_value)
 		return 0;
 
 	for (m_search = m; m_search; m_search = m_search->next)
@@ -382,7 +382,8 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
 
 		packs->list[packs->nr] = add_packed_git(full_path,
-							full_path_len, 0);
+							full_path_len,
+							0);
 
 		if (!packs->list[packs->nr]) {
 			warning(_("failed to add packfile '%s'"),
@@ -661,8 +662,8 @@ static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
 			struct pack_midx_entry *next = list;
 			if (oidcmp(&obj->oid, &next->oid) >= 0)
 				BUG("OIDs not in order: %s >= %s",
-				oid_to_hex(&obj->oid),
-				oid_to_hex(&next->oid));
+				    oid_to_hex(&obj->oid),
+				    oid_to_hex(&next->oid));
 		}
 
 		hashwrite(f, obj->oid.hash, (int)hash_len);
diff --git a/midx.h b/midx.h
index 5a42cbed1d..e3b07f1586 100644
--- a/midx.h
+++ b/midx.h
@@ -3,7 +3,31 @@
 
 #include "repository.h"
 
-struct multi_pack_index;
+struct multi_pack_index {
+	struct multi_pack_index *next;
+
+	int fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	uint32_t signature;
+	unsigned char version;
+	unsigned char hash_len;
+	unsigned char num_chunks;
+	uint32_t num_packs;
+	uint32_t num_objects;
+
+	const unsigned char *chunk_pack_names;
+	const uint32_t *chunk_oid_fanout;
+	const unsigned char *chunk_oid_lookup;
+	const unsigned char *chunk_object_offsets;
+	const unsigned char *chunk_large_offsets;
+
+	const char **pack_names;
+	struct packed_git **packs;
+	char object_dir[FLEX_ARRAY];
+};
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
diff --git a/object-store.h b/object-store.h
index 03cc278758..c2b162489a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -84,31 +84,7 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-struct multi_pack_index {
-	struct multi_pack_index *next;
-
-	int fd;
-
-	const unsigned char *data;
-	size_t data_len;
-
-	uint32_t signature;
-	unsigned char version;
-	unsigned char hash_len;
-	unsigned char num_chunks;
-	uint32_t num_packs;
-	uint32_t num_objects;
-
-	const unsigned char *chunk_pack_names;
-	const uint32_t *chunk_oid_fanout;
-	const unsigned char *chunk_oid_lookup;
-	const unsigned char *chunk_object_offsets;
-	const unsigned char *chunk_large_offsets;
-
-	const char **pack_names;
-	struct packed_git **packs;
-	char object_dir[FLEX_ARRAY];
-};
+struct multi_pack_index;
 
 struct raw_object_store {
 	/*
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 20771d1c1d..8e19972e89 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -1,6 +1,3 @@
-/*
- * test-mktemp.c: code to exercise the creation of temporary files
- */
 #include "test-tool.h"
 #include "cache.h"
 #include "midx.h"
@@ -13,7 +10,7 @@ static int read_midx_file(const char *object_dir)
 	struct multi_pack_index *m = load_multi_pack_index(object_dir);
 
 	if (!m)
-		return 0;
+		return 1;
 
 	printf("header: %08x %d %d %d\n",
 	       m->signature,
@@ -24,15 +21,15 @@ static int read_midx_file(const char *object_dir)
 	printf("chunks:");
 
 	if (m->chunk_pack_names)
-		printf(" pack_names");
+		printf(" pack-names");
 	if (m->chunk_oid_fanout)
-		printf(" oid_fanout");
+		printf(" oid-fanout");
 	if (m->chunk_oid_lookup)
-		printf(" oid_lookup");
+		printf(" oid-lookup");
 	if (m->chunk_object_offsets)
-		printf(" object_offsets");
+		printf(" object-offsets");
 	if (m->chunk_large_offsets)
-		printf(" large_offsets");
+		printf(" large-offsets");
 
 	printf("\nnum_objects: %d\n", m->num_objects);
 
@@ -40,7 +37,7 @@ static int read_midx_file(const char *object_dir)
 	for (i = 0; i < m->num_packs; i++)
 		printf("%s\n", m->pack_names[i]);
 
-	printf("object_dir: %s\n", m->object_dir);
+	printf("object-dir: %s\n", m->object_dir);
 
 	return 0;
 }
@@ -48,7 +45,7 @@ static int read_midx_file(const char *object_dir)
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (argc != 2)
-		usage("read-midx <object_dir>");
+		usage("read-midx <object-dir>");
 
 	return read_midx_file(argv[1]);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 4c630ecab4..5ad6614465 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -11,17 +11,19 @@ midx_read_expect () {
 	NUM_CHUNKS=$3
 	OBJECT_DIR=$4
 	EXTRA_CHUNKS="$5"
-	cat >expect <<-EOF
-	header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
-	chunks: pack_names oid_fanout oid_lookup object_offsets$EXTRA_CHUNKS
-	num_objects: $NUM_OBJECTS
-	packs:
-	EOF
-	if [ $NUM_PACKS -ge 1 ]
-	then
-		ls $OBJECT_DIR/pack/ | grep idx | sort >> expect
-	fi
-	printf "object_dir: $OBJECT_DIR\n" >>expect &&
+	{
+		cat <<-EOF &&
+		header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
+		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
+		num_objects: $NUM_OBJECTS
+		packs:
+		EOF
+		if test $NUM_PACKS -ge 1
+		then
+			ls $OBJECT_DIR/pack/ | grep idx | sort
+		fi &&
+		printf "object-dir: $OBJECT_DIR\n"
+	} >expect &&
 	test-tool read-midx $OBJECT_DIR >actual &&
 	test_cmp expect actual
 }
@@ -32,35 +34,55 @@ test_expect_success 'write midx with no packs' '
 	midx_read_expect 0 0 4 .
 '
 
+generate_objects () {
+	i=$1
+	iii=$(printf '%03i' $i)
+	{
+		test-tool genrandom "bar" 200 &&
+		test-tool genrandom "baz $iii" 50
+	} >wide_delta_$iii &&
+	{
+		test-tool genrandom "foo"$i 100 &&
+		test-tool genrandom "foo"$(( $i + 1 )) 100 &&
+		test-tool genrandom "foo"$(( $i + 2 )) 100
+	} >deep_delta_$iii &&
+	{
+		echo $iii &&
+		test-tool genrandom "$iii" 8192
+	} >file_$iii &&
+	git update-index --add file_$iii deep_delta_$iii wide_delta_$iii
+}
+
+commit_and_list_objects () {
+	{
+		echo 101 &&
+		test-tool genrandom 100 8192;
+	} >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree -p HEAD</dev/null) &&
+	{
+		echo $tree &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list &&
+	git reset --hard $commit
+}
+
 test_expect_success 'create objects' '
+	test_commit initial &&
 	for i in $(test_seq 1 5)
 	do
-		iii=$(printf '%03i' $i)
-		test-tool genrandom "bar" 200 >wide_delta_$iii &&
-		test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
-		test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
-		test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
-		test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
-		echo $iii >file_$iii &&
-		test-tool genrandom "$iii" 8192 >>file_$iii &&
-		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
-		i=$(expr $i + 1) || return 1
+		generate_objects $i
 	done &&
-	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
-	git update-index --add file_101 &&
-	tree=$(git write-tree) &&
-	commit=$(git commit-tree $tree </dev/null) && {
-	echo $tree &&
-	git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
-	} >obj-list &&
-	git update-ref HEAD $commit
+	commit_and_list_objects
 '
 
 test_expect_success 'write midx with one v1 pack' '
-	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
-	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1 17 4 .
+	pack=$(git pack-objects --index-version=1 $objdir/pack/test <obj-list) &&
+	test_when_finished rm $objdir/pack/test-$pack.pack \
+		$objdir/pack/test-$pack.idx $objdir/pack/multi-pack-index &&
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 1 18 4 $objdir
 '
 
 midx_git_two_modes() {
@@ -80,81 +102,33 @@ compare_results_with_midx() {
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list &&
 	git multi-pack-index --object-dir=$objdir write &&
-	midx_read_expect 1 17 4 $objdir
+	midx_read_expect 1 18 4 $objdir
 '
 
-midx_git_two_modes() {
-	git -c core.multiPackIndex=false $1 >expect &&
-	git -c core.multiPackIndex=true $1 >actual &&
-	test_cmp expect actual
-}
-
-compare_results_with_midx() {
-	MSG=$1
-	test_expect_success "check normal git operations: $MSG" '
-		midx_git_two_modes "rev-list --objects --all" &&
-		midx_git_two_modes "log --raw" &&
-		midx_git_two_modes "log --oneline"
-	'
-}
-
 compare_results_with_midx "one v2 pack"
 
-test_expect_success 'Add more objects' '
+test_expect_success 'add more objects' '
 	for i in $(test_seq 6 10)
 	do
-		iii=$(printf '%03i' $i)
-		test-tool genrandom "bar" 200 >wide_delta_$iii &&
-		test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
-		test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
-		test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
-		test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
-		echo $iii >file_$iii &&
-		test-tool genrandom "$iii" 8192 >>file_$iii &&
-		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
-		i=$(expr $i + 1) || return 1
+		generate_objects $i
 	done &&
-	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
-	git update-index --add file_101 &&
-	tree=$(git write-tree) &&
-	commit=$(git commit-tree $tree -p HEAD</dev/null) && {
-	echo $tree &&
-	git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
-	} >obj-list2 &&
-	git update-ref HEAD $commit
+	commit_and_list_objects
 '
 
 test_expect_success 'write midx with two packs' '
-	git pack-objects --index-version=1 $objdir/pack/test-2 <obj-list2 &&
+	git pack-objects --index-version=1 $objdir/pack/test-2 <obj-list &&
 	git multi-pack-index --object-dir=$objdir write &&
-	midx_read_expect 2 33 4 $objdir
+	midx_read_expect 2 34 4 $objdir
 '
 
 compare_results_with_midx "two packs"
 
-test_expect_success 'Add more packs' '
-	for j in $(test_seq 1 10)
+test_expect_success 'add more packs' '
+	for j in $(test_seq 11 20)
 	do
-		iii=$(printf '%03i' $i)
-		test-tool genrandom "bar" 200 >wide_delta_$iii &&
-		test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
-		test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
-		test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
-		test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
-		echo $iii >file_$iii &&
-		test-tool genrandom "$iii" 8192 >>file_$iii &&
-		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
-		{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
-		git update-index --add file_101 &&
-		tree=$(git write-tree) &&
-		commit=$(git commit-tree $tree -p HEAD</dev/null) && {
-		echo $tree &&
-		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
-		} >obj-list &&
-		git update-ref HEAD $commit &&
-		git pack-objects --index-version=2 $objdir/pack/test-pack <obj-list &&
-		i=$(expr $i + 1) || return 1 &&
-		j=$(expr $j + 1) || return 1
+		generate_objects $j &&
+		commit_and_list_objects &&
+		git pack-objects --index-version=2 $objdir/pack/test-pack <obj-list
 	done
 '
 
@@ -162,13 +136,22 @@ compare_results_with_midx "mixed mode (two packs + extra)"
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=$objdir write &&
-	midx_read_expect 12 73 4 $objdir
+	midx_read_expect 12 74 4 $objdir
 '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'repack removes multi-pack-index' '
+	test_path_is_file $objdir/pack/multi-pack-index &&
+	git repack -adf &&
+	test_path_is_missing $objdir/pack/multi-pack-index
+'
+
+compare_results_with_midx "after repack"
+
+
 # usage: corrupt_data <file> <pos> [<data>]
-corrupt_data() {
+corrupt_data () {
 	file=$1
 	pos=$2
 	data="${3:-\0}"
@@ -180,12 +163,17 @@ corrupt_data() {
 test_expect_success 'force some 64-bit offsets with pack-objects' '
 	mkdir objects64 &&
 	mkdir objects64/pack &&
+	for i in $(test_seq 1 11)
+	do
+		generate_objects 11
+	done &&
+	commit_and_list_objects &&
 	pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
 	idx64=objects64/pack/test-64-$pack64.idx &&
 	chmod u+w $idx64 &&
-	corrupt_data $idx64 2899 "\02" &&
-	midx64=$(git multi-pack-index write --object-dir=objects64) &&
-	midx_read_expect 1 62 5 objects64 " large_offsets"
+	corrupt_data $idx64 2999 "\02" &&
+	midx64=$(git multi-pack-index --object-dir=objects64 write) &&
+	midx_read_expect 1 63 5 objects64 " large-offsets"
 '
 
 test_done
