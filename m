Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7F41F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeBFAUC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:20:02 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:35196 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFAT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:19:57 -0500
Received: by mail-pl0-f53.google.com with SMTP id j19so129191pll.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UCpASrTq+K2xDMdyuCDlmacJzatVX2AV1hPc0pAsA8c=;
        b=HAqZ2WfGPgHlLqgfpdNMqPzFDLKHdEkGXI2XNgFftleAFGHGnS5c5+XzCLCxtYzmeo
         8u8KNe7RSw8eC44W39qHrHX/WZ0qZ1Xpd0e2CbCWA9TphAJUokfSzsl5J1SV3VU4N2BE
         I0Qb+N6hDFgzyJSRqB8wtyszl/9uzDlc06skej2KqHpH3i+xrd/Bnbx+o9pYObY5UV7j
         KnwXvS8PSvWufVUeJ2UbYEveLqU9pVmox66Ge5Dbw+mM9c1/Lvr1K1JBT+nzLWZxUYRK
         PAtj5BBLHL7PRgWt5S0Bv00MI1q0tLvP1tQo/q9YflZ+cMza2RAN6Sj4a0nIfqD/L4eH
         0j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UCpASrTq+K2xDMdyuCDlmacJzatVX2AV1hPc0pAsA8c=;
        b=YZV76OPqO5OghRZqLzsfr+qIhUsAcVi/xsjaP2NzARiJgUOyXk/JjJYiOMZaN5FWwI
         LmUWDSVIfe31IQ6T+ps2cBG+fW4nnl/yaC6tHdN/PXv3oLiOWUguKC4RYfuwQWlzbFn9
         s1dKhooSIEO8ks0sAmzOcNfGNxaoVs0rdHiKISzSi8QD/baQ9L9vvaTp7JwwmzNbOIK0
         9MhXp7vzdoIXxQ82HPaGoxHT0e8ya727iQAja7FHxI5fmvaKWgciJBQIiMDttwwvBuim
         oKSatgU4xQrwT8HGrQKCNQzaONtp44RgU+KNVkjpoUpQwodIx7BueQM2IGXItJHUkLMd
         12cA==
X-Gm-Message-State: APf1xPCUXNohVCoLQsCtcBenjtKk6yNwMoFj0OfX/doHDShGWQUNCuHv
        MeqZhYFhBAVGXFLS4Va9n6mc3Wiu/Cc=
X-Google-Smtp-Source: AH8x224LPxoiPrAGUzI3gw+A2UFowtI1IumQR5avg8cxhHBYheums5DFQJ3DGM5uZ3GgA6oR17KIOQ==
X-Received: by 2002:a17:902:7c86:: with SMTP id y6-v6mr571178pll.24.1517876395913;
        Mon, 05 Feb 2018 16:19:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b68sm17895870pfg.159.2018.02.05.16.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:19:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 113/194] object-store: add repository argument to read_sha1_file
Date:   Mon,  5 Feb 2018 16:16:28 -0800
Message-Id: <20180206001749.218943-15-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of read_sha1_file to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                               |  7 +++++--
 archive.c                             |  3 ++-
 bisect.c                              |  4 +++-
 blame.c                               |  7 +++++--
 builtin/cat-file.c                    | 15 ++++++++++-----
 builtin/difftool.c                    |  4 +++-
 builtin/fast-export.c                 |  6 ++++--
 builtin/fmt-merge-msg.c               |  3 ++-
 builtin/grep.c                        |  2 +-
 builtin/index-pack.c                  |  6 ++++--
 builtin/log.c                         |  2 +-
 builtin/merge-tree.c                  |  8 ++++++--
 builtin/mktag.c                       |  2 +-
 builtin/notes.c                       |  7 ++++---
 builtin/pack-objects.c                | 17 +++++++++++------
 builtin/reflog.c                      |  3 ++-
 builtin/tag.c                         |  4 ++--
 builtin/unpack-file.c                 |  3 ++-
 builtin/unpack-objects.c              |  3 ++-
 builtin/verify-commit.c               |  2 +-
 bundle.c                              |  2 +-
 combine-diff.c                        |  4 +++-
 commit.c                              |  9 ++++++---
 config.c                              |  2 +-
 contrib/coccinelle/object_store.cocci |  9 +++++++++
 diff.c                                |  3 ++-
 dir.c                                 |  3 ++-
 entry.c                               |  4 +++-
 fast-import.c                         |  9 ++++++---
 fsck.c                                |  3 ++-
 grep.c                                |  4 +++-
 http-push.c                           |  3 ++-
 mailmap.c                             |  3 ++-
 match-trees.c                         |  5 +++--
 merge-blobs.c                         |  7 +++++--
 merge-recursive.c                     |  5 +++--
 notes-cache.c                         |  3 ++-
 notes-merge.c                         |  2 +-
 notes.c                               | 11 +++++++----
 object-store.h                        |  3 ++-
 object.c                              |  2 +-
 read-cache.c                          |  6 ++++--
 ref-filter.c                          |  2 +-
 remote-testsvn.c                      |  5 +++--
 rerere.c                              |  4 +++-
 sha1_file.c                           |  3 ++-
 submodule-config.c                    |  3 ++-
 tag.c                                 |  5 +++--
 tree-walk.c                           |  4 +++-
 tree.c                                |  3 ++-
 xdiff-interface.c                     |  3 ++-
 51 files changed, 162 insertions(+), 80 deletions(-)

diff --git a/apply.c b/apply.c
index de4440cd2a..fa266f6c27 100644
--- a/apply.c
+++ b/apply.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "config.h"
 #include "object-store.h"
+#include "repository.h"
 #include "blob.h"
 #include "delta.h"
 #include "diff.h"
@@ -3181,7 +3182,8 @@ static int apply_binary(struct apply_state *state,
 		unsigned long size;
 		char *result;
 
-		result = read_sha1_file(oid.hash, &type, &size);
+		result = read_sha1_file(the_repository, oid.hash, &type,
+					&size);
 		if (!result)
 			return error(_("the necessary postimage %s for "
 				       "'%s' cannot be read"),
@@ -3243,7 +3245,8 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		unsigned long sz;
 		char *result;
 
-		result = read_sha1_file(oid->hash, &type, &sz);
+		result = read_sha1_file(the_repository, oid->hash, &type,
+					&sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
diff --git a/archive.c b/archive.c
index 2aeafe647d..6f38a5cf55 100644
--- a/archive.c
+++ b/archive.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "refs.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "tree-walk.h"
 #include "attr.h"
@@ -73,7 +74,7 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	const struct commit *commit = args->convert ? args->commit : NULL;
 
 	path += args->baselen;
-	buffer = read_sha1_file(sha1, type, sizep);
+	buffer = read_sha1_file(the_repository, sha1, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
diff --git a/bisect.c b/bisect.c
index c3066bd972..2db384ce2d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -132,7 +132,9 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+		char *buf = read_sha1_file(the_repository,
+					   commit->object.sha1, &type,
+					   &size);
 		const char *subject_start;
 		int subject_len;
 
diff --git a/blame.c b/blame.c
index 1aab6228cc..8648a1ddff 100644
--- a/blame.c
+++ b/blame.c
@@ -299,7 +299,8 @@ static void fill_origin_blob(struct diff_options *opt,
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
-			file->ptr = read_sha1_file(o->blob_oid.hash, &type,
+			file->ptr = read_sha1_file(the_repository,
+						   o->blob_oid.hash, &type,
 						   &file_size);
 		file->size = file_size;
 
@@ -1833,7 +1834,9 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 				    &sb->final_buf_size))
 			;
 		else
-			sb->final_buf = read_sha1_file(o->blob_oid.hash, &type,
+			sb->final_buf = read_sha1_file(the_repository,
+						       o->blob_oid.hash,
+						       &type,
 						       &sb->final_buf_size);
 
 		if (!sb->final_buf)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 96c834b8f4..2ebed86524 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -33,7 +33,7 @@ static int filter_object(const char *path, unsigned mode,
 {
 	enum object_type type;
 
-	*buf = read_sha1_file(oid->hash, &type, size);
+	*buf = read_sha1_file(the_repository, oid->hash, &type, size);
 	if (!*buf)
 		return error(_("cannot read object %s '%s'"),
 			     oid_to_hex(oid), path);
@@ -131,7 +131,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 		if (type == OBJ_BLOB)
 			return stream_blob_to_fd(1, &oid, NULL, 0);
-		buf = read_sha1_file(oid.hash, &type, &size);
+		buf = read_sha1_file(the_repository, oid.hash, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
@@ -142,7 +142,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			struct object_id blob_oid;
 			if (sha1_object_info(the_repository, oid.hash, NULL) == OBJ_TAG) {
-				char *buffer = read_sha1_file(oid.hash, &type, &size);
+				char *buffer = read_sha1_file(the_repository,
+							      oid.hash,
+							      &type, &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
 				    get_oid_hex(target, &blob_oid))
@@ -305,7 +307,9 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 				enum object_type type;
 				if (!textconv_object(data->rest, 0100644, oid,
 						     1, &contents, &size))
-					contents = read_sha1_file(oid->hash, &type,
+					contents = read_sha1_file(the_repository,
+								  oid->hash,
+								  &type,
 								  &size);
 				if (!contents)
 					die("could not convert '%s' %s",
@@ -322,7 +326,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		unsigned long size;
 		void *contents;
 
-		contents = read_sha1_file(oid->hash, &type, &size);
+		contents = read_sha1_file(the_repository, oid->hash, &type,
+					  &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
diff --git a/builtin/difftool.c b/builtin/difftool.c
index d62094060d..32bebbf358 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -21,6 +21,7 @@
 #include "strbuf.h"
 #include "lockfile.h"
 #include "object-store.h"
+#include "repository.h"
 #include "dir.h"
 
 static char *diff_gui_tool;
@@ -307,7 +308,8 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 	} else {
 		enum object_type type;
 		unsigned long size;
-		data = read_sha1_file(oid->hash, &type, &size);
+		data = read_sha1_file(the_repository, oid->hash, &type,
+				      &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
 				oid_to_hex(oid), path);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5d524e7dd2..1562ac4927 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -239,7 +239,8 @@ static void export_blob(const struct object_id *oid)
 		object = (struct object *)lookup_blob(the_repository, oid);
 		eaten = 0;
 	} else {
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_sha1_file(the_repository, oid->hash, &type,
+				     &size);
 		if (!buf)
 			die ("Could not read blob %s", oid_to_hex(oid));
 		if (check_sha1_signature(the_repository, oid->hash, buf, size, typename(type)) < 0)
@@ -686,7 +687,8 @@ static void handle_tag(const char *name, struct tag *tag)
 		return;
 	}
 
-	buf = read_sha1_file(tag->object.oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, tag->object.oid.hash, &type,
+			     &size);
 	if (!buf)
 		die ("Could not read tag %s", oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3e99d10218..ac98556a1d 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -492,7 +492,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		unsigned char *sha1 = origins.items[i].util;
 		enum object_type type;
 		unsigned long size, len;
-		char *buf = read_sha1_file(sha1, &type, &size);
+		char *buf = read_sha1_file(the_repository, sha1, &type,
+					   &size);
 		struct strbuf sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
diff --git a/builtin/grep.c b/builtin/grep.c
index a83e87a676..de1339bfc6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -308,7 +308,7 @@ static void *lock_and_read_oid_file(const struct object_id *oid, enum object_typ
 	void *data;
 
 	grep_read_lock();
-	data = read_sha1_file(oid->hash, type, size);
+	data = read_sha1_file(the_repository, oid->hash, type, size);
 	grep_read_unlock();
 	return data;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0928ed8dd5..b42bf12f65 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -819,7 +819,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
-		has_data = read_sha1_file(oid->hash, &has_type, &has_size);
+		has_data = read_sha1_file(the_repository, oid->hash,
+					  &has_type, &has_size);
 		read_unlock();
 		if (!data)
 			data = new_data = get_data_from_pack(obj_entry);
@@ -1379,7 +1380,8 @@ static void fix_unresolved_deltas(struct sha1file *f)
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		base_obj->data = read_sha1_file(d->sha1, &type, &base_obj->size);
+		base_obj->data = read_sha1_file(the_repository, d->sha1,
+						&type, &base_obj->size);
 		if (!base_obj->data)
 			continue;
 
diff --git a/builtin/log.c b/builtin/log.c
index 529e19ce6f..fce7b07df4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -518,7 +518,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(oid->hash, &type, &size);
+	char *buf = read_sha1_file(the_repository, oid->hash, &type, &size);
 	int offset = 0;
 
 	if (!buf)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 41f1ae30cc..86a8ea3965 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -62,7 +62,9 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	const char *path = entry->path;
 
 	if (!entry->stage)
-		return read_sha1_file(entry->blob->object.oid.hash, &type, size);
+		return read_sha1_file(the_repository,
+				      entry->blob->object.oid.hash, &type,
+				      size);
 	base = NULL;
 	if (entry->stage == 1) {
 		base = entry->blob;
@@ -84,7 +86,9 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 	enum object_type type;
 	while (entry) {
 		if (entry->stage == 2)
-			return read_sha1_file(entry->blob->object.oid.hash, &type, size);
+			return read_sha1_file(the_repository,
+					      entry->blob->object.oid.hash,
+					      &type, size);
 		entry = entry->link;
 	}
 	return NULL;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index d05fdb824a..b6498dbb0e 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -25,7 +25,7 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 	int ret = -1;
 	enum object_type type;
 	unsigned long size;
-	void *buffer = read_sha1_file(sha1, &type, &size);
+	void *buffer = read_sha1_file(the_repository, sha1, &type, &size);
 	const unsigned char *repl = lookup_replace_object(the_repository, sha1);
 
 	if (buffer) {
diff --git a/builtin/notes.c b/builtin/notes.c
index 18128eb439..56d99c2789 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -124,7 +124,7 @@ static void copy_obj_to_fd(int fd, const unsigned char *sha1)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(sha1, &type, &size);
+	char *buf = read_sha1_file(the_repository, sha1, &type, &size);
 	if (buf) {
 		if (size)
 			write_or_die(fd, buf, size);
@@ -255,7 +255,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (get_oid(arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_sha1_file(object.hash, &type, &len))) {
+	if (!(buf = read_sha1_file(the_repository, object.hash, &type, &len))) {
 		free(buf);
 		die(_("failed to read object '%s'."), arg);
 	}
@@ -610,7 +610,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		char *prev_buf = read_sha1_file(note->hash, &type, &size);
+		char *prev_buf = read_sha1_file(the_repository, note->hash,
+						&type, &size);
 
 		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fae579f12a..128e5e3676 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -123,10 +123,12 @@ static void *get_delta(struct object_entry *entry)
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
-	buf = read_sha1_file(entry->idx.oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, entry->idx.oid.hash, &type,
+			     &size);
 	if (!buf)
 		die("unable to read %s", oid_to_hex(&entry->idx.oid));
-	base_buf = read_sha1_file(entry->delta->idx.oid.hash, &type,
+	base_buf = read_sha1_file(the_repository, entry->delta->idx.oid.hash,
+				  &type,
 				  &base_size);
 	if (!base_buf)
 		die("unable to read %s",
@@ -271,7 +273,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
-			buf = read_sha1_file(entry->idx.oid.hash, &type,
+			buf = read_sha1_file(the_repository,
+					     entry->idx.oid.hash, &type,
 					     &size);
 			if (!buf)
 				die(_("unable to read %s"),
@@ -1193,7 +1196,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = read_sha1_file(oid->hash, &type, &size);
+	data = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!data)
 		return NULL;
 	if (type != OBJ_TREE) {
@@ -1877,7 +1880,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Load data if not already done */
 	if (!trg->data) {
 		read_lock();
-		trg->data = read_sha1_file(trg_entry->idx.oid.hash, &type,
+		trg->data = read_sha1_file(the_repository,
+					   trg_entry->idx.oid.hash, &type,
 					   &sz);
 		read_unlock();
 		if (!trg->data)
@@ -1891,7 +1895,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->data) {
 		read_lock();
-		src->data = read_sha1_file(src_entry->idx.oid.hash, &type,
+		src->data = read_sha1_file(the_repository,
+					   src_entry->idx.oid.hash, &type,
 					   &sz);
 		read_unlock();
 		if (!src->data) {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index e12b99e9cb..3b600966e3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -76,7 +76,8 @@ static int tree_is_complete(const struct object_id *oid)
 	if (!tree->buffer) {
 		enum object_type type;
 		unsigned long size;
-		void *data = read_sha1_file(oid->hash, &type, &size);
+		void *data = read_sha1_file(the_repository, oid->hash, &type,
+					    &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index 1fad1e6733..59db44447f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -169,7 +169,7 @@ static void write_tag_body(int fd, const struct object_id *oid)
 	enum object_type type;
 	char *buf, *sp;
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!buf)
 		return;
 	/* skip header */
@@ -301,7 +301,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		strbuf_addstr(sb, "object of unknown type");
 		break;
 	case OBJ_COMMIT:
-		if ((buf = read_sha1_file(oid->hash, &type, &size)) != NULL) {
+		if ((buf = read_sha1_file(the_repository, oid->hash, &type, &size)) != NULL) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index b28e056c74..2e9aeaf0da 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "object-store.h"
+#include "repository.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
@@ -10,7 +11,7 @@ static char *create_temp_file(struct object_id *oid)
 	unsigned long size;
 	int fd;
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6b8fb918b6..d8175cecd6 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -423,7 +423,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
 		return;
 
-	base = read_sha1_file(base_oid.hash, &type, &base_size);
+	base = read_sha1_file(the_repository, base_oid.hash, &type,
+			      &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index b0ae18ec33..17641b6097 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -47,7 +47,7 @@ static int verify_commit(const char *name, unsigned flags)
 	if (get_oid(name, &oid))
 		return error("commit '%s' not found.", name);
 
-	buf = read_sha1_file(oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid.hash, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.", name);
 	if (type != OBJ_COMMIT)
diff --git a/bundle.c b/bundle.c
index d9579f851e..abe158b59c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -227,7 +227,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	if (revs->max_age == -1 && revs->min_age == -1)
 		goto out;
 
-	buf = read_sha1_file(tag->oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, tag->oid.hash, &type, &size);
 	if (!buf)
 		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
diff --git a/combine-diff.c b/combine-diff.c
index f45ab6f57c..8f6ac31252 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "blob.h"
 #include "diff.h"
@@ -307,7 +308,8 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = read_sha1_file(oid->hash, &type, size);
+		blob = read_sha1_file(the_repository, oid->hash, &type,
+				      size);
 		if (type != OBJ_BLOB)
 			die("object '%s' is not a blob!", oid_to_hex(oid));
 	}
diff --git a/commit.c b/commit.c
index 8e42af7565..2fb702795c 100644
--- a/commit.c
+++ b/commit.c
@@ -277,7 +277,8 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_sha1_file(commit->object.oid.hash, &type, &size);
+		ret = read_sha1_file(the_repository, commit->object.oid.hash,
+				     &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
@@ -395,7 +396,8 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
+	buffer = read_sha1_file(the_repository, item->object.oid.hash, &type,
+				&size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
@@ -1234,7 +1236,8 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	desc = merge_remote_util(parent);
 	if (!desc || !desc->obj)
 		return;
-	buf = read_sha1_file(desc->obj->oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, desc->obj->oid.hash, &type,
+			     &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
 	len = parse_signature(buf, size);
diff --git a/config.c b/config.c
index e617c2018d..c023740c97 100644
--- a/config.c
+++ b/config.c
@@ -1480,7 +1480,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	unsigned long size;
 	int ret;
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!buf)
 		return error("unable to load config blob object '%s'", name);
 	if (type != OBJ_BLOB) {
diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index 915dd176dd..72066e3768 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -25,3 +25,12 @@ expression H;
  read_sha1_file_extended(
 +the_repository,
  E, F, G, H)
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+ read_sha1_file(
++the_repository,
+ E, F, G)
diff --git a/diff.c b/diff.c
index 08bff6e720..9ad272b5cb 100644
--- a/diff.c
+++ b/diff.c
@@ -3629,7 +3629,8 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 				return 0;
 			}
 		}
-		s->data = read_sha1_file(s->oid.hash, &type, &s->size);
+		s->data = read_sha1_file(the_repository, s->oid.hash, &type,
+					 &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
 		s->should_free = 1;
diff --git a/dir.c b/dir.c
index 4a7981abc4..e4f49636ca 100644
--- a/dir.c
+++ b/dir.c
@@ -12,6 +12,7 @@
 #include "config.h"
 #include "dir.h"
 #include "object-store.h"
+#include "repository.h"
 #include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
@@ -246,7 +247,7 @@ static int do_read_blob(const struct object_id *oid,
 	*size_out = 0;
 	*data_out = NULL;
 
-	data = read_sha1_file(oid->hash, &type, &sz);
+	data = read_sha1_file(the_repository, oid->hash, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return -1;
diff --git a/entry.c b/entry.c
index 02aa09bc83..4fa34741af 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "object-store.h"
+#include "repository.h"
 #include "dir.h"
 #include "streaming.h"
 #include "submodule.h"
@@ -86,7 +87,8 @@ static int create_file(const char *path, unsigned int mode)
 static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
-	void *new = read_sha1_file(ce->oid.hash, &type, size);
+	void *new = read_sha1_file(the_repository, ce->oid.hash, &type,
+				   size);
 
 	if (new) {
 		if (type == OBJ_BLOB)
diff --git a/fast-import.c b/fast-import.c
index 54c2e10656..b1ff3d47df 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1412,7 +1412,8 @@ static void load_tree(struct tree_entry *root)
 			die("Can't load tree %s", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_sha1_file(the_repository, oid->hash, &type,
+				     &size);
 		if (!buf || type != OBJ_TREE)
 			die("Can't load tree %s", oid_to_hex(oid));
 	}
@@ -2973,7 +2974,8 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	char *buf;
 
 	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_sha1_file(the_repository, oid->hash, &type,
+				     &size);
 	} else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
@@ -3079,7 +3081,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
-		buf = read_sha1_file(oid->hash, &unused, &size);
+		buf = read_sha1_file(the_repository, oid->hash, &unused,
+				     &size);
 	}
 	if (!buf)
 		die("Can't load object %s", oid_to_hex(oid));
diff --git a/fsck.c b/fsck.c
index af0291121d..5144ceb8e2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -813,7 +813,8 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		enum object_type type;
 
 		buffer = to_free =
-			read_sha1_file(tag->object.oid.hash, &type, &size);
+			read_sha1_file(the_repository, tag->object.oid.hash,
+				       &type, &size);
 		if (!buffer)
 			return report(options, &tag->object,
 				FSCK_MSG_MISSING_TAG_OBJECT,
diff --git a/grep.c b/grep.c
index 6bccd7c7ea..c8e27ec6e2 100644
--- a/grep.c
+++ b/grep.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "grep.h"
 #include "object-store.h"
+#include "repository.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 #include "diff.h"
@@ -2011,7 +2012,8 @@ static int grep_source_load_oid(struct grep_source *gs)
 	enum object_type type;
 
 	grep_read_lock();
-	gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
+	gs->buf = read_sha1_file(the_repository, gs->identifier, &type,
+				 &gs->size);
 	grep_read_unlock();
 
 	if (!gs->buf)
diff --git a/http-push.c b/http-push.c
index 7cefc2df76..c7fa9ee15a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -364,7 +364,8 @@ static void start_put(struct transfer_request *request)
 	ssize_t size;
 	git_zstream stream;
 
-	unpacked = read_sha1_file(request->obj->oid.hash, &type, &len);
+	unpacked = read_sha1_file(the_repository, request->obj->oid.hash,
+				  &type, &len);
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
diff --git a/mailmap.c b/mailmap.c
index 6afa9cc56d..1830e9d2a3 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -2,6 +2,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-store.h"
+#include "repository.h"
 
 #define DEBUG_MAILMAP 0
 #if DEBUG_MAILMAP
@@ -225,7 +226,7 @@ static int read_mailmap_blob(struct string_list *map,
 	if (get_oid(name, &oid) < 0)
 		return 0;
 
-	buf = read_sha1_file(oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid.hash, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB)
diff --git a/match-trees.c b/match-trees.c
index bdfdfcaaab..af77d78e63 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -2,6 +2,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "object-store.h"
+#include "repository.h"
 
 static int score_missing(unsigned mode, const char *path)
 {
@@ -55,7 +56,7 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 	enum object_type type;
 	unsigned long size;
 
-	buffer = read_sha1_file(hash->hash, &type, &size);
+	buffer = read_sha1_file(the_repository, hash->hash, &type, &size);
 	if (!buffer)
 		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
@@ -183,7 +184,7 @@ static int splice_tree(const unsigned char *hash1,
 	if (*subpath)
 		subpath++;
 
-	buf = read_sha1_file(hash1, &type, &sz);
+	buf = read_sha1_file(the_repository, hash1, &type, &sz);
 	if (!buf)
 		die("cannot read tree %s", sha1_to_hex(hash1));
 	init_tree_desc(&desc, buf, sz);
diff --git a/merge-blobs.c b/merge-blobs.c
index f5e71bcd9b..4c69509bf8 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "merge-blobs.h"
 #include "object-store.h"
+#include "repository.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
@@ -12,7 +13,8 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 	unsigned long size;
 	enum object_type type;
 
-	buf = read_sha1_file(obj->object.oid.hash, &type, &size);
+	buf = read_sha1_file(the_repository, obj->object.oid.hash, &type,
+			     &size);
 	if (!buf)
 		return -1;
 	if (type != OBJ_BLOB) {
@@ -67,7 +69,8 @@ void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct
 			return NULL;
 		if (!our)
 			our = their;
-		return read_sha1_file(our->object.oid.hash, &type, size);
+		return read_sha1_file(the_repository, our->object.oid.hash,
+				      &type, size);
 	}
 
 	if (fill_mmfile_blob(&f1, our) < 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index 8b6984cdd7..0b4cb14773 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -825,7 +825,8 @@ static int update_file_flags(struct merge_options *o,
 			goto update_index;
 		}
 
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_sha1_file(the_repository, oid->hash, &type,
+				     &size);
 		if (!buf)
 			return err(o, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
 		if (type != OBJ_BLOB) {
@@ -1629,7 +1630,7 @@ static int read_oid_strbuf(struct merge_options *o,
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!buf)
 		return err(o, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
diff --git a/notes-cache.c b/notes-cache.c
index 6348baeb07..a4a6ccab97 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -79,7 +79,8 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
 		return NULL;
-	value = read_sha1_file(value_oid->hash, &type, &size);
+	value = read_sha1_file(the_repository, value_oid->hash, &type,
+			       &size);
 
 	*outsize = size;
 	return value;
diff --git a/notes-merge.c b/notes-merge.c
index ea701827ba..02729fc474 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -324,7 +324,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 {
 	enum object_type type;
 	unsigned long size;
-	void *buf = read_sha1_file(note->hash, &type, &size);
+	void *buf = read_sha1_file(the_repository, note->hash, &type, &size);
 
 	if (!buf)
 		die("cannot read note %s for object %s",
diff --git a/notes.c b/notes.c
index b1478a8dca..369af2ee15 100644
--- a/notes.c
+++ b/notes.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "notes.h"
 #include "object-store.h"
+#include "repository.h"
 #include "blob.h"
 #include "tree.h"
 #include "utf8.h"
@@ -797,13 +798,15 @@ int combine_notes_concatenate(unsigned char *cur_sha1,
 
 	/* read in both note blob objects */
 	if (!is_null_sha1(new_sha1))
-		new_msg = read_sha1_file(new_sha1, &new_type, &new_len);
+		new_msg = read_sha1_file(the_repository, new_sha1, &new_type,
+					 &new_len);
 	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
 		free(new_msg);
 		return 0;
 	}
 	if (!is_null_sha1(cur_sha1))
-		cur_msg = read_sha1_file(cur_sha1, &cur_type, &cur_len);
+		cur_msg = read_sha1_file(the_repository, cur_sha1, &cur_type,
+					 &cur_len);
 	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
 		free(cur_msg);
 		free(new_msg);
@@ -859,7 +862,7 @@ static int string_list_add_note_lines(struct string_list *list,
 		return 0;
 
 	/* read_sha1_file NUL-terminates */
-	data = read_sha1_file(sha1, &t, &len);
+	data = read_sha1_file(the_repository, sha1, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
 		return t != OBJ_BLOB || !data;
@@ -1217,7 +1220,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = read_sha1_file(oid->hash, &type, &msglen)) || type != OBJ_BLOB) {
+	if (!(msg = read_sha1_file(the_repository, oid->hash, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/object-store.h b/object-store.h
index d6462cd9f1..974f2de78d 100644
--- a/object-store.h
+++ b/object-store.h
@@ -86,7 +86,8 @@ struct packed_git {
 extern void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
 				     enum object_type *type,
 				     unsigned long *size, int lookup_replace);
-static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+#define read_sha1_file(r, s, t, sz) read_sha1_file_##r(s, t, sz)
+static inline void *read_sha1_file_the_repository(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
 	return read_sha1_file_extended(the_repository, sha1, type, size, 1);
 }
diff --git a/object.c b/object.c
index 85b0360e0a..28f536dcae 100644
--- a/object.c
+++ b/object.c
@@ -268,7 +268,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 		return lookup_object(the_repository, oid->hash);
 	}
 
-	buffer = read_sha1_file(oid->hash, &type, &size);
+	buffer = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (buffer) {
 		if (check_sha1_signature(the_repository, repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
diff --git a/read-cache.c b/read-cache.c
index 45cad9272a..0df9c2d7b7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "object-store.h"
+#include "repository.h"
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
@@ -185,7 +186,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 	if (strbuf_readlink(&sb, ce->name, expected_size))
 		return -1;
 
-	buffer = read_sha1_file(ce->oid.hash, &type, &size);
+	buffer = read_sha1_file(the_repository, ce->oid.hash, &type, &size);
 	if (buffer) {
 		if (size == sb.len)
 			match = memcmp(buffer, sb.buf, size);
@@ -2671,7 +2672,8 @@ void *read_blob_data_from_index(const struct index_state *istate,
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz);
+	data = read_sha1_file(the_repository, istate->cache[pos]->oid.hash,
+			      &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
diff --git a/ref-filter.c b/ref-filter.c
index 256887b585..32e2c1cbfc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -730,7 +730,7 @@ int verify_ref_format(struct ref_format *format)
 static void *get_obj(const struct object_id *oid, struct object **obj, unsigned long *sz, int *eaten)
 {
 	enum object_type type;
-	void *buf = read_sha1_file(oid->hash, &type, sz);
+	void *buf = read_sha1_file(the_repository, oid->hash, &type, sz);
 
 	if (buf)
 		*obj = parse_object_buffer(the_repository, oid, type, *sz,
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 387d4ae935..d27cdce87f 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "object-store.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "url.h"
 #include "exec_cmd.h"
@@ -62,7 +63,7 @@ static char *read_ref_note(const struct object_id *oid)
 	init_notes(NULL, notes_ref, NULL, 0);
 	if (!(note_oid = get_note(NULL, oid)))
 		return NULL;	/* note tree not found */
-	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)))
+	if (!(msg = read_sha1_file(the_repository, note_oid->hash, &type, &msglen)))
 		error("Empty notes tree. %s", notes_ref);
 	else if (!msglen || type != OBJ_BLOB) {
 		error("Note contains unusable content. "
@@ -109,7 +110,7 @@ static int note2mark_cb(const struct object_id *object_oid,
 	enum object_type type;
 	struct rev_note note;
 
-	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)) ||
+	if (!(msg = read_sha1_file(the_repository, note_oid->hash, &type, &msglen)) ||
 			!msglen || type != OBJ_BLOB) {
 		free(msg);
 		return 1;
diff --git a/rerere.c b/rerere.c
index ab64d3f48e..30ca5fa56d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -10,6 +10,7 @@
 #include "attr.h"
 #include "pathspec.h"
 #include "object-store.h"
+#include "repository.h"
 #include "sha1-lookup.h"
 
 #define RESOLVED 0
@@ -982,7 +983,8 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 			break;
 		i = ce_stage(ce) - 1;
 		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = read_sha1_file(ce->oid.hash, &type,
+			mmfile[i].ptr = read_sha1_file(the_repository,
+						       ce->oid.hash, &type,
 						       &size);
 			mmfile[i].size = size;
 		}
diff --git a/sha1_file.c b/sha1_file.c
index 2d9a794654..ca567b64d6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1409,7 +1409,8 @@ void *read_object_with_reference(const unsigned char *sha1,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = read_sha1_file(actual_sha1, &type, &isize);
+		buffer = read_sha1_file(the_repository, actual_sha1, &type,
+					&isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
diff --git a/submodule-config.c b/submodule-config.c
index 2aa8a1747f..cac5f0ac52 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -520,7 +520,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	if (submodule)
 		goto out;
 
-	config = read_sha1_file(oid.hash, &type, &config_size);
+	config = read_sha1_file(the_repository, oid.hash, &type,
+				&config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
 
diff --git a/tag.c b/tag.c
index da2fe4f2ee..e2fd31ffc7 100644
--- a/tag.c
+++ b/tag.c
@@ -51,7 +51,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 				find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
 				typename(type));
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
 				name_to_report ?
@@ -186,7 +186,8 @@ int parse_tag(struct tag *item)
 
 	if (item->object.parsed)
 		return 0;
-	data = read_sha1_file(item->object.oid.hash, &type, &size);
+	data = read_sha1_file(the_repository, item->object.oid.hash, &type,
+			      &size);
 	if (!data)
 		return error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
diff --git a/tree-walk.c b/tree-walk.c
index 8bd56eddd5..1fa979d146 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -3,6 +3,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "object-store.h"
+#include "repository.h"
 #include "tree.h"
 #include "pathspec.h"
 
@@ -715,7 +716,8 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = read_sha1_file(current_tree_sha1, &type,
+			contents = read_sha1_file(the_repository,
+						  current_tree_sha1, &type,
 						  &link_len);
 
 			if (!contents)
diff --git a/tree.c b/tree.c
index 6e0aafa805..f1c4e937c8 100644
--- a/tree.c
+++ b/tree.c
@@ -222,7 +222,8 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
+	buffer = read_sha1_file(the_repository, item->object.oid.hash, &type,
+				&size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
diff --git a/xdiff-interface.c b/xdiff-interface.c
index a2d0e05edd..22bbe92584 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "object-store.h"
+#include "repository.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
@@ -192,7 +193,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 		return;
 	}
 
-	ptr->ptr = read_sha1_file(oid->hash, &type, &size);
+	ptr->ptr = read_sha1_file(the_repository, oid->hash, &type, &size);
 	if (!ptr->ptr || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size = size;
-- 
2.15.1.433.g936d1b9894.dirty

