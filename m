Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3903D208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdH3GxZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:53:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34239 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3GxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:53:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id p69so3794965pfk.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5HCqoX3c5B68vWndoiprm4Pbu2wfNgtW/BRkZxaYVQI=;
        b=eCgdLc+WA2TsiTRXYt/X/IMEq1fu4putjM76wDRgtOhXFw9inqdDGMfdcPsrZUseei
         eeIrmHx+iRF6qUBYyno4Efa8VX1tlsJkVxt02uG7nrXmX6QzL0r3+8cRK74Szs56BTLx
         0y0OfFRDgyl0WzxltJUZrqkEk3Gh55um/uRSHaIPI3gnqhW5ImjFYil379G470JMaNmn
         0n4dp259wIo0kPmkrsLAOm8Kcgrg38te9jeN/+6Jo7uV/aI/ENkWjqUP1x/83lhCltgK
         NkWUoNCePwxnA8hEQQC94a0+w7QS+9hW1xY/zIAHGisaONtIZgWHz28ClQ3zK4Qdt2HG
         uCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HCqoX3c5B68vWndoiprm4Pbu2wfNgtW/BRkZxaYVQI=;
        b=DRJ/Agwb7AQ8rHjk7s93Po/3ATt/aqWRVZEcBvcQ5aTLqquEBv43TbAPL/U/FuxEj1
         GCEAhYEa7GYFdwgLCsL6ks7HjjeJcbwRuikrHqLzE1wvppzkXICU92agmJoaeY9Pbwj5
         XsffGvI0xdw1+cI3nSPLZBdERh/fM6eF1zV3yqZH6SOf4dgkHUWXacuOaA+hWm6zQSKd
         zj53KGTAi5piuMqxzKvHgf0O3sn7U+Lsq5N0p4kdfKKTxoyydtlW+yVwgiaCiPoVEEBT
         VUUvkQiryW53OTAZYTO++2glqUnDnmYM5wQYVuIiGrD7enirA0bypbW+TnnOSomGqkB2
         kkyg==
X-Gm-Message-State: AHYfb5jUFuY65+Q5uF1exhr3lShLHYIpo9827i4bPTURgSOo22mvDpMQ
        r5miT1v1lxwmuGrLoUw=
X-Received: by 10.84.216.5 with SMTP id m5mr703077pli.434.1504076003735;
        Tue, 29 Aug 2017 23:53:23 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id w64sm7697452pfi.75.2017.08.29.23.53.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:53:23 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:53:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 03/39] object-store: move alt_odb_list and alt_odb_tail to
 object store
Message-ID: <20170830065321.GD153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

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
index 1e4c471b41..188e32acd6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tree.h"
@@ -699,7 +700,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
-		for (alt = alt_odb_list; alt; alt = alt->next)
+		for (alt = the_repository->objects.alt_odb_list;
+				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
 		if (check_full) {
diff --git a/cache.h b/cache.h
index 49b083ee0a..8d0d34f78b 100644
--- a/cache.h
+++ b/cache.h
@@ -1504,7 +1504,7 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-extern struct alternate_object_database {
+struct alternate_object_database {
 	struct alternate_object_database *next;
 
 	/* see alt_scratch_buf() */
@@ -1522,7 +1522,7 @@ extern struct alternate_object_database {
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
index f69a5c8d60..5040c9f137 100644
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
@@ -873,7 +874,7 @@ void prepare_packed_git(void)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
diff --git a/sha1_file.c b/sha1_file.c
index f56bb5cae7..7c6ffd205a 100644
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
@@ -276,9 +277,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
-struct alternate_object_database *alt_odb_list;
-static struct alternate_object_database **alt_odb_tail;
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
@@ -298,7 +296,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -358,8 +356,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*alt_odb_tail = ent;
-	alt_odb_tail = &(ent->next);
+	*the_repository->objects.alt_odb_tail = ent;
+	the_repository->objects.alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -502,7 +500,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(lock))
 			die_errno("unable to move new alternates file into place");
-		if (alt_odb_tail)
+		if (the_repository->objects.alt_odb_tail)
 			link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
 	}
 	free(alts);
@@ -600,7 +598,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -612,13 +610,14 @@ void prepare_alt_odb(void)
 {
 	const char *alt;
 
-	if (alt_odb_tail)
+	if (the_repository->objects.alt_odb_tail)
 		return;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 	if (!alt) alt = "";
 
-	alt_odb_tail = &alt_odb_list;
+	the_repository->objects.alt_odb_tail =
+			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
@@ -657,7 +656,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -813,7 +812,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 
 	prepare_alt_odb();
 	errno = ENOENT;
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -839,7 +838,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	most_interesting_errno = errno;
 
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
diff --git a/sha1_name.c b/sha1_name.c
index 134ac9742f..5b8ce1c42c 100644
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
2.14.1.581.gf28d330327

