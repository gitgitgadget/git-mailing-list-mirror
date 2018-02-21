Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D539E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBUBzD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45725 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeBUBzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id e11so54304pgq.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xb975XQT4SQJaVGqcmCQzkwXZY4vB1L8+gXsWlf+B/I=;
        b=h3130uKCEh6GAUD2dAAD2L4fIYE7OE32AvcuO6kjaYzj6D3V+BYlZl9iseF5VyNsU+
         SBY2+qhA3/at7vmdo2Tn9WnGHOXaJt41zhxGvPAW1GWwOeen2SQaA1FzDcFdXZPuHS8u
         u21oLN4EoZwVVN/YBxF8eHxFz93iuXJJNgkjIogd7AaJOimd4k2KMh54tTOqylzJr+y7
         ct8lVW0nmbVP4DuwNEd8ow0h0ULiBg2F12RL6MabOkp5gBxMKXqDcrevZjf0SsrFAZU/
         ABUXVsK0c55FshI7nvUqMGKFz2kKLR0ceLJbw7/KB1sCv2NNsGJaeOwMaC8gMUWJq2HL
         /1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xb975XQT4SQJaVGqcmCQzkwXZY4vB1L8+gXsWlf+B/I=;
        b=U2dG8Gy3EhNb/OaKCzjxNl/RxGRDl7O4n0fuGcOAsqAPbQyfognf7/x7PZNAvq8wi4
         ryMTEm+j1qxoxyC4F7qzXzXMove2Fj2Py3BtzcYlfplBzq8Tispr3NBLxErNjzcO83EG
         Qa58IErqXOh8jN1bTRQN8VMkOjJjPKoyFBB/jtjSrqr/qExxH3/A0FgNGHSDmG4NVzGN
         PIMllrETIWFkMGKPP1y8kiL43v+zn/JL+dkLFdLtUMmMv6QIxYwkUZMUE6Pnec1shVM+
         30eQwKiEqb6EiWAabUAIyQIb2kO8aP5TYgWdYb/Rb//eyTJIOJnS840vmd8Lk9Fnq3Ya
         iF/Q==
X-Gm-Message-State: APf1xPD/vzmF1vyclpf/HwaWx3EntqfgP02R7eT4kMdCpeSglm2yKoeD
        aw4Y+8JBq4LCy3gX89FKIjqqeA==
X-Google-Smtp-Source: AH8x227G5S366l/nLOAZsDgtb9GIUwDU8vD+b/YcyqVbeGIF/MWk0MOZM+2Iy+Mgea1q6cc7gn2mMg==
X-Received: by 10.98.166.200 with SMTP id r69mr1578761pfl.205.1519178100888;
        Tue, 20 Feb 2018 17:55:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j1sm54203290pff.94.2018.02.20.17.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/27] sha1_file: add repository argument to prepare_alt_odb
Date:   Tue, 20 Feb 2018 17:54:16 -0800
Message-Id: <20180221015430.96054-14-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
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
 object-store.h |  3 ++-
 packfile.c     |  2 +-
 sha1_file.c    | 13 +++++++------
 sha1_name.c    |  3 ++-
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2e99e02128..76c94e9b5a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -717,7 +717,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		for (alt = the_repository->objects.alt_odb_list;
 				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/object-store.h b/object-store.h
index bd1e4fcd8b..514ad94287 100644
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
index 693bafbc98..ccfe084642 100644
--- a/packfile.c
+++ b/packfile.c
@@ -890,7 +890,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index a0e9116318..c26921df4a 100644
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
@@ -581,7 +582,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference,
 			     '\n', NULL, 0);
@@ -667,7 +668,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -676,7 +677,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	const char *alt;
 
@@ -730,7 +731,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -889,7 +890,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -920,7 +921,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
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
2.16.1.291.g4437f3f132-goog

