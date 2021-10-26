Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3C1C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748BD60FE8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhJZVD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbhJZVDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:47 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE53C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:23 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h196so1055003iof.2
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P14nP80u28N0gDZjjjFRzYGG4afkmA3T4lsXSvXgew4=;
        b=5e+NOyaOeDsWa6EiyUIc2Ez7a+GwvkIHvswV5QKTQvpW1xDOaVr0gY7mlmTZ2J/0p9
         Dm17GpuIP7VJVHaHn0NWYpr0zDvOGMgFsOlHost0i+YKPMwFPcGyTlSqfUwIqeaGqW5c
         EpuRoHKj/rKfOObeekhYhH7zow6Ncyq5ariMu5apg44j8pkPsYGcccri7mXbelnnKLWN
         PumVtu7lyu22RuUH+B+p6+VPg+dQRjFlO4DIgoVLr61qoWtVjtU0CbFer/Cg3lBTbYYI
         ETXpBbr1ZZsoU51DtXiugXEIpuWaEBS62Bk7NZnU29Q2NOtHtmq4ttEGmhJ4dV/PbWtR
         nMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P14nP80u28N0gDZjjjFRzYGG4afkmA3T4lsXSvXgew4=;
        b=wInE/3JcB53HkLSKbHwtVEHqap4gKa4KDrltL69XHsXpJyOUHb8FCYkMC7NrlWSSJc
         OouzI6OC/ejjwpFRI/1+9Mz0ehdQSfLsv+6oUBnPYq0hn1HrkJXSp/1ouFjgjoW+gZWa
         SWFBzoSkgiyN6d5NMOYF1Tu2fp/BOHy81U8ydd4Pw2bHaNPgvh6y0oASVwS4NM45s+hO
         dA1CCjx87ynzDKiPzeIhpgAJ+zdfFIK1JD5A5gFj9xC9yTy9I5vnnEdg9uuwg2dM697R
         dw1JrqVHIzp1g2VjLx77lUYiGutKJvvVRolNvw5vvT+ylQM1V2QS+3TjiIJmX58ais0K
         aPfQ==
X-Gm-Message-State: AOAM531iI2pgTqNtYPlPl7Pp8+/XYSaR1X3li7l/919TM/2T6HCBfg/T
        Cnjr/gskswS+TrKkgWvgnfo3ldjxH3dI+g==
X-Google-Smtp-Source: ABdhPJxp0GUn5C+CXc8fGHczBnokawHgt5wyZyvTMGNMWQrhUhckrtDtT46M+5ZEgM9SpLonyOBCww==
X-Received: by 2002:a05:6602:134d:: with SMTP id i13mr17047586iov.164.1635282082380;
        Tue, 26 Oct 2021 14:01:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b13sm10243999ilj.55.2021.10.26.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:22 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 7/9] midx.c: write MIDX filenames to strbuf
Message-ID: <0f293ab63825e767043876d951ef6c742a540096.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ask for the name of a MIDX and its corresponding .rev file, callers
invoke get_midx_filename() and get_midx_rev_filename(), respectively.
These both invoke xstrfmt(), allocating a chunk of memory which must be
freed later on.

This makes callers in pack-bitmap.c somewhat awkward. Specifically,
midx_bitmap_filename(), which is implemented like:

    return xstrfmt("%s-%s.bitmap",
                   get_midx_filename(midx->object_dir),
                   hash_to_hex(get_midx_checksum(midx)));

this leaks the second argument to xstrfmt(), which itself was allocated
with xstrfmt(). This caller could assign both the result of
get_midx_filename() and the outer xstrfmt() to a temporary variable,
remembering to free() the former before returning. But that involves a
wasteful copy.

Instead, get_midx_filename() and get_midx_rev_filename() take a strbuf
as an output parameter. This way midx_bitmap_filename() can manipulate
and pass around a temporary buffer which it detaches back to its caller.

That allows us to implement the function without copying or open-coding
get_midx_filename() in a way that doesn't leak.

Update the other callers of get_midx_filename() and
get_midx_rev_filename() accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c          | 59 +++++++++++++++++++++++++++----------------------
 midx.h          |  4 ++--
 pack-bitmap.c   | 15 ++++++++-----
 pack-revindex.c |  8 +++----
 4 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/midx.c b/midx.c
index ad60e48468..837b46b2af 100644
--- a/midx.c
+++ b/midx.c
@@ -57,15 +57,15 @@ const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 	return m->data + m->data_len - the_hash_algo->rawsz;
 }
 
-char *get_midx_filename(const char *object_dir)
+void get_midx_filename(struct strbuf *out, const char *object_dir)
 {
-	return xstrfmt("%s/pack/multi-pack-index", object_dir);
+	strbuf_addf(out, "%s/pack/multi-pack-index", object_dir);
 }
 
-char *get_midx_rev_filename(struct multi_pack_index *m)
+void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
 {
-	return xstrfmt("%s/pack/multi-pack-index-%s.rev",
-		       m->object_dir, hash_to_hex(get_midx_checksum(m)));
+	get_midx_filename(out, m->object_dir);
+	strbuf_addf(out, "-%s.rev", hash_to_hex(get_midx_checksum(m)));
 }
 
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
@@ -89,28 +89,30 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	size_t midx_size;
 	void *midx_map = NULL;
 	uint32_t hash_version;
-	char *midx_name = get_midx_filename(object_dir);
+	struct strbuf midx_name = STRBUF_INIT;
 	uint32_t i;
 	const char *cur_pack_name;
 	struct chunkfile *cf = NULL;
 
-	fd = git_open(midx_name);
+	get_midx_filename(&midx_name, object_dir);
+
+	fd = git_open(midx_name.buf);
 
 	if (fd < 0)
 		goto cleanup_fail;
 	if (fstat(fd, &st)) {
-		error_errno(_("failed to read %s"), midx_name);
+		error_errno(_("failed to read %s"), midx_name.buf);
 		goto cleanup_fail;
 	}
 
 	midx_size = xsize_t(st.st_size);
 
 	if (midx_size < MIDX_MIN_SIZE) {
-		error(_("multi-pack-index file %s is too small"), midx_name);
+		error(_("multi-pack-index file %s is too small"), midx_name.buf);
 		goto cleanup_fail;
 	}
 
-	FREE_AND_NULL(midx_name);
+	strbuf_release(&midx_name);
 
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
@@ -184,7 +186,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 cleanup_fail:
 	free(m);
-	free(midx_name);
+	strbuf_release(&midx_name);
 	free_chunkfile(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
@@ -1131,7 +1133,7 @@ static int write_midx_internal(const char *object_dir,
 			       const char *refs_snapshot,
 			       unsigned flags)
 {
-	char *midx_name;
+	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t i;
 	struct hashfile *f = NULL;
@@ -1142,10 +1144,10 @@ static int write_midx_internal(const char *object_dir,
 	int result = 0;
 	struct chunkfile *cf;
 
-	midx_name = get_midx_filename(object_dir);
-	if (safe_create_leading_directories(midx_name))
+	get_midx_filename(&midx_name, object_dir);
+	if (safe_create_leading_directories(midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
-			  midx_name);
+			  midx_name.buf);
 
 	if (!packs_to_include) {
 		/*
@@ -1374,7 +1376,7 @@ static int write_midx_internal(const char *object_dir,
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
-	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
 	if (ctx.nr - dropped_packs == 0) {
@@ -1411,9 +1413,9 @@ static int write_midx_internal(const char *object_dir,
 		ctx.pack_order = midx_pack_order(&ctx);
 
 	if (flags & MIDX_WRITE_REV_INDEX)
-		write_midx_reverse_index(midx_name, midx_hash, &ctx);
+		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
 	if (flags & MIDX_WRITE_BITMAP) {
-		if (write_midx_bitmap(midx_name, midx_hash, &ctx,
+		if (write_midx_bitmap(midx_name.buf, midx_hash, &ctx,
 				      refs_snapshot, flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
@@ -1443,7 +1445,7 @@ static int write_midx_internal(const char *object_dir,
 	free(ctx.entries);
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
-	free(midx_name);
+	strbuf_release(&midx_name);
 
 	return result;
 }
@@ -1507,20 +1509,22 @@ static void clear_midx_files_ext(const char *object_dir, const char *ext,
 
 void clear_midx_file(struct repository *r)
 {
-	char *midx = get_midx_filename(r->objects->odb->path);
+	struct strbuf midx = STRBUF_INIT;
+
+	get_midx_filename(&midx, r->objects->odb->path);
 
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
 		r->objects->multi_pack_index = NULL;
 	}
 
-	if (remove_path(midx))
-		die(_("failed to clear multi-pack-index at %s"), midx);
+	if (remove_path(midx.buf))
+		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
 	clear_midx_files_ext(r->objects->odb->path, ".bitmap", NULL);
 	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
 
-	free(midx);
+	strbuf_release(&midx);
 }
 
 static int verify_midx_error;
@@ -1573,12 +1577,15 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	if (!m) {
 		int result = 0;
 		struct stat sb;
-		char *filename = get_midx_filename(object_dir);
-		if (!stat(filename, &sb)) {
+		struct strbuf filename = STRBUF_INIT;
+
+		get_midx_filename(&filename, object_dir);
+
+		if (!stat(filename.buf, &sb)) {
 			error(_("multi-pack-index file exists, but failed to parse"));
 			result = 1;
 		}
-		free(filename);
+		strbuf_release(&filename);
 		return result;
 	}
 
diff --git a/midx.h b/midx.h
index 6e32297fa3..b7d79a515c 100644
--- a/midx.h
+++ b/midx.h
@@ -48,8 +48,8 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
-char *get_midx_filename(const char *object_dir);
-char *get_midx_rev_filename(struct multi_pack_index *m);
+void get_midx_filename(struct strbuf *out, const char *object_dir);
+void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f47a0a7db4..3f603425c9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -292,9 +292,12 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
-	return xstrfmt("%s-%s.bitmap",
-		       get_midx_filename(midx->object_dir),
-		       hash_to_hex(get_midx_checksum(midx)));
+	struct strbuf buf = STRBUF_INIT;
+
+	get_midx_filename(&buf, midx->object_dir);
+	strbuf_addf(&buf, "-%s.bitmap", hash_to_hex(get_midx_checksum(midx)));
+
+	return strbuf_detach(&buf, NULL);
 }
 
 char *pack_bitmap_filename(struct packed_git *p)
@@ -324,10 +327,12 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
+		struct strbuf buf = STRBUF_INIT;
+		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s",
-			get_midx_filename(midx->object_dir));
+		warning("ignoring extra bitmap file: %s", buf.buf);
 		close(fd);
+		strbuf_release(&buf);
 		return -1;
 	}
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 0e4a31d9db..70d0fbafcb 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -296,14 +296,14 @@ int load_pack_revindex(struct packed_git *p)
 
 int load_midx_revindex(struct multi_pack_index *m)
 {
-	char *revindex_name;
+	struct strbuf revindex_name = STRBUF_INIT;
 	int ret;
 	if (m->revindex_data)
 		return 0;
 
-	revindex_name = get_midx_rev_filename(m);
+	get_midx_rev_filename(&revindex_name, m);
 
-	ret = load_revindex_from_disk(revindex_name,
+	ret = load_revindex_from_disk(revindex_name.buf,
 				      m->num_objects,
 				      &m->revindex_map,
 				      &m->revindex_len);
@@ -313,7 +313,7 @@ int load_midx_revindex(struct multi_pack_index *m)
 	m->revindex_data = (const uint32_t *)((const char *)m->revindex_map + RIDX_HEADER_SIZE);
 
 cleanup:
-	free(revindex_name);
+	strbuf_release(&revindex_name);
 	return ret;
 }
 
-- 
2.33.0.96.g73915697e6

