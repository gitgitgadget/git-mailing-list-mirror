Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2835C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCC06120D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhFXT1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhFXT0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9BC06124A
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a05600c2154b02901dcefb16af0so4326591wml.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnUcJ55C+2XbaZOiCasOLVwJH73t9gy1CuGjUfZ5vMY=;
        b=AdN7y9jBmrexzGrdOAofgnrAc7nocwomfignMMu0vc/T4NIl1YpZME33CweuvTc1gL
         84kRojMRObNAt7RDW4c1QqLSuSZe39Q5iUU+iBocsH8brBeslq37uBakSusEVBNfQ0Md
         aYyheppEvDjh9B9nNdkvYjvubqtI2nO4ahFmdPZqCMs7WdHSn6NadIwTBlPyB+ycIkn8
         gbZW7+npVdPnB/F9Cv+bhMOg7L5V3sFbcMliwSnUwfLXzbGa4EzKeYmvxLp5k/aeRicH
         cM0NulfYHKXpy+M2nCe4yigYzLCgX6rXw4zy5ApKvaVU6XMBYb3DAElJfvj9r+5S4pth
         jHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnUcJ55C+2XbaZOiCasOLVwJH73t9gy1CuGjUfZ5vMY=;
        b=deogcd9C3huxgGaRHGd4K+5wEE7OYM2ou3huB+kzOGK/gjFp2Cb4IHQJ542DtxOdIy
         lZNMZSeAkKXhArca9x0lwfMkdmTQgqwfJLB0JHVX4pllJbnwn7YfoqKSNw0i4fZ/ljlS
         oiM5R7w5VRLqKrFfw0qI/V3iZJau9ULJR1tFix0L7GGZGmNOa+Vg+O5y2cLxTsPEQOQ+
         FySNDENFE/VmqsdpRTRezwhddNK2fhdhpfEFf4Szbgi7IGB2eMwXTewYDaPxvsXdYwTA
         MAmKtRjO4h9bf26wKVl6JiMgAlY2ltgeV7S4frFGMKBv9eFCGC3czOWXeeumgZRAuJuI
         uwEA==
X-Gm-Message-State: AOAM533kCBo228yXeBVmbpOWi6R+KJewP1JKoAlfdUn87FhacXIR2HBA
        e/VjRmOia4i1i9EVFVSU0V76Nxi3jZ/zCg==
X-Google-Smtp-Source: ABdhPJy7hOXnjChbAO7bU4g68w8YLcJojd1HsthFx2GxFZCKQkBZeXvDvE9+je7qxr8PMWsbq1mtUg==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr6056243wmj.160.1624562660651;
        Thu, 24 Jun 2021 12:24:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/21] object-store.h: move read_loose_object() below 'struct object_info'
Date:   Thu, 24 Jun 2021 21:23:57 +0200
Message-Id: <patch-19.21-acbea7e2a2a-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
index 94ff03072c1..72d668b1674 100644
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
2.32.0.606.g2e440ee2c94

