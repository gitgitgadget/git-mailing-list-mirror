Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFE21F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeBXAtE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:49:04 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38068 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeBXAsR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:17 -0500
Received: by mail-pl0-f66.google.com with SMTP id d4so5848345pll.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOEWlCJWM0kggJ2BN4kj6i7JKCQsDeEXfndYUzgE2U8=;
        b=dNj5zKsGIRgU0x2H6yBgllBq+hEW/XPFeY86vTXnJk/SxaoDHuoHDAWgMNIMt8bNfC
         DO78jiR1SzPhg+ohYrP/59g6+QG9UsRwR5yRVsSLnd894bWVvSqHWszxnyn5c1+cj5N4
         fHb5VSy8mYGfZ9KDizoKU+FQrOK5W2UGBHhhh98tBbaNwHAiNWDnDbIbnt0DHKVIAP0o
         qobNOQ1SFwUqMCSOpm8fb/1n7sNHj4+T579yfeEI3/N6ToxLPBP/4FWzyrEyt1CQ1RlD
         b937RZFndWaYeuxdmrm96HP1bqbYYznKltlHcc5jZInSj+z7vFNZPgL6GSbs81MHZnOf
         eB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOEWlCJWM0kggJ2BN4kj6i7JKCQsDeEXfndYUzgE2U8=;
        b=VLYMhtL/2eROfLu7zU7hpMKTrpaxO2DInktr0zZXzNY1BcPhD5Lh2zQDqYyICjRWnt
         KI60NrOt6oTx+ECMucHdXgHZ1diLrhjnV4fW5VvqfYxvlffiIZ3tGbPpVsB8TFfxfDyA
         uDrnFoWIVvoqEX449q8WN81FDqKvcnEG7VGL1sS6nlcKeSOak+4zuRJQWH2UMZryq8x0
         u23olyIVO3ZF+5Gfl/KZPCHZrIqaOuZRbySZWndU17F3+iz1noHt8Jo5zjVYvo3okrTj
         wlVbzqZQ3mlm+8Bu9KvwH+qnkdTNlj8uXhgvMmTjDlPV6N74WZA3gfFKzB+sGpPsBxes
         esHQ==
X-Gm-Message-State: APf1xPBzayk56Mhbi2s0rrpjK8PgVIBH09me2Sl3nYtvNqxDrNIQvxc3
        K0U4Plutm/7O4V8WlOFRWojkZCrW0sM=
X-Google-Smtp-Source: AH8x2257ouZmRJoD7z++cLYclPcniAiSrTRoCMDGusIE7hqETbSg2JiebpgSjs8xL0Wa7s9AJ4iKIw==
X-Received: by 2002:a17:902:9009:: with SMTP id a9-v6mr3286495plp.272.1519433296760;
        Fri, 23 Feb 2018 16:48:16 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b123sm6640249pfb.179.2018.02.23.16.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 13/27] sha1_file: add repository argument to prepare_alt_odb
Date:   Fri, 23 Feb 2018 16:47:40 -0800
Message-Id: <20180224004754.129721-14-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fsck.c |  2 +-
 object-store.h |  3 ++-
 packfile.c     |  2 +-
 sha1_file.c    | 13 +++++++------
 sha1_name.c    |  2 +-
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c3a339193c8..cdcf2fa926c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -722,7 +722,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		for (alt = the_repository->objects.alt_odb_list;
 		     alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/object-store.h b/object-store.h
index 31ca4d3f340..95f328482aa 100644
--- a/object-store.h
+++ b/object-store.h
@@ -20,7 +20,8 @@ struct alternate_object_database {
 
 	char path[FLEX_ARRAY];
 };
-void prepare_alt_odb(void);
+#define prepare_alt_odb(r) prepare_alt_odb_##r()
+void prepare_alt_odb_the_repository(void);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/packfile.c b/packfile.c
index 8d7b1dd5f9c..1e02fe3b0bb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -889,7 +889,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index 8fb56ca0362..381eaf8221d 100644
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
@@ -579,7 +580,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference,
 			     '\n', NULL, 0);
@@ -665,7 +666,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -674,7 +675,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	const char *alt;
 
@@ -728,7 +729,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -887,7 +888,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -918,7 +919,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index 016c883b5c7..627e93f1447 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -353,7 +353,7 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	return 0;
 }
 
-- 
2.16.1.291.g4437f3f132-goog

