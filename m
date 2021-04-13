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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F5C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DF9613B2
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhDMJnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhDMJnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:43:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05005C061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m9so3017949wrx.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jpw60cWMkCxAGCGD0z8pQpPzbV8bZZK/MbUpTl289xg=;
        b=rRdsOe7QeZ5c6CT+2yLl9mRl5rBMpJFkpaLqlr1nTXQydlweM67rWzX8tP0LpUbVIq
         B7KKeQjtClF/+sWMlB/ar06X3TYCih153CKePVS/PisquBKfwBG47gXDFiWnfNBa7JEz
         7fBvvKvYo+DSJZiBENdYwq7ZLLVtkzpB61HROpCFMCm4DeoG79dREFtsOtQ0fASMqvvd
         ARZ0zdRnmY6mEmY9VKkVanoG+X5uWb7vO7kcEBiUctDiCzRQ223YBGW0nr6fTcOPG1cz
         VYb9cV33/T9t+ZLvX3BTWyXqITD+tFY/vHGJ8Dlmn0EmKa6FLBjQtL5j1FLxUxXlHy+7
         PU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jpw60cWMkCxAGCGD0z8pQpPzbV8bZZK/MbUpTl289xg=;
        b=IHGoVmVzN+t7TRVafPA4wacMrlCDJzL9PpNl7pjjgWiKbFAhAgxDbsSDWZ85rhdXnW
         nI80pCknQfkm4i6P9z5RGKu6fA7/oAt5LMAcWiXwBbljFYMcCVCjm5ZSb3yXi04mpJBN
         8yVvvX54lQFGhPQ2bVWJjQY72bDxAacC01BDAscfSIROuM/6tixfSoUveu+SjlfOZtpV
         e4SWf40Qm6cCjISvzPmbH69gyWYiGxDmu6TsHQDT+71zaDF4Ev4ROf+BgsX3sk2313Pe
         uC3vnERmS9051eZZE6hmc89tr73UmcKbY52B4ou7Xv5H+H1oyX0oBxTcIg0G6KW3D0wg
         j/Kw==
X-Gm-Message-State: AOAM532PkOIR+gOdKVsv0/dmu0ysiQmhWAqakknu4VYStOuMdQHcrCz3
        WZCmJ5/y3OgFWFeBkOkAKzmNobK4VTPtOQ==
X-Google-Smtp-Source: ABdhPJzNKfoEjNlCdh5CbNkliQP2OUmNAxjKN+Jan6WjvKnDrmiWurIQTBAUh5ik5imUuXE4J5U7AA==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr1069840wrw.322.1618307004565;
        Tue, 13 Apr 2021 02:43:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p14sm4622877wrn.49.2021.04.13.02.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:43:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] object-store.h: move read_loose_object() below 'struct object_info'
Date:   Tue, 13 Apr 2021 11:43:07 +0200
Message-Id: <patch-4.6-81fffefcf99-20210413T093734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definition of read_loose_object() below "struct
object_info". In the next commit we'll add a "struct object_info *"
parameter to it, moving it will avoid a forward declaration of the
struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-store.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/object-store.h b/object-store.h
index ab86c8bf32c..4680dc68ee4 100644
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
2.31.1.645.g989d83ea6a6

