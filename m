Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A331F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162398AbeBPRqx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33946 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162384AbeBPRqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:49 -0500
Received: by mail-pg0-f67.google.com with SMTP id m19so2970330pgn.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ey7O79QdhqFEVhmJvy2LIB/3SOh/f04b9WNB7nLymtY=;
        b=Ia+EWoK+Z+j5HumuhmMDf8C16YYEjkiMb3RG2gqe95s1g7wGpl96w6wYv0TekO1zMD
         dHuUu77ZncEp+EFTwwrbwyO9jbDrPjDGttjwiDr8wQuEP39XJgFWkKCUj9Zaqh2c1bLO
         8dS2saPQXAJVtkFvzoosSSZqRTZsj5mLlv/ILNW3j3HKMdS+Od9xkvFGO2wekuoreL5Q
         5wuoQL3AWfZUlCJ5nKWCRB5TMw57nWf0PzdTsILmR5BH9ZkX45O+sqFqr1pPimx+SVBt
         UKxH1FUsYdKoGMMJod+52Q8r+9lvg07yPNT+S/3hdOE2AHB9gyVJg6DShazjBPZ2PbEh
         g18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ey7O79QdhqFEVhmJvy2LIB/3SOh/f04b9WNB7nLymtY=;
        b=KBRBj7eMXwMtrxHp2cd5FBNBgzDvTPxlBVh/iuyxA7x+LTydcLmU88XrmMMbuvSI6+
         wZFS8SdYZbOvQZoZ1GA1buVVAUBUTxkm5+V7IpnQA7Z2uBDVuDgRuq3lTbdf/c+lA/Ut
         vgAerlREioc55lbLoutQaRKmX/8SBF890aXGrTbxMMLuVKfNHIZNy+RepZOq9OlLSXta
         wPJFZH+7cS0ELq2P5w7L15kcH36Sl5Tn7+PcAyW184z9nmGs1h/XKabvHRhQHvJ/MG6C
         NHSmqJJ2NHb6OymmUUGM1lpRIpVHHZhFTQWOmXOrq0N+nfZrmV6uoG0Xnj/Df+sayJWP
         lGcg==
X-Gm-Message-State: APf1xPDO8xZNlEeu21zb4JSuXzfPtVZrQd0qLasPH5keyDcClC0mVXUD
        5Dg8fR6uaWBaHoQypiMwxS3tsg==
X-Google-Smtp-Source: AH8x224oOgRsS5H8SiMUSNW4dPjvrowjoQgJfsbowP3z+jB1qF19eWyCnZbe54SVcFpXNX0gfgDNLw==
X-Received: by 10.99.123.12 with SMTP id w12mr5591221pgc.405.1518803209061;
        Fri, 16 Feb 2018 09:46:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b123sm45991274pfb.179.2018.02.16.09.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 10/16] sha1_file: allow prepare_alt_odb to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:20 -0800
Message-Id: <20180216174626.24677-11-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fsck.c |  2 +-
 cache.h        |  1 -
 object-store.h |  2 ++
 packfile.c     |  2 +-
 sha1_file.c    | 23 +++++++++++------------
 sha1_name.c    |  3 ++-
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2e99e02128..c0d967d6d7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -717,7 +717,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(&the_repository->objects);
 		for (alt = the_repository->objects.alt_odb_list;
 				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/cache.h b/cache.h
index 12bb42f951..d0c1a533c5 100644
--- a/cache.h
+++ b/cache.h
@@ -1599,7 +1599,6 @@ struct alternate_object_database {
 	 */
 	char path[FLEX_ARRAY];
 };
-extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/object-store.h b/object-store.h
index 80a2ca6f75..280e8e16ad 100644
--- a/object-store.h
+++ b/object-store.h
@@ -67,4 +67,6 @@ extern struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
+void prepare_alt_odb(struct raw_object_store *o);
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 693bafbc98..83b10e55c0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -890,7 +890,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index c4255a2da6..04a81e29f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
+#include "object-store.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
@@ -577,7 +578,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 
 	link_alt_odb_entries(&the_repository->objects, reference,
 			     '\n', NULL, 0);
@@ -663,7 +664,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -672,21 +673,19 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb(struct raw_object_store *o)
 {
 	const char *alt;
 
-	if (the_repository->objects.alt_odb_tail)
+	if (o->alt_odb_tail)
 		return;
 
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(&the_repository->objects, alt,
-			     PATH_SEP, NULL, 0);
+	o->alt_odb_tail = &o->alt_odb_list;
+	link_alt_odb_entries(o, alt, PATH_SEP, NULL, 0);
 
-	read_info_alternates(&the_repository->objects, get_object_directory(), 0);
+	read_info_alternates(o, o->objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
@@ -726,7 +725,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -885,7 +884,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -916,7 +915,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index 016c883b5c..f1e6c910ba 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -11,6 +11,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "repository.h"
+#include "object-store.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -353,7 +354,7 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb();
+	prepare_alt_odb(&the_repository->objects);
 	return 0;
 }
 
-- 
2.16.1.291.g4437f3f132-goog

