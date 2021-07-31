Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D44C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634C060F48
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhGaCml (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhGaCmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:38 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CADC06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:32 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x12so6209307qvo.12
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uV8rbFZ3ElcotGxBhDYSXLHyZKRBbis9T9URYhw1oek=;
        b=HoQhVpAoVf8xwzytLvXlWQFE08W+GPOQXg1TfvAn1K6Ucs7vItKlNFCcMfuXHVOQOs
         88NFP+iHJjOI+r5A12srV9ToKisZFsVAN75xD+TMz3rUbn2bUXRM/hfWhvwnLbKz/RbG
         qPcVJQ6kELGSICDADhdkBqaWr5q3antd1C79Aiw8VTJBfDjx1BaJn8zH0ew+6vaj9XpF
         OtBmKbAyWFSz3YVV9mDkbXqOE4bk/Cg9Q7PPPrkAmdzrpT2JpTtKAt+QsWQ9Bo+nJlzk
         F58yt//xMWjleEKTRNDLWgnS9V7ShH/y5VgQvHrrP763KDaUcjAQzdJ2I0hwu3T+PvmH
         PvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uV8rbFZ3ElcotGxBhDYSXLHyZKRBbis9T9URYhw1oek=;
        b=D8jIM8+nRqA0BoyReYz1w/8DM3R6Ml4Mo8b3Tje3lbDxqqlM9UIX/nDq7XxgH2+TYI
         Y9f2buJDgPZvjgr8XRXaIgO7AJ90ELYCbRZ6G6u+4JaccagAnl/vqGxIkuwDBKGb8z63
         uSRSyqNig++VqU8FK2KIW7soe1GCCQiS/lZ9W5D3xA4j1gCyoiD36VegPobeBytcIeVg
         uXeORsiRnvgyPDaNrDWbJpNBaQwb4Up3yv1xPEToftO93oWD1XxnUNFn8yKbSvQS0S3j
         bEuGLAx08+JKteNQjbdygmPyYvHu4mNWXHBINL+Efg94TPnytad6sU2e8z/2s3LSj4Bj
         p2hA==
X-Gm-Message-State: AOAM532G4FIzGLaxf1Bo74iS2NkL84htv5Gv6WRrd6YuVTXXh4njRPg4
        4zrjw2PhnNksWdiZPLJVlBXdprGW4PoRYg==
X-Google-Smtp-Source: ABdhPJx57IlkZvvbfMTKrzgaOGrFWI9sbmrZjEOkJg+OWinMOf8sLdQjRlhJ5bkphH89WQRalh4T3w==
X-Received: by 2002:a0c:e88f:: with SMTP id b15mr6192059qvo.8.1627699351064;
        Fri, 30 Jul 2021 19:42:31 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id o2sm1917600qkm.109.2021.07.30.19.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:30 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 2/6] mailmap: move `git_default_mailmap_config` to `mailmap.c`
Date:   Fri, 30 Jul 2021 22:42:17 -0400
Message-Id: <20210731024221.2113906-3-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731024221.2113906-1-mathstuf@gmail.com>
References: <20210731024221.2113906-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows mailmap-specific variables to be tracked locally in
`mailmap.c` instead of globally.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 cache.h   |  2 --
 config.c  | 12 +-----------
 mailmap.c | 16 ++++++++++++++--
 mailmap.h |  2 ++
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 6ea1ea5854..551a6cb5cf 100644
--- a/cache.h
+++ b/cache.h
@@ -1718,8 +1718,6 @@ int author_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
-extern const char *git_mailmap_file;
-extern const char *git_mailmap_blob;
 
 /* IO helper functions */
 void maybe_flush_or_die(FILE *, const char *);
diff --git a/config.c b/config.c
index 840be51710..c45001adbe 100644
--- a/config.c
+++ b/config.c
@@ -15,6 +15,7 @@
 #include "strbuf.h"
 #include "quote.h"
 #include "hashmap.h"
+#include "mailmap.h"
 #include "string-list.h"
 #include "object-store.h"
 #include "utf8.h"
@@ -1603,17 +1604,6 @@ static int git_default_push_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_mailmap_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "mailmap.file"))
-		return git_config_pathname(&git_mailmap_file, var, value);
-	if (!strcmp(var, "mailmap.blob"))
-		return git_config_string(&git_mailmap_blob, var, value);
-
-	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
-}
-
 int git_default_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "core."))
diff --git a/mailmap.c b/mailmap.c
index d1f7c0d272..e1d9a2bbdb 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-store.h"
@@ -12,8 +13,19 @@ static inline void debug_mm(const char *format, ...) {}
 static inline const char *debug_str(const char *s) { return s; }
 #endif
 
-const char *git_mailmap_file;
-const char *git_mailmap_blob;
+static const char *git_mailmap_file;
+static const char *git_mailmap_blob;
+
+int git_default_mailmap_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "mailmap.file"))
+		return git_config_pathname(&git_mailmap_file, var, value);
+	if (!strcmp(var, "mailmap.blob"))
+		return git_config_string(&git_mailmap_blob, var, value);
+
+	/* Add other config variables here and to Documentation/config.txt. */
+	return 0;
+}
 
 struct mailmap_info {
 	char *name;
diff --git a/mailmap.h b/mailmap.h
index 7e99fccb46..48bfe9fac7 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,6 +3,8 @@
 
 struct string_list;
 
+int git_default_mailmap_config(const char *var, const char *value);
+
 int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
-- 
2.31.1

