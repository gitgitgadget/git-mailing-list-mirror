Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3E01F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeB1BGY (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:24 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38500 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeB1BGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:22 -0500
Received: by mail-pg0-f68.google.com with SMTP id l24so317488pgc.5
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c3fVmPL1f4zqOTTe99RRWjes81PRq/KoXwtVyh9YKZ0=;
        b=iDKYUlRlwFKgBaLqDN33nZlx8pmzOmenMMmynl0dUwEKeewcmbBwEQ2f1RMRzbi5c2
         Prmi6NXbn0IMXYPijFyConTnVKd5obRXLthiSMDOe+iKS+eGmtBn8/I+0V6O8e6mAGdz
         AEIjw78q9X1Xxk0cqqzUCylsNFryaQGqs+MA8pNHIECREH5rUen+eYO+OaR3DRsZ1yj7
         ZKgzHtzvfpf9udfz91ChWnA46H7w9myrMrMWmovTzYTC8zloWGJMj060yYxtuNstwnvG
         MkIEIbjAVo/U9sE65e9cH30zYYjAbpJadMadZ5nyJSsV+Kv5SFlBwJCLNnP/2fmknLX0
         o3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c3fVmPL1f4zqOTTe99RRWjes81PRq/KoXwtVyh9YKZ0=;
        b=MJLEFPFoGSwxsKaL5aQyM8B6UnS8Q4WrwWu7jMLin6ubBI2gFYzi8ykAVW8J1rAZPE
         g5Tm37kAvXkF7tKG23uFcYZF4aBz/AXnM3V9rZhNVrzKCPl0OfEEkZLqI9UU3grKJ06u
         C37Axc4PD0FtwloPqH6c118QNDt1xFXhKGzEhflO8giLTX3ZfymSz0B9fz6ZNqvawbgz
         8NkMe+Ek4niFOmyPqD5NUTgqINkIWTc//uniodjJnEu93DV8LkdZ1eA5JAiAptAII6W9
         xCv+q4G7u7tK9ziCkcgeafurI8wmE9y2OpojxxtEgixqodw4yAaHYA5lbI2d49+xyOeC
         /Awg==
X-Gm-Message-State: APf1xPBmxBKYA/mDaqk8vfh94Czo9wIpV0c5pAgX3Q7/pbBYf9jpas+D
        b0hHjZ5R3S+qjq4OtGYfDNpj+JNzlM4=
X-Google-Smtp-Source: AH8x224oprQfekIOuVMS4sqxEsrIgO9PIbAZPYg6sXLSrkzcS2Du7Nf+l+oDOPvsr9nWtmA3zBGFWw==
X-Received: by 10.99.170.73 with SMTP id x9mr12775126pgo.393.1519779980970;
        Tue, 27 Feb 2018 17:06:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o82sm524690pfj.163.2018.02.27.17.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/11] packfile: add repository argument to prepare_packed_git
Date:   Tue, 27 Feb 2018 17:06:02 -0800
Message-Id: <20180228010608.215505-6-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow prepare_packed_git callers to
be more specific about which repository to handle. See c28d027a52c
(sha1_file: add repository argument to link_alt_odb_entry, 2018-02-20)
for an explanation of the #define trick.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/count-objects.c  |  2 +-
 builtin/fsck.c           |  2 +-
 builtin/gc.c             |  2 +-
 builtin/pack-objects.c   |  2 +-
 builtin/pack-redundant.c |  2 +-
 fast-import.c            |  2 +-
 http-backend.c           |  2 +-
 pack-bitmap.c            |  2 +-
 packfile.c               | 10 +++++-----
 packfile.h               |  3 ++-
 server-info.c            |  2 +-
 sha1_name.c              |  4 ++--
 12 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9334648dccf..b262327bf6d 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -123,7 +123,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 		if (!the_repository->objects.packed_git)
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 		for (p = the_repository->objects.packed_git; p; p = p->next) {
 			if (!p->pack_local)
 				continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 76c94e9b5af..27f580352c5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -727,7 +727,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 
 			if (show_progress) {
 				for (p = the_repository->objects.packed_git; p;
diff --git a/builtin/gc.c b/builtin/gc.c
index 96ff7908677..97f34ae9fe0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -174,7 +174,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (cnt = 0, p = the_repository->objects.packed_git; p; p = p->next) {
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7f376c2aefb..84e940a53ba 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3151,7 +3151,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = the_repository->objects.packed_git; p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 55462bc826a..83d2395dae9 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -631,7 +631,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 
 	if (load_all_packs)
 		load_all();
diff --git a/fast-import.c b/fast-import.c
index 67550584da4..39cd0b7540d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3471,7 +3471,7 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index 4d93126c15f..4950078c936 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -519,7 +519,7 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d51172b1d5b..273bdfb631f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -336,7 +336,7 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
diff --git a/packfile.c b/packfile.c
index 8bb158fc84e..6e8b98ab405 100644
--- a/packfile.c
+++ b/packfile.c
@@ -817,7 +817,7 @@ unsigned long approximate_object_count(void)
 		unsigned long count;
 		struct packed_git *p;
 
-		prepare_packed_git();
+		prepare_packed_git(the_repository);
 		count = 0;
 		for (p = the_repository->objects.packed_git; p; p = p->next) {
 			if (open_pack_index(p))
@@ -884,7 +884,7 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
-void prepare_packed_git(void)
+void prepare_packed_git_the_repository(void)
 {
 	struct alternate_object_database *alt;
 
@@ -903,7 +903,7 @@ void reprepare_packed_git(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -1844,7 +1844,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (!the_repository->objects.packed_git)
 		return 0;
 
@@ -1897,7 +1897,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
diff --git a/packfile.h b/packfile.h
index cc3bf67ab50..39eb590b2ae 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(void);
+#define prepare_packed_git(r) prepare_packed_git_##r()
+extern void prepare_packed_git_the_repository(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
diff --git a/server-info.c b/server-info.c
index 96885c45f64..6cd1506e5e3 100644
--- a/server-info.c
+++ b/server-info.c
@@ -201,7 +201,7 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
diff --git a/sha1_name.c b/sha1_name.c
index 3e490ee8f62..d3769713ea0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -196,7 +196,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -567,7 +567,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.16.2.395.g2e18187dfd-goog

