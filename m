Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80830E82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjI0T4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjI0Tz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:57 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40476CC
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79f909071c3so407928539f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844554; x=1696449354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4LK71V82XDfAsC4icL5Dk5UxaffRPCmxGntq7sDdQE=;
        b=cFzrnMXrc7DZXf0xdAzdNyMswFOqmGwboHjpfTBDlM3bQz3RPnk3Ma8DeUj6xmIW8w
         FsZ9HZONWqhFEjXJiIptyeqezWwlLdd9T9rqN7kkLFxyFwXfrXfNCs02mdWuokDn6uOv
         MNMP71iBUtqyGBFNuh/WSGeAKqlSEaka0kR9+IAiLRfQhTkSRanRQ7VUGC5tH3ODZJyf
         /8BhYAHGbYanE5Ru24sgl4+wkvgosZTxhKT9bHsZIhxnHpXAfuSVsK7STpefI7ceaFXN
         TRfen+eQnkdjg/BfVz3mhplnrhcwbodeWqPM9TzTZMdmfrVS5lEIoTeNZp5aDjDPXaWo
         haHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844554; x=1696449354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4LK71V82XDfAsC4icL5Dk5UxaffRPCmxGntq7sDdQE=;
        b=dn0gg/kMgVCX1xgrQZcuPxwgv8cr0nLFHlsk5uqPY0PfiaFI6ywuVFtPBhG6LkyMUB
         gGtXOGuIBw8zPCz/QxJhM37h+jOnBeFGuEJCp5JZysy/CAPUfXwlExjTuYjsqP847cWy
         kiYxJA5y8tw7Uyfvo4eIHw9TsosWH7+mDDEnUoSuoEfzZahfCnwOJsodWFVgZcBXB5Vw
         ulhYeo463A0LaAM+qRXinSC7GJWRZGJukrKdKg4ebgjW8L/FjIIiH3VwNg6eE3t4+OCo
         PmH3OPjhkiAB0IWKAsRAo1NDWRsKfUMSVjzj+92XjzQah8phAMouapeGpZuNjHQbbIjp
         7RDw==
X-Gm-Message-State: AOJu0Yw5JoVIkkt8sOq5DZ+2laSHnjau7aX0Qd7Vu/kRIdKEkQWkHf42
        1iGGQV861fL4cSBE6+YTIEA=
X-Google-Smtp-Source: AGHT+IHVr4sGDUvTJpmhO6IVmxTD6lLESM6TPujoDLBnnRBAC85/l48X0Q+eqtchMEKrAkeHrqygdg==
X-Received: by 2002:a6b:7301:0:b0:785:ca70:46a2 with SMTP id e1-20020a6b7301000000b00785ca7046a2mr3565772ioh.4.1695844554569;
        Wed, 27 Sep 2023 12:55:54 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:54 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 05/30] loose: add a mapping between SHA-1 and SHA-256 for loose objects
Date:   Wed, 27 Sep 2023 14:55:12 -0500
Message-Id: <20230927195537.1682-5-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

As part of the transition plan, we'd like to add a file in the .git
directory that maps loose objects between SHA-1 and SHA-256.  Let's
implement the specification in the transition plan and store this data
on a per-repository basis in struct repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 Makefile              |   1 +
 loose.c               | 245 ++++++++++++++++++++++++++++++++++++++++++
 loose.h               |  22 ++++
 object-file-convert.c |  14 ++-
 object-store-ll.h     |   3 +
 object.c              |   2 +
 repository.c          |   6 ++
 7 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 loose.c
 create mode 100644 loose.h

diff --git a/Makefile b/Makefile
index f7e824f25cda..3c18664def9a 100644
--- a/Makefile
+++ b/Makefile
@@ -1053,6 +1053,7 @@ LIB_OBJS += list-objects-filter.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += loose.o
 LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
diff --git a/loose.c b/loose.c
new file mode 100644
index 000000000000..28d11593b2ea
--- /dev/null
+++ b/loose.c
@@ -0,0 +1,245 @@
+#include "git-compat-util.h"
+#include "hash.h"
+#include "path.h"
+#include "object-store.h"
+#include "hex.h"
+#include "wrapper.h"
+#include "gettext.h"
+#include "loose.h"
+#include "lockfile.h"
+
+static const char *loose_object_header = "# loose-object-idx\n";
+
+static inline int should_use_loose_object_map(struct repository *repo)
+{
+	return repo->compat_hash_algo && repo->gitdir;
+}
+
+void loose_object_map_init(struct loose_object_map **map)
+{
+	struct loose_object_map *m;
+	m = xmalloc(sizeof(**map));
+	m->to_compat = kh_init_oid_map();
+	m->to_storage = kh_init_oid_map();
+	*map = m;
+}
+
+static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const struct object_id *value)
+{
+	khiter_t pos;
+	int ret;
+	struct object_id *stored;
+
+	pos = kh_put_oid_map(map, *key, &ret);
+
+	/* This item already exists in the map. */
+	if (ret == 0)
+		return 0;
+
+	stored = xmalloc(sizeof(*stored));
+	oidcpy(stored, value);
+	kh_value(map, pos) = stored;
+	return 1;
+}
+
+static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
+{
+	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+	FILE *fp;
+
+	if (!dir->loose_map)
+		loose_object_map_init(&dir->loose_map);
+
+	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_tree, repo->hash_algo->empty_tree);
+
+	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_blob, repo->hash_algo->empty_blob);
+
+	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->null_oid, repo->hash_algo->null_oid);
+
+	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	fp = fopen(path.buf, "rb");
+	if (!fp)
+		return 0;
+
+	errno = 0;
+	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
+		goto err;
+	while (!strbuf_getline_lf(&buf, fp)) {
+		const char *p;
+		struct object_id oid, compat_oid;
+		if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_algo) ||
+		    *p++ != ' ' ||
+		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
+		    p != buf.buf + buf.len)
+			goto err;
+		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
+		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return errno ? -1 : 0;
+err:
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return -1;
+}
+
+int repo_read_loose_object_map(struct repository *repo)
+{
+	struct object_directory *dir;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	prepare_alt_odb(repo);
+
+	for (dir = repo->objects->odb; dir; dir = dir->next) {
+		if (load_one_loose_object_map(repo, dir) < 0) {
+			return -1;
+		}
+	}
+	return 0;
+}
+
+int repo_write_loose_object_map(struct repository *repo)
+{
+	kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
+	struct lock_file lock;
+	int fd;
+	khiter_t iter;
+	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
+	iter = kh_begin(map);
+	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
+		goto errout;
+
+	for (; iter != kh_end(map); iter++) {
+		if (kh_exist(map, iter)) {
+			if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
+			    oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
+				continue;
+			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
+			if (write_in_full(fd, buf.buf, buf.len) < 0)
+				goto errout;
+			strbuf_reset(&buf);
+		}
+	}
+	strbuf_release(&buf);
+	if (commit_lock_file(&lock) < 0) {
+		error_errno(_("could not write loose object index %s"), path.buf);
+		strbuf_release(&path);
+		return -1;
+	}
+	strbuf_release(&path);
+	return 0;
+errout:
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	error_errno(_("failed to write loose object index %s\n"), path.buf);
+	strbuf_release(&path);
+	return -1;
+}
+
+static int write_one_object(struct repository *repo, const struct object_id *oid,
+			    const struct object_id *compat_oid)
+{
+	struct lock_file lock;
+	int fd;
+	struct stat st;
+	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+
+	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
+
+	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
+	if (fd < 0)
+		goto errout;
+	if (fstat(fd, &st) < 0)
+		goto errout;
+	if (!st.st_size && write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
+		goto errout;
+
+	strbuf_addf(&buf, "%s %s\n", oid_to_hex(oid), oid_to_hex(compat_oid));
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		goto errout;
+	if (close(fd))
+		goto errout;
+	adjust_shared_perm(path.buf);
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return 0;
+errout:
+	error_errno(_("failed to write loose object index %s\n"), path.buf);
+	close(fd);
+	rollback_lock_file(&lock);
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return -1;
+}
+
+int repo_add_loose_object_map(struct repository *repo, const struct object_id *oid,
+			      const struct object_id *compat_oid)
+{
+	int inserted = 0;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_compat, oid, compat_oid);
+	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_storage, compat_oid, oid);
+	if (inserted)
+		return write_one_object(repo, oid, compat_oid);
+	return 0;
+}
+
+int repo_loose_object_map_oid(struct repository *repo,
+			      const struct object_id *src,
+			      const struct git_hash_algo *to,
+			      struct object_id *dest)
+
+{
+	struct object_directory *dir;
+	kh_oid_map_t *map;
+	khiter_t pos;
+
+	for (dir = repo->objects->odb; dir; dir = dir->next) {
+		struct loose_object_map *loose_map = dir->loose_map;
+		if (!loose_map)
+			continue;
+		map = (to == repo->compat_hash_algo) ?
+			loose_map->to_compat :
+			loose_map->to_storage;
+		pos = kh_get_oid_map(map, *src);
+		if (pos < kh_end(map)) {
+			oidcpy(dest, kh_value(map, pos));
+			return 0;
+		}
+	}
+	return -1;
+}
+
+void loose_object_map_clear(struct loose_object_map **map)
+{
+	struct loose_object_map *m = *map;
+	struct object_id *oid;
+
+	if (!m)
+		return;
+
+	kh_foreach_value(m->to_compat, oid, free(oid));
+	kh_foreach_value(m->to_storage, oid, free(oid));
+	kh_destroy_oid_map(m->to_compat);
+	kh_destroy_oid_map(m->to_storage);
+	free(m);
+	*map = NULL;
+}
diff --git a/loose.h b/loose.h
new file mode 100644
index 000000000000..2c2957072c5f
--- /dev/null
+++ b/loose.h
@@ -0,0 +1,22 @@
+#ifndef LOOSE_H
+#define LOOSE_H
+
+#include "khash.h"
+
+struct loose_object_map {
+	kh_oid_map_t *to_compat;
+	kh_oid_map_t *to_storage;
+};
+
+void loose_object_map_init(struct loose_object_map **map);
+void loose_object_map_clear(struct loose_object_map **map);
+int repo_loose_object_map_oid(struct repository *repo,
+			      const struct object_id *src,
+			      const struct git_hash_algo *dest_algo,
+			      struct object_id *dest);
+int repo_add_loose_object_map(struct repository *repo, const struct object_id *oid,
+			      const struct object_id *compat_oid);
+int repo_read_loose_object_map(struct repository *repo);
+int repo_write_loose_object_map(struct repository *repo);
+
+#endif
diff --git a/object-file-convert.c b/object-file-convert.c
index ba3e18f6af44..4d62ed192bf0 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -4,6 +4,7 @@
 #include "repository.h"
 #include "hash-ll.h"
 #include "object.h"
+#include "loose.h"
 #include "object-file-convert.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
@@ -21,7 +22,18 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 			oidcpy(dest, src);
 		return 0;
 	}
-	return -1;
+	if (repo_loose_object_map_oid(repo, src, to, dest)) {
+		/*
+		 * We may have loaded the object map at repo initialization but
+		 * another process (perhaps upstream of a pipe from us) may have
+		 * written a new object into the map.  If the object is missing,
+		 * let's reload the map to see if the object has appeared.
+		 */
+		repo_read_loose_object_map(repo);
+		if (repo_loose_object_map_oid(repo, src, to, dest))
+			return -1;
+	}
+	return 0;
 }
 
 int convert_object_file(struct strbuf *outbuf,
diff --git a/object-store-ll.h b/object-store-ll.h
index 26a3895c821c..bc76d6bec80d 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -26,6 +26,9 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/* Map between object IDs for loose objects. */
+	struct loose_object_map *loose_map;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
diff --git a/object.c b/object.c
index 2c61e4c86217..186a0a47c0fb 100644
--- a/object.c
+++ b/object.c
@@ -13,6 +13,7 @@
 #include "alloc.h"
 #include "packfile.h"
 #include "commit-graph.h"
+#include "loose.h"
 
 unsigned int get_max_object_index(void)
 {
@@ -540,6 +541,7 @@ void free_object_directory(struct object_directory *odb)
 {
 	free(odb->path);
 	odb_clear_loose_cache(odb);
+	loose_object_map_clear(&odb->loose_map);
 	free(odb);
 }
 
diff --git a/repository.c b/repository.c
index 80252b79e93e..6214f61cf4e7 100644
--- a/repository.c
+++ b/repository.c
@@ -14,6 +14,7 @@
 #include "read-cache-ll.h"
 #include "remote.h"
 #include "setup.h"
+#include "loose.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
 #include "trace2.h"
@@ -109,6 +110,8 @@ void repo_set_compat_hash_algo(struct repository *repo, int algo)
 	if (hash_algo_by_ptr(repo->hash_algo) == algo)
 		BUG("hash_algo and compat_hash_algo match");
 	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
+	if (repo->compat_hash_algo)
+		repo_read_loose_object_map(repo);
 }
 
 /*
@@ -201,6 +204,9 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	if (repo->compat_hash_algo)
+		repo_read_loose_object_map(repo);
+
 	clear_repository_format(&format);
 	return 0;
 
-- 
2.41.0

