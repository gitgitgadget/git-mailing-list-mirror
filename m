Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCB61F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeBEXzl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:41 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45924 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeBEXzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:35 -0500
Received: by mail-pl0-f66.google.com with SMTP id p5so74233plo.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9v0XuQjnZMK52Y/MCmDjk+cNNHVo82JdtG26QcgpgwQ=;
        b=H50ED3Uswa/DC8aX9vMdwM2lJE6GKNJ6q4zeMGYGzVMgZweTWCh+pYGmVNZxULA/u7
         BbgadRjH6FN1vBelAEkUosmA5+Z66wDHhriS85imH/Mx1pdahnlSbaIUtcswUcOsIiXP
         42f9lsCKAFdEyHFFEL41aXeSj5E6fT4wl+7Kf1ymma8sYQUZ8A4FkaHMeH38yE2uwCoQ
         GxEBRzQ7x8rTUik4NISIDEwRgu7Wckke6zA1A40Huhn8X56Xw256Y6VKEgx2CSa9cCHU
         7oCdnS8TVNQ+Tu0TeDOvkdzhaQGYgidastcam3OtDX2mOCufGegvBUsjyHnslk1/7BYd
         4Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9v0XuQjnZMK52Y/MCmDjk+cNNHVo82JdtG26QcgpgwQ=;
        b=gNH36ga+SiTHxsOaMD8+wCFK9KQ/Xy+fRAPmlp+B48u+Er9kxza9MuFd7MT3HQ5wVe
         1loX1oqt33GiOIWzuVSpDimsOwpupe6x4ry502dtgm8BRySLPUXic1FSjm02IgeWsPRx
         l1B2j+9rlEStAIPaDEY5nLW9NfAVnQ3Bq0tohxQPMkiWNByA/MtQ9dKkP1+pLX23mERo
         n9x6UpNXiinT17aeCOc1M4yzh5dGmYm0RWm6Isln9x346JWs9fkuk2VLXiBup4uEJaO6
         SHWMSeBihCUNxUDnd7W9wLHQ20OE5qFjfNYdIsXUFaxqkP54aZRqD8ooPHBsMryEt/zJ
         qrIA==
X-Gm-Message-State: APf1xPCPQ+pc7ZedETO4Jv1okyJzNdDDGNeJmdU1RK5eEi5PddTMl6mA
        mpmpc2bXyIJzKIoGokJpc63z2diuD0M=
X-Google-Smtp-Source: AH8x226iVm+VeRWaEZygyUIg5ByN2y9TpAmG/u1B7fZaVxxwkOct5s9wE1wY270wQK7xcx6GPJhavw==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10-v6mr494318plb.156.1517874934509;
        Mon, 05 Feb 2018 15:55:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h8sm22569030pfk.121.2018.02.05.15.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 002/194] object-store: move alt_odb_list and alt_odb_tail to object store
Date:   Mon,  5 Feb 2018 15:51:56 -0800
Message-Id: <20180205235508.216277-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a process with multiple repositories open, alternates should be
associated to a single repository and not shared globally. Move
alt_odb_list and alt_odb_tail into the_repository and adjust callers
to reflect this.

No functional change intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fsck.c |  4 +++-
 cache.h        |  4 ++--
 object-store.h |  6 +++++-
 packfile.c     |  3 ++-
 sha1_file.c    | 25 ++++++++++++-------------
 sha1_name.c    |  3 ++-
 6 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04846d46f9..1048255da1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tree.h"
@@ -694,7 +695,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
-		for (alt = alt_odb_list; alt; alt = alt->next)
+		for (alt = the_repository->objects.alt_odb_list;
+				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
 		if (check_full) {
diff --git a/cache.h b/cache.h
index d8b975a571..918c2f15b4 100644
--- a/cache.h
+++ b/cache.h
@@ -1573,7 +1573,7 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-extern struct alternate_object_database {
+struct alternate_object_database {
 	struct alternate_object_database *next;
 
 	/* see alt_scratch_buf() */
@@ -1591,7 +1591,7 @@ extern struct alternate_object_database {
 	struct oid_array loose_objects_cache;
 
 	char path[FLEX_ARRAY];
-} *alt_odb_list;
+};
 extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
diff --git a/object-store.h b/object-store.h
index 05722cdde0..ace3efbfab 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,8 +1,12 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
+#include "cache.h"
+
 struct object_store {
+	struct alternate_object_database *alt_odb_list;
+	struct alternate_object_database **alt_odb_tail;
 };
-#define OBJECT_STORE_INIT {}
+#define OBJECT_STORE_INIT { NULL, NULL }
 
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab18..d61076faaf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "mru.h"
 #include "pack.h"
+#include "repository.h"
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
@@ -880,7 +881,7 @@ void prepare_packed_git(void)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..2826d5d6ed 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,6 +22,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "streaming.h"
 #include "dir.h"
 #include "mru.h"
@@ -346,9 +347,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
-struct alternate_object_database *alt_odb_list;
-static struct alternate_object_database **alt_odb_tail;
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
@@ -368,7 +366,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -428,8 +426,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*alt_odb_tail = ent;
-	alt_odb_tail = &(ent->next);
+	*the_repository->objects.alt_odb_tail = ent;
+	the_repository->objects.alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -563,7 +561,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (alt_odb_tail)
+		if (the_repository->objects.alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
 	}
 	free(alts);
@@ -661,7 +659,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -673,12 +671,13 @@ void prepare_alt_odb(void)
 {
 	const char *alt;
 
-	if (alt_odb_tail)
+	if (the_repository->objects.alt_odb_tail)
 		return;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 
-	alt_odb_tail = &alt_odb_list;
+	the_repository->objects.alt_odb_tail =
+			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
@@ -717,7 +716,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -873,7 +872,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 
 	prepare_alt_odb();
 	errno = ENOENT;
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -899,7 +898,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	most_interesting_errno = errno;
 
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..957ce25680 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "repository.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -104,7 +105,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		 */
 		fakeent = alloc_alt_odb(get_object_directory());
 	}
-	fakeent->next = alt_odb_list;
+	fakeent->next = the_repository->objects.alt_odb_list;
 
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		int pos;
-- 
2.15.1.433.g936d1b9894.dirty

