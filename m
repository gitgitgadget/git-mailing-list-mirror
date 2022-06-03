Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C4FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346920AbiFCSkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347239AbiFCSjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348AB50
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x17so11456622wrg.6
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb3ozS1/FnP3aHyFJ0qlNVf7HdVtI6nw/qrFNBu94Q8=;
        b=TxzQO1UFl6XhpM3q5O//zBnxBAWqDmNi+5vjS3OB9i9iRgRcQ7RKSwDdkQ6M569hU4
         mbGgjmMQkkevwTNh2e/zr163fm/OTmKY55sNBt4PQYXnR1KcPHgI7ZbZfLQeIPd7FIYx
         3kSzZU/PlQOPAwt/sJdVJVfimVICrkgOJdpXjsWJJaoIyCYph4iIkbEgetKYgq47mBOl
         4dHRS9phb7K/SddgCD9isj1DPRs3LJy5NnaZCWWKPO1SNUoAqQBSTBd3Zq/Z4/8LfP18
         tuXYxG0K93eDxLtl1Ho/A9QEj9r2I4vxMWjWgEztmnijQ3IXo9HfbYbyKgfXaPOvgSD8
         x06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yb3ozS1/FnP3aHyFJ0qlNVf7HdVtI6nw/qrFNBu94Q8=;
        b=xeFw3bP1or8e6e/XHM3rA8YApFCeJW2yz8HcvQy7dDlt3EuvMNnfwJGWAcl7k1OPTC
         6rdbO9f02SOJWr8eH/u+YjfhE1XwVWOmkNp3FXBbYUgrrmL9JMgWpFdzYLBRLSHM5vGv
         DLJRFiPjmaeUTKcXBCArM85U6zTPvmvMvmDOjQxtCzm2UxT4atOmJwCV3Nzs0Cb7Iw1w
         KUIONsfZD+0Ldy8bcZx7+C7RynJ0shr2pEUkZ9MuE27myNFYlPuY0URAo8LE5ys9a+e+
         D8gVQxQ+pTlGGiV0G6Zm2EWm18V9j9UCTb9gKBtllWP9OvXI6LoiY3bjBUwCAAE+xSmc
         fSPw==
X-Gm-Message-State: AOAM531GV3+88ewu8pTBnzan3s+0uz3hB/j4ntT45LAU/om6bjMN3hMS
        LJ1IfWQ71QcE03h3C/0qV+aRQJRTvns9GA==
X-Google-Smtp-Source: ABdhPJyf/PVC3IwEiK3m2k6eeS1Sqjyv1hhoJXtbNshwCLTvBYmxdF16TkQR2rDh3zQmE4jtz0RsMw==
X-Received: by 2002:a5d:4d8f:0:b0:210:3e14:ff27 with SMTP id b15-20020a5d4d8f000000b002103e14ff27mr9517679wru.81.1654281492768;
        Fri, 03 Jun 2022 11:38:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 13/15] pack-write API: pass down "verify" not arbitrary flags
Date:   Fri,  3 Jun 2022 20:37:50 +0200
Message-Id: <RFC-patch-13.15-63eeb66185a-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the pack-write API to accept a boolean "verify" parameter
instead of passing down the "struct pack_idx_option" flags directly.

This simplifies the code for both humans and machines, e.g. GCC's
-fanalyzer would correctly note that there were potential paths
through this code where we'd deference NULL, but in reality we
wouldn't hit them because certain flags would always go hand-in-hand.

Let's instead separate the underlying API from the total set of flags,
and stop passing the flags down to functions that don't need the full
set of flags, they'll just get the specific state they need.

See e37d0b8730b (builtin/index-pack.c: write reverse indexes,
2021-01-25) for the initial implementation, and [1] for the initial
WIP version of this commit on the ML.

1. https://lore.kernel.org/git/87v93bidhn.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c  |  2 +-
 builtin/index-pack.c   | 35 ++++++++++++++---------------------
 builtin/pack-objects.c |  9 +++------
 midx.c                 |  2 +-
 pack-write.c           | 38 +++++++++++++++++---------------------
 pack.h                 | 15 ++++++---------
 6 files changed, 42 insertions(+), 59 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 28d3193c380..7cd2a3b8203 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -787,7 +787,7 @@ static const char *create_index(void)
 		die("internal consistency error creating the index");
 
 	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
-				 pack_data->hash);
+				 pack_data->hash, 0);
 	free(idx);
 	return tmpfile;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3e385b48002..6691c5836e4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1589,12 +1589,9 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		}
 		return 0;
 	}
-	if (!strcmp(k, "pack.writereverseindex")) {
-		if (git_config_bool(k, v))
-			opts->flags |= WRITE_REV;
-		else
-			opts->flags &= ~WRITE_REV;
-	}
+	if (!strcmp(k, "pack.writereverseindex"))
+		opts->write_rev = git_config_bool(k, v);
+
 	return git_default_config(k, v, cb);
 }
 
@@ -1713,7 +1710,7 @@ static void show_pack_info(int stat_only)
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
+	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
 	const char *curr_index;
 	const char *curr_rev_index = NULL;
 	const char *index_name = NULL, *pack_name = NULL, *rev_index_name = NULL;
@@ -1747,10 +1744,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
-	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
-		rev_index = 1;
-	else
-		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
+	opts.write_rev = git_env_bool(GIT_TEST_WRITE_REV_INDEX,
+				       opts.write_rev);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -1835,9 +1830,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					die(_("unknown hash algorithm '%s'"), arg);
 				repo_set_hash_algo(the_repository, hash_algo);
 			} else if (!strcmp(arg, "--rev-index")) {
-				rev_index = 1;
+				opts.write_rev = 1;
 			} else if (!strcmp(arg, "--no-rev-index")) {
-				rev_index = 0;
+				opts.write_rev = 0;
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1859,9 +1854,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
 
-	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
-	if (rev_index) {
-		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
+	if (opts.write_rev) {
 		if (index_name)
 			rev_index_name = derive_filename(index_name,
 							 "idx", "rev",
@@ -1872,10 +1865,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		if (!index_name)
 			die(_("--verify with no packfile name given"));
 		read_idx_option(&opts, index_name);
-		opts.flags |= WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
 	}
 	if (strict)
-		opts.flags |= WRITE_IDX_STRICT;
+		opts.write_idx_strict = 1;
 
 	if (HAVE_THREADS && !nr_threads) {
 		nr_threads = online_cpus();
@@ -1919,11 +1911,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_hash);
-	if (rev_index)
+	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts,
+				    pack_hash, verify);
+	if (opts.write_rev)
 		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
 						nr_objects, pack_hash,
-						opts.flags);
+						verify);
 	free(idx_objects);
 
 	if (!verify)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 014dcd4bc98..6aeaad8560f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3160,10 +3160,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.writereverseindex")) {
-		if (git_config_bool(k, v))
-			pack_idx_opts.flags |= WRITE_REV;
-		else
-			pack_idx_opts.flags &= ~WRITE_REV;
+		pack_idx_opts.write_rev = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
@@ -4007,8 +4004,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
-	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
-		pack_idx_opts.flags |= WRITE_REV;
+	pack_idx_opts.write_rev = git_env_bool(GIT_TEST_WRITE_REV_INDEX,
+					       pack_idx_opts.write_rev);
 
 	progress = isatty(2);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
diff --git a/midx.c b/midx.c
index 3db0e47735f..f0bb56b2c64 100644
--- a/midx.c
+++ b/midx.c
@@ -905,7 +905,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
 
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
-					midx_hash, WRITE_REV);
+					midx_hash, 0);
 
 	if (finalize_object_file(tmp_file, buf.buf))
 		die(_("cannot store reverse index file"));
diff --git a/pack-write.c b/pack-write.c
index 51812cb1299..7973aa75579 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -44,7 +44,7 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
-			   const unsigned char *sha1)
+			   const unsigned char *sha1, int verify)
 {
 	struct hashfile *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
@@ -65,7 +65,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	else
 		sorted_by_sha = list = last = NULL;
 
-	if (opts->flags & WRITE_IDX_VERIFY) {
+	if (verify) {
 		assert(index_name);
 		f = hashfd_check(index_name);
 	} else {
@@ -117,7 +117,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
 		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
-		if ((opts->flags & WRITE_IDX_STRICT) &&
+		if (opts->write_idx_strict &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
 			    oid_to_hex(&obj->oid));
@@ -159,9 +159,10 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	hashwrite(f, sha1, the_hash_algo->rawsz);
+
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+			  (verify ? 0 : CSUM_FSYNC));
 	return index_name;
 }
 
@@ -216,22 +217,19 @@ const char *write_rev_file(const char *rev_name,
 			   struct pack_idx_entry **objects,
 			   uint32_t nr_objects,
 			   const unsigned char *hash,
-			   unsigned flags)
+			   int verify)
 {
 	uint32_t *pack_order;
 	uint32_t i;
 	const char *ret;
 
-	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
-		return NULL;
-
 	ALLOC_ARRAY(pack_order, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		pack_order[i] = i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
 
 	ret = write_rev_file_order(rev_name, pack_order, nr_objects, hash,
-				   flags);
+				   verify);
 
 	free(pack_order);
 
@@ -242,15 +240,12 @@ const char *write_rev_file_order(const char *rev_name,
 				 uint32_t *pack_order,
 				 uint32_t nr_objects,
 				 const unsigned char *hash,
-				 unsigned flags)
+				 int verify)
 {
 	struct hashfile *f;
 	int fd;
 
-	if ((flags & WRITE_REV) && (flags & WRITE_REV_VERIFY))
-		die(_("cannot both write and verify reverse index"));
-
-	if (flags & WRITE_REV) {
+	if (!verify) {
 		if (!rev_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
 			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
@@ -260,7 +255,7 @@ const char *write_rev_file_order(const char *rev_name,
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		}
 		f = hashfd(fd, rev_name);
-	} else if (flags & WRITE_REV_VERIFY) {
+	} else {
 		struct stat statbuf;
 		if (stat(rev_name, &statbuf)) {
 			if (errno == ENOENT) {
@@ -270,8 +265,7 @@ const char *write_rev_file_order(const char *rev_name,
 				die_errno(_("could not stat: %s"), rev_name);
 		}
 		f = hashfd_check(rev_name);
-	} else
-		return NULL;
+	}
 
 	write_rev_header(f);
 
@@ -283,7 +277,8 @@ const char *write_rev_file_order(const char *rev_name,
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+			  (verify ? 0 : CSUM_FSYNC));
+
 
 	return rev_name;
 }
@@ -494,12 +489,13 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 		die_errno("unable to make temporary pack file readable");
 
 	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
-					       pack_idx_opts, hash);
+					       pack_idx_opts, hash, 0);
 	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
-				      pack_idx_opts->flags);
+	if (pack_idx_opts->write_rev)
+		rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
+					      0);
 
 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
 	if (rev_tmp_name)
diff --git a/pack.h b/pack.h
index 802c047efe6..ccc4c129b0c 100644
--- a/pack.h
+++ b/pack.h
@@ -38,12 +38,8 @@ struct pack_header {
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
 struct pack_idx_option {
-	unsigned flags;
-	/* flag bits */
-#define WRITE_IDX_VERIFY 01 /* verify only, do not write the idx file */
-#define WRITE_IDX_STRICT 02
-#define WRITE_REV 04
-#define WRITE_REV_VERIFY 010
+	unsigned int write_idx_strict:1,
+		     write_rev:1;
 
 	uint32_t version;
 	uint32_t off32_limit;
@@ -84,7 +80,8 @@ typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned lo
 const char *write_idx_file(const char *index_name,
 			   struct pack_idx_entry **objects, int nr_objects,
 			   const struct pack_idx_option *opts,
-			   const unsigned char *sha1);
+			   const unsigned char *sha1,
+			   int verify);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
@@ -99,11 +96,11 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 const char *write_rev_file(const char *rev_name,
 			   struct pack_idx_entry **objects,
 			   uint32_t nr_objects,
-			   const unsigned char *hash, unsigned flags);
+			   const unsigned char *hash, int verify);
 const char *write_rev_file_order(const char *rev_name, uint32_t *pack_order,
 				 uint32_t nr_objects,
 				 const unsigned char *hash,
-				 unsigned flags);
+				 int verify);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
-- 
2.36.1.1124.g577fa9c2ebd

