Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38568208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdH3HBn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:01:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33808 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbdH3HBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:01:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id 63so4476627pgc.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gwfkEuYskUorHTwyLQse44bUrwjN9R/cehK8uV1oRLo=;
        b=BV1Vean0NQ4mGZR8iORElGF2kORNYZWh9mudVxquBE9fOiEyprL0uwXGOyzc1lkv8r
         VmKvhHi7Qhh/o+Ux1sMoTeZJNXYk4MutOfAqJ/qWLe0B0hTStgzsuPKL8pD329BY2MzM
         jZ4/I2IMLzZkNj3M2OGLqKOEdwODP94Kh58J8nQuuC7rLENmfa+6d/rSMAor56poXFhz
         Xc6QtBzjNNruGfUbh0vKWWNmEN3qS7FnomIT2jqSyY4GV6qK381v3WtPH1DmuIWNgpo0
         JdKrANMSdnMpO+dpCJscXAELaPwqZhuQC0iJAuLytOsY8ZfVGaYYEVsGJPtciOgA7FU5
         3kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gwfkEuYskUorHTwyLQse44bUrwjN9R/cehK8uV1oRLo=;
        b=RudrUZmXycKkwroRxETkOiYnE5M9vTQGZzSvEd83NVK5Lsc8mOMkcPiuuGCiFQf/zN
         60o+d8V+kyvBbVmI85zJY9x6AOWq+Vc1sWOO2MfjcY0E/WtVSDO5Km7K31Q0rNYyPa3B
         WM+UsEMrS0OCEJd7tqk14dLdWaB2hID1dDYQC2YLhi55w9lfB6LVcx9AT/x7WQI8xxbw
         Btc3c8kCdOz8aYXek+GIwVOlHMRkLRg7J30VegvsCuvrRrOdDJ8r+dmnpECFLVK9MsS9
         SyPVKRs2ieVZEAjQml6qGFT/jrCKH7bvy8kvfhZ7GS085G+/1oBAT+eofnsODhMvWumG
         S1+Q==
X-Gm-Message-State: AHYfb5gXP6Yh79zm56aKSqjuU1MR+WxhgXDUD2/QScnfw87GLmQJW/Vi
        fihxqZT7jnRv6g0kZN4=
X-Received: by 10.84.216.82 with SMTP id f18mr740100plj.202.1504076501718;
        Wed, 30 Aug 2017 00:01:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id t64sm9171427pfi.85.2017.08.30.00.01.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:01:41 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:01:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 15/39] object-store: add repository argument to
 prepare_alt_odb
Message-ID: <20170830070139.GP153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow prepare_alt_odb callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fsck.c |  2 +-
 cache.h        |  1 -
 object-store.h |  3 +++
 packfile.c     |  2 +-
 sha1_file.c    | 13 +++++++------
 sha1_name.c    |  3 ++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 20bbcdcf4a..35972fe2be 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -700,7 +700,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		for (alt = the_repository->objects.alt_odb_list;
 				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/cache.h b/cache.h
index cd59c2fdb7..5770224167 100644
--- a/cache.h
+++ b/cache.h
@@ -1523,7 +1523,6 @@ struct alternate_object_database {
 
 	char path[FLEX_ARRAY];
 };
-extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/object-store.h b/object-store.h
index 99f77d10cd..e749c952d5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -54,4 +54,7 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+#define prepare_alt_odb(r) prepare_alt_odb_##r()
+extern void prepare_alt_odb_the_repository(void);
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 98267f014f..2cd61b32a3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -872,7 +872,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index d1c8dbcfa5..9211c73920 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
+#include "object-store.h"
 #include "streaming.h"
 #include "dir.h"
 #include "mru.h"
@@ -524,7 +525,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference, strlen(reference),
 			     '\n', NULL, 0);
@@ -610,7 +611,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -619,7 +620,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	const char *alt;
 
@@ -669,7 +670,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -825,7 +826,7 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -854,7 +855,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index 153bcd83b9..952eb64711 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -11,6 +11,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "repository.h"
+#include "object-store.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -351,7 +352,7 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	return 0;
 }
 
-- 
2.14.1.581.gf28d330327

