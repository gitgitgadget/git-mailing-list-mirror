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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBFBC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F99611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhETM1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhETM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6DC0438DF
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lg14so24647960ejb.9
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hz6UWfo8NlIyUeLj9eB5EU1nny5r2LBbc2rHGJLb5s=;
        b=QbFj7ypd36RGbrYl7w64cU3WkLw1qDluUxd5bhdbfLC2xFtUynCa6MYPWaEuSmWHxC
         JKDoI5dPKbwfbMpP5UrxcxZLn9rlN95mURvCkCt5MIvrTSZEYwW19x+5z7oeEUNc0Pm/
         Fobl9bG0TkjyFaWmyv+IKQyA6+kdQT2iR83ZNTnNTr/XQyRy10CvmBR1kQBQxdsJ7+PY
         HL11n+hjJvh7LJcXG8aY5nxxCU/OkUlPyu+UuGo+cBUim5BtCQjrWO7bRI6pmusc3tMb
         dvloqmlpUdwSOClkZWvb6Mk18hlBJVJAGP3sP+6ZvT/DwSOuJReeYj0sfn3KJLlr2UYR
         7ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hz6UWfo8NlIyUeLj9eB5EU1nny5r2LBbc2rHGJLb5s=;
        b=OuisQipfpx5r46jx4qm3lzAUHNTIvsp4NbbkYrlngV4Pi/TLfjlm7GuworFPL5b05Q
         YJxiUW2pGajAHudylbktf1qn6vI5FtXDdynkuWBUO/6xSl3nHrIYvyAdceAg34pNzIQr
         jUMMVQvAybwdd1PqICZnrTDyzcn7mUqBT0iEPDMSeYi0jpr8OPYzarTNs+5q6BupZ1H1
         BPrxY8qIKpI9A5sxBsYcjUs2fY0H6hD6Ds0IQud3oqWPItvZTfhN3e+uGraQBVw7/F7s
         +g/g6L5CU+zef1tkHdmeh76Qe3XB3dVztpU2hHtMsVyI+PRLd+5KVdnZ9U3WS+dByita
         UX4A==
X-Gm-Message-State: AOAM533pYlp8nZyPw9eeEEDPCKYDKlqtzGIYlBjNugT3KJfTMVkUJoul
        OoVJla3dxT4a+6ktHkwgI56285mGKAgq1Q==
X-Google-Smtp-Source: ABdhPJwMtRRRHtUw0nu+8juP8CkdjwLWgPNITZnMKJuhLDWGxV5g5gAiSc9/ocuoTLlVijcK3lzJDQ==
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17mr4179870ejh.31.1621509807390;
        Thu, 20 May 2021 04:23:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/17] object-store.h: move read_loose_object() below 'struct object_info'
Date:   Thu, 20 May 2021 13:23:09 +0200
Message-Id: <patch-15.17-e2afb813b2-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of read_loose_object() below "struct
object_info". In the next commit we'll add a "struct object_info *"
parameter to it, moving it will avoid a forward declaration of the
struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-store.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/object-store.h b/object-store.h
index 790e8b1798..698a701d70 100644
--- a/object-store.h
+++ b/object-store.h
@@ -234,20 +234,6 @@ int pretend_object_file(void *, unsigned long, enum object_type,
 
 int force_object_loose(const struct object_id *oid, time_t mtime);
 
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents,
-		      unsigned int oi_flags);
-
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
 
@@ -388,6 +374,20 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
+/*
+ * Open the loose object at path, check its hash, and return the contents,
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const struct object_id *expected_oid,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents,
+		      unsigned int oi_flags);
+
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
-- 
2.32.0.rc0.406.g73369325f8d

