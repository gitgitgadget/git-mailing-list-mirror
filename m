Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C61220899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbdHHTc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:32:56 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35568 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbdHHTcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:32:52 -0400
Received: by mail-pg0-f54.google.com with SMTP id v189so18639480pgd.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eqvIIZL/ImCCiBqFSZS754tD198OENIjw9WBWi+lz2c=;
        b=hjyNQDW1Zw0YoapOPKgwAjyo/ApktqadxMElIiWp2xeMkuyhdI7qKA12ZVOL59WMeS
         LNbivQqXhkNquy2Qi7SvaQBsWlK2jPFNW4mYXVMUg3DtGtQnotbeFqqnRxv6t0slg4CH
         J03yW22nRcTfWuqJycIBZ2OG7pLk92GfDk/kOnXHY/G9Br0K76QaFKbrHu8+Mvpjkg5u
         sxWDC8D+ih2TsTceU3DSJgXcza1ixngQRF5hdr/D8xtTse8XWqIZ1Q+hTVBBPIpXzp6W
         eq2GH0vZWshhPPjiGuuxyHJ0I8T5tP1BC3j+hFKe7g+MSvu3+W/H+H3ZY0tN3SFC8/5E
         3vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eqvIIZL/ImCCiBqFSZS754tD198OENIjw9WBWi+lz2c=;
        b=o0YtiM6nYi03ctXMppMyx85VNfcb5oBYbC+e9LJVqRaudbqKOjdfe3qPi5sadouyzs
         l903Hr8txj2BkxyXvsN5hUYM6Ysu4+OkkjRwdnYbhhPH0lw+i8COtA+zQt3TEt6oltWB
         0uTKzZe4Y+wUaVAsJhVKyyY8G0Fhdi++7pOQRLFLS+5QAQrIhbU3y6otMM70SDaHhCk8
         FC3x8lzvVEYoW95bzEtPWY7/S3yF/fUbX6zKvW5QUhNhEFwR9MJAsRi6bnev7ZU9KCXk
         hIu9r3JBz985odqZFyvHmNpfJVuhrBsu7lUKod4lVET2Rr3kpn+3bn72oWcSHwox5pom
         tygQ==
X-Gm-Message-State: AHYfb5ipuBUaPXW4go42JuuocK/KyJc0Epfzf34mWDLd5LkZIdpRka2c
        +EDelcGcQAnytdnFxa1xxw==
X-Received: by 10.84.224.134 with SMTP id s6mr6142226plj.4.1502220771177;
        Tue, 08 Aug 2017 12:32:51 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:49 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 03/10] pack: move pack_report()
Date:   Tue,  8 Aug 2017 12:32:33 -0700
Message-Id: <07fe6cc04c5c2b1019ee9c7aa414965421ee4828.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  2 --
 pack.c      | 24 ++++++++++++++++++++++++
 pack.h      |  2 ++
 sha1_file.c | 24 ------------------------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index 1f0f47819..c7f802e4a 100644
--- a/cache.h
+++ b/cache.h
@@ -1624,8 +1624,6 @@ unsigned long approximate_object_count(void);
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
-extern void pack_report(void);
-
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the
diff --git a/pack.c b/pack.c
index 0f46e0617..60d9fc3b0 100644
--- a/pack.c
+++ b/pack.c
@@ -35,3 +35,27 @@ struct packed_git *packed_git;
 
 static struct mru packed_git_mru_storage;
 struct mru *packed_git_mru = &packed_git_mru_storage;
+
+#define SZ_FMT PRIuMAX
+static inline uintmax_t sz_fmt(size_t s) { return s; }
+
+void pack_report(void)
+{
+	fprintf(stderr,
+		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
+		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
+		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
+		sz_fmt(getpagesize()),
+		sz_fmt(packed_git_window_size),
+		sz_fmt(packed_git_limit));
+	fprintf(stderr,
+		"pack_report: pack_used_ctr            = %10u\n"
+		"pack_report: pack_mmap_calls          = %10u\n"
+		"pack_report: pack_open_windows        = %10u / %10u\n"
+		"pack_report: pack_mapped              = "
+			"%10" SZ_FMT " / %10" SZ_FMT "\n",
+		pack_used_ctr,
+		pack_mmap_calls,
+		pack_open_windows, peak_pack_open_windows,
+		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
+}
diff --git a/pack.h b/pack.h
index 7fcd45f7b..6098bfe40 100644
--- a/pack.h
+++ b/pack.h
@@ -133,4 +133,6 @@ extern unsigned int pack_max_fds;
 extern size_t peak_pack_mapped;
 extern size_t pack_mapped;
 
+extern void pack_report(void);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 4d95e21eb..0de39f480 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,9 +29,6 @@
 #include "mergesort.h"
 #include "quote.h"
 
-#define SZ_FMT PRIuMAX
-static inline uintmax_t sz_fmt(size_t s) { return s; }
-
 const unsigned char null_sha1[20];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
@@ -682,27 +679,6 @@ static int has_loose_object(const unsigned char *sha1)
 	return check_and_freshen(sha1, 0);
 }
 
-void pack_report(void)
-{
-	fprintf(stderr,
-		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
-		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
-		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
-		sz_fmt(getpagesize()),
-		sz_fmt(packed_git_window_size),
-		sz_fmt(packed_git_limit));
-	fprintf(stderr,
-		"pack_report: pack_used_ctr            = %10u\n"
-		"pack_report: pack_mmap_calls          = %10u\n"
-		"pack_report: pack_open_windows        = %10u / %10u\n"
-		"pack_report: pack_mapped              = "
-			"%10" SZ_FMT " / %10" SZ_FMT "\n",
-		pack_used_ctr,
-		pack_mmap_calls,
-		pack_open_windows, peak_pack_open_windows,
-		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
-}
-
 /*
  * Open and mmap the index file at path, perform a couple of
  * consistency checks, then record its information to p.  Return 0 on
-- 
2.14.0.434.g98096fd7a8-goog

