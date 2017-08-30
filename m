Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341CE208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdH3HFZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:05:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33110 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdH3HFY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:05:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id m15so4495718pgc.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dCgvmem0o/qxwGgZvEC/o1k8x5QsAzbfz3HomkW36LA=;
        b=d57nmjiW4QYHAEOO6YPdr99a/+0Thz68p1DKNH4MNY44Bx24lZPpSi9L3DI7EJVqlX
         z1Q8YWByEuBYDbMyOHFWVFwknh6QVyHj1Cv/Zxv2GtY8j0EsvvtHcYn94IlzKy7VWJmy
         EZchUTNgdqGKfy3ofLWijW4Y1SGsH/GOzMGPlZBxBh79B6CfCHUoFKcsQQf6F123cMkP
         6y8e8RQqi3kenckdKyFySM0FyESTEUEnkXiZuIXQDjHQ+XEfQxUlWptZyuxJWNLOsJYn
         G5nHtg0+xpcn9z7RkZ2XuMVk6Eb+6jtev222rpXdeD2bO5Y7xARQl4OGfMC1jvQZ8k8o
         ZFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCgvmem0o/qxwGgZvEC/o1k8x5QsAzbfz3HomkW36LA=;
        b=pkUPxH5Cwx6zl6k7hXmmoHP3x0U95r/vPLrResv/Af576xdrpvdXRj5b3MEXi7AIuF
         R2Pt+L1IuIB/Bj5trPJNjkSJ3ICaqt9JoEkR4xa8NhdJVGEzx5YPvV85hbHGT9v8avEb
         sZw115BKjw26d64ns3eT7f5Ws1FKGvK0QgDztQpBFjbvwkTcHqpD6Kmye9uq+Cp1Mcjc
         bBB//6xWzv5cbw3fjEyIY9DgiylMWo5zeR+XgvolScu1YAIEAkgCuLPMteMieHHi8Eb4
         wVb2mEl6C2LL8iSKAA6hZB0rRmnbs4VnhZlefdMH9f2vv516uj7vs4hp0ouL1ZHTI2XT
         S0+w==
X-Gm-Message-State: AHYfb5jTJexraVEojG3r3aTRNdB7xGHrt9IavOU89pwagZreGNhsfdPU
        opxgUDm4tOmhnYiTHEo=
X-Received: by 10.84.131.105 with SMTP id 96mr739964pld.442.1504076723650;
        Wed, 30 Aug 2017 00:05:23 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id b8sm7834076pfe.8.2017.08.30.00.05.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:05:23 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:05:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 21/39] pack: add repository argument to prepare_packed_git
Message-ID: <20170830070521.GV153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow prepare_packed_git_mru callers to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Callers adapted using contrib/coccinelle/packed_git.cocci.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/count-objects.c             |  2 +-
 builtin/fsck.c                      |  2 +-
 builtin/gc.c                        |  2 +-
 builtin/pack-objects.c              |  2 +-
 builtin/pack-redundant.c            |  2 +-
 contrib/coccinelle/packed_git.cocci |  4 ++++
 fast-import.c                       |  2 +-
 http-backend.c                      |  2 +-
 pack-bitmap.c                       |  2 +-
 packfile.c                          | 10 +++++-----
 packfile.h                          |  3 ++-
 server-info.c                       |  2 +-
 sha1_name.c                         |  2 +-
 13 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 843a7d7d7e..e340b3e3c3 100644
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
index 35972fe2be..9ed210b377 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -710,7 +710,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 
 			if (show_progress) {
 				for (p = the_repository->objects.packed_git; p;
diff --git a/builtin/gc.c b/builtin/gc.c
index 73f727332c..11312529c8 100644
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
index b135fb3fb9..cf2941e68f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3052,7 +3052,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = the_repository->objects.packed_git; p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 55462bc826..83d2395dae 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -631,7 +631,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 
 	if (load_all_packs)
 		load_all();
diff --git a/contrib/coccinelle/packed_git.cocci b/contrib/coccinelle/packed_git.cocci
index da317a51a9..7554f4773c 100644
--- a/contrib/coccinelle/packed_git.cocci
+++ b/contrib/coccinelle/packed_git.cocci
@@ -5,3 +5,7 @@
 @@ @@
 - packed_git_mru
 + the_repository->objects.packed_git_mru
+
+@@ @@
+- prepare_packed_git()
++ prepare_packed_git(the_repository)
diff --git a/fast-import.c b/fast-import.c
index 4c3b3d9df6..0024a5e132 100644
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
index 681515aefd..c62796a131 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -520,7 +520,7 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 396abb75bd..39ec1eaf05 100644
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
index 6a04e4bb1b..34b887e7e5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -800,7 +800,7 @@ unsigned long approximate_object_count(void)
 		unsigned long count;
 		struct packed_git *p;
 
-		prepare_packed_git();
+		prepare_packed_git(the_repository);
 		count = 0;
 		for (p = the_repository->objects.packed_git; p; p = p->next) {
 			if (open_pack_index(p))
@@ -868,7 +868,7 @@ static void prepare_packed_git_mru_the_repository(void)
 		mru_append(&the_repository->objects.packed_git_mru, p);
 }
 
-void prepare_packed_git(void)
+void prepare_packed_git_the_repository(void)
 {
 	struct alternate_object_database *alt;
 
@@ -887,7 +887,7 @@ void reprepare_packed_git(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -1829,7 +1829,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct mru_entry *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (!the_repository->objects.packed_git)
 		return 0;
 
@@ -1881,7 +1881,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
diff --git a/packfile.h b/packfile.h
index 7e6959d440..e543a98b23 100644
--- a/packfile.h
+++ b/packfile.h
@@ -32,7 +32,8 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(void);
+#define prepare_packed_git(r) prepare_packed_git_##r()
+extern void prepare_packed_git_the_repository(void);
 extern void reprepare_packed_git(void);
 #define install_packed_git(r, p) install_packed_git_##r(p)
 extern void install_packed_git_the_repository(struct packed_git *pack);
diff --git a/server-info.c b/server-info.c
index 96885c45f6..6cd1506e5e 100644
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
index 952eb64711..387836e717 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -194,7 +194,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
-- 
2.14.1.581.gf28d330327

