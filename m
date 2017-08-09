Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5513620899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbdHIBXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:07 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:37885 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdHIBXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:06 -0400
Received: by mail-pg0-f50.google.com with SMTP id y129so21568667pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eOTWwUAjjB4qpFjQqVyWO9PLSvVmUwF0X40/JOgkb4s=;
        b=SR8hLcWs3B+wX6RbDY7dopDggTOqoCAZC3co2S0Rqj1l0ZvJXPPfVVAZZBt5LDru48
         Dx/XHH88oqsYhksG6o7XP/GkYqJP7HiFzHdyYSebUwO+lcskhzTRdXbNkCbelCqrWGR4
         gWn/obSpmeUfzyG7VtklkCjJe0MvgZLBG6OStsFnBs594LpFLuLqQK3Yyt/wKvrBjYbH
         I5mMSgwyF5BID9ysaL3LrgNuFVCwUCnPIXf2ITTyQ62LhEepmikqUXwKrK5Err3N1nvs
         d7SbmwjNdoZj367KBHAecGOESJW89JUOE2lwipWfeV7nt3tb2RCMFWmWEWAlulXEJlWW
         Cy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eOTWwUAjjB4qpFjQqVyWO9PLSvVmUwF0X40/JOgkb4s=;
        b=AW0X4UYbCgDro947pwQ4FHRfqK3p4twGMbuuFH+dA9/E25rB5rdxvKRwE/77UTNLAP
         ocJ01Ov1zmDZ7uZVIZFDkTAbOivcaxAV8WRZy56ikHCSW5WzR0x0wFbTzokJl5jFjmwx
         jS1+ivID//IkgJ9QbVg4ia+sMMThKBLCnJUBvapfqNXNXJ3Cxg3e9QLCUf2jCx6PRahP
         MRY3gYXh/x0e85edB/VkSxDJ/2uHXyEgkMYJ1TxrPcBtw/NhrLe8KNqMamE5ZtY11MlO
         OtanD0Ylvw0VFYaIcFva1jl6BTcENxj693xD9AOSzGbti9EktE6dX4dQO5ewgdyh6/T5
         NdMg==
X-Gm-Message-State: AHYfb5ijm9BCA0eE7Ko8SQgJAKXdlmc/yJ4CEA6JKCd5fG35Dq09LvsI
        smkvXfD+KOrrgNx5J5crsA==
X-Received: by 10.84.217.214 with SMTP id d22mr7054899plj.204.1502241785372;
        Tue, 08 Aug 2017 18:23:05 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:04 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 03/25] pack: move pack_report()
Date:   Tue,  8 Aug 2017 18:22:35 -0700
Message-Id: <2f286cd1eddece9cff42bf580d9a5587e0bc178c.1502241234.git.jonathantanmy@google.com>
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
 cache.h     |  2 --
 pack.h      |  2 ++
 packfile.c  | 24 ++++++++++++++++++++++++
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

