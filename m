Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C667EC2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00592074F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+zLKWpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDHHFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:05:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44342 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDHHFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 03:05:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so2180996plr.11
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 00:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yav+ovAJ9p4fMLMk0ZCj/krt/m0kroK80cw297/2E/o=;
        b=O+zLKWptOOmD+xPwF4vUYYvPVCxUszZaSlI43s994GoNqHBXfdGzKqxjA/Vrw5afWZ
         +VwNonS9RwAvsdvF+p55nOytsJLtGJZxHM+qbsJz+LvgJsJ5UMW4N9nIapKi3l2wzWxn
         hJbSMyK9LsRDvoMPdp7T0ZRRK8KdniimrSRVarIWQQs/DAp5j3oESAJ6Lu+w6eqqj4gi
         SJpYE6GT8YUrCw6VpoO3fiVufjFXsGDDpof1Gd1ILVum0V5hoXwCqQFjf5XTrUX100Mu
         Y90VWNXwBIGcOj0rJXSNWEMYuyYWSl7h1LJ6EhcOuv/N403D026e/T+/E3Hkuk8AekFR
         xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yav+ovAJ9p4fMLMk0ZCj/krt/m0kroK80cw297/2E/o=;
        b=DYk1KjKnLf8B0uXbYHs/2aZ8J8VaCGvVLfctE20iJDs4/Xm9x7BV7DZuYM2AbAEbuN
         rH/uxQ6Dm8Ru5DjEnBvIpRrWF4WHaQpIR4GlfqH0tRO3CULANZIiXfxw4uc/X2C3ZjLN
         SW2nMS17BdT3srGPdRW0FAJwF+CREbSMND05Ub/Xlpm1jwdu1WbWbDoX03m7zO6gHqYW
         ShCoRcFE+PEFq9Ssh3e2aRKf1QPHiAdHBPlOOdJp3e3A5ZDqLXtMcj059tdzLGGj+pLa
         OCogoSS8roCgd2vjRebl3NMslzHnCMWn0Bt13MHu5lx1/VI1LU5ktdLuwSrETC3lwyCb
         TfJQ==
X-Gm-Message-State: AGi0PuaCzAE/9urz7rFzx6Ln8zFbFUu0uvlTnf3Ylx98gsaMNtW1XNAs
        +Myl8evc/jkHBVMt3++2l6IbXbZw7ks=
X-Google-Smtp-Source: APiQypJ/W/PptSLXeumCYFN8TTyxcJ+B0yzxMRMauZr45mL6qFaAxTKuxDNE7xFNPJS6MkSr0wrKnA==
X-Received: by 2002:a17:90a:24af:: with SMTP id i44mr3771792pje.136.1586329505373;
        Wed, 08 Apr 2020 00:05:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2182:8a2e:a277:ba54:a2ce:8862])
        by smtp.gmail.com with ESMTPSA id d26sm15669489pfo.37.2020.04.08.00.05.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:05:04 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/2] oidmap: rework iterators to return typed pointer
Date:   Wed,  8 Apr 2020 12:33:46 +0530
Message-Id: <20200408070346.24872-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408070346.24872-1-abhishekkumar8222@gmail.com>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
 <20200408070346.24872-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

87571c3f (hashmap: use *_entry APIs for iteration, 2019-10-06) modified
hashmap_iter_next() to return a hashmap_entry pointer instead of void
pointer.

However, oidmap_iter_next() is unaware of the struct type containing
oidmap_entry and explicitly returns a void pointer.

Rework oidmap_iter_next() to include struct type and return appropriate
pointer. This allows for compile-time type checks.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 oidmap.h               | 27 +++++++++++++++------------
 t/helper/test-oidmap.c |  2 +-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/oidmap.h b/oidmap.h
index c66a83ab1d..5d6b34a7ce 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -76,18 +76,21 @@ static inline void oidmap_iter_init(struct oidmap *map, struct oidmap_iter *iter
 	hashmap_iter_init(&map->map, &iter->h_iter);
 }
 
-static inline void *oidmap_iter_next(struct oidmap_iter *iter)
-{
-	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)hashmap_iter_next(&iter->h_iter);
-}
+/*
+ * Returns the next entry, or NULL if there are no more entries.
+ *
+ * The entry is of @type (e.g. "struct foo") and has a member of type struct
+ * oidmap_entry.
+ */
+#define oidmap_iter_next(iter, type) \
+	(type *) hashmap_iter_next(&(iter)->h_iter)
 
-static inline void *oidmap_iter_first(struct oidmap *map,
-				      struct oidmap_iter *iter)
-{
-	oidmap_iter_init(map, iter);
-	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)oidmap_iter_next(iter);
-}
+/*
+ * Returns the first entry in @map using @iter, where the entry is of @type
+ * (e.g. "struct foo") and has a member of type struct oidmap_entry.
+ */
+#define oidmap_iter_first(map, iter, type) \
+	({oidmap_iter_init(map, iter); \
+	 oidmap_iter_next(iter, type); })
 
 #endif
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0acf99931e..a28bf007a8 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -96,7 +96,7 @@ int cmd__oidmap(int argc, const char **argv)
 
 			struct oidmap_iter iter;
 			oidmap_iter_init(&map, &iter);
-			while ((entry = oidmap_iter_next(&iter)))
+			while ((entry = oidmap_iter_next(&iter, struct test_entry)))
 				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
 
 		} else {
-- 
2.26.0

