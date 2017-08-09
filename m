Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395F320899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdHIBXs (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:48 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34881 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdHIBX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:26 -0400
Received: by mail-pf0-f177.google.com with SMTP id t86so21281121pfe.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JS1ulTlxlqywEktnAWUd4e8vbr0yg4tNHidtreLq41M=;
        b=YJuzoPREwcsztwg1dhijq5huRvlrgyq2r2KcUYrzVk1fsdWxwV4CI+wlFJOzlV1DXg
         jVnDj/hkdt1++pNLekI/p+A7Lnd24QgkU2wbXRbGtN0Z6maMsW3ApfdpDv/YaHUvDspw
         IoE8WbHa9fMbCd2TxA8TOHMQHEnATXlX3Yi08YydsZp0a9lLRH2qa95UISTe/64kFhje
         5RSQkG3Hructo0Os68dtfBDJMVy91aezlujYOLa59gCfsjpxFNKoGepgaiUCFZwYf/MN
         y6z0lCoCuFlWm/1+TgnPpt8YyTgUF/sDgoEzOKPlKI60+IOFYl2B9fETBqgcyOVGpaGr
         xd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JS1ulTlxlqywEktnAWUd4e8vbr0yg4tNHidtreLq41M=;
        b=pJmX1OprZPBZWW8NGihIHXV0NGb+pCTN1epJfDDor963kPgheA2rgrXg71um7+Oxnv
         ofp1LrLTZD+l8TR+TJJRG6ksJGHlv332PYXiUIhBXF8yqpMP9jLoGtKLpg4JNvKaEuUx
         XEZHkZj1G7mgzsnFWql4X42ABHQsX5Aslfx1PuH6yjLTaWegIWQhfRtT8Ft1A1khJAHM
         K/ShbbxAOJEP8Zjl9MbN61o8Me5VQuFu9RxLHZYvdkgSQt0eQRbBqA1vH9E0FiC5mwVs
         BJ/OVLHEF+4+5EtW/KFrLxeKVijgZRwpnfmFc8FZ67nf82BjmMc8OsjHwhC0Ata1+EKc
         onGw==
X-Gm-Message-State: AHYfb5jptyADj0Sd5P3c/YOKtZZ8nKsu8R/EqD/pKcRJCDDWicb3lid6
        epgNWWsSe21QAQMcCInZ3w==
X-Received: by 10.99.190.4 with SMTP id l4mr6030422pgf.46.1502241806135;
        Tue, 08 Aug 2017 18:23:26 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:25 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 21/25] pack: move find_sha1_pack()
Date:   Tue,  8 Aug 2017 18:22:53 -0700
Message-Id: <99f48f676b9abaeffdf357cb8e6454b5c0946de7.1502241234.git.jonathantanmy@google.com>
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
 cache.h       |  3 ---
 http-push.c   |  1 +
 http-walker.c |  1 +
 pack.h        |  3 +++
 packfile.c    | 13 +++++++++++++
 sha1_file.c   | 13 -------------
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index b944aca69..06a8caae6 100644
--- a/cache.h
+++ b/cache.h
@@ -1600,9 +1600,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
-					 struct packed_git *packs);
-
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the
diff --git a/http-push.c b/http-push.c
index c91f40a61..4e8a227d1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "pack.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
diff --git a/http-walker.c b/http-walker.c
index ee049cb13..d6f0af944 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -4,6 +4,7 @@
 #include "http.h"
 #include "list.h"
 #include "transport.h"
+#include "pack.h"
 
 struct alt_base {
 	char *base;
diff --git a/pack.h b/pack.h
index f5bd94813..0517d6542 100644
--- a/pack.h
+++ b/pack.h
@@ -218,4 +218,7 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 
+extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
+					 struct packed_git *packs);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 71017d2ec..f16b56262 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1783,3 +1783,16 @@ int is_pack_valid(struct packed_git *p)
 	/* Force the pack to open to prove its valid. */
 	return !open_packed_git(p);
 }
+
+struct packed_git *find_sha1_pack(const unsigned char *sha1,
+				  struct packed_git *packs)
+{
+	struct packed_git *p;
+
+	for (p = packs; p; p = p->next) {
+		if (find_pack_entry_one(sha1, p))
+			return p;
+	}
+	return NULL;
+
+}
diff --git a/sha1_file.c b/sha1_file.c
index 75b9ceb39..229358663 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1126,19 +1126,6 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	return 0;
 }
 
-struct packed_git *find_sha1_pack(const unsigned char *sha1,
-				  struct packed_git *packs)
-{
-	struct packed_git *p;
-
-	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(sha1, p))
-			return p;
-	}
-	return NULL;
-
-}
-
 static int sha1_loose_object_info(const unsigned char *sha1,
 				  struct object_info *oi,
 				  int flags)
-- 
2.14.0.434.g98096fd7a8-goog

