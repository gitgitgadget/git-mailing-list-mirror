Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1106C4332E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF63123447
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbhANCGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbhAMW3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:29:04 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE3C061794
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:11 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r9so2302721qtp.11
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f1hm3vJlGY6epOAWRkBuswJR30nELgtokm54YWms9BI=;
        b=i0rf3mTJa/Tr9djSRNhz6h4J2F6XyLf/NwBEbJckcOABUY8prN0pelUovj1VYIgwmX
         qNs1B8rM1QWwX0A0CcEgQCiHmax+NoXZblRI1pfE4v6MXeeKNsP4T55gP+Zf9MlHOVVF
         77jjoY+gJylahUcHlTinQBW/vl9UWLYhjf4LzKEfO0CJI2kKQqyg4qLtSAF8Ln9rkLZi
         iMeGl8/ES6NVJz2N3Yu/8Yp9axqRwNh69UVlejo8A6bz4xTl8vK9ZXCcQKvkmGhrjT7a
         No0XvLpPs2w62/w4A9nCjGU7w0DXDYm2a15JiMuO3ktWvyBdBnTBkyzFTg+cyNd3lDZ/
         z5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f1hm3vJlGY6epOAWRkBuswJR30nELgtokm54YWms9BI=;
        b=ePnBPo4di9ZNK3gLIYfVdgEeNaJ3Y05JOhNGAyeFgFinolKHOmmlaRmT1+qxbzIwvs
         PM6+NzkLbpMQOEWzug0iv8OqVMyOU/gE0bKOvwXJbMiDc+c4AoHRjx/zy0wRxm6oYetO
         5u9Luw/G2KnDmyn+R9F+i+j1qRvau8gk/GsCAUiqYqRWHYBHZrQ9kOU8lxSUQx8gcWI3
         5fC4TTN9hrKaXKOwNduiZcX/aq/AJovpoBOLwBQrPVdG0Ow/yZJby0fddbKdcHZjbScj
         FBFuHxYUA9MK/Pgng/4kT8D3b23T7VNbHs6RkdS5G0nfckwCLnfOzkovDGw7sqa7/wl7
         8RiQ==
X-Gm-Message-State: AOAM5313+0dCcFqvDgnp8LhYjzPJDHb68gECSBvRdrCbSmT33MQH4ei6
        O3zX8PQKqaKMJrRASDnxu313lgXzsHJkBQ==
X-Google-Smtp-Source: ABdhPJymLkDEmHht7QOmI63IoWhY+IlNcc22f43bx4aj5v106OLW/FuGZQZokw6UcDRSqt/awEz93g==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr4502598qtn.199.1610576889907;
        Wed, 13 Jan 2021 14:28:09 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id b67sm1902165qkc.44.2021.01.13.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:09 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev' files
Message-ID: <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1610576805.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specify the format of the on-disk reverse index 'pack-*.rev' file, as
well as prepare the code for the existence of such files.

The reverse index maps from pack relative positions (i.e., an index into
the array of object which is sorted by their offsets within the
packfile) to their position within the 'pack-*.idx' file. Today, this is
done by building up a list of (off_t, uint32_t) tuples for each object
(the off_t corresponding to that object's offset, and the uint32_t
corresponding to its position in the index). To convert between pack and
index position quickly, this array of tuples is radix sorted based on
its offset.

This has two major drawbacks:

First, the in-memory cost scales linearly with the number of objects in
a pack.  Each 'struct revindex_entry' is sizeof(off_t) +
sizeof(uint32_t) + padding bytes for a total of 16.

To observe this, force Git to load the reverse index by, for e.g.,
running 'git cat-file --batch-check="%(objectsize:disk)"'. When asking
for a single object in a fresh clone of the kernel, Git needs to
allocate 120+ MB of memory in order to hold the reverse index in memory.

Second, the cost to sort also scales with the size of the pack.
Luckily, this is a linear function since 'load_pack_revindex()' uses a
radix sort, but this cost still must be paid once per pack per process.

As an example, it takes ~60x longer to print the _size_ of an object as
it does to print that entire object's _contents_:

  Benchmark #1: git.compile cat-file --batch <obj
    Time (mean ± σ):       3.4 ms ±   0.1 ms    [User: 3.3 ms, System: 2.1 ms]
    Range (min … max):     3.2 ms …   3.7 ms    726 runs

  Benchmark #2: git.compile cat-file --batch-check="%(objectsize:disk)" <obj
    Time (mean ± σ):     210.3 ms ±   8.9 ms    [User: 188.2 ms, System: 23.2 ms]
    Range (min … max):   193.7 ms … 224.4 ms    13 runs

Instead, avoid computing and sorting the revindex once per process by
writing it to a file when the pack itself is generated.

The format is relatively straightforward. It contains an array of
uint32_t's, the length of which is equal to the number of objects in the
pack.  The ith entry in this table contains the index position of the
ith object in the pack, where "ith object in the pack" is determined by
pack offset.

One thing that the on-disk format does _not_ contain is the full (up to)
eight-byte offset corresponding to each object. This is something that
the in-memory revindex contains (it stores an off_t in 'struct
revindex_entry' along with the same uint32_t that the on-disk format
has). Omit it in the on-disk format, since knowing the index position
for some object is sufficient to get a constant-time lookup in the
pack-*.idx file to ask for an object's offset within the pack.

This trades off between the on-disk size of the 'pack-*.rev' file for
runtime to chase down the offset for some object. Even though the lookup
is constant time, the constant is heavier, since it can potentially
involve two pointer walks in v2 indexes (one to access the 4-byte offset
table, and potentially a second to access the double wide offset table).

Consider trying to map an object's pack offset to a relative position
within that pack. In a cold-cache scenario, more page faults occur while
switching between binary searching through the reverse index and
searching through the *.idx file for an object's offset. Sure enough,
with a cold cache (writing '3' into '/proc/sys/vm/drop_caches' after
'sync'ing), printing out the entire object's contents is still
marginally faster than printing its size:

  Benchmark #1: git.compile cat-file --batch-check="%(objectsize:disk)" <obj >/dev/null
    Time (mean ± σ):      22.6 ms ±   0.5 ms    [User: 2.4 ms, System: 7.9 ms]
    Range (min … max):    21.4 ms …  23.5 ms    41 runs

  Benchmark #2: git.compile cat-file --batch <obj >/dev/null
    Time (mean ± σ):      17.2 ms ±   0.7 ms    [User: 2.8 ms, System: 5.5 ms]
    Range (min … max):    15.6 ms …  18.2 ms    45 runs

(Numbers taken in the kernel after cheating and using the next patch to
generate a reverse index). There are a couple of approaches to improve
cold cache performance not pursued here:

  - We could include the object offsets in the reverse index format.
    Predictably, this does result in fewer page faults, but it triples
    the size of the file, while simultaneously duplicating a ton of data
    already available in the .idx file. (This was the original way I
    implemented the format, and it did show
    `--batch-check='%(objectsize:disk)'` winning out against `--batch`.)

    On the other hand, this increase in size also results in a large
    block-cache footprint, which could potentially hurt other workloads.

  - We could store the mapping from pack to index position in more
    cache-friendly way, like constructing a binary search tree from the
    table and writing the values in breadth-first order. This would
    result in much better locality, but the price you pay is trading
    O(1) lookup in 'pack_pos_to_index()' for an O(log n) one (since you
    can no longer directly index the table).

So, neither of these approaches are taken here. (Thankfully, the format
is versioned, so we are free to pursue these in the future.) But, cold
cache performance likely isn't interesting outside of one-off cases like
asking for the size of an object directly. In real-world usage, Git is
often performing many operations in the revindex,

The trade-off is worth it, since we will avoid the vast majority of the
cost of generating the revindex that the extra pointer chase will look
like noise in the following patch's benchmarks.

This patch describes the format and prepares callers (like in
pack-revindex.c) to be able to read *.rev files once they exist. An
implementation of the writer will appear in the next patch, and callers
will gradually begin to start using the writer in the patches that
follow after that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/pack-format.txt |  17 ++++
 builtin/repack.c                        |   1 +
 object-store.h                          |   3 +
 pack-revindex.c                         | 112 +++++++++++++++++++++---
 pack-revindex.h                         |   7 +-
 packfile.c                              |  13 ++-
 packfile.h                              |   1 +
 tmp-objdir.c                            |   4 +-
 8 files changed, 145 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index f96b2e605f..9593f8bc68 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -259,6 +259,23 @@ Pack file entry: <+
 
     Index checksum of all of the above.
 
+== pack-*.rev files have the format:
+
+  - A 4-byte magic number '0x52494458' ('RIDX').
+
+  - A 4-byte version identifier (= 1)
+
+  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256)
+
+  - A table of index positions, sorted by their corresponding offsets in the
+    packfile.
+
+  - A trailer, containing a:
+
+    checksum of the corresponding packfile, and
+
+    a checksum of all of the above.
+
 == multi-pack-index (MIDX) files have the following format:
 
 The multi-pack-index files refer to multiple pack-files and loose objects.
diff --git a/builtin/repack.c b/builtin/repack.c
index 279be11a16..8d643ddcb9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -208,6 +208,7 @@ static struct {
 } exts[] = {
 	{".pack"},
 	{".idx"},
+	{".rev", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
 };
diff --git a/object-store.h b/object-store.h
index c4fc9dd74e..3fbf11280f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -85,6 +85,9 @@ struct packed_git {
 		 multi_pack_index:1;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct revindex_entry *revindex;
+	const void *revindex_data;
+	const void *revindex_map;
+	size_t revindex_size;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 };
diff --git a/pack-revindex.c b/pack-revindex.c
index 5e69bc7372..369812dd21 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -164,16 +164,98 @@ static void create_pack_revindex(struct packed_git *p)
 	sort_revindex(p->revindex, num_ent, p->pack_size);
 }
 
-int load_pack_revindex(struct packed_git *p)
+static int load_pack_revindex_from_memory(struct packed_git *p)
 {
-	if (!p->revindex) {
-		if (open_pack_index(p))
-			return -1;
-		create_pack_revindex(p);
-	}
+	if (open_pack_index(p))
+		return -1;
+	create_pack_revindex(p);
 	return 0;
 }
 
+static char *pack_revindex_filename(struct packed_git *p)
+{
+	size_t len;
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		BUG("pack_name does not end in .pack");
+	return xstrfmt("%.*s.rev", (int)len, p->pack_name);
+}
+
+#define RIDX_MIN_SIZE (12 + (2 * the_hash_algo->rawsz))
+
+static int load_revindex_from_disk(char *revindex_name,
+				   uint32_t num_objects,
+				   const void **data, size_t *len)
+{
+	int fd, ret = 0;
+	struct stat st;
+	size_t revindex_size;
+
+	fd = git_open(revindex_name);
+
+	if (fd < 0) {
+		ret = -1;
+		goto cleanup;
+	}
+	if (fstat(fd, &st)) {
+		ret = error_errno(_("failed to read %s"), revindex_name);
+		goto cleanup;
+	}
+
+	revindex_size = xsize_t(st.st_size);
+
+	if (revindex_size < RIDX_MIN_SIZE) {
+		ret = error(_("reverse-index file %s is too small"), revindex_name);
+		goto cleanup;
+	}
+
+	if (revindex_size - RIDX_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
+		ret = error(_("reverse-index file %s is corrupt"), revindex_name);
+		goto cleanup;
+	}
+
+	*len = revindex_size;
+	*data = xmmap(NULL, revindex_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+cleanup:
+	close(fd);
+	return ret;
+}
+
+static int load_pack_revindex_from_disk(struct packed_git *p)
+{
+	char *revindex_name;
+	int ret;
+	if (open_pack_index(p))
+		return -1;
+
+	revindex_name = pack_revindex_filename(p);
+
+	ret = load_revindex_from_disk(revindex_name,
+				      p->num_objects,
+				      &p->revindex_map,
+				      &p->revindex_size);
+	if (ret)
+		goto cleanup;
+
+	p->revindex_data = (char *)p->revindex_map + 12;
+
+cleanup:
+	free(revindex_name);
+	return ret;
+}
+
+int load_pack_revindex(struct packed_git *p)
+{
+	if (p->revindex || p->revindex_data)
+		return 0;
+
+	if (!load_pack_revindex_from_disk(p))
+		return 0;
+	else if (!load_pack_revindex_from_memory(p))
+		return 0;
+	return -1;
+}
+
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	unsigned lo, hi;
@@ -203,18 +285,28 @@ int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 
 uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
 {
-	if (!p->revindex)
+	if (!(p->revindex || p->revindex_data))
 		BUG("pack_pos_to_index: reverse index not yet loaded");
 	if (p->num_objects <= pos)
 		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
-	return p->revindex[pos].nr;
+
+	if (p->revindex)
+		return p->revindex[pos].nr;
+	else
+		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));
 }
 
 off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
 {
-	if (!p->revindex)
+	if (!(p->revindex || p->revindex_data))
 		BUG("pack_pos_to_index: reverse index not yet loaded");
 	if (p->num_objects < pos)
 		BUG("pack_pos_to_offset: out-of-bounds object at %"PRIu32, pos);
-	return p->revindex[pos].offset;
+
+	if (p->revindex)
+		return p->revindex[pos].offset;
+	else if (pos == p->num_objects)
+		return p->pack_size - the_hash_algo->rawsz;
+	else
+		return nth_packed_object_offset(p, pack_pos_to_index(p, pos));
 }
diff --git a/pack-revindex.h b/pack-revindex.h
index 6e0320b08b..01622cf21a 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -21,6 +21,9 @@ struct packed_git;
 /*
  * load_pack_revindex populates the revindex's internal data-structures for the
  * given pack, returning zero on success and a negative value otherwise.
+ *
+ * If a '.rev' file is present, it is checked for consistency, mmap'd, and
+ * pointers are assigned into it (instead of using the in-memory variant).
  */
 int load_pack_revindex(struct packed_git *p);
 
@@ -55,7 +58,9 @@ uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
  * If the reverse index has not yet been loaded, or the position is out of
  * bounds, this function aborts.
  *
- * This function runs in constant time.
+ * This function runs in constant time under both in-memory and on-disk reverse
+ * indexes, but an additional step is taken to consult the corresponding .idx
+ * file when using the on-disk format.
  */
 off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
 
diff --git a/packfile.c b/packfile.c
index 7bb1750934..b04eac9286 100644
--- a/packfile.c
+++ b/packfile.c
@@ -324,11 +324,21 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
+void close_pack_revindex(struct packed_git *p) {
+	if (!p->revindex_map)
+		return;
+
+	munmap((void *)p->revindex_map, p->revindex_size);
+	p->revindex_map = NULL;
+	p->revindex_data = NULL;
+}
+
 void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
 	close_pack_index(p);
+	close_pack_revindex(p);
 }
 
 void close_object_store(struct raw_object_store *o)
@@ -351,7 +361,7 @@ void close_object_store(struct raw_object_store *o)
 
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
-	static const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
+	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -853,6 +863,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	if (!strcmp(file_name, "multi-pack-index"))
 		return;
 	if (ends_with(file_name, ".idx") ||
+	    ends_with(file_name, ".rev") ||
 	    ends_with(file_name, ".pack") ||
 	    ends_with(file_name, ".bitmap") ||
 	    ends_with(file_name, ".keep") ||
diff --git a/packfile.h b/packfile.h
index a58fc738e0..4cfec9e8d3 100644
--- a/packfile.h
+++ b/packfile.h
@@ -90,6 +90,7 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 void close_pack_windows(struct packed_git *);
+void close_pack_revindex(struct packed_git *);
 void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 42ed4db5d3..da414df14f 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -187,7 +187,9 @@ static int pack_copy_priority(const char *name)
 		return 2;
 	if (ends_with(name, ".idx"))
 		return 3;
-	return 4;
+	if (ends_with(name, ".rev"))
+		return 4;
+	return 5;
 }
 
 static int pack_copy_cmp(const char *a, const char *b)
-- 
2.30.0.138.g6d7191ea01

