Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2AB208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdHRWUv (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:20:51 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36392 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdHRWUt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:49 -0400
Received: by mail-pg0-f50.google.com with SMTP id i12so72233175pgr.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Oyx3xpPb8PqPIdRtoFIE9AB7EfGcizmlGYZC1ahIAqQ=;
        b=ubS0mM+Vvgre6WKXP5hqLhPHvkBat5RSGSTI0UQmH/aEoesVE1r+0fYl2CeyGwT5Zv
         cGYUcG0MKaI9Qo1biRV1i11lFHIaR48WY6tDOtuvTHEyqUa409rgKdSwuGqtWTEOXN5I
         +uSVByiqmX+9BaEM58hVGYb5R5bkD0F3YbbPCRIopk0yZCEKH8nNL75mLKgEedE6+QsG
         lw+Os4/jrbgCAeKBPMcvI8ooun/nfwt/97pAQjv2FZDioCDDiVXkOifPqF1nMo/8O6Pl
         P8V9OAKVJcEonf6SZnlso1TdUlVObyHHTZAmhgN+pwcUWsA4nD4ZNMuKTrU82V+ykc7X
         92ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Oyx3xpPb8PqPIdRtoFIE9AB7EfGcizmlGYZC1ahIAqQ=;
        b=PhmfILyjJRyLip5UWIvcmOkzmMZ5+6nwh/G63hC+C0MGOI4RIT3ptnJldeAl8DylLF
         ehGjPV01exnbuQNbyX1Ln3mmWQ8jP9cf4GPlI1h02mOkQKx6VEG2WfoW7UPKtAMvOnNx
         MlFL/9at/2aNO8IGU2/jzY723GU24L3XUPLgIWcivZUUiPqNlqKAXZSWXmtUXOSUULuE
         Ui21yr1sAJoxaigr7A+EdqPJX0NY3dLHYAIVtZH6F/k9FuUV1UpAYXJ2umlJHOD8OeJw
         rHa4uc/W8ds8ISIcpYnScZbjTMLxXxlPmbqFLlGqTtExqXVcrX1tD6LrGg47kSSf+KNh
         eyvw==
X-Gm-Message-State: AHYfb5gfhJyqFBFbMkIKLB50mDReXczrAfTK8cevMFRLRExccbiEr55Z
        +NrGuPphXYt/28/ENbaadg==
X-Received: by 10.84.167.2 with SMTP id c2mr11459768plb.370.1503094848468;
        Fri, 18 Aug 2017 15:20:48 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:47 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 03/23] pack: move pack_report()
Date:   Fri, 18 Aug 2017 15:20:18 -0700
Message-Id: <fa347818654814cd9b5fa9fb329b8ef8267688e1.1503094448.git.jonathantanmy@google.com>
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
 cache.h     |  2 --
 packfile.c  | 24 ++++++++++++++++++++++++
 packfile.h  |  2 ++
 sha1_file.c | 24 ------------------------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index aa2b4d390..a0497d469 100644
--- a/cache.h
+++ b/cache.h
@@ -1632,8 +1632,6 @@ unsigned long approximate_object_count(void);
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
-extern void pack_report(void);
-
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the
diff --git a/packfile.c b/packfile.c
index 0f46e0617..60d9fc3b0 100644
--- a/packfile.c
+++ b/packfile.c
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
diff --git a/packfile.h b/packfile.h
index a76bb7cec..bfa94c8fe 100644
--- a/packfile.h
+++ b/packfile.h
@@ -33,4 +33,6 @@ extern unsigned int pack_max_fds;
 extern size_t peak_pack_mapped;
 extern size_t pack_mapped;
 
+extern void pack_report(void);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 2b5ce9959..f7c8152ac 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -30,9 +30,6 @@
 #include "quote.h"
 #include "packfile.h"
 
-#define SZ_FMT PRIuMAX
-static inline uintmax_t sz_fmt(size_t s) { return s; }
-
 const unsigned char null_sha1[20];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
@@ -683,27 +680,6 @@ static int has_loose_object(const unsigned char *sha1)
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
2.14.1.480.gb18f417b89-goog

