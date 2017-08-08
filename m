Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E4020899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbdHHTdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:33:11 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36302 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdHHTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:33:05 -0400
Received: by mail-pg0-f51.google.com with SMTP id v77so18591100pgb.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qv0SVfLd967Ynkjl8jn4MtpWGpZh8v5Usir5hDbKS+o=;
        b=fp7xR1oUFJTsarN4X/FoA26Ny+Iqi5N/mmwyYloACoU6jzdW0CGLf1VfVITAzlcBa7
         SgV2L+M3xWQJSU12LqWSP/mwBKpzXLoKxOjtYDV055cnAENCSBDu3PjbwPDuy6zBMRCe
         srdxlvWTlSNRhFG9x5Z9OmSB0eJmJ2o8iglUIAovYzQddoxYv7RrgLQ16BJAy6tHqodV
         Jy4FazLp9dDOBhTQTIB6rX4Qj2MzWNNdQd3hUEG/5DEUMONfvhnMLLSx4UUiAHqtm4Fs
         naCq/sRzG30mATsSfJ9efmA8C2SHU1SedVDpw9WvmI9VUgIOStPnYWZZYjwetkMX26HI
         xuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qv0SVfLd967Ynkjl8jn4MtpWGpZh8v5Usir5hDbKS+o=;
        b=aWblJlt6RahOSxgbVEpjeSrWnB2RlTqYnfeU56elApyZ5GOeJCCfM6fhZYGWgy9sn6
         hHyMDdRBCTlfMtOb+xT02lzLb8H3yYNW1VradTUTsDxmhxeDacPT5NVuglhMtw1TktSx
         OMw95L1Z3KMhWzjdfd2EXapReO9rEEHGnQrgjPtGAxYW9R0hLygKg2twdnlKakw2epHm
         tjaDv1t9i5ux9aLYqMADUv19RkRV4mZfTnbBlwLQqP6Gi8w71RHYWr6h9tWA2YXOOHMx
         o6RGO5yKiLYDxBsw3Zyn5vq/LnF5TmAibA36r7VOEFyMzTc/bL7jcVAKs7OTBwUdGxNs
         31jg==
X-Gm-Message-State: AHYfb5ggjU57h7IUBlC0rJRmX4YpHBC41L86sRWQpDPWQP39O6TYx9LE
        B/B4LgFjAB2qpZWulilfGw==
X-Received: by 10.98.70.200 with SMTP id o69mr5590318pfi.325.1502220784046;
        Tue, 08 Aug 2017 12:33:04 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:33:02 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 10/10] pack: move install_packed_git()
Date:   Tue,  8 Aug 2017 12:32:40 -0700
Message-Id: <6220e9e0c8708a0ea54a6785050b8dae8f9992a9.1502220307.git.jonathantanmy@google.com>
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
 cache.h     |  1 -
 pack.c      | 11 ++++++++++-
 pack.h      |  4 ++--
 sha1_file.c |  9 ---------
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index bf93477e8..41562dc0b 100644
--- a/cache.h
+++ b/cache.h
@@ -1611,7 +1611,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/pack.c b/pack.c
index efe0ed3e8..4eb65e460 100644
--- a/pack.c
+++ b/pack.c
@@ -28,7 +28,7 @@ static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
-unsigned int pack_open_fds;
+static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
@@ -658,3 +658,12 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		hashclr(p->sha1);
 	return p;
 }
+
+void install_packed_git(struct packed_git *pack)
+{
+	if (pack->pack_fd != -1)
+		pack_open_fds++;
+
+	pack->next = packed_git;
+	packed_git = pack;
+}
diff --git a/pack.h b/pack.h
index c1f3ff32d..576c4fc7c 100644
--- a/pack.h
+++ b/pack.h
@@ -124,8 +124,6 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern unsigned int pack_open_fds;
-
 extern void pack_report(void);
 
 /*
@@ -152,4 +150,6 @@ extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+extern void install_packed_git(struct packed_git *pack);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 7f12b1ee0..b956ca0c9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,15 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void install_packed_git(struct packed_git *pack)
-{
-	if (pack->pack_fd != -1)
-		pack_open_fds++;
-
-	pack->next = packed_git;
-	packed_git = pack;
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
-- 
2.14.0.434.g98096fd7a8-goog

