Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39953208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdHRWVZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:25 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36469 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdHRWVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:09 -0400
Received: by mail-pg0-f49.google.com with SMTP id i12so72236805pgr.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+3BuinNIo1uNGyDaFNU1PY5S+E88c2kGEgLbAcR32NY=;
        b=olqqtCFc7p1VTbgxgJIWrLA1on/31VGcAy1XaYnTxkhf4g7YOOvb8P4UQmqukJW1zM
         pu0V3l2uk3ooIVpZGY7eHWg1BXCocClUvOBkaKzuxusQbfVsZ4bJiB5K1v6S5h2QLY25
         wJCpDvRntRvOQlmuA7cDNYBetOiel18Qa4sRd+kWxtxYTJgAO30pkaMbjC4rtwM5rMe0
         JgrUid+yVlCCPx5BcKJBJb6eUyTWyiWkx2HK3iCHMuquxa5A2L35WVPdmALcTwwNM0wP
         s+77/xmOwWtWUjUwkN213PbUDohb5uBDlkpakqTi6wqKFJsKeoP1x3iPzwC1mA0lTZ6T
         Niug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+3BuinNIo1uNGyDaFNU1PY5S+E88c2kGEgLbAcR32NY=;
        b=I2vluDMSFxD36Ditp+uACx+dfMeFlLSpgCZJg1DgpGEsDd7GWZbpxqsC5k77OEC86Y
         FoeaCRuaxRVxEg5TXEddVS8ZC/n2/41IyBMhRLrGPaNDjTZau+muGhTV33cZjQh28hfX
         /yIU+6ZSFipkP/7fXzynkOGjJwytN6ur4ba/8NbrUd3BxMdDVepF2HTfATBXNRt2/Ur2
         Ih7gPwSTd48n9QSEHBjLJ3cLASzOO7iNJzKgQlRU43GeZw+4fNCs6zqEsJy0Ddri+hgL
         +w6YnBvXzANRiKMA+t2lwhtC1GovQ4kd2Gl/MKNPLp3fCTiHyUxy6Ubn8XwAO1/qYdS+
         NbQQ==
X-Gm-Message-State: AHYfb5hZ92RRQALfl0gl6QOdA82ia+4BpGp+K073e8JklWmvHycR9bOr
        Q+Pj7GBdT4bWRkOh4k/roA==
X-Received: by 10.98.155.65 with SMTP id r62mr7409557pfd.21.1503094868446;
        Fri, 18 Aug 2017 15:21:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 21/23] pack: move has_sha1_pack()
Date:   Fri, 18 Aug 2017 15:20:36 -0700
Message-Id: <6200890f7fcb3b2aa9d8206c713ff657fe9d0074.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/prune-packed.c | 1 +
 cache.h                | 2 --
 diff.c                 | 1 +
 packfile.c             | 6 ++++++
 packfile.h             | 2 ++
 revision.c             | 1 +
 sha1_file.c            | 6 ------
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index ac978ad40..97bfde24b 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "progress.h"
 #include "parse-options.h"
+#include "packfile.h"
 
 static const char * const prune_packed_usage[] = {
 	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
diff --git a/cache.h b/cache.h
index 1e90bb754..286891df4 100644
--- a/cache.h
+++ b/cache.h
@@ -1198,8 +1198,6 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
-extern int has_sha1_pack(const unsigned char *sha1);
-
 /*
  * Open the loose object at path, check its sha1, and return the contents,
  * type, and size. If the object is a blob, then "contents" may return NULL,
diff --git a/diff.c b/diff.c
index 85e714f6c..e9a1d6162 100644
--- a/diff.c
+++ b/diff.c
@@ -20,6 +20,7 @@
 #include "string-list.h"
 #include "argv-array.h"
 #include "graph.h"
+#include "packfile.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/packfile.c b/packfile.c
index ae5395f5f..7472ab816 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1840,3 +1840,9 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	}
 	return 0;
 }
+
+int has_sha1_pack(const unsigned char *sha1)
+{
+	struct pack_entry e;
+	return find_pack_entry(sha1, &e);
+}
diff --git a/packfile.h b/packfile.h
index c9b4fcfaf..4945a1505 100644
--- a/packfile.h
+++ b/packfile.h
@@ -120,4 +120,6 @@ extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
 extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
 
+extern int has_sha1_pack(const unsigned char *sha1);
+
 #endif
diff --git a/revision.c b/revision.c
index 6603af944..db97b9221 100644
--- a/revision.c
+++ b/revision.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
+#include "packfile.h"
 
 volatile show_early_output_fn_t show_early_output;
 
diff --git a/sha1_file.c b/sha1_file.c
index 76c86639c..e4975e0ae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1630,12 +1630,6 @@ int has_pack_index(const unsigned char *sha1)
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
2.14.1.480.gb18f417b89-goog

