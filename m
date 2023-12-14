Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B62C698
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U8bblx+b"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-589d4033e84so67387eaf.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592632; x=1703197432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7l7hngAwNvJhZLNLsoaio/dfa11PQj0fp8hhM8HT90=;
        b=U8bblx+bhlbPXlbZ1cc3+VLMZ7NZl+FoOOSLN2rt1FP0cd26Al8mRe115zdtZYfzj0
         NYnFxWpeY+zbuzO+l0YVVsqzXJhJbou1tQAV1Wf/DkF8nzEHSORBvbspbacfem5jogsl
         ll4jCUrsAJgNo6G4R75VyZf1dLP2JsaSgB8Tz7O9pWCtnDkJe8QTMg6l5l25J2N2WmRB
         EPUxJQslZSUXTDengX+KthHWgrb0awxOpn19RpbCd0wx+Nb1fIQfKohLgV//TSiY3QvW
         ROcJ286sI3bc6N0fP+YHFOsEbdKFFRsF63qe+duP0H611qsH3e+Uf7E+duTBek6p+0qA
         Nq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592632; x=1703197432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7l7hngAwNvJhZLNLsoaio/dfa11PQj0fp8hhM8HT90=;
        b=TfTwwolBjuNM8KF6uQBInkhee7EXE1//PsuE2fNCfcj6uInw6UOmqKaHUGLndQ9Wtf
         G6jMHzWa9PRSTB6uua0n5h3mbeYxz+Ut71SeQVdFJW6Ju0/bXhr7TLwEorGkQ0lQSwq4
         BOwL0xMoo10D1oK/veNkcTk0nAymZmXC+1hTLjKW2c2iBz9TbNKP9QFkIBUtrYj7PaZS
         w+Is/9i5KYWvFjxtmhIkL8sCKhXd7RYMtlFR3KkZQRdjLc+tCfwGI8Ipu2Gqk/EV7jck
         32oa9sj+MHFiq6Q0eVwtTfVRjrv5Mq2G4oCTpsKcGLELh9BklYJXAhjbE5KabHdpVJ7T
         7JnQ==
X-Gm-Message-State: AOJu0YwNnXKxNkHuDpAGu7hHb0FZBSt09iofHg64/yNGsoWyiPCjOmTx
	k2s5BgDFmQZKp2lZOH8Esiu2WMsxAqUUvFQTDMvwGA==
X-Google-Smtp-Source: AGHT+IFLhkELFWZXnErcZGzsUkYNOI3lMH0OdU1HMg8FTWFWegb+ligLVJhhu/JI6aCKfzCehmN3hg==
X-Received: by 2002:a05:6870:9f82:b0:1fb:75b:99ad with SMTP id xm2-20020a0568709f8200b001fb075b99admr12088026oab.92.1702592632461;
        Thu, 14 Dec 2023 14:23:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id du37-20020a0568703a2500b00203184540easm1448915oab.50.2023.12.14.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:52 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/26] midx: implement `BTMP` chunk
Message-ID: <6fdc68418f196ad4d35866321760c3e4629c7ff7.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

When a multi-pack bitmap is used to implement verbatim pack reuse (that
is, when verbatim chunks from an on-disk packfile are copied
directly[^1]), it does so by using its "preferred pack" as the source
for pack-reuse.

This allows repositories to pack the majority of their objects into a
single (often large) pack, and then use it as the single source for
verbatim pack reuse. This increases the amount of objects that are
reused verbatim (and consequently, decrease the amount of time it takes
to generate many packs). But this performance comes at a cost, which is
that the preferred packfile must pace its growth with that of the entire
repository in order to maintain the utility of verbatim pack reuse.

As repositories grow beyond what we can reasonably store in a single
packfile, the utility of verbatim pack reuse diminishes. Or, at the very
least, it becomes increasingly more expensive to maintain as the pack
grows larger and larger.

It would be beneficial to be able to perform this same optimization over
multiple packs, provided some modest constraints (most importantly, that
the set of packs eligible for verbatim reuse are disjoint with respect
to the subset of their objects being sent).

If we assume that the packs which we treat as candidates for verbatim
reuse are disjoint with respect to any of their objects we may output,
we need to make only modest modifications to the verbatim pack-reuse
code itself. Most notably, we need to remove the assumption that the
bits in the reachability bitmap corresponding to objects from the single
reuse pack begin at the first bit position.

Future patches will unwind these assumptions and reimplement their
existing functionality as special cases of the more general assumptions
(e.g. that reuse bits can start anywhere within the bitset, but happen
to start at 0 for all existing cases).

This patch does not yet relax any of those assumptions. Instead, it
implements a foundational data-structure, the "Bitampped Packs" (`BTMP`)
chunk of the multi-pack index. The `BTMP` chunk's contents are described
in detail here. Importantly, the `BTMP` chunk contains information to
map regions of a multi-pack index's reachability bitmap to the packs
whose objects they represent.

For now, this chunk is only written, not read (outside of the test-tool
used in this patch to test the new chunk's behavior). Future patches
will begin to make use of this new chunk.

[^1]: Modulo patching any `OFS_DELTA`'s that cross over a region of the
  pack that wasn't used verbatim.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.txt | 76 ++++++++++++++++++++++++++++++++
 midx.c                           | 75 +++++++++++++++++++++++++++++--
 midx.h                           |  5 +++
 pack-bitmap.h                    |  9 ++++
 t/helper/test-read-midx.c        | 30 ++++++++++++-
 t/t5319-multi-pack-index.sh      | 35 +++++++++++++++
 6 files changed, 226 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 9fcb29a9c8..d6ae229be5 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -396,6 +396,15 @@ CHUNK DATA:
 	    is padded at the end with between 0 and 3 NUL bytes to make the
 	    chunk size a multiple of 4 bytes.
 
+	Bitmapped Packfiles (ID: {'B', 'T', 'M', 'P'})
+	    Stores a table of two 4-byte unsigned integers in network order.
+	    Each table entry corresponds to a single pack (in the order that
+	    they appear above in the `PNAM` chunk). The values for each table
+	    entry are as follows:
+	    - The first bit position (in pseudo-pack order, see below) to
+	      contain an object from that pack.
+	    - The number of bits whose objects are selected from that pack.
+
 	OID Fanout (ID: {'O', 'I', 'D', 'F'})
 	    The ith entry, F[i], stores the number of OIDs with first
 	    byte at most i. Thus F[255] stores the total
@@ -509,6 +518,73 @@ packs arranged in MIDX order (with the preferred pack coming first).
 The MIDX's reverse index is stored in the optional 'RIDX' chunk within
 the MIDX itself.
 
+=== `BTMP` chunk
+
+The Bitmapped Packfiles (`BTMP`) chunk encodes additional information
+about the objects in the multi-pack index's reachability bitmap. Recall
+that objects from the MIDX are arranged in "pseudo-pack" order (see
+above) for reachability bitmaps.
+
+From the example above, suppose we have packs "a", "b", and "c", with
+10, 15, and 20 objects, respectively. In pseudo-pack order, those would
+be arranged as follows:
+
+    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
+
+When working with single-pack bitmaps (or, equivalently, multi-pack
+reachability bitmaps with a preferred pack), linkgit:git-pack-objects[1]
+performs ``verbatim'' reuse, attempting to reuse chunks of the bitmapped
+or preferred packfile instead of adding objects to the packing list.
+
+When a chunk of bytes is reused from an existing pack, any objects
+contained therein do not need to be added to the packing list, saving
+memory and CPU time. But a chunk from an existing packfile can only be
+reused when the following conditions are met:
+
+  - The chunk contains only objects which were requested by the caller
+    (i.e. does not contain any objects which the caller didn't ask for
+    explicitly or implicitly).
+
+  - All objects stored in non-thin packs as offset- or reference-deltas
+    also include their base object in the resulting pack.
+
+The `BTMP` chunk encodes the necessary information in order to implement
+multi-pack reuse over a set of packfiles as described above.
+Specifically, the `BTMP` chunk encodes three pieces of information (all
+32-bit unsigned integers in network byte-order) for each packfile `p`
+that is stored in the MIDX, as follows:
+
+`bitmap_pos`:: The first bit position (in pseudo-pack order) in the
+  multi-pack index's reachability bitmap occupied by an object from `p`.
+
+`bitmap_nr`:: The number of bit positions (including the one at
+  `bitmap_pos`) that encode objects from that pack `p`.
+
+For example, the `BTMP` chunk corresponding to the above example (with
+packs ``a'', ``b'', and ``c'') would look like:
+
+[cols="1,2,2"]
+|===
+| |`bitmap_pos` |`bitmap_nr`
+
+|packfile ``a''
+|`0`
+|`10`
+
+|packfile ``b''
+|`10`
+|`15`
+
+|packfile ``c''
+|`25`
+|`20`
+|===
+
+With this information in place, we can treat each packfile as
+individually reusable in the same fashion as verbatim pack reuse is
+performed on individual packs prior to the implementation of the `BTMP`
+chunk.
+
 == cruft packs
 
 The cruft packs feature offer an alternative to Git's traditional mechanism of
diff --git a/midx.c b/midx.c
index 8dba67ddbe..de25612b0c 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,7 @@
 
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
+#define MIDX_CHUNKID_BITMAPPEDPACKS 0x42544d50 /* "BTMP" */
 #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
@@ -41,6 +42,7 @@
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
+#define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
 #define PACK_EXPIRED UINT_MAX
@@ -193,6 +195,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
 		   &m->chunk_large_offsets_len);
+	pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
+		   (const unsigned char **)&m->chunk_bitmapped_packs,
+		   &m->chunk_bitmapped_packs_len);
 
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
 		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex,
@@ -286,6 +291,26 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
 	return 0;
 }
 
+int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
+		       struct bitmapped_pack *bp, uint32_t pack_int_id)
+{
+	if (!m->chunk_bitmapped_packs)
+		return error(_("MIDX does not contain the BTMP chunk"));
+
+	if (prepare_midx_pack(r, m, pack_int_id))
+		return error(_("could not load bitmapped pack %"PRIu32), pack_int_id);
+
+	bp->p = m->packs[pack_int_id];
+	bp->bitmap_pos = get_be32((char *)m->chunk_bitmapped_packs +
+				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id);
+	bp->bitmap_nr = get_be32((char *)m->chunk_bitmapped_packs +
+				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id +
+				 sizeof(uint32_t));
+	bp->pack_int_id = pack_int_id;
+
+	return 0;
+}
+
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result)
 {
 	return bsearch_hash(oid->hash, m->chunk_oid_fanout, m->chunk_oid_lookup,
@@ -468,10 +493,16 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+#define BITMAP_POS_UNKNOWN (~((uint32_t)0))
+
 struct pack_info {
 	uint32_t orig_pack_int_id;
 	char *pack_name;
 	struct packed_git *p;
+
+	uint32_t bitmap_pos;
+	uint32_t bitmap_nr;
+
 	unsigned expired : 1;
 };
 
@@ -484,6 +515,7 @@ static void fill_pack_info(struct pack_info *info,
 	info->orig_pack_int_id = orig_pack_int_id;
 	info->pack_name = xstrdup(pack_name);
 	info->p = p;
+	info->bitmap_pos = BITMAP_POS_UNKNOWN;
 }
 
 static int pack_info_compare(const void *_a, const void *_b)
@@ -824,6 +856,26 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
 	return 0;
 }
 
+static int write_midx_bitmapped_packs(struct hashfile *f, void *data)
+{
+	struct write_midx_context *ctx = data;
+	size_t i;
+
+	for (i = 0; i < ctx->nr; i++) {
+		struct pack_info *pack = &ctx->info[i];
+		if (pack->expired)
+			continue;
+
+		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN && pack->bitmap_nr)
+			BUG("pack '%s' has no bitmap position, but has %d bitmapped object(s)",
+			    pack->pack_name, pack->bitmap_nr);
+
+		hashwrite_be32(f, pack->bitmap_pos);
+		hashwrite_be32(f, pack->bitmap_nr);
+	}
+	return 0;
+}
+
 static int write_midx_oid_fanout(struct hashfile *f,
 				 void *data)
 {
@@ -991,8 +1043,19 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	QSORT(data, ctx->entries_nr, midx_pack_order_cmp);
 
 	ALLOC_ARRAY(pack_order, ctx->entries_nr);
-	for (i = 0; i < ctx->entries_nr; i++)
+	for (i = 0; i < ctx->entries_nr; i++) {
+		struct pack_midx_entry *e = &ctx->entries[data[i].nr];
+		struct pack_info *pack = &ctx->info[ctx->pack_perm[e->pack_int_id]];
+		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
+			pack->bitmap_pos = i;
+		pack->bitmap_nr++;
 		pack_order[i] = data[i].nr;
+	}
+	for (i = 0; i < ctx->nr; i++) {
+		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
+		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
+			pack->bitmap_pos = 0;
+	}
 	free(data);
 
 	trace2_region_leave("midx", "midx_pack_order", the_repository);
@@ -1293,6 +1356,7 @@ static int write_midx_internal(const char *object_dir,
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
+	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -1505,8 +1569,10 @@ static int write_midx_internal(const char *object_dir,
 	}
 
 	for (i = 0; i < ctx.nr; i++) {
-		if (!ctx.info[i].expired)
-			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
+		if (ctx.info[i].expired)
+			continue;
+		pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
+		bitmapped_packs_concat_len += 2 * sizeof(uint32_t);
 	}
 
 	/* Check that the preferred pack wasn't expired (if given). */
@@ -1566,6 +1632,9 @@ static int write_midx_internal(const char *object_dir,
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
 			  write_midx_revindex);
+		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
+			  bitmapped_packs_concat_len,
+			  write_midx_bitmapped_packs);
 	}
 
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
diff --git a/midx.h b/midx.h
index a5d98919c8..b404235db5 100644
--- a/midx.h
+++ b/midx.h
@@ -7,6 +7,7 @@
 struct object_id;
 struct pack_entry;
 struct repository;
+struct bitmapped_pack;
 
 #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
 #define GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP \
@@ -33,6 +34,8 @@ struct multi_pack_index {
 
 	const unsigned char *chunk_pack_names;
 	size_t chunk_pack_names_len;
+	const uint32_t *chunk_bitmapped_packs;
+	size_t chunk_bitmapped_packs_len;
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_object_offsets;
@@ -58,6 +61,8 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
+int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
+		       struct bitmapped_pack *bp, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
 off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos);
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 5273a6a019..b68b213388 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -52,6 +52,15 @@ typedef int (*show_reachable_fn)(
 
 struct bitmap_index;
 
+struct bitmapped_pack {
+	struct packed_git *p;
+
+	uint32_t bitmap_pos;
+	uint32_t bitmap_nr;
+
+	uint32_t pack_int_id; /* MIDX only */
+};
+
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index e9a444ddba..e48557aba1 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -100,10 +100,36 @@ static int read_midx_preferred_pack(const char *object_dir)
 	return 0;
 }
 
+static int read_midx_bitmapped_packs(const char *object_dir)
+{
+	struct multi_pack_index *midx = NULL;
+	struct bitmapped_pack pack;
+	uint32_t i;
+
+	setup_git_directory();
+
+	midx = load_multi_pack_index(object_dir, 1);
+	if (!midx)
+		return 1;
+
+	for (i = 0; i < midx->num_packs; i++) {
+		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0)
+			return 1;
+
+		printf("%s\n", pack_basename(pack.p));
+		printf("  bitmap_pos: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_pos);
+		printf("  bitmap_nr: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_nr);
+	}
+
+	close_midx(midx);
+
+	return 0;
+}
+
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects|--checksum|--preferred-pack] <object-dir>");
+		usage("read-midx [--show-objects|--checksum|--preferred-pack|--bitmap] <object-dir>");
 
 	if (!strcmp(argv[1], "--show-objects"))
 		return read_midx_file(argv[2], 1);
@@ -111,5 +137,7 @@ int cmd__read_midx(int argc, const char **argv)
 		return read_midx_checksum(argv[2]);
 	else if (!strcmp(argv[1], "--preferred-pack"))
 		return read_midx_preferred_pack(argv[2]);
+	else if (!strcmp(argv[1], "--bitmap"))
+		return read_midx_bitmapped_packs(argv[2]);
 	return read_midx_file(argv[1], 0);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c20aafe99a..dd09134db0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1171,4 +1171,39 @@ test_expect_success 'reader notices out-of-bounds fanout' '
 	test_cmp expect err
 '
 
+test_expect_success 'bitmapped packs are stored via the BTMP chunk' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for i in 1 2 3 4 5
+		do
+			test_commit "$i" &&
+			git repack -d || return 1
+		done &&
+
+		find $objdir/pack -type f -name "*.idx" | xargs -n 1 basename |
+		sort >packs &&
+
+		git multi-pack-index write --stdin-packs <packs &&
+		test_must_fail test-tool read-midx --bitmap $objdir 2>err &&
+		cat >expect <<-\EOF &&
+		error: MIDX does not contain the BTMP chunk
+		EOF
+		test_cmp expect err &&
+
+		git multi-pack-index write --stdin-packs --bitmap \
+			--preferred-pack="$(head -n1 <packs)" <packs  &&
+		test-tool read-midx --bitmap $objdir >actual &&
+		for i in $(test_seq $(wc -l <packs))
+		do
+			sed -ne "${i}s/\.idx$/\.pack/p" packs &&
+			echo "  bitmap_pos: $((($i - 1) * 3))" &&
+			echo "  bitmap_nr: 3" || return 1
+		done >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.43.0.102.ga31d690331.dirty

