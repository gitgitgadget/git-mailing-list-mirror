Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C196C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhK2W3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhK2W2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:34 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF9C0698E6
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:09 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id r2so19038029ilb.10
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GjnTv67WWRPsnfURvjk45ilOS3yFcPRKz2+khVTLhE=;
        b=IryNj0RSA+jy+BC5dDCnNJJYsPy5jcI8O0W4hXPI+J0z1hzmiFg5t3rkkhcAZaUUZi
         83RJdyEN62W7QOcyS0JF14gwEccuHotyBQoPh3VbO6XTydcKCnAyLEGTPh13sMxkx03K
         iSxiUhFCDozHHR27czIAXV5ACh6RW+d6FI2EyzRD0uzIlvxvl2B4bPZnuIToLiMK6nbQ
         H5a4WJFUcPVvTfyd/RhlvVIn+FbuVd5E7dfkORCCAenqDX7H1JyTYL8Hk5PdB5QNAJTt
         G5Ap4ZRDTnCVACMR3ELsDDI009+OGb/P6xklmhJ1rOq1OrOOHxEY7sii5/SpOBxETD1s
         n0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GjnTv67WWRPsnfURvjk45ilOS3yFcPRKz2+khVTLhE=;
        b=Dd4wFHA9rcFs45Ma0CYTOfvWYp+rxZBiptfUQnAGNWLo5v/EkGWfjg3HF9I85oC64C
         u0sP5CizjNSNwE4W0USC6+t6dG5SEO1Z5qP5NOsyN2dhqpHkx7/Tkd1FgCZIrxnIFJNo
         gpQg/fnY92oo8eOtxCQIPFAnv0uanwWo7zQbt3/AEnJ3tcn+CVDegjy0PZTuzN5XycwN
         iq2CsJUt/dcumrZo68nHSWmJM562pbxLI2i47GbT9nwUeKz9eXZhZ6yuBOWflci9Fztx
         BDrMMudtYgbPuoZDNeACHu64GH+3rxvRI0KNrneuMjUd6LcVFG1qIVNMQ2nu1bK2vVsQ
         JHhA==
X-Gm-Message-State: AOAM532ri9VCi1dVZaRREh/rnFxgVsVxX1iJyrrL7mkkUGplQwpmS2hv
        jma062bhCnVIKDl/UBtCG4mDyH+KDXaRBWep
X-Google-Smtp-Source: ABdhPJwF2BWxczcIOHEiPIzTspMsuJpSotpQMsId2+xcs+m/FkDRc/nL0SBAtBsaFb3YQD/xwHWbew==
X-Received: by 2002:a05:6e02:b45:: with SMTP id f5mr61815412ilu.118.1638224708954;
        Mon, 29 Nov 2021 14:25:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m16sm6914723ilj.45.2021.11.29.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:08 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <7d4ae7bd3e28e2ec904abb37b6f26505e37531c5.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To store the individual mtimes of objects in a cruft pack, introduce a
new `.mtimes` format that can optionally accompany a single pack in the
repository.

The format is defined in Documentation/technical/pack-format.txt, and
stores a 4-byte network order timestamp for each object in name (index)
order.

This patch prepares for cruft packs by defining the `.mtimes` format,
and introducing a basic API that callers can use to read out individual
mtimes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/pack-format.txt |  22 ++++
 Makefile                                |   1 +
 builtin/repack.c                        |   1 +
 object-store.h                          |   5 +-
 pack-mtimes.c                           | 139 ++++++++++++++++++++++++
 pack-mtimes.h                           |  16 +++
 packfile.c                              |  18 ++-
 packfile.h                              |   1 +
 8 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8d2f42f29e..61d8d960e7 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -294,6 +294,28 @@ Pack file entry: <+
 
 All 4-byte numbers are in network order.
 
+== pack-*.mtimes files have the format:
+
+  - A 4-byte magic number '0x4d544d45' ('MTME').
+
+  - A 4-byte version identifier (= 1).
+
+  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
+
+  - A table of mtimes (one per packed object, num_objects in total, each
+    a 4-byte unsigned integer in network order), in the same order as
+    objects appear in the index file (e.g., the first entry in the mtime
+    table corresponds to the object with the lowest lexically-sorted
+    oid). The mtimes count standard epoch seconds.
+
+  - A trailer, containing a:
+
+    checksum of the corresponding packfile, and
+
+    a checksum of all of the above.
+
+All 4-byte numbers are in network order.
+
 == multi-pack-index (MIDX) files have the following format:
 
 The multi-pack-index files refer to multiple pack-files and loose objects.
diff --git a/Makefile b/Makefile
index 12be39ac49..efd5e00717 100644
--- a/Makefile
+++ b/Makefile
@@ -949,6 +949,7 @@ LIB_OBJS += oidtree.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
+LIB_OBJS += pack-mtimes.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82..acbb7b8c3b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -212,6 +212,7 @@ static struct {
 } exts[] = {
 	{".pack"},
 	{".rev", 1},
+	{".mtimes", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
 	{".idx"},
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..d87481f101 100644
--- a/object-store.h
+++ b/object-store.h
@@ -89,12 +89,15 @@ struct packed_git {
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1,
-		 multi_pack_index:1;
+		 multi_pack_index:1,
+		 is_cruft:1;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct revindex_entry *revindex;
 	const uint32_t *revindex_data;
 	const uint32_t *revindex_map;
 	size_t revindex_size;
+	const uint32_t *mtimes_map;
+	size_t mtimes_size;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 };
diff --git a/pack-mtimes.c b/pack-mtimes.c
new file mode 100644
index 0000000000..4c7c00fa67
--- /dev/null
+++ b/pack-mtimes.c
@@ -0,0 +1,139 @@
+#include "pack-mtimes.h"
+#include "object-store.h"
+#include "packfile.h"
+
+static char *pack_mtimes_filename(struct packed_git *p)
+{
+	size_t len;
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		BUG("pack_name does not end in .pack");
+	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
+	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
+}
+
+int pack_has_mtimes(struct packed_git *p)
+{
+	struct stat st;
+	char *fname = pack_mtimes_filename(p);
+
+	if (stat(fname, &st) < 0) {
+		if (errno == ENOENT)
+			return 0;
+		die_errno(_("could not stat %s"), fname);
+	}
+
+	free(fname);
+	return 1;
+}
+
+#define MTIMES_HEADER_SIZE (12)
+#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
+
+struct mtimes_header {
+	uint32_t signature;
+	uint32_t version;
+	uint32_t hash_id;
+};
+
+static int load_pack_mtimes_file(char *mtimes_file,
+				 uint32_t num_objects,
+				 const uint32_t **data_p, size_t *len_p)
+{
+	int fd, ret = 0;
+	struct stat st;
+	void *data = NULL;
+	size_t mtimes_size;
+	uint32_t *hdr;
+
+	fd = git_open(mtimes_file);
+
+	if (fd < 0) {
+		ret = -1;
+		goto cleanup;
+	}
+	if (fstat(fd, &st)) {
+		ret = error_errno(_("failed to read %s"), mtimes_file);
+		goto cleanup;
+	}
+
+	mtimes_size = xsize_t(st.st_size);
+
+	if (mtimes_size < MTIMES_MIN_SIZE) {
+		ret = error(_("mtimes file %s is too small"), mtimes_file);
+		goto cleanup;
+	}
+
+	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
+		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
+		goto cleanup;
+	}
+
+	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	if (ntohl(*hdr) != MTIMES_SIGNATURE) {
+		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
+		goto cleanup;
+	}
+
+	if (ntohl(*++hdr) != 1) {
+		ret = error(_("mtimes file %s has unsupported version %"PRIu32),
+			    mtimes_file, ntohl(*hdr));
+		goto cleanup;
+	}
+	hdr++;
+	if (!(ntohl(*hdr) == 1 || ntohl(*hdr) == 2)) {
+		ret = error(_("mtimes file %s has unsupported hash id %"PRIu32),
+			    mtimes_file, ntohl(*hdr));
+		goto cleanup;
+	}
+
+cleanup:
+	if (ret) {
+		if (data)
+			munmap(data, mtimes_size);
+	} else {
+		*len_p = mtimes_size;
+		*data_p = (const uint32_t *)data;
+	}
+
+	close(fd);
+	return ret;
+}
+
+int load_pack_mtimes(struct packed_git *p)
+{
+	char *mtimes_name = NULL;
+	int ret = 0;
+
+	if (!p->is_cruft)
+		return ret; /* not a cruft pack */
+	if (p->mtimes_map)
+		return ret; /* already loaded */
+
+	ret = open_pack_index(p);
+	if (ret < 0)
+		goto cleanup;
+
+	mtimes_name = pack_mtimes_filename(p);
+	ret = load_pack_mtimes_file(mtimes_name,
+				    p->num_objects,
+				    &p->mtimes_map,
+				    &p->mtimes_size);
+	if (ret)
+		goto cleanup;
+
+cleanup:
+	free(mtimes_name);
+	return ret;
+}
+
+uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)
+{
+	if (!p->mtimes_map)
+		BUG("pack .mtimes file not loaded for %s", p->pack_name);
+	if (p->num_objects <= pos)
+		BUG("pack .mtimes out-of-bounds (%"PRIu32" vs %"PRIu32")",
+		    pos, p->num_objects);
+
+	return get_be32(p->mtimes_map + pos + 3);
+}
diff --git a/pack-mtimes.h b/pack-mtimes.h
new file mode 100644
index 0000000000..ac4247bb5e
--- /dev/null
+++ b/pack-mtimes.h
@@ -0,0 +1,16 @@
+#ifndef PACK_MTIMES_H
+#define PACK_MTIMES_H
+
+#include "git-compat-util.h"
+
+#define MTIMES_SIGNATURE 0x4d544d45 /* "MTME" */
+#define MTIMES_VERSION 1
+
+struct packed_git;
+
+int pack_has_mtimes(struct packed_git *p);
+int load_pack_mtimes(struct packed_git *p);
+
+uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos);
+
+#endif
diff --git a/packfile.c b/packfile.c
index 89402cfc69..ae79ac644e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -333,12 +333,21 @@ void close_pack_revindex(struct packed_git *p) {
 	p->revindex_data = NULL;
 }
 
+void close_pack_mtimes(struct packed_git *p) {
+	if (!p->mtimes_map)
+		return;
+
+	munmap((void *)p->mtimes_map, p->mtimes_size);
+	p->mtimes_map = NULL;
+}
+
 void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
 	close_pack_index(p);
 	close_pack_revindex(p);
+	close_pack_mtimes(p);
 	oidset_clear(&p->bad_objects);
 }
 
@@ -362,7 +371,7 @@ void close_object_store(struct raw_object_store *o)
 
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
-	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
+	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -717,6 +726,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	if (!access(p->pack_name, F_OK))
 		p->pack_promisor = 1;
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".mtimes");
+	if (!access(p->pack_name, F_OK))
+		p->is_cruft = 1;
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
@@ -868,7 +881,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	    ends_with(file_name, ".pack") ||
 	    ends_with(file_name, ".bitmap") ||
 	    ends_with(file_name, ".keep") ||
-	    ends_with(file_name, ".promisor"))
+	    ends_with(file_name, ".promisor") ||
+	    ends_with(file_name, ".mtimes"))
 		string_list_append(data->garbage, full_name);
 	else
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
diff --git a/packfile.h b/packfile.h
index 186146779d..32201d8af7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -91,6 +91,7 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 void close_pack_windows(struct packed_git *);
 void close_pack_revindex(struct packed_git *);
+void close_pack_mtimes(struct packed_git *p);
 void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
-- 
2.34.1.25.gb3157a20e6

