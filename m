Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB13C433E2
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175BD61A02
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCZTM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 15:12:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C7C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso3554670wmi.0
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l7+rRrEXV2Q2h6Qz3T+EHOvakWRPdZR7UgWZ8l6HMpA=;
        b=AB4FT5pKuwUCJSLK5EW2SizHSaN3+0hzxJtlEiwLwD2q9Zc5de+N8tRqSV/pp6xa44
         pRtnfSmTCI6/NBBhO3jQVRLTVC1zh8/kYNCITiT8t0Yj2DdE8+Y4nSXgy5egOJiH4p+G
         QKJq5+x+19O/tIdKxIBWFioi9NxWSKf5qvOM7Mky4braOwsqbpqHU0mcvQ+0dYYTIdwt
         MjcoboWlJpbH8DsFd/ZtZ1sW38EvR+OTsM5dVSKXnX0rwgnXxDk+veqMyWDu+x+CrujR
         kFO3f0haqc1mWHWtn9oI8MIV14lXaHuhr7wwo9nkxuyInc3iNVdPe86HU8gq9VNnunv7
         20rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l7+rRrEXV2Q2h6Qz3T+EHOvakWRPdZR7UgWZ8l6HMpA=;
        b=HMmR19qKXLT+qP4Cy5jZr3Qj1lLSR6kKd0MsH4/Qb2Xt+46sZcoYilqthByTpwFNIV
         Kz/axlA4ixrzgl+XsHMP14PtNGR4BRSmjqDWvzVkgMICHjtaIoDxY5BTX2Ah6/8POQoJ
         wFsaSBJRjthGjF4d4Ti/ookq7kPB8W6Y2/kLLnuezBwybJ1xtne66B0c+saiPdtIklmf
         +7Q3ZanK/8eLkdItobM1hw92VmhuFuFYzK6sNalzYr0YzcCBavoEorFXNLb38Pzk2KPr
         rYPP6N3q2TLZei0vDFesRBGWw9/ny6uYEqEM9t/kHTlBmTZYccMeL/4f4HEVB9Ss7g5s
         GSpw==
X-Gm-Message-State: AOAM530a5sC3SMHn3txGFq3/rA9JZjqJfMmTZxBzQgimcNYldRLwiYw4
        vxJwWQEWUtIBfDyCkHpLg2hU0bB1LM8=
X-Google-Smtp-Source: ABdhPJyFCEs6pVgPchPMAPm2u7ISjXSNqlJ+rhsJ+u7IrAunH/1JcQC926ZQb1cgzLpE4Iuvb8XPww==
X-Received: by 2002:a05:600c:2145:: with SMTP id v5mr14445806wml.65.1616785931191;
        Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm15159641wra.8.2021.03.26.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:12:10 -0700 (PDT)
Message-Id: <e2611bbc007a4583af55e006136c2bc74351a7de.1616785928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.git.1616785928.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 19:12:06 +0000
Subject: [PATCH 2/3] read-cache: use hashfile instead of git_hash_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The do_write_index() method in read-cache.c has its own hashing logic
and buffering mechanism. Specifically, the ce_write() method was
introduced by 4990aadc (Speed up index file writing by chunking it
nicely, 2005-04-20) and similar mechanisms were introduced a few months
later in c38138cd (git-pack-objects: write the pack files with a SHA1
csum, 2005-06-26). Based on the timing, in the early days of the Git
codebase, I figured that these roughly equivalent code paths were never
unified only because it got lost in the shuffle. The hashfile API has
since been used extensively in other file formats, such as pack-indexes,
mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to
unify the index writing code to use the same mechanism.

I discovered this disparity while trying to create a new index format
that uses the chunk-format API. That API uses a hashfile as its base, so
it is incompatible with the custom code in read-cache.c.

This rewrite of the logic is rather straightforward, except for the
special case of creating a nested hashfile to handle computing the hash
of the extension data just for the End of Index Entries extension. The
previous change introduced the concept for just this purpose.

The internals of the algorithms are mostly identical. The only
meaningful change is that the buffer sizes are different: 8KB for
hashfile and 128KB in read-cache.c. I was unable to find a performance
difference in these two implementations, despite testing on several repo
sizes. I also tried adjusting the buffer size of the hashfile struct for
a variety of sizes between 8KB and 128KB, and did not see a performance
change for any of the commands that currently use hashfiles.

Some static methods become orphaned in this diff, so I marked them as
MAYBE_UNUSED. The diff is much harder to read if they are deleted during
this change. Instead, they will be deleted in the following change.

In addition to the test suite passing, I computed indexes using the
previous binaries and the binaries compiled after this change, and found
the index data to be exactly equal. Finally, I did extensive performance
testing of "git update-index --really-refresh" on repos of various
sizes, including one with over 2 million paths at HEAD. These tests
demonstrated less than 1% difference in behavior, so the performance
should be considered identical.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 126 +++++++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 64 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5a907af2fb52..b9916350f331 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "csum-file.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1957,7 +1958,7 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
 
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
-static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
+static void write_eoie_extension(struct strbuf *sb, const unsigned char *hash, size_t offset);
 
 struct load_index_extensions
 {
@@ -2470,6 +2471,7 @@ int repo_index_has_changes(struct repository *repo,
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
+MAYBE_UNUSED
 static int ce_write_flush(git_hash_ctx *context, int fd)
 {
 	unsigned int buffered = write_buffer_len;
@@ -2482,6 +2484,7 @@ static int ce_write_flush(git_hash_ctx *context, int fd)
 	return 0;
 }
 
+MAYBE_UNUSED
 static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
@@ -2504,19 +2507,14 @@ static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
-static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoie_context,
-				  int fd, unsigned int ext, unsigned int sz)
+static int write_index_ext_header(struct hashfile *f, unsigned int ext, unsigned int sz)
 {
-	ext = htonl(ext);
-	sz = htonl(sz);
-	if (eoie_context) {
-		the_hash_algo->update_fn(eoie_context, &ext, 4);
-		the_hash_algo->update_fn(eoie_context, &sz, 4);
-	}
-	return ((ce_write(context, fd, &ext, 4) < 0) ||
-		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
+	hashwrite_be32(f, ext);
+	hashwrite_be32(f, sz);
+	return 0;
 }
 
+MAYBE_UNUSED
 static int ce_flush(git_hash_ctx *context, int fd, unsigned char *hash)
 {
 	unsigned int left = write_buffer_len;
@@ -2618,11 +2616,10 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
+static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
 {
 	int size;
-	int result;
 	unsigned int saved_namelen;
 	int stripped_name = 0;
 	static unsigned char padding[8] = { 0x00 };
@@ -2638,11 +2635,9 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 	if (!previous_name) {
 		int len = ce_namelen(ce);
 		copy_cache_entry_to_ondisk(ondisk, ce);
-		result = ce_write(c, fd, ondisk, size);
-		if (!result)
-			result = ce_write(c, fd, ce->name, len);
-		if (!result)
-			result = ce_write(c, fd, padding, align_padding_size(size, len));
+		hashwrite(f, ondisk, size);
+		hashwrite(f, ce->name, len);
+		hashwrite(f, padding, align_padding_size(size, len));
 	} else {
 		int common, to_remove, prefix_size;
 		unsigned char to_remove_vi[16];
@@ -2656,13 +2651,10 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		prefix_size = encode_varint(to_remove, to_remove_vi);
 
 		copy_cache_entry_to_ondisk(ondisk, ce);
-		result = ce_write(c, fd, ondisk, size);
-		if (!result)
-			result = ce_write(c, fd, to_remove_vi, prefix_size);
-		if (!result)
-			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common);
-		if (!result)
-			result = ce_write(c, fd, padding, 1);
+		hashwrite(f, ondisk, size);
+		hashwrite(f, to_remove_vi, prefix_size);
+		hashwrite(f, ce->name + common, ce_namelen(ce) - common);
+		hashwrite(f, padding, 1);
 
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
@@ -2672,7 +2664,7 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		ce->ce_flags &= ~CE_STRIP_NAME;
 	}
 
-	return result;
+	return 0;
 }
 
 /*
@@ -2784,8 +2776,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			  int strip_extensions)
 {
 	uint64_t start = getnanotime();
-	int newfd = tempfile->fd;
-	git_hash_ctx c, eoie_c;
+	struct hashfile *f, *eoie_f;
 	struct cache_header hdr;
 	int i, err = 0, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
@@ -2799,6 +2790,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
 
+	f = hashfd(tempfile->fd, tempfile->filename.buf);
+
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
@@ -2827,9 +2820,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	hdr.hdr_version = htonl(hdr_version);
 	hdr.hdr_entries = htonl(entries - removed);
 
-	the_hash_algo->init_fn(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
-		return -1;
+	hashwrite(f, &hdr, sizeof(hdr));
 
 	if (!HAVE_THREADS || git_config_get_index_threads(&nr_threads))
 		nr_threads = 1;
@@ -2864,12 +2855,12 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		}
 	}
 
-	offset = lseek(newfd, 0, SEEK_CUR);
+	offset = lseek(f->fd, 0, SEEK_CUR);
 	if (offset < 0) {
 		free(ieot);
 		return -1;
 	}
-	offset += write_buffer_len;
+
 	nr = 0;
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 
@@ -2904,14 +2895,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			if (previous_name)
 				previous_name->buf[0] = 0;
 			nr = 0;
-			offset = lseek(newfd, 0, SEEK_CUR);
+
+			offset = lseek(f->fd, 0, SEEK_CUR);
 			if (offset < 0) {
 				free(ieot);
 				return -1;
 			}
-			offset += write_buffer_len;
 		}
-		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
+		if (ce_write_entry(f, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
 
 		if (err)
@@ -2930,14 +2921,21 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return err;
 	}
 
-	/* Write extension data here */
-	offset = lseek(newfd, 0, SEEK_CUR);
+	offset = lseek(f->fd, 0, SEEK_CUR);
 	if (offset < 0) {
 		free(ieot);
 		return -1;
 	}
-	offset += write_buffer_len;
-	the_hash_algo->init_fn(&eoie_c);
+
+	/*
+	 * The extensions must be hashed on their own for use in the EOIE
+	 * extension. Use a nested hashfile to compute the hash for this
+	 * region while passing the buffer to the original hashfile.
+	 */
+	if (offset && record_eoie())
+		eoie_f = nested_hashfile(f);
+	else
+		eoie_f = f;
 
 	/*
 	 * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
@@ -2950,8 +2948,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_ieot_extension(&sb, ieot);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(eoie_f, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0;
+		hashwrite(eoie_f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		free(ieot);
 		if (err)
@@ -2963,9 +2961,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		err = write_link_extension(&sb, istate) < 0 ||
-			write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
-					       sb.len) < 0 ||
-			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+			write_index_ext_header(eoie_f, CACHE_EXT_LINK,
+					       sb.len) < 0;
+		hashwrite(eoie_f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -2974,8 +2972,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(eoie_f, CACHE_EXT_TREE, sb.len) < 0;
+		hashwrite(eoie_f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -2984,9 +2982,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UNDO,
-					     sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(eoie_f, CACHE_EXT_RESOLVE_UNDO,
+					     sb.len) < 0;
+		hashwrite(eoie_f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -2995,9 +2993,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_untracked_extension(&sb, istate->untracked);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
-					     sb.len) < 0 ||
-			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(eoie_f, CACHE_EXT_UNTRACKED,
+					     sb.len) < 0;
+		hashwrite(eoie_f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -3006,8 +3004,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_fsmonitor_extension(&sb, istate);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(eoie_f, CACHE_EXT_FSMONITOR, sb.len) < 0;
+		hashwrite(eoie_f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -3019,19 +3017,21 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * read.  Write it out regardless of the strip_extensions parameter as we need it
 	 * when loading the shared index.
 	 */
-	if (offset && record_eoie()) {
+	if (f != eoie_f) {
 		struct strbuf sb = STRBUF_INIT;
+		unsigned char hash[GIT_MAX_RAWSZ];
 
-		write_eoie_extension(&sb, &eoie_c, offset);
-		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		finalize_hashfile(eoie_f, hash, 0);
+
+		write_eoie_extension(&sb, hash, offset);
+		err = write_index_ext_header(f, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
 	}
 
-	if (ce_flush(&c, newfd, istate->oid.hash))
-		return -1;
+	finalize_hashfile(f, istate->oid.hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
@@ -3568,17 +3568,15 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 	return offset;
 }
 
-static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset)
+static void write_eoie_extension(struct strbuf *sb, const unsigned char *hash, size_t offset)
 {
 	uint32_t buffer;
-	unsigned char hash[GIT_MAX_RAWSZ];
 
 	/* offset */
 	put_be32(&buffer, offset);
 	strbuf_add(sb, &buffer, sizeof(uint32_t));
 
 	/* hash */
-	the_hash_algo->final_fn(hash, eoie_context);
 	strbuf_add(sb, hash, the_hash_algo->rawsz);
 }
 
-- 
gitgitgadget

