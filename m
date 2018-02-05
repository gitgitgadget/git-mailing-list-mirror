Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BF31F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBEX4T (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:19 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45956 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBEXzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:54 -0500
Received: by mail-pl0-f66.google.com with SMTP id p5so74639plo.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYXZaza6tIuudSPRXI2DUF2fzvPax4E344J3/IUXoBg=;
        b=irX7Y3PAnZbIherMyKuNIQQsuFUnMOqBvhREYVHlqPNUeLKJ2Gwg/nOLZHlDFu7toO
         uKwd9ZlUrW/VeItvVLIg8/mvQWUTFvfVTRjqiG6+Pubvr0FgxSwZ3mQr7qoBF7fVJy7q
         EpqJZ9KxSOJ8tiQPsh6zcLk3gOLXKx2brOUZ09aD4rrt6tHghe6Ffa8QGknJAISH+0Qa
         M1wFByZOhSW5c58C8nMNh5dxVPw81cb64QzNdCEx0LEdCb9CCooh7GJnqNHeAi9DisyZ
         pListSnrM1UQbLGpPE9DKQg5r5mz8wO5MctgOedAEmrF70tA8SReTC+M8wCkauZ3X9HL
         rR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYXZaza6tIuudSPRXI2DUF2fzvPax4E344J3/IUXoBg=;
        b=CvKSsPd8Gs0zffBnvG8vaEDFrIlrqirveYhcMz4UBwxB4MChL9PXDKOfL+to7X7TdO
         Z4shBbMJy8KPZZibUwCivJL/TSVqQZSRKNpMrn0daj1g2BGpS8Ga6O9DruGmB+u0APMC
         Npj6D2WJzhjEtzpkvJhwpZ3+0Y9ek/9mL0WU2BJvTCu3giGpzHBLRjELaMLSQ8Vfx+Lf
         K93dt5DLdk7JYvo8WF8wnxaV0Zoz+JbZpEH7jaspc/c+KFdaFtDfki43mpWETindLQbX
         AuUOQNnbatnp0Zx64B0WkflnVqhc373qjPqEDPLceMWQLwqY4k3bxyKaMCQvrhREAxnt
         8Rtg==
X-Gm-Message-State: APf1xPBqaEFp536KhLhE2NfDW5jbCaGpDPVvo/3IBtdFVhN0GtvLTi2y
        qI2iriHa143AJTmfXhJ54E20pCzYgDQ=
X-Google-Smtp-Source: AH8x226xM/ghvPLzIt1WvnAHt2XO+1DPYlFpvxmqdFwJT7eApsUPZ+0/uiGRa7jKLJuMJ10LgMUE7w==
X-Received: by 2002:a17:902:8f87:: with SMTP id z7-v6mr496545plo.242.1517874953104;
        Mon, 05 Feb 2018 15:55:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w13sm14310294pfi.112.2018.02.05.15.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 015/194] object-store: add repository argument to foreach_alt_odb
Date:   Mon,  5 Feb 2018 15:52:09 -0800
Message-Id: <20180205235508.216277-16-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow foreach_alt_odb callers to be more
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
 builtin/count-objects.c     | 2 +-
 builtin/submodule--helper.c | 4 +++-
 cache.h                     | 2 --
 object-store.h              | 4 ++++
 sha1_file.c                 | 4 ++--
 transport.c                 | 4 +++-
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9334648dcc..843a7d7d7e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -155,7 +155,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
-		foreach_alt_odb(print_alternate, NULL);
+		foreach_alt_odb(the_repository, print_alternate, NULL);
 		strbuf_release(&loose_buf);
 		strbuf_release(&pack_buf);
 		strbuf_release(&garbage_buf);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a5c4a8a694..8005adbf3d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "object-store.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
@@ -835,7 +836,8 @@ static void prepare_possible_alternates(const char *sm_name,
 		die(_("Value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
 
 	if (!strcmp(sm_alternate, "superproject"))
-		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
+		foreach_alt_odb(the_repository,
+				add_possible_reference_from_superproject, &sas);
 	else if (!strcmp(sm_alternate, "no"))
 		; /* do nothing */
 	else
diff --git a/cache.h b/cache.h
index 70518e24ce..bba53f356d 100644
--- a/cache.h
+++ b/cache.h
@@ -1593,8 +1593,6 @@ struct alternate_object_database {
 	char path[FLEX_ARRAY];
 };
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern int foreach_alt_odb(alt_odb_fn, void*);
 
 /*
  * Allocate a "struct alternate_object_database" but do _not_ actually
diff --git a/object-store.h b/object-store.h
index e749c952d5..eef8d3b653 100644
--- a/object-store.h
+++ b/object-store.h
@@ -57,4 +57,8 @@ struct packed_git {
 #define prepare_alt_odb(r) prepare_alt_odb_##r()
 extern void prepare_alt_odb_the_repository(void);
 
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+#define foreach_alt_odb(r, fn, cb) foreach_alt_odb_##r(fn, cb)
+extern int foreach_alt_odb_the_repository(alt_odb_fn, void*);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 779bfd4079..7662692ee5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -667,7 +667,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-int foreach_alt_odb(alt_odb_fn fn, void *cb)
+int foreach_alt_odb_the_repository(alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
 	int r = 0;
@@ -2103,7 +2103,7 @@ int for_each_loose_object(each_loose_object_fn cb, void *data, unsigned flags)
 
 	alt.cb = cb;
 	alt.data = data;
-	return foreach_alt_odb(loose_from_alt_odb, &alt);
+	return foreach_alt_odb(the_repository, loose_from_alt_odb, &alt);
 }
 
 static int check_stream_sha1(git_zstream *stream,
diff --git a/transport.c b/transport.c
index fc802260f6..3f97fbe7c5 100644
--- a/transport.c
+++ b/transport.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "transport.h"
+#include "repository.h"
 #include "run-command.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
@@ -11,6 +12,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "object-store.h"
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
@@ -1294,5 +1296,5 @@ void for_each_alternate_ref(alternate_ref_fn fn, void *data)
 	struct alternate_refs_data cb;
 	cb.fn = fn;
 	cb.data = data;
-	foreach_alt_odb(refs_from_alternate_cb, &cb);
+	foreach_alt_odb(the_repository, refs_from_alternate_cb, &cb);
 }
-- 
2.15.1.433.g936d1b9894.dirty

