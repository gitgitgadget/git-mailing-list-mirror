Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15411F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeBMBXH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:07 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41393 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBXF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:05 -0500
Received: by mail-pg0-f65.google.com with SMTP id t4so7690545pgp.8
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+5wJjRj76UzcigWqhNRR6B0JHzG80DADTvH8jP0lg8=;
        b=ox4in6fTIDmiv3sp4jsV3MNafYJrAlSgyQTFPH7+6dk4ZIe3ZfBO6o4fIc+9Mz3t1K
         nSifIrLyDXG0X4nFkdeh/Fd5e2PLwjsrDAPx4YF1RW7ByedZ84Ge1KICfG85o+n5urNw
         RCfms15lmmGNU8Oq+hUKdwNZJPga6OM+RVN3mWXPSFQjyouIqWzbEOy0z1FaqBC3QRIk
         BPVzm1NMVocnuVd5FEDAWLJLFmL7Oik/+jmjBUguT4XV30UgBCuOBPSbIu8oi9PAZIsZ
         j8sZMcRR7Sy/HcwMRNj4DQ1nxAvvDIobCrDg5hkTUNv1ElF6SQ9F9nwUT2Lx4y5Xn4s2
         RaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+5wJjRj76UzcigWqhNRR6B0JHzG80DADTvH8jP0lg8=;
        b=QZLTJdA/hgralUWRZ89ZKP4Z8jsi8NaxYHuDw7Z3OAEZyuEIwCnO+17fcF9BAfTmDR
         6cPfKyPeuTkwONbUxHixE+VPYEjbF6RNncka3QdW63GBTcV868TstycIig4RzmJL0joq
         l15CFlvF0C4iY0jwlQe+cUUDpiGKB8DTP91OcTJxLaT2Hfs5eUAWIablOo/RYJx6mPen
         WaW6UDZg8EpXi5KyvWtRy0Y3QSvSNIZYqYKfkmw2xkL/Le9ZLGdCdyL7juiXyeduTn/s
         drxAOqY7/waAmF6/YBjlVQvtvF0BPUPegjcWfLnNCtt/4qZE0bUKg4TlFEhouJ0PxJMr
         EemQ==
X-Gm-Message-State: APf1xPAQUCqNGlR/aOhTAk9cYWaLMoqybqlrfLexSev98NcHOUbcg+lO
        JFBNmfojdchWXt6TGsQIWHIy7w==
X-Google-Smtp-Source: AH8x226+vrfWXtWJRM/BtuJUMSvzFxOjajsRMdqXP6po2UdX1BOWeCRU/gwDVVQWOzXc5OIK8BlfBQ==
X-Received: by 10.99.50.66 with SMTP id y63mr10075189pgy.207.1518484984378;
        Mon, 12 Feb 2018 17:23:04 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o63sm31635527pfa.101.2018.02.12.17.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/26] sha1_file: add repository argument to prepare_alt_odb
Date:   Mon, 12 Feb 2018 17:22:27 -0800
Message-Id: <20180213012241.187007-13-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

While at it, move the declaration to object-store.h,
where it should be easier to find.

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
index d4d249c2ed..00ec8eecf0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -695,7 +695,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		for (alt = the_repository->objects.alt_odb_list;
 				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/cache.h b/cache.h
index 459fd01dbb..70518e24ce 100644
--- a/cache.h
+++ b/cache.h
@@ -1592,7 +1592,6 @@ struct alternate_object_database {
 
 	char path[FLEX_ARRAY];
 };
-extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/object-store.h b/object-store.h
index 86f1ec2cd0..d96a16edd1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -61,4 +61,7 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+#define prepare_alt_odb(r) prepare_alt_odb_##r()
+extern void prepare_alt_odb_the_repository(void);
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index a53706cf16..9c49b34d2b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -879,7 +879,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index b090f403d8..d7f271fe6e 100644
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
@@ -585,7 +586,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference,
 			     '\n', NULL, 0);
@@ -671,7 +672,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -680,7 +681,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	const char *alt;
 
@@ -729,7 +730,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -884,7 +885,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -911,7 +912,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index 016c883b5c..3e490ee8f6 100644
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
+	prepare_alt_odb(the_repository);
 	return 0;
 }
 
-- 
2.16.1.73.ga2c3e9663f.dirty

