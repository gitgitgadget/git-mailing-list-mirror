Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E9E20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbdHIBXn (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:43 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36191 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbdHIBX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:29 -0400
Received: by mail-pg0-f42.google.com with SMTP id v77so21520608pgb.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sojk7zQWLQif7Zl6z9AQuBsGmEqn+dsdCYR8irdqMKg=;
        b=A1EpxSnXn+X/nuUwlt1R8Tqp9SNJJyUoLmUtF/faleMBxD8FsbroVTok7avzrXikOU
         XeXIIfr+ZAtRln9X9a8EqkqHMbKoYyb4wZKVFyANzJncfMoINOd/hOIo4KJ3U3uX3PH1
         EbPFnu6ZPmqaHG2dr+3NBlfLXLGwUylSRd/CWfINyVe0mGm9pPm0OHu+RXZOUUUz7NVY
         wM/bWTWijmk00T2pUlVFak6oi4o51msargzoCq+ekT5yEDsZqsNOt5y2kNhbRI0XNw9N
         PxKGyXJIJyZ7/tuvMmJzlmwmLdlbJAHOij1/enG2HUZ74le8EFQNA1JwehhOrYqJWQ6u
         6sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sojk7zQWLQif7Zl6z9AQuBsGmEqn+dsdCYR8irdqMKg=;
        b=JvGmXyovDCa6TjKqyBKHt3hmilRRRaBvEc3uX9kq0x7tgDAKFt7llPRWCVyjP7Y8y/
         QXLYLghSaxfEyuYBxI5CX+sf/IQApK/WLAjCpl58CGnAdnKwyd1JIQjWuq3YBse1co+F
         LRS1S+rKv5NQ8QVKSmZjHN12OzOT3WJpJQGtg5dLFZbTip9H/CiP1k6DwptfM3iyml7O
         lqf77wWzzbyqwkFkbKRjYfqzGt5PG3eeNhVGFlwTJOumMHwn+uW8RylR8mbof/e148jO
         cCJ8lIUnZhB25kK1ZrK62/x/n8Nret031AfvjJSGYwFAmt1YXMEtrQp2S9W5xoYDJWra
         y3/w==
X-Gm-Message-State: AHYfb5hKalzJPCT6j8LF6pi3Bv5t22O2bqBqDKdVTgUmgAFaxvxW0fzy
        XUoTL6dxHy9VIlcEXWuLiQ==
X-Received: by 10.101.87.140 with SMTP id b12mr5908409pgr.174.1502241808228;
        Tue, 08 Aug 2017 18:23:28 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:27 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 23/25] pack: move has_sha1_pack()
Date:   Tue,  8 Aug 2017 18:22:55 -0700
Message-Id: <5849701548adb4a116ecc2d5d110029a1b409cd4.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/prune-packed.c | 1 +
 cache.h                | 2 --
 diff.c                 | 1 +
 pack.h                 | 2 ++
 packfile.c             | 6 ++++++
 revision.c             | 1 +
 sha1_file.c            | 6 ------
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index ac978ad40..79130aa2e 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "progress.h"
 #include "parse-options.h"
+#include "pack.h"
 
 static const char * const prune_packed_usage[] = {
 	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
diff --git a/cache.h b/cache.h
index 06a8caae6..d96d36d50 100644
--- a/cache.h
+++ b/cache.h
@@ -1190,8 +1190,6 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
-extern int has_sha1_pack(const unsigned char *sha1);
-
 /*
  * Open the loose object at path, check its sha1, and return the contents,
  * type, and size. If the object is a blob, then "contents" may return NULL,
diff --git a/diff.c b/diff.c
index 85e714f6c..6bbc46326 100644
--- a/diff.c
+++ b/diff.c
@@ -20,6 +20,7 @@
 #include "string-list.h"
 #include "argv-array.h"
 #include "graph.h"
+#include "pack.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/pack.h b/pack.h
index 1021a781c..ce0e15deb 100644
--- a/pack.h
+++ b/pack.h
@@ -223,4 +223,6 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
 
+extern int has_sha1_pack(const unsigned char *sha1);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 0f1e3338b..507f65236 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1849,3 +1849,9 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	}
 	return 0;
 }
+
+int has_sha1_pack(const unsigned char *sha1)
+{
+	struct pack_entry e;
+	return find_pack_entry(sha1, &e);
+}
diff --git a/revision.c b/revision.c
index 6603af944..2868c4fc8 100644
--- a/revision.c
+++ b/revision.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
+#include "pack.h"
 
 volatile show_early_output_fn_t show_early_output;
 
diff --git a/sha1_file.c b/sha1_file.c
index 1a505eae5..2610ea057 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1629,12 +1629,6 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-int has_sha1_pack(const unsigned char *sha1)
-{
-	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
-}
-
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	if (!startup_info->have_repository)
-- 
2.14.0.434.g98096fd7a8-goog

