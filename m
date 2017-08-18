Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE434208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdHRWVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:32 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35736 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdHRWVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:07 -0400
Received: by mail-pg0-f41.google.com with SMTP id q6so1094769pgs.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SvKqcjoVJgSxC4sh1K7flRDryBIHdRB9B9EpBKgw9QQ=;
        b=B2m861CZsI6U0u0QzOEU0WWlvP0ffrHo/dKZWaqPOdo5HETai24X6zKEpbSQqtNc0f
         t5h/ZjzIB6vHUnMi50n0Kho712MXBSiarFcjTvNtL7xcmZFtw3BEwF+1oEMPx4s/fsL+
         ibPGc/xk0qx7dFWPWFAD+ftD3vzwC0HwiC5dF0qqyoDkEN9NwDST0auh8l9ESlX0uKG6
         /g+8B/o93fSIlazDqizKgywPLy+V+pBeXSWb+s52YefQ/Y0F5XAsdj2coZamNo+/Eit3
         dxJ3kqMmKiVig/g5XH6ak6wBvKINC/K6SdkaN7FapYTBVxahu0i4CZI5Qc5ChIgnvM6L
         483Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SvKqcjoVJgSxC4sh1K7flRDryBIHdRB9B9EpBKgw9QQ=;
        b=gegrI3QVDQMGHwK3Qr+e26UDUYRBNsbf1zAjIbnFBxw6HNpP8HWxcU5+pa4p2FJGvd
         pXrNJtoOmrI+KiohVIH3xmRbamWT1ttBOK/KhGH7PDtDu9yDYtmPAaKL/CkhFfS2ngtW
         Ka/+XEMCp/3xJpw92a57PKCBFXnp9UF2Si5+PerGVKBjLsrsc1k9yXXr/TKQwbFmprvj
         e38pCa7GtruN83vQ5giRMEtKZCUmum0j7/PyC3xC1oFCNwRmc/gPl8Ftg179V0Cytfwu
         6/d1mhmYp1ug7fhvt+Gh6QhwsvOyxmn5AT4rCipnik1C1krcCKOFgss6+jZht/m4tO+1
         8soA==
X-Gm-Message-State: AHYfb5i97i8brFUZuLRHpCwO5iw1kdxcYmi1hAkvUWBKLWUEgUuD4/Mv
        ANNMM7kcUcHeMBKBmtCUdQ==
X-Received: by 10.99.97.207 with SMTP id v198mr6405859pgb.346.1503094866482;
        Fri, 18 Aug 2017 15:21:06 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 19/23] pack: move find_sha1_pack()
Date:   Fri, 18 Aug 2017 15:20:34 -0700
Message-Id: <d22d82ea53ebc8007fbfdd1572f61859e81353ce.1503094448.git.jonathantanmy@google.com>
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
 cache.h       |  3 ---
 http-push.c   |  1 +
 http-walker.c |  1 +
 packfile.c    | 13 +++++++++++++
 packfile.h    |  3 +++
 sha1_file.c   | 13 -------------
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 9297d078a..1e90bb754 100644
--- a/cache.h
+++ b/cache.h
@@ -1608,9 +1608,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
-					 struct packed_git *packs);
-
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the
diff --git a/http-push.c b/http-push.c
index c91f40a61..e4c9b065c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "packfile.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
diff --git a/http-walker.c b/http-walker.c
index ee049cb13..1ae8363de 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -4,6 +4,7 @@
 #include "http.h"
 #include "list.h"
 #include "transport.h"
+#include "packfile.h"
 
 struct alt_base {
 	char *base;
diff --git a/packfile.c b/packfile.c
index ad7336594..ba3a5eb3a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1774,3 +1774,16 @@ int is_pack_valid(struct packed_git *p)
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
diff --git a/packfile.h b/packfile.h
index 4fca6fb28..a4ff6f6ed 100644
--- a/packfile.h
+++ b/packfile.h
@@ -42,6 +42,9 @@ extern void install_packed_git(struct packed_git *pack);
  */
 unsigned long approximate_object_count(void);
 
+extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
+					 struct packed_git *packs);
+
 extern void pack_report(void);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 27714f5e1..8853672d2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1127,19 +1127,6 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
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
2.14.1.480.gb18f417b89-goog

